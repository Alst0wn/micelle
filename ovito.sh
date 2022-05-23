for vel in 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0 1.1 1.2 1.3
do
    ovitos -nt 4 ovito.py $vel
    curl -s -X POST https://api.telegram.org/bot5290830951:AAEZaRP20r2MyHW0kxcxGuG8Ru0O5qlBOhQ/sendMessage -d chat_id=264630131 -d text="Movie for $vel finished"
done