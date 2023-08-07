<?php
if (isset($_POST['audioData'])) {
    $audioData = $_POST['audioData'];

    // Generate a unique filename for the audio file
    $filename = 'requestsongs/audio_' . uniqid() . '.ogg';

    // Save the audio data to the requestsongs folder
    file_put_contents($filename, base64_decode($audioData));

    echo 'Audio saved successfully.';

    // Execute Flask API and capture output
    $pythonFile = "requestapi.py";
    $command = "sudo su | python " . $pythonFile;

    exec($command . ' 2>&1', $output, $returnCode);

    $outputString = implode("\n", $output);

    if ($returnCode === 0) {
        echo "Python file executed successfully.";
    } else {
        echo "An error occurred while executing the Python file.";
    }
    
    echo "<pre>" . $outputString . "</pre>";
    exit; // Terminate the PHP script after executing
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Audio Recorder</title>
    <link rel="stylesheet" href="style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    
    <div class="recorder_wrapper">
        <div class="recorder">
            <button class="record_btn" id="recordButton" onclick="toggleRecording()"></button>
        </div>
    </div>

    <div id="output"></div>
    
    <script>
    var audioChunks = [];
    var mediaRecorder;
    var isRecording = false;

    // Create the MediaRecorder instance when the page is loaded
    window.onload = function() {
        navigator.mediaDevices.getUserMedia({ audio: true })
            .then(function(stream) {
                mediaRecorder = new MediaRecorder(stream);

                mediaRecorder.ondataavailable = function(e) {
                    audioChunks.push(e.data);
                };

                mediaRecorder.onstop = function() {
                    var audioBlob = new Blob(audioChunks, { type: 'audio/ogg; codecs=opus' });
                    var reader = new FileReader();

                    reader.onload = function() {
                        var audioData = reader.result.split(',')[1];

                        // Send the audio data to the server for saving
                        $.post('', { audioData: audioData }, function(response) {
                            console.log(response);
                            document.getElementById("output").innerHTML = response;
                        });
                    };

                    reader.readAsDataURL(audioBlob);
                    audioChunks = [];
                };
            })
            .catch(function(error) {
                console.error(error);
            });
    };

    // Toggle recording when the button is clicked
    function toggleRecording() {
        if (!isRecording) {
            mediaRecorder.start();
            console.log('Recording started...');
            isRecording = true;
        } else {
            mediaRecorder.stop();
            console.log('Recording stopped...');
            isRecording = false;
        }
    }
    </script>
</body>
</html>
