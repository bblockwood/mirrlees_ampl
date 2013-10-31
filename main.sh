# Run scripts to generate Mirrlees results
# Ben Lockwood, bblockwood@gmail.com

MAINDIR=$(dirname $0)/..

cd $MAINDIR/code/

# Remove old files
rm mirrlees_data.txt ampl_output.txt mtr_schedule.eps mtr_schedule.pdf

matlab -nodesktop -nosplash -r "make_mirrlees_data();quit;"
/Applications/ampl/ampl mirrlees_general.run
matlab -nodesktop -nosplash -r "plot_mirrlees_results();quit;"
epstopdf mtr_schedule.eps

echo "Complete."
