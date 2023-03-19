#include "app.h"
#include <iostream>

using namespace std;

void main()
{
	cout << "Fractal" << endl;
	cout << "GDV 2"<< endl;
	cout << "Dariush Naghed" << endl;

    CApplication Application;

    RunApplication(800, 600, "Fractal", &Application);
}