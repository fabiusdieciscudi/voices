VOICES_DIR := /Volumes/AI/Voices/voices
PKLS_DIR   := /Volumes/AI/Voices/pkls
MP3_FILES  := $(shell find "$(VOICES_DIR)" -type f -name "*.mp3")
PKL_FILES  := $(patsubst $(VOICES_DIR)/%.mp3,$(PKLS_DIR)/%.pkl,$(MP3_FILES))

TEXT='Con tutta l’apparente calma del mondo, nonostante fosse in leggero ritardo, Géraldine Lagardère scese dal taxi in Rue de Rivoli, ringraziò sorridendo l’autista che le porgeva il trolley appena recuperato dal bagagliaio e si diresse verso il vicino accesso alle Tuilleries, per poi proseguire verso la Cour Carrée. Infilò la mano in tasca per controllare di avere con sé l’accredito per l’ingresso, poi guardò l’orologio: non c’era tempo da perdere. Forse l’idea di non farsi portare direttamente al Passaggio Richelieu non era stata grandiosa, ma sapendo di avere di fronte una giornata intensa sentiva il bisogno di una breve passeggiata per scaricare la tensione.'


all:	pkl-files

pkl-files: $(PKL_FILES)
	@true

$(PKLS_DIR):
	@mkdir -p $(PKLS_DIR)

$(PKLS_DIR)/%.pkl: $(VOICES_DIR)/%.mp3 | $(PKLS_DIR)
	@mkdir -p $(@D)
	@echo "Generating $@"...
	@CloneVoice --csv '$(VOICES_DIR)/voices.csv' --csv-ref-audio "$(patsubst $(VOICES_DIR)/%,%,$<)" --voice-name "$@" --text $(TEXT) --output "$(patsubst %.pkl,%.wav,$@)" clone
	@echo "Playing sample..."
	@afplay "$(patsubst %.pkl,%.wav,$@)"

