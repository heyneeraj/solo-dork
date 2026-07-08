#!/bin/bash

# ==============================================================================
# SOLO DORK - Safe Local Web Server Launcher
# ==============================================================================

# Create a secure temporary directory
TMP_DIR=$(mktemp -d /tmp/solodork.XXXXXX)
HTML_FILE="$TMP_DIR/index.html"

# Write the embedded HTML content to the temporary index.html
cat << 'EOF' > "$HTML_FILE"
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SOLO DORK</title>

<!-- Modern Premium Typography -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">

<style>
:root {
    --bg-base: #080b10;
    --bg-surface: #10141e;
    --bg-card: rgba(22, 28, 45, 0.45);
    --border-color: rgba(56, 189, 248, 0.15);
    --border-glow: rgba(56, 189, 248, 0.35);
    --primary: #06b6d4;
    --primary-glow: rgba(6, 182, 212, 0.4);
    --success: #10b981;
    --success-glow: rgba(16, 185, 129, 0.3);
    --text-main: #f8fafc;
    --text-muted: #94a3b8;
    --text-accent: #38bdf8;
}

body {
    background: radial-gradient(circle at 50% 0%, #151e33 0%, var(--bg-base) 70%);
    color: var(--text-main);
    font-family: 'Outfit', sans-serif;
    margin: 0;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 20px;
    box-sizing: border-box;
}

.container {
    width: 100%;
    max-width: 650px;
    background: var(--bg-card);
    backdrop-filter: blur(16px);
    -webkit-backdrop-filter: blur(16px);
    border: 1px solid var(--border-color);
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3), 
                0 0 40px rgba(6, 182, 212, 0.05);
    border-radius: 24px;
    padding: 40px;
    transition: border-color 0.4s ease, box-shadow 0.4s ease;
}

.container:hover {
    border-color: var(--border-glow);
    box-shadow: 0 20px 50px rgba(0, 0, 0, 0.4), 
                0 0 50px rgba(6, 182, 212, 0.1);
}

h1 {
    font-family: 'Outfit', sans-serif;
    font-weight: 800;
    font-size: 2.5rem;
    text-align: center;
    margin-top: 0;
    margin-bottom: 30px;
    background: linear-gradient(135deg, #38bdf8 0%, #06b6d4 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    letter-spacing: -0.05em;
    text-transform: uppercase;
}

.input-group {
    margin-bottom: 20px;
    display: flex;
    flex-direction: column;
}

label {
    font-size: 0.85rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    color: var(--text-muted);
    margin-bottom: 8px;
    transition: color 0.3s ease;
}

.input-group:focus-within label {
    color: var(--text-accent);
}

input, select {
    width: 100%;
    padding: 14px 16px;
    border: 1px solid rgba(255, 255, 255, 0.08);
    border-radius: 12px;
    background: rgba(15, 23, 42, 0.6);
    color: var(--text-main);
    font-family: 'Outfit', sans-serif;
    font-size: 1rem;
    outline: none;
    box-sizing: border-box;
    transition: all 0.3s ease;
}

input::placeholder {
    color: rgba(255, 255, 255, 0.25);
}

input:focus, select:focus {
    border-color: var(--primary);
    background: rgba(15, 23, 42, 0.8);
    box-shadow: 0 0 12px var(--primary-glow);
}

option {
    background: var(--bg-surface);
    color: var(--text-main);
}

.btn-generate {
    width: 100%;
    padding: 16px;
    background: linear-gradient(135deg, #06b6d4 0%, #0891b2 100%);
    color: #ffffff;
    border: none;
    border-radius: 12px;
    cursor: pointer;
    font-family: 'Outfit', sans-serif;
    font-weight: 600;
    font-size: 1.1rem;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    box-shadow: 0 4px 20px var(--primary-glow);
    transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
    margin-top: 10px;
}

.btn-generate:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(6, 182, 212, 0.6);
    background: linear-gradient(135deg, #08d9ff 0%, #06b6d4 100%);
}

.btn-generate:active {
    transform: translateY(1px);
}

.result-card {
    margin-top: 30px;
    background: rgba(10, 15, 30, 0.75);
    border: 1px dashed rgba(56, 189, 248, 0.2);
    padding: 20px;
    border-radius: 16px;
    position: relative;
    overflow: hidden;
}

.result-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12px;
}

.result-title {
    font-size: 0.8rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.15em;
    color: var(--text-accent);
}

.output-box {
    min-height: 48px;
    background: rgba(0, 0, 0, 0.3);
    border-radius: 8px;
    padding: 14px;
    font-family: 'Space Mono', monospace;
    font-size: 0.95rem;
    color: #e2e8f0;
    word-break: break-all;
    margin: 0 0 15px 0;
    border: 1px solid rgba(255, 255, 255, 0.05);
    line-height: 1.5;
}

.btn-copy {
    width: 100%;
    padding: 12px;
    background: rgba(255, 255, 255, 0.04);
    color: var(--text-main);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 10px;
    cursor: pointer;
    font-family: 'Outfit', sans-serif;
    font-weight: 600;
    font-size: 0.95rem;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 8px;
}

.btn-copy:hover {
    background: rgba(255, 255, 255, 0.08);
    border-color: rgba(255, 255, 255, 0.2);
}

.btn-copy.copied {
    background: var(--success);
    color: #ffffff;
    border-color: var(--success);
    box-shadow: 0 0 15px var(--success-glow);
}
</style>

</head>
<body>

<div class="container">

    <h1>SOLO DORK</h1>

    <div class="input-group">
        <label for="site">Target Domain</label>
        <input type="text" id="site" placeholder="example.com">
    </div>

    <div class="input-group">
        <label for="keyword">Keyword</label>
        <input type="text" id="keyword" placeholder="login">
    </div>

    <div class="input-group">
        <label for="filetype">File Type</label>
        <select id="filetype">
            <option value="">None</option>
            <optgroup label="Documents & Text">
                <option value="pdf">.pdf</option>
                <option value="doc">.doc</option>
                <option value="docx">.docx</option>
                <option value="odt">.odt</option>
                <option value="rtf">.rtf</option>
                <option value="txt">.txt</option>
            </optgroup>
            <optgroup label="Spreadsheets & Data">
                <option value="xls">.xls</option>
                <option value="xlsx">.xlsx</option>
                <option value="csv">.csv</option>
                <option value="ods">.ods</option>
            </optgroup>
            <optgroup label="Presentations">
                <option value="ppt">.ppt</option>
                <option value="pptx">.pptx</option>
                <option value="odp">.odp</option>
            </optgroup>
            <optgroup label="Images & Graphics">
                <option value="jpg">.jpg</option>
                <option value="jpeg">.jpeg</option>
                <option value="png">.png</option>
                <option value="gif">.gif</option>
                <option value="bmp">.bmp</option>
                <option value="svg">.svg</option>
                <option value="webp">.webp</option>
                <option value="tiff">.tiff</option>
                <option value="ico">.ico</option>
            </optgroup>
            <optgroup label="Audio">
                <option value="mp3">.mp3</option>
                <option value="wav">.wav</option>
                <option value="aac">.aac</option>
                <option value="flac">.flac</option>
                <option value="ogg">.ogg</option>
                <option value="m4a">.m4a</option>
            </optgroup>
            <optgroup label="Video">
                <option value="mp4">.mp4</option>
                <option value="avi">.avi</option>
                <option value="mov">.mov</option>
                <option value="mkv">.mkv</option>
                <option value="wmv">.wmv</option>
                <option value="webm">.webm</option>
                <option value="flv">.flv</option>
            </optgroup>
            <optgroup label="Archives & Images">
                <option value="zip">.zip</option>
                <option value="rar">.rar</option>
                <option value="7z">.7z</option>
                <option value="tar">.tar</option>
                <option value="gz">.gz</option>
                <option value="bz2">.bz2</option>
                <option value="iso">.iso</option>
            </optgroup>
            <optgroup label="Programming & Web">
                <option value="html">.html</option>
                <option value="css">.css</option>
                <option value="js">.js</option>
                <option value="ts">.ts</option>
                <option value="php">.php</option>
                <option value="py">.py</option>
                <option value="java">.java</option>
                <option value="c">.c</option>
                <option value="cpp">.cpp</option>
                <option value="cs">.cs</option>
                <option value="go">.go</option>
                <option value="rb">.rb</option>
                <option value="swift">.swift</option>
                <option value="kt">.kt</option>
            </optgroup>
            <optgroup label="Data & Configuration">
                <option value="json">.json</option>
                <option value="xml">.xml</option>
                <option value="yaml">.yaml</option>
                <option value="yml">.yml</option>
                <option value="ini">.ini</option>
                <option value="conf">.conf</option>
                <option value="env">.env</option>
                <option value="toml">.toml</option>
            </optgroup>
            <optgroup label="Databases">
                <option value="db">.db</option>
                <option value="sqlite">.sqlite</option>
                <option value="sqlite3">.sqlite3</option>
                <option value="sql">.sql</option>
                <option value="mdb">.mdb</option>
                <option value="accdb">.accdb</option>
            </optgroup>
            <optgroup label="Logs & Audits">
                <option value="log">.log</option>
                <option value="evtx">.evtx</option>
                <option value="out">.out</option>
            </optgroup>
            <optgroup label="Security & Certificates">
                <option value="pem">.pem</option>
                <option value="crt">.crt</option>
                <option value="cer">.cer</option>
                <option value="csr">.csr</option>
                <option value="key">.key</option>
                <option value="pfx">.pfx</option>
                <option value="p12">.p12</option>
            </optgroup>
            <optgroup label="Emails">
                <option value="eml">.eml</option>
                <option value="msg">.msg</option>
                <option value="pst">.pst</option>
                <option value="ost">.ost</option>
                <option value="mbox">.mbox</option>
            </optgroup>
            <optgroup label="Backups">
                <option value="bak">.bak</option>
                <option value="backup">.backup</option>
                <option value="old">.old</option>
            </optgroup>
        </select>
    </div>

    <div class="input-group">
        <label for="operator">Operator</label>
        <select id="operator">
            <option value="">None</option>
            <option>intitle:</option>
            <option>inurl:</option>
            <option>intext:</option>
            <option>allintitle:</option>
            <option>allinurl:</option>
            <option>cache:</option>
            <option>related:</option>
        </select>
    </div>

    <button class="btn-generate" onclick="generate()">Generate Dork</button>

    <div class="result-card">
        <div class="result-header">
            <span class="result-title">Generated Dork Output</span>
        </div>
        <div class="output-box" id="output">No dork generated yet.</div>
        <button id="copyBtn" class="btn-copy" onclick="copyDork()">
            <span>Copy Dork</span>
        </button>
    </div>

</div>

<script>
function generate() {
    let site = document.getElementById("site").value.trim();
    let keyword = document.getElementById("keyword").value.trim();
    let file = document.getElementById("filetype").value;
    let op = document.getElementById("operator").value;

    let dork = "";

    if (site != "") {
        dork += "site:" + site + " ";
    }

    if (op != "") {
        dork += op;
    }

    if (keyword != "") {
        dork += '"' + keyword + '" ';
    }

    if (file != "") {
        dork += "filetype:" + file;
    }

    dork = dork.trim();

    if (dork === "") {
        document.getElementById("output").innerText = "Please fill in some values first.";
    } else {
        document.getElementById("output").innerText = dork;
    }
}

function copyDork() {
    let outputText = document.getElementById("output").innerText;
    
    if (outputText === "No dork generated yet." || outputText === "Please fill in some values first.") {
        return;
    }

    navigator.clipboard.writeText(outputText).then(() => {
        let copyBtn = document.getElementById("copyBtn");
        let btnText = copyBtn.querySelector("span");
        
        copyBtn.classList.add("copied");
        btnText.innerText = "Copied!";
        
        setTimeout(() => {
            copyBtn.classList.remove("copied");
            btnText.innerText = "Copy Dork";
        }, 2000);
    });
}
</script>

</body>
</html>
EOF

# Find a dynamic free port using python to avoid any collision
if command -v python3 >/dev/null 2>&1; then
    PORT=$(python3 -c 'import socket; s = socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
else
    PORT=8080
fi

# Change directory to the temp space to serve only our index.html securely
cd "$TMP_DIR" || exit 1

# Start python HTTP server
python3 -m http.server "$PORT" > /dev/null 2>&1 &
SERVER_PID=$!

# Let server bind to socket
sleep 0.5

# Automatically launch default browser
if command -v firefox >/dev/null 2>&1; then
    firefox "http://127.0.0.1:$PORT" > /dev/null 2>&1 &
elif command -v xdg-open >/dev/null 2>&1; then
    xdg-open "http://127.0.0.1:$PORT" > /dev/null 2>&1 &
else
    echo -e "\e[1;33m[!] Could not find automatic launcher. Please visit http://127.0.0.1:$PORT in your browser.\e[0m"
fi

echo -e "\e[1;36m[+] SOLO DORK server is live on http://127.0.0.1:$PORT\e[0m"
echo -e "\e[1;34m[!] Press [Ctrl+C] to stop server and clean up.\e[0m"

# Handle graceful exit
cleanup() {
    echo -e "\n\e[1;31m[-] Stopping server and cleaning up temp files...\e[0m"
    kill "$SERVER_PID" 2>/dev/null
    rm -rf "$TMP_DIR"
    exit 0
}

# Trap terminal shutdown signals
trap cleanup INT TERM EXIT

# Wait on background HTTP server
wait "$SERVER_PID"
