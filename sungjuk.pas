program quick_sort(input, output);
uses SysUtils;
const MAX=1000;
type
	Sub=array[0..MAX] of string;
	score = record
				number: integer;
				sname: string;
				grade: array[0..MAX] of integer;
				total: integer
			end;
var numOfsub, i, j, numOfper, temp, idx:integer;
multi: array[0..MAX] of score;
subarr:Sub;
procedure print(var a: score);
begin
	writeln('number: ' + InttoStr(a.number) + '|| name: ' + a.sname + '|| total: ' + IntToStr(a.total));
end;
function InputSub(idx: integer): integer; {function 1: 과목 입력}
	var temp: string;
	begin
		numOfsub := 0;
		write('과목 입력(Ctrl+z를 입력하면 입력 종료): ');
		readln(subarr[numOfsub]);
		while NOT EOF DO
		begin
			numOfsub := numOfsub + 1;
			readln(subarr[numOfsub])
		end;
		InputSub := numOfsub;	
	end;
function partition(var a: array of score; left, right:integer): integer;
	var pivot, k, p: integer;
	temp : score;
	begin
		pivot := a[right].total;
		k := left-1;
		for p := left to right-1 do
			if a[p].total <= pivot then
			begin
				temp := a[p];
				k := k+1;
				a[p] := a[k];
				a[k] := temp;
			end;
		temp := a[k+1];
		a[k+1] := a[right];
		a[right] := temp;
		partition := k+1;
	end;
procedure qsort(var a: array of score; left, right:integer);
	var i, j, pivot, o: integer;
	begin
	if left < right then 
		begin
		o := partition(a,left,right);
		qsort(a,left,o-1);
		qsort(a,o+1,right)
		end;
	end;
procedure calctot(var p: score; var k: integer);
	var i: integer;
	begin
		p.total := 0;
		for i := 0 to k do
		begin
			p.total := p.total + p.grade[i];
		end;
	end;
begin	
	idx := 0;
	numOfsub := InputSub(0) + 1;
	writeln('입력받은 과목 개수: ' + InttoStr(numOfsub));
	write('사람 수 입력: ');
	readln(numOfper);
	for i:=0 to numOfper-1 do
	begin
		temp := 0;
		write('학번 입력: ');
		readln(multi[i].number);
		write('이름 입력: ');
		readln(multi[i].sname);
		for j:=0 to numOfsub-1 do
		begin
			write(subarr[j] +' 성적 입력: ' );
			readln(multi[i].grade[temp]);
			temp := temp + 1;
		end;
	end;
	for i:=0 to numOfper do
		calctot(multi[i],numOfsub);
	qsort(multi,0,numOfper-1);
	for i := 0 to numOfper-1 do
	begin
		print(multi[i]);
	end;
end.