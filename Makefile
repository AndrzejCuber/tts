tts.pdf:
	pandoc --pdf-engine=pdfroff --output=tts.pdf tts.md
	xreader tts.pdf
