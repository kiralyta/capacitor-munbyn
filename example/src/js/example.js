import { CapacitorMunbyn } from 'capacitor-munbyn';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    CapacitorMunbyn.echo({ value: inputValue })
}
