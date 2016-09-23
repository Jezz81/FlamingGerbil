#!/usr/bin/perl

use DateTime;
use Date::Calc qw(Delta_Days);
use Date::Calc qw(Add_Delta_Days);
use POSIX qw(strftime);

use strict;
use warnings;

my $priceTimeDir = 'PriceTimeData';
my $priceHistoryDir = 'MarketData';
my $chartDir = 'Charts';
my $currentFile = '';
my $friendlyName = '';
my $date = '';
my $dateAsStr = '';
my @priceTimeVectorsDate;
my @priceTimeVectorsPrice;
my @priceTimeFibonacciDates;
my @priceTimeFibonacciPrices;
my $iterator;
my $printAll = 1;

opendir(DIR,$priceTimeDir) or die $!;
while($currentFile = readdir(DIR))
{
	next unless(-f"$priceTimeDir/$currentFile");

	next unless ($currentFile =~ m/\.txt$/);
	
	open FILE, "$priceTimeDir/$currentFile" or die $!;
	
	my $line = <FILE>;
	chomp($line);
	$friendlyName = $line;	
	while(my $line = <FILE>)
	{
		chomp($line);
		my($dateAsStr,$price) = split(/;/,$line);
		$date = new DateTime
				(
				year => substr($dateAsStr,0,4),
				month => substr($dateAsStr,4,2),
				day=>substr($dateAsStr,6,2),
				);
		push @priceTimeVectorsDate,$date;
		push @priceTimeVectorsPrice,$price;
	}

        
	my $iteratorOuter = 0;
	my $iteratorInner = 0;
	my $factorCalDaysToBusinessDays = 5/7;
	my $year;
	my $month;
	my $day;
	my $newDate;
	for $iteratorOuter (1..$#priceTimeVectorsDate)
	{
		for $iteratorInner(0..$iteratorOuter-1)
		{
			
			my $dateDiff = Delta_Days($priceTimeVectorsDate[$iteratorInner]->year,
						$priceTimeVectorsDate[$iteratorInner]->month,
						$priceTimeVectorsDate[$iteratorInner]->day,
						$priceTimeVectorsDate[$iteratorOuter]->year,
						$priceTimeVectorsDate[$iteratorOuter]->month,
						$priceTimeVectorsDate[$iteratorOuter]->day);
			my $priceDiff = $priceTimeVectorsPrice[$iteratorInner]-$priceTimeVectorsPrice[$iteratorOuter];

			#1.618 ratio			
			($year,$month,$day) = Add_Delta_Days($priceTimeVectorsDate[$iteratorInner]->year,
						$priceTimeVectorsDate[$iteratorInner]->month,
						$priceTimeVectorsDate[$iteratorInner]->day,
						int($dateDiff*1.618));
			$newDate = new DateTime(year => $year,
						month => $month,
						day => $day);
			push @priceTimeFibonacciDates, $newDate;

			push @priceTimeFibonacciPrices, $priceDiff * 0.618 + $priceTimeVectorsPrice[$iteratorOuter];
			push @priceTimeFibonacciPrices, $priceDiff * -0.618 + $priceTimeVectorsPrice[$iteratorOuter];
			

			if($printAll eq 1)
			{
			#1.381 ratio
			($year,$month,$day) = Add_Delta_Days($priceTimeVectorsDate[$iteratorInner]->year,
						$priceTimeVectorsDate[$iteratorInner]->month,
						$priceTimeVectorsDate[$iteratorInner]->day,
						int($dateDiff*1.381));
			$newDate = new DateTime(year => $year,
						month => $month,
						day => $day);
			push @priceTimeFibonacciDates, $newDate;

			push @priceTimeFibonacciPrices, $priceDiff * 0.381 + $priceTimeVectorsPrice[$iteratorOuter];
			push @priceTimeFibonacciPrices, $priceDiff * -0.381 + $priceTimeVectorsPrice[$iteratorOuter];

			#1.236 ratio
			($year,$month,$day) = Add_Delta_Days($priceTimeVectorsDate[$iteratorInner]->year,
						$priceTimeVectorsDate[$iteratorInner]->month,
						$priceTimeVectorsDate[$iteratorInner]->day,
						int($dateDiff*1.236));
			$newDate = new DateTime(year => $year,
						month => $month,
						day => $day);
			push @priceTimeFibonacciDates, $newDate;

			push @priceTimeFibonacciPrices, $priceDiff * 0.236 + $priceTimeVectorsPrice[$iteratorOuter];
			push @priceTimeFibonacciPrices, $priceDiff * -0.236 + $priceTimeVectorsPrice[$iteratorOuter];

			#2.618 ratio
			($year,$month,$day) = Add_Delta_Days($priceTimeVectorsDate[$iteratorInner]->year,
						$priceTimeVectorsDate[$iteratorInner]->month,
						$priceTimeVectorsDate[$iteratorInner]->day,
						int($dateDiff*2.618));
			$newDate = new DateTime(year => $year,
						month => $month,
						day => $day);
			push @priceTimeFibonacciDates, $newDate;

			push @priceTimeFibonacciPrices, $priceDiff * 1.618 + $priceTimeVectorsPrice[$iteratorOuter];
			push @priceTimeFibonacciPrices, $priceDiff * -1.618 + $priceTimeVectorsPrice[$iteratorOuter];

			#1.907 ratio
			($year,$month,$day) = Add_Delta_Days($priceTimeVectorsDate[$iteratorInner]->year,
						$priceTimeVectorsDate[$iteratorInner]->month,
						$priceTimeVectorsDate[$iteratorInner]->day,
						int($dateDiff*1.907));
			$newDate = new DateTime(year => $year,
						month => $month,
						day => $day);
			push @priceTimeFibonacciDates, $newDate;

			push @priceTimeFibonacciPrices, $priceDiff * 1.907 + $priceTimeVectorsPrice[$iteratorOuter];
			push @priceTimeFibonacciPrices, $priceDiff * -1.907 + $priceTimeVectorsPrice[$iteratorOuter];

			#1.527 ratio
			($year,$month,$day) = Add_Delta_Days($priceTimeVectorsDate[$iteratorInner]->year,
						$priceTimeVectorsDate[$iteratorInner]->month,
						$priceTimeVectorsDate[$iteratorInner]->day,
						int($dateDiff*1.527));
			$newDate = new DateTime(year => $year,
						month => $month,
						day => $day);
			push @priceTimeFibonacciDates, $newDate;

			push @priceTimeFibonacciPrices, $priceDiff * 1.527 + $priceTimeVectorsPrice[$iteratorOuter];
			push @priceTimeFibonacciPrices, $priceDiff * -1.527 + $priceTimeVectorsPrice[$iteratorOuter];
			}

		}
	}

	print "set title \"$friendlyName\"\n";
	print "set xdata time\n";	
	print "set timefmt \"%Y%m%d %H:%M\"\n";
	print "set autoscale y\n";
	print "set datafile separator \";\"\n";
	print "set terminal pngcairo size 1300,800 enhanced font 'Verdana,10'\n";
	print "set output '$chartDir/$friendlyName.png'\n";
	print "set xrange['20101231 00:00':'20170331 00:00']\n";
	#print "set style line 2 ps 2\n";
	for $iterator(0..$#priceTimeFibonacciDates)
	{
		print  "set arrow from '";
		print $priceTimeFibonacciDates[$iterator]->strftime('%Y%m%d %H:%M');
		print "', graph 0 to '";
		print $priceTimeFibonacciDates[$iterator]->strftime('%Y%m%d %H:%M');
		print "', graph 1 nohead\n";
	}

	for $iterator(0..$#priceTimeFibonacciPrices)
	{
		print  "set arrow from  graph 0, first ";
		print $priceTimeFibonacciPrices[$iterator];
		print " to graph 1, first ";
		print $priceTimeFibonacciPrices[$iterator];
		print " nohead\n";
	}
	
	print "plot '$priceHistoryDir/$friendlyName.data' using 1:2 with lines\n";
	print "unset arrow\n";
	
	@priceTimeFibonacciDates = ();
	@priceTimeFibonacciPrices = ();
	@priceTimeVectorsDate = ();
	@priceTimeVectorsPrice = ();

}
