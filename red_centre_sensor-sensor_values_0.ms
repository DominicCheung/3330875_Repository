/* 3DS Max Sensor Value Spheres by Josh Harle (http://tacticalspace.org) */
if queryBox "We will extract EXIF data from images downloaded by PhotoSynth Toolkit 7.  This might take a while.  Are you ready?" beep:true then (




progressstart "Adding Cameras and Camera Maps"

startCamera = matrix3 [1,0,0] [0,-1,0] [0,0,-1] [0,0,0]
sideCamera = matrix3 [0,1,0] [1,0,0] [0,0,-1] [0,0,0]
t = matrix3 [1,0,0] [0,1,0] [0,0,1] [0,0,0]
R = matrix3 [1,0,0] [0,1,0] [0,0,1] [0,0,0]

/*  EXIF stuff inspired by: http://www.preset.de/3dsMAX/jpegExif/ */

theLogName = getOpenFileName caption:"Locate your PhotoSynth2PMVS.log file..." types:"PhotoSynth2PMVS.log|PhotoSynth2PMVS.log"
theAppPath = getOpenFileName caption:"Locate your EXIFTOOLS executable..." types:"Executable (*.exe)|*.exe"

camera_altitude = #()
min_value = 9999;
max_value = -9999;

in_file = openFile theLogName;
numcameras = readLine in_file;
numcameras = (filterstring numcameras " ")[1]  as integer /*   "287 pictures in CoordSystem 0"   */

for v = 1 to numcameras do
(
	/* get image's exif data */
	filename = (filterstring (readLine in_file) " ")[2]
	command = "\"" + theAppPath + "\"  -GPSAltitude  \"" + filename + "\" >  \"" + filename + ".log\" "
	HiddenDOSCommand (command)
	exifdata_file = openFile (filename + ".log");
	exif_line = readLine exifdata_file
	camera_altitude[v] = (filterstring exif_line " ")[4]  as integer
	if (camera_altitude[v] < min_value) do min_value = camera_altitude[v];
	if (camera_altitude[v] > max_value) do max_value = camera_altitude[v];
	close exifdata_file;
)
close in_file


/* colour converter function */
fn HSV_to_RGB hsv = 
(
hsv /= 255
h = hsv.x*6
i = h as integer
k = if (mod i 2) == 1 then (h-i) else (1-h+i)
m = hsv.z*(1-hsv.y)
n = hsv.z*(1-hsv.y*k)
case i of
(
1: [n, hsv.z, m]*255
2: [m, hsv.z, n]*255
3: [m, n, hsv.z]*255
4: [n, m, hsv.z]*255
5: [hsv.z, m, n]*255
default: [hsv.z, n, m]*255
)
)


progressupdate (100.0*0/287)
Sphere0 = Sphere name: "0_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[1] - min_value) * 255) / (max_value - min_value),255,255];
Sphere0.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text0 = Text text: (camera_altitude[1] as string) size: 0.15 
R.row1 = [0.842264419776, 0.538842354727498, -0.0154778529235409]
R.row2 = [-0.0903501133834984, 0.112803558336, -0.989500992540344]
R.row3 = [-0.531439087940459, 0.834819905116344, 0.143694891456]
t.row4 = [2.1395, -0.694323, 0.138847] 
Sphere0.transform = startCamera * R * t
Sphere_Text0.transform = startCamera * R * t

progressupdate (100.0*1/287)
Sphere1 = Sphere name: "1_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[2] - min_value) * 255) / (max_value - min_value),255,255];
Sphere1.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text1 = Text text: (camera_altitude[2] as string) size: 0.15 
R.row1 = [0.714020920604, 0.700123926631629, 0.000782494553055624]
R.row2 = [-0.095630367199629, 0.09863562023, -0.990517969191426]
R.row3 = [-0.693562511825056, 0.707175721995426, 0.13738100455]
t.row4 = [2.15033, -0.716959, 0.135066] 
Sphere1.transform = startCamera * R * t
Sphere_Text1.transform = startCamera * R * t

progressupdate (100.0*2/287)
Sphere2 = Sphere name: "2_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[3] - min_value) * 255) / (max_value - min_value),255,255];
Sphere2.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text2 = Text text: (camera_altitude[3] as string) size: 0.15 
R.row1 = [0.52927362966, 0.848394635670773, 0.00979628049751113]
R.row2 = [-0.100407890054773, 0.0740963616300001, -0.992183443123269]
R.row3 = [-0.842488979489511, 0.524152908375269, 0.124402765566]
t.row4 = [2.13281, -0.711666, 0.138259] 
Sphere2.transform = startCamera * R * t
Sphere_Text2.transform = startCamera * R * t

progressupdate (100.0*3/287)
Sphere3 = Sphere name: "3_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[4] - min_value) * 255) / (max_value - min_value),255,255];
Sphere3.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text3 = Text text: (camera_altitude[4] as string) size: 0.15 
R.row1 = [0.95313046296, 0.301880986086787, 0.0202531680713199]
R.row2 = [-0.0302469525667871, 0.161675038448, -0.986380405220653]
R.row3 = [-0.30104392111132, 0.939536615668653, 0.163228384112]
t.row4 = [1.90363, -0.908665, 0.135701] 
Sphere3.transform = startCamera * R * t
Sphere_Text3.transform = startCamera * R * t

progressupdate (100.0*4/287)
Sphere4 = Sphere name: "4_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[5] - min_value) * 255) / (max_value - min_value),255,255];
Sphere4.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text4 = Text text: (camera_altitude[5] as string) size: 0.15 
R.row1 = [0.873869563328, 0.486157970740247, 0.00155363272857792]
R.row2 = [-0.0732446221002475, 0.134815199, -0.988159950337992]
R.row3 = [-0.480611289528578, 0.863409109057992, 0.153419355928]
t.row4 = [1.90303, -0.93106, 0.132952] 
Sphere4.transform = startCamera * R * t
Sphere_Text4.transform = startCamera * R * t

progressupdate (100.0*5/287)
Sphere5 = Sphere name: "5_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[6] - min_value) * 255) / (max_value - min_value),255,255];
Sphere5.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text5 = Text text: (camera_altitude[6] as string) size: 0.15 
R.row1 = [0.744036754908, 0.66795651480974, 0.0156013354940798]
R.row2 = [-0.0838560767097397, 0.11652215982, -0.989641725408611]
R.row3 = [-0.66285553912208, 0.735021551108611, 0.142708982412]
t.row4 = [1.89074, -0.924295, 0.135544] 
Sphere5.transform = startCamera * R * t
Sphere_Text5.transform = startCamera * R * t

progressupdate (100.0*6/287)
Sphere6 = Sphere name: "6_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[7] - min_value) * 255) / (max_value - min_value),255,255];
Sphere6.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text6 = Text text: (camera_altitude[7] as string) size: 0.15 
R.row1 = [0.508790622846, 0.86068681345253, 0.0187166036691758]
R.row2 = [-0.09765194690853, 0.0792998309759999, -0.99205626557779]
R.row3 = [-0.855333969493176, 0.50292121247379, 0.124394753406]
t.row4 = [1.88765, -0.940883, 0.1347] 
Sphere6.transform = startCamera * R * t
Sphere_Text6.transform = startCamera * R * t

progressupdate (100.0*7/287)
Sphere7 = Sphere name: "7_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[8] - min_value) * 255) / (max_value - min_value),255,255];
Sphere7.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text7 = Text text: (camera_altitude[8] as string) size: 0.15 
R.row1 = [0.96768508573854, 0.252102255414422, 0.00547974946105767]
R.row2 = [-0.0279678837056221, 0.12889998736662, -0.991263128910742]
R.row3 = [-0.250606010143858, 0.959077288893782, 0.13178536188792]
t.row4 = [1.62638, -1.14554, 0.133493] 
Sphere7.transform = startCamera * R * t
Sphere_Text7.transform = startCamera * R * t

progressupdate (100.0*8/287)
Sphere8 = Sphere name: "8_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[9] - min_value) * 255) / (max_value - min_value),255,255];
Sphere8.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text8 = Text text: (camera_altitude[9] as string) size: 0.15 
R.row1 = [0.89176516151, 0.451804097905477, 0.0250590070206726]
R.row2 = [-0.0354146844094766, 0.12489600998, -0.99153758719438]
R.row3 = [-0.451110515112673, 0.88333121976238, 0.127378410054]
t.row4 = [1.62945, -1.16256, 0.131913] 
Sphere8.transform = startCamera * R * t
Sphere_Text8.transform = startCamera * R * t

progressupdate (100.0*9/287)
Sphere9 = Sphere name: "9_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[10] - min_value) * 255) / (max_value - min_value),255,255];
Sphere9.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text9 = Text text: (camera_altitude[10] as string) size: 0.15 
R.row1 = [0.772333400124, 0.63514163385387, 0.00980938317828745]
R.row2 = [-0.0717722940778695, 0.102598100814, -0.992130217013956]
R.row3 = [-0.631149631114287, 0.765551261937956, 0.124825512174]
t.row4 = [1.61954, -1.15589, 0.132566] 
Sphere9.transform = startCamera * R * t
Sphere_Text9.transform = startCamera * R * t

progressupdate (100.0*10/287)
Sphere10 = Sphere name: "10_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[11] - min_value) * 255) / (max_value - min_value),255,255];
Sphere10.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text10 = Text text: (camera_altitude[11] as string) size: 0.15 
R.row1 = [0.572384812806, 0.819926298126838, 0.00982301934540164]
R.row2 = [-0.0874680894068379, 0.0729632577980001, -0.993491668987224]
R.row3 = [-0.815306665865402, 0.567800342243224, 0.113480447408]
t.row4 = [1.60895, -1.15537, 0.133363] 
Sphere10.transform = startCamera * R * t
Sphere_Text10.transform = startCamera * R * t

progressupdate (100.0*11/287)
Sphere11 = Sphere name: "11_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[12] - min_value) * 255) / (max_value - min_value),255,255];
Sphere11.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text11 = Text text: (camera_altitude[12] as string) size: 0.15 
R.row1 = [0.283090743086, 0.959092648987678, -0.000960123333794749]
R.row2 = [-0.110600966263677, 0.0316511245259999, -0.993360776645515]
R.row3 = [-0.952694629690205, 0.281317430981515, 0.115036714076]
t.row4 = [1.62429, -1.16981, 0.130308] 
Sphere11.transform = startCamera * R * t
Sphere_Text11.transform = startCamera * R * t

progressupdate (100.0*12/287)
Sphere12 = Sphere name: "12_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[13] - min_value) * 255) / (max_value - min_value),255,255];
Sphere12.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text12 = Text text: (camera_altitude[13] as string) size: 0.15 
R.row1 = [0.9659756929771, 0.257883135356145, 0.0196786451844558]
R.row2 = [-0.0156255801885449, 0.13413946167512, -0.9908392634859]
R.row3 = [-0.258160418773256, 0.95681915392638, 0.13360503305798]
t.row4 = [1.36081, -1.36943, 0.130149] 
Sphere12.transform = startCamera * R * t
Sphere_Text12.transform = startCamera * R * t

progressupdate (100.0*13/287)
Sphere13 = Sphere name: "13_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[14] - min_value) * 255) / (max_value - min_value),255,255];
Sphere13.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text13 = Text text: (camera_altitude[14] as string) size: 0.15 
R.row1 = [0.868200713004, 0.496031250037678, 0.0134358075828784]
R.row2 = [-0.0480481021296784, 0.11098611726, -0.992659791498218]
R.row3 = [-0.493881465354878, 0.861182373694218, 0.1201915863]
t.row4 = [1.36091, -1.3779, 0.12829] 
Sphere13.transform = startCamera * R * t
Sphere_Text13.transform = startCamera * R * t

progressupdate (100.0*14/287)
Sphere14 = Sphere name: "14_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[15] - min_value) * 255) / (max_value - min_value),255,255];
Sphere14.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text14 = Text text: (camera_altitude[15] as string) size: 0.15 
R.row1 = [0.750528249974, 0.660725720061657, 0.0122011819087038]
R.row2 = [-0.0685880184936574, 0.0962470717999999, -0.99299153314066]
R.row3 = [-0.657269373780704, 0.74443134271666, 0.11755401427]
t.row4 = [1.35811, -1.37555, 0.129066] 
Sphere14.transform = startCamera * R * t
Sphere_Text14.transform = startCamera * R * t

progressupdate (100.0*15/287)
Sphere15 = Sphere name: "15_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[16] - min_value) * 255) / (max_value - min_value),255,255];
Sphere15.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text15 = Text text: (camera_altitude[16] as string) size: 0.15 
R.row1 = [0.518808141624, 0.854801419122805, 0.0123550010234978]
R.row2 = [-0.0927372208428047, 0.0706404830219999, -0.993181619860522]
R.row3 = [-0.849845821343498, 0.514124942036522, 0.115920765702]
t.row4 = [1.36224, -1.37935, 0.127894] 
Sphere15.transform = startCamera * R * t
Sphere_Text15.transform = startCamera * R * t

progressupdate (100.0*16/287)
Sphere16 = Sphere name: "16_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[17] - min_value) * 255) / (max_value - min_value),255,255];
Sphere16.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text16 = Text text: (camera_altitude[17] as string) size: 0.15 
R.row1 = [0.253571944988, 0.967245111592076, -0.0117542680007931]
R.row2 = [-0.128955836252076, 0.0217589775799998, -0.991411589195527]
R.row3 = [-0.958682252371207, 0.252909946415527, 0.130249368492]
t.row4 = [1.34166, -1.37947, 0.126043] 
Sphere16.transform = startCamera * R * t
Sphere_Text16.transform = startCamera * R * t

progressupdate (100.0*17/287)
Sphere17 = Sphere name: "17_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[18] - min_value) * 255) / (max_value - min_value),255,255];
Sphere17.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text17 = Text text: (camera_altitude[18] as string) size: 0.15 
R.row1 = [0.99784963849656, 0.0649557773652164, 0.00876618156125951]
R.row2 = [-0.00195877138441638, 0.16323633444608, -0.986585050733727]
R.row3 = [-0.0655153582524595, 0.984446365275167, 0.16301255083448]
t.row4 = [1.13172, -1.59413, 0.125214] 
Sphere17.transform = startCamera * R * t
Sphere_Text17.transform = startCamera * R * t

progressupdate (100.0*18/287)
Sphere18 = Sphere name: "18_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[19] - min_value) * 255) / (max_value - min_value),255,255];
Sphere18.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text18 = Text text: (camera_altitude[19] as string) size: 0.15 
R.row1 = [0.936675589798, 0.35004721517586, 0.0102852624757149]
R.row2 = [-0.0517286701758595, 0.16734667096, -0.984540114165209]
R.row3 = [-0.346356729627715, 0.921662649165209, 0.174857018662]
t.row4 = [1.12644, -1.59692, 0.124458] 
Sphere18.transform = startCamera * R * t
Sphere_Text18.transform = startCamera * R * t

progressupdate (100.0*19/287)
Sphere19 = Sphere name: "19_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[20] - min_value) * 255) / (max_value - min_value),255,255];
Sphere19.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text19 = Text text: (camera_altitude[20] as string) size: 0.15 
R.row1 = [0.79128406179, 0.611360597262317, 0.0103804466273295]
R.row2 = [-0.0819420022223166, 0.122850640758, -0.989036515168751]
R.row3 = [-0.60593319914733, 0.781758236400751, 0.147305865432]
t.row4 = [1.12246, -1.59746, 0.125355] 
Sphere19.transform = startCamera * R * t
Sphere_Text19.transform = startCamera * R * t

progressupdate (100.0*20/287)
Sphere20 = Sphere name: "20_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[21] - min_value) * 255) / (max_value - min_value),255,255];
Sphere20.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text20 = Text text: (camera_altitude[21] as string) size: 0.15 
R.row1 = [0.576392435478, 0.817066154557589, 0.0132158768235043]
R.row2 = [-0.0950699386255887, 0.083111602902, -0.991995044459793]
R.row3 = [-0.811623969023504, 0.570522007059793, 0.12558332838]
t.row4 = [1.12227, -1.5995, 0.123853] 
Sphere20.transform = startCamera * R * t
Sphere_Text20.transform = startCamera * R * t

progressupdate (100.0*21/287)
Sphere21 = Sphere name: "21_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[22] - min_value) * 255) / (max_value - min_value),255,255];
Sphere21.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text21 = Text text: (camera_altitude[22] as string) size: 0.15 
R.row1 = [0.370745666366, 0.928707041129863, 0.00713320591640482]
R.row2 = [-0.122181981689863, 0.0563867453079999, -0.990904686790767]
R.row3 = [-0.920662377976405, 0.366502069174767, 0.134376408158]
t.row4 = [1.10165, -1.59211, 0.12666] 
Sphere21.transform = startCamera * R * t
Sphere_Text21.transform = startCamera * R * t

progressupdate (100.0*22/287)
Sphere22 = Sphere name: "22_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[23] - min_value) * 255) / (max_value - min_value),255,255];
Sphere22.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text22 = Text text: (camera_altitude[23] as string) size: 0.15 
R.row1 = [0.98674418836182, 0.158855640240778, 0.0331781900932755]
R.row2 = [0.00767708083042176, 0.15852350871, -0.987325356514353]
R.row3 = [-0.162101724741276, 0.974492269209953, 0.15520260334782]
t.row4 = [0.858862, -1.8411, 0.120059] 
Sphere22.transform = startCamera * R * t
Sphere_Text22.transform = startCamera * R * t

progressupdate (100.0*23/287)
Sphere23 = Sphere name: "23_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[24] - min_value) * 255) / (max_value - min_value),255,255];
Sphere23.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text23 = Text text: (camera_altitude[24] as string) size: 0.15 
R.row1 = [0.93049347563, 0.365510926672525, 0.024158938159495]
R.row2 = [-0.0298151449125255, 0.141304883662, -0.989517047345377]
R.row3 = [-0.365093068879495, 0.920018854337377, 0.142381033568]
t.row4 = [0.859338, -1.84995, 0.118097] 
Sphere23.transform = startCamera * R * t
Sphere_Text23.transform = startCamera * R * t

progressupdate (100.0*24/287)
Sphere24 = Sphere name: "24_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[25] - min_value) * 255) / (max_value - min_value),255,255];
Sphere24.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text24 = Text text: (camera_altitude[25] as string) size: 0.15 
R.row1 = [0.79648437462, 0.604599026756335, 0.00852395632793385]
R.row2 = [-0.0777275204523346, 0.11635620507, -0.990161434366154]
R.row3 = [-0.599642454759934, 0.787985564834154, 0.139669882446]
t.row4 = [0.854549, -1.84396, 0.119599] 
Sphere24.transform = startCamera * R * t
Sphere_Text24.transform = startCamera * R * t

progressupdate (100.0*25/287)
Sphere25 = Sphere name: "25_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[26] - min_value) * 255) / (max_value - min_value),255,255];
Sphere25.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text25 = Text text: (camera_altitude[26] as string) size: 0.15 
R.row1 = [0.6047937734, 0.796349595748418, 0.00719812530598146]
R.row2 = [-0.101173590484418, 0.0857960739900001, -0.991162417707811]
R.row3 = [-0.789929361553982, 0.598720598475811, 0.132458479214]
t.row4 = [0.843672, -1.83438, 0.121038] 
Sphere25.transform = startCamera * R * t
Sphere_Text25.transform = startCamera * R * t

progressupdate (100.0*26/287)
Sphere26 = Sphere name: "26_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[27] - min_value) * 255) / (max_value - min_value),255,255];
Sphere26.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text26 = Text text: (camera_altitude[27] as string) size: 0.15 
R.row1 = [0.33590257659, 0.94181941899982, 0.0120681827563565]
R.row2 = [-0.13398121291982, 0.0604592875980001, -0.989137861537853]
R.row3 = [-0.932318879796356, 0.330637046529853, 0.146494538592]
t.row4 = [0.817248, -1.82249, 0.12508] 
Sphere26.transform = startCamera * R * t
Sphere_Text26.transform = startCamera * R * t

progressupdate (100.0*27/287)
Sphere27 = Sphere name: "27_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[28] - min_value) * 255) / (max_value - min_value),255,255];
Sphere27.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text27 = Text text: (camera_altitude[28] as string) size: 0.15 
R.row1 = [0.9984826686875, 0.0489120681248055, 0.0252976268144365]
R.row2 = [0.0170280944815945, 0.16263562249568, -0.986539253295969]
R.row3 = [-0.0523679704496365, 0.985473116775489, 0.16155597105582]
t.row4 = [0.631305, -2.04731, 0.113329] 
Sphere27.transform = startCamera * R * t
Sphere_Text27.transform = startCamera * R * t

progressupdate (100.0*28/287)
Sphere28 = Sphere name: "28_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[29] - min_value) * 255) / (max_value - min_value),255,255];
Sphere28.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text28 = Text text: (camera_altitude[29] as string) size: 0.15 
R.row1 = [0.96512988422364, 0.260968051634978, 0.0204934771160693]
R.row2 = [-0.0215956622373777, 0.15739785221982, -0.987299115511159]
R.row3 = [-0.260879155838469, 0.952429310837519, 0.15754514878782]
t.row4 = [0.629477, -2.07286, 0.111266] 
Sphere28.transform = startCamera * R * t
Sphere_Text28.transform = startCamera * R * t

progressupdate (100.0*29/287)
Sphere29 = Sphere name: "29_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[30] - min_value) * 255) / (max_value - min_value),255,255];
Sphere29.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text29 = Text text: (camera_altitude[30] as string) size: 0.15 
R.row1 = [0.876281783772, 0.481661314769535, 0.011515784117685]
R.row2 = [-0.0572259294895346, 0.12778354547, -0.990149765692632]
R.row3 = [-0.478388365685685, 0.866991201432633, 0.139537909598]
t.row4 = [0.629683, -2.07266, 0.111271] 
Sphere29.transform = startCamera * R * t
Sphere_Text29.transform = startCamera * R * t

progressupdate (100.0*30/287)
Sphere30 = Sphere name: "30_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[31] - min_value) * 255) / (max_value - min_value),255,255];
Sphere30.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text30 = Text text: (camera_altitude[31] as string) size: 0.15 
R.row1 = [0.738308309358, 0.673983181177437, 0.0254462536117534]
R.row2 = [-0.0811497242014371, 0.126222211068, -0.988677235347884]
R.row3 = [-0.669563710631753, 0.727883661667884, 0.147884456526]
t.row4 = [0.632232, -2.07697, 0.110716] 
Sphere30.transform = startCamera * R * t
Sphere_Text30.transform = startCamera * R * t

progressupdate (100.0*31/287)
Sphere31 = Sphere name: "31_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[32] - min_value) * 255) / (max_value - min_value),255,255];
Sphere31.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text31 = Text text: (camera_altitude[32] as string) size: 0.15 
R.row1 = [0.518982108092, 0.854785099206373, 7.52006360982826E-05]
R.row2 = [-0.111331355414373, 0.0676819719980001, -0.991475909928255]
R.row3 = [-0.847503923756098, 0.514549885668255, 0.13029011619]
t.row4 = [0.603474, -2.04525, 0.116516] 
Sphere31.transform = startCamera * R * t
Sphere_Text31.transform = startCamera * R * t

progressupdate (100.0*32/287)
Sphere32 = Sphere name: "32_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[33] - min_value) * 255) / (max_value - min_value),255,255];
Sphere32.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text32 = Text text: (camera_altitude[33] as string) size: 0.15 
R.row1 = [0.99494010689136, 0.100469034821679, 0.000395905303531389]
R.row2 = [-0.0135671853248791, 0.13825755568688, -0.990303377646391]
R.row3 = [-0.0995495614323314, 0.985287177089751, 0.13892106924848]
t.row4 = [0.414238, -2.24504, 0.109824] 
Sphere32.transform = startCamera * R * t
Sphere_Text32.transform = startCamera * R * t

progressupdate (100.0*33/287)
Sphere33 = Sphere name: "33_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[34] - min_value) * 255) / (max_value - min_value),255,255];
Sphere33.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text33 = Text text: (camera_altitude[34] as string) size: 0.15 
R.row1 = [0.937803346764, 0.347112959662808, -0.0061217670951042]
R.row2 = [-0.0505843027908078, 0.11917700951, -0.991583616602968]
R.row3 = [-0.343461950016896, 0.930220099566968, 0.12932306543]
t.row4 = [0.414848, -2.25365, 0.110247] 
Sphere33.transform = startCamera * R * t
Sphere_Text33.transform = startCamera * R * t

progressupdate (100.0*34/287)
Sphere34 = Sphere name: "34_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[35] - min_value) * 255) / (max_value - min_value),255,255];
Sphere34.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text34 = Text text: (camera_altitude[35] as string) size: 0.15 
R.row1 = [0.82009389543, 0.572203571938611, 0.00539211824268615]
R.row2 = [-0.0681276355146108, 0.1069892412, -0.991923347616456]
R.row3 = [-0.568158981234686, 0.813102929848456, 0.126724099974]
t.row4 = [0.409322, -2.23796, 0.111075] 
Sphere34.transform = startCamera * R * t
Sphere_Text34.transform = startCamera * R * t

progressupdate (100.0*35/287)
Sphere35 = Sphere name: "35_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[36] - min_value) * 255) / (max_value - min_value),255,255];
Sphere35.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text35 = Text text: (camera_altitude[36] as string) size: 0.15 
R.row1 = [0.642124620156, 0.766599114872111, -0.00133013789073827]
R.row2 = [-0.112672070688111, 0.0926606889660001, -0.989302279996968]
R.row3 = [-0.758275000693262, 0.635405220152968, 0.145874019366]
t.row4 = [0.388263, -2.21023, 0.114956] 
Sphere35.transform = startCamera * R * t
Sphere_Text35.transform = startCamera * R * t

progressupdate (100.0*36/287)
Sphere36 = Sphere name: "36_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[37] - min_value) * 255) / (max_value - min_value),255,255];
Sphere36.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text36 = Text text: (camera_altitude[37] as string) size: 0.15 
R.row1 = [0.350827596198, 0.93634261559433, -0.0135094029439474]
R.row2 = [-0.15229911047433, 0.0428170814000001, -0.987406541647924]
R.row3 = [-0.923972390656053, 0.348466933527924, 0.157625561198]
t.row4 = [0.351474, -2.18789, 0.117235] 
Sphere36.transform = startCamera * R * t
Sphere_Text36.transform = startCamera * R * t

progressupdate (100.0*37/287)
Sphere37 = Sphere name: "37_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[38] - min_value) * 255) / (max_value - min_value),255,255];
Sphere37.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text37 = Text text: (camera_altitude[38] as string) size: 0.15 
R.row1 = [0.627019626222, 0.778988593625378, 0.00481241456858333]
R.row2 = [-0.0995069681533774, 0.0862186461179999, -0.991294460970352]
R.row3 = [-0.772621997888583, 0.621082213610352, 0.13157557644]
t.row4 = [-0.152139, -1.71761, 0.0805635] 
Sphere37.transform = startCamera * R * t
Sphere_Text37.transform = startCamera * R * t

progressupdate (100.0*38/287)
Sphere38 = Sphere name: "38_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[39] - min_value) * 255) / (max_value - min_value),255,255];
Sphere38.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text38 = Text text: (camera_altitude[39] as string) size: 0.15 
R.row1 = [0.810531520056, 0.585400402612687, 0.0185748113479956]
R.row2 = [-0.0667197584286874, 0.123793373406, -0.990062459916535]
R.row3 = [-0.581882401203996, 0.801237523660535, 0.139396204566]
t.row4 = [-0.144972, -1.7154, 0.0801302] 
Sphere38.transform = startCamera * R * t
Sphere_Text38.transform = startCamera * R * t

progressupdate (100.0*39/287)
Sphere39 = Sphere name: "39_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[40] - min_value) * 255) / (max_value - min_value),255,255];
Sphere39.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text39 = Text text: (camera_altitude[40] as string) size: 0.15 
R.row1 = [0.942572858878, 0.333201075011494, 0.0230965217671065]
R.row2 = [-0.0287409102114943, 0.149809321676, -0.988297084493925]
R.row3 = [-0.332761725243107, 0.930878193293925, 0.150782702798]
t.row4 = [-0.123073, -1.73774, 0.0756688] 
Sphere39.transform = startCamera * R * t
Sphere_Text39.transform = startCamera * R * t

progressupdate (100.0*40/287)
Sphere40 = Sphere name: "40_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[41] - min_value) * 255) / (max_value - min_value),255,255];
Sphere40.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text40 = Text text: (camera_altitude[41] as string) size: 0.15 
R.row1 = [0.999504119297618, 0.0274462710338043, 0.0154343031404584]
R.row2 = [0.0112729242801957, 0.145779193610838, -0.989252924124234]
R.row3 = [-0.0294013041422584, 0.988936362420006, 0.14539750478678]
t.row4 = [-0.114236, -1.73408, 0.0747867] 
Sphere40.transform = startCamera * R * t
Sphere_Text40.transform = startCamera * R * t

progressupdate (100.0*41/287)
Sphere41 = Sphere name: "41_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[42] - min_value) * 255) / (max_value - min_value),255,255];
Sphere41.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text41 = Text text: (camera_altitude[42] as string) size: 0.15 
R.row1 = [0.98311319272718, -0.182245385874388, 0.0165852227379085]
R.row2 = [0.0459877116183881, 0.15831866600718, -0.986316546740351]
R.row3 = [0.177125889315692, 0.970423525745951, 0.164026217456]
t.row4 = [-0.106509, -1.73947, 0.0722367] 
Sphere41.transform = startCamera * R * t
Sphere_Text41.transform = startCamera * R * t

progressupdate (100.0*42/287)
Sphere42 = Sphere name: "42_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[43] - min_value) * 255) / (max_value - min_value),255,255];
Sphere42.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text42 = Text text: (camera_altitude[43] as string) size: 0.15 
R.row1 = [0.511846706318, 0.859020526210971, 0.0098328418904064]
R.row2 = [-0.105055481138971, 0.073948943372, -0.991713113585186]
R.row3 = [-0.852629048950406, 0.506572096865186, 0.12809533779]
t.row4 = [0.0627556, -1.50017, 0.0857818] 
Sphere42.transform = startCamera * R * t
Sphere_Text42.transform = startCamera * R * t

progressupdate (100.0*43/287)
Sphere43 = Sphere name: "43_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[44] - min_value) * 255) / (max_value - min_value),255,255];
Sphere43.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text43 = Text text: (camera_altitude[44] as string) size: 0.15 
R.row1 = [0.8147303911, 0.578961973417234, 0.0318970712583917]
R.row2 = [-0.0606924205452341, 0.139857455846, -0.988309831041179]
R.row3 = [-0.576654853362392, 0.803270144709179, 0.14908472327]
t.row4 = [0.0921503, -1.51396, 0.080744] 
Sphere43.transform = startCamera * R * t
Sphere_Text43.transform = startCamera * R * t

progressupdate (100.0*44/287)
Sphere44 = Sphere name: "44_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[45] - min_value) * 255) / (max_value - min_value),255,255];
Sphere44.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text44 = Text text: (camera_altitude[45] as string) size: 0.15 
R.row1 = [0.96749850815846, 0.24942896530786, 0.041615237312849]
R.row2 = [0.00431231604494012, 0.14826952047078, -0.98893758813673]
R.row3 = [-0.252839950643649, 0.95697509923969, 0.14237492333168]
t.row4 = [0.100899, -1.51904, 0.0791464] 
Sphere44.transform = startCamera * R * t
Sphere_Text44.transform = startCamera * R * t

progressupdate (100.0*45/287)
Sphere45 = Sphere name: "45_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[46] - min_value) * 255) / (max_value - min_value),255,255];
Sphere45.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text45 = Text text: (camera_altitude[46] as string) size: 0.15 
R.row1 = [0.99834490113237, -0.037281725119714, 0.0437896261127685]
R.row2 = [0.048881927241754, 0.14894047718838, -0.987637226639432]
R.row3 = [0.0302987717924315, 0.98814311070158, 0.15051636854799]
t.row4 = [0.109123, -1.51793, 0.078509] 
Sphere45.transform = startCamera * R * t
Sphere_Text45.transform = startCamera * R * t

progressupdate (100.0*46/287)
Sphere46 = Sphere name: "46_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[47] - min_value) * 255) / (max_value - min_value),255,255];
Sphere46.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text46 = Text text: (camera_altitude[47] as string) size: 0.15 
R.row1 = [0.396030700992, 0.918133272624478, -0.013819463508087]
R.row2 = [-0.109628601424478, 0.0323345143920001, -0.993446550614952]
R.row3 = [-0.911669487051913, 0.394950342294952, 0.113459127]
t.row4 = [0.412942, -1.22085, 0.086123] 
Sphere46.transform = startCamera * R * t
Sphere_Text46.transform = startCamera * R * t

progressupdate (100.0*47/287)
Sphere47 = Sphere name: "47_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[48] - min_value) * 255) / (max_value - min_value),255,255];
Sphere47.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text47 = Text text: (camera_altitude[48] as string) size: 0.15 
R.row1 = [0.683160620184, 0.730218563444894, 0.00850979613665498]
R.row2 = [-0.0878542198208943, 0.0937497529739999, -0.991711964169524]
R.row3 = [-0.724964277112655, 0.676750938985524, 0.128198921574]
t.row4 = [0.408087, -1.21637, 0.0867706] 
Sphere47.transform = startCamera * R * t
Sphere_Text47.transform = startCamera * R * t

progressupdate (100.0*48/287)
Sphere48 = Sphere name: "48_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[49] - min_value) * 255) / (max_value - min_value),255,255];
Sphere48.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text48 = Text text: (camera_altitude[49] as string) size: 0.15 
R.row1 = [0.864664944608, 0.501572145698905, 0.0279269802348969]
R.row2 = [-0.0417781988189054, 0.127199438336, -0.990996914722974]
R.row3 = [-0.500608745098897, 0.855713553442974, 0.130939676128]
t.row4 = [0.41594, -1.2246, 0.0850458] 
Sphere48.transform = startCamera * R * t
Sphere_Text48.transform = startCamera * R * t

progressupdate (100.0*49/287)
Sphere49 = Sphere name: "49_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[50] - min_value) * 255) / (max_value - min_value),255,255];
Sphere49.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text49 = Text text: (camera_altitude[50] as string) size: 0.15 
R.row1 = [0.97481158725854, 0.221355868485025, 0.0272754254545424]
R.row2 = [-0.00406474182582471, 0.13990725059552, -0.990156270042609]
R.row3 = [-0.222992930875342, 0.965104937671569, 0.13728296347902]
t.row4 = [0.420725, -1.2206, 0.0858405] 
Sphere49.transform = startCamera * R * t
Sphere_Text49.transform = startCamera * R * t

progressupdate (100.0*50/287)
Sphere50 = Sphere name: "50_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[51] - min_value) * 255) / (max_value - min_value),255,255];
Sphere50.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text50 = Text text: (camera_altitude[51] as string) size: 0.15 
R.row1 = [0.998468152709032, 0.0401041007564182, 0.0381183568419812]
R.row2 = [0.0314767744995818, 0.154866862364312, -0.987433778847238]
R.row3 = [-0.0455034140797812, 0.98712102401071, 0.15336728224472]
t.row4 = [0.425773, -1.22411, 0.0853982] 
Sphere50.transform = startCamera * R * t
Sphere_Text50.transform = startCamera * R * t

progressupdate (100.0*51/287)
Sphere51 = Sphere name: "51_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[52] - min_value) * 255) / (max_value - min_value),255,255];
Sphere51.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text51 = Text text: (camera_altitude[52] as string) size: 0.15 
R.row1 = [0.162299850886, 0.986682685389692, -0.0107720357671706]
R.row2 = [-0.163385278197692, 0.0161060267800001, -0.986430862640472]
R.row3 = [-0.973120757804829, 0.161857573976472, 0.16382343079]
t.row4 = [0.646079, -0.988344, 0.0921] 
Sphere51.transform = startCamera * R * t
Sphere_Text51.transform = startCamera * R * t

progressupdate (100.0*52/287)
Sphere52 = Sphere name: "52_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[53] - min_value) * 255) / (max_value - min_value),255,255];
Sphere52.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text52 = Text text: (camera_altitude[53] as string) size: 0.15 
R.row1 = [0.422388440508, 0.906409184170537, 0.003224310239761]
R.row2 = [-0.125289342690536, 0.06190740423, -0.990186878275852]
R.row3 = [-0.897714089191761, 0.417839519615852, 0.139712382822]
t.row4 = [0.657466, -0.990886, 0.0904031] 
Sphere52.transform = startCamera * R * t
Sphere_Text52.transform = startCamera * R * t

progressupdate (100.0*53/287)
Sphere53 = Sphere name: "53_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[54] - min_value) * 255) / (max_value - min_value),255,255];
Sphere53.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text53 = Text text: (camera_altitude[54] as string) size: 0.15 
R.row1 = [0.679965159708, 0.733242688164405, -0.00159431386844289]
R.row2 = [-0.094086482524405, 0.0850933777500001, -0.991920788606268]
R.row3 = [-0.727182999931557, 0.674621580826268, 0.126848757558]
t.row4 = [0.664036, -0.994201, 0.0901239] 
Sphere53.transform = startCamera * R * t
Sphere_Text53.transform = startCamera * R * t

progressupdate (100.0*54/287)
Sphere54 = Sphere name: "54_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[55] - min_value) * 255) / (max_value - min_value),255,255];
Sphere54.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text54 = Text text: (camera_altitude[55] as string) size: 0.15 
R.row1 = [0.875980556502, 0.482284818928006, 0.00770831123054741]
R.row2 = [-0.0583023115120059, 0.121731937532, -0.99084921953699]
R.row3 = [-0.478809884090547, 0.86751523837699, 0.134753130134]
t.row4 = [0.667837, -0.983797, 0.0912172] 
Sphere54.transform = startCamera * R * t
Sphere_Text54.transform = startCamera * R * t

progressupdate (100.0*55/287)
Sphere55 = Sphere name: "55_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[56] - min_value) * 255) / (max_value - min_value),255,255];
Sphere55.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text55 = Text text: (camera_altitude[56] as string) size: 0.15 
R.row1 = [0.97174115498438, 0.235944576476704, 0.00702029492628438]
R.row2 = [-0.0247236689407039, 0.1313119768955, -0.991032746642565]
R.row3 = [-0.234750650486284, 0.962853738402165, 0.13343466768888]
t.row4 = [0.675517, -0.990706, 0.0899787] 
Sphere55.transform = startCamera * R * t
Sphere_Text55.transform = startCamera * R * t

progressupdate (100.0*56/287)
Sphere56 = Sphere name: "56_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[57] - min_value) * 255) / (max_value - min_value),255,255];
Sphere56.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text56 = Text text: (camera_altitude[57] as string) size: 0.15 
R.row1 = [0.99739540372784, 0.0715181165888362, 0.009357757325593]
R.row2 = [-0.00328148776803615, 0.17459786118872, -0.984634357874207]
R.row3 = [-0.072053039218393, 0.982039075530047, 0.17437779007512]
t.row4 = [0.680822, -0.988049, 0.0886979] 
Sphere56.transform = startCamera * R * t
Sphere_Text56.transform = startCamera * R * t

progressupdate (100.0*57/287)
Sphere57 = Sphere name: "57_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[58] - min_value) * 255) / (max_value - min_value),255,255];
Sphere57.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text57 = Text text: (camera_altitude[58] as string) size: 0.15 
R.row1 = [0.032731564094, 0.99935741195838, -0.0146084864311672]
R.row2 = [-0.15600226176638, -0.00932878329999998, -0.987712644510495]
R.row3 = [-0.987214231580833, 0.034608336654495, 0.15559667091]
t.row4 = [0.942531, -0.743679, 0.0935648] 
Sphere57.transform = startCamera * R * t
Sphere_Text57.transform = startCamera * R * t

progressupdate (100.0*58/287)
Sphere58 = Sphere name: "58_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[59] - min_value) * 255) / (max_value - min_value),255,255];
Sphere58.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text58 = Text text: (camera_altitude[59] as string) size: 0.15 
R.row1 = [0.299730547206, 0.954010909932108, 0.0049782328293923]
R.row2 = [-0.140504994864108, 0.04930380983, -0.988851596931756]
R.row3 = [-0.943620657621392, 0.295689563675756, 0.1488211559]
t.row4 = [0.954779, -0.742094, 0.0928817] 
Sphere58.transform = startCamera * R * t
Sphere_Text58.transform = startCamera * R * t

progressupdate (100.0*59/287)
Sphere59 = Sphere name: "59_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[60] - min_value) * 255) / (max_value - min_value),255,255];
Sphere59.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text59 = Text text: (camera_altitude[60] as string) size: 0.15 
R.row1 = [0.58748547331, 0.809228366597237, 0.0032045817343947]
R.row2 = [-0.113461544693237, 0.0862906799799999, -0.989788056315297]
R.row3 = [-0.801241097626395, 0.581122507947297, 0.142510821454]
t.row4 = [0.954839, -0.735704, 0.0938814] 
Sphere59.transform = startCamera * R * t
Sphere_Text59.transform = startCamera * R * t

progressupdate (100.0*60/287)
Sphere60 = Sphere name: "60_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[61] - min_value) * 255) / (max_value - min_value),255,255];
Sphere60.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text60 = Text text: (camera_altitude[61] as string) size: 0.15 
R.row1 = [0.82277243079, 0.568331423901436, 0.00670221889232187]
R.row2 = [-0.0690751173094363, 0.111690596846, -0.991339416519323]
R.row3 = [-0.564157916988322, 0.815183784911323, 0.13115350364]
t.row4 = [0.955784, -0.730939, 0.0943634] 
Sphere60.transform = startCamera * R * t
Sphere_Text60.transform = startCamera * R * t

progressupdate (100.0*61/287)
Sphere61 = Sphere name: "61_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[62] - min_value) * 255) / (max_value - min_value),255,255];
Sphere61.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text61 = Text text: (camera_altitude[62] as string) size: 0.15 
R.row1 = [0.97123295026364, 0.236057270992747, 0.0313611405028976]
R.row2 = [-0.00703073968994725, 0.16006491135062, -0.987081451985463]
R.row3 = [-0.238027571977698, 0.958465538747103, 0.15711997330902]
t.row4 = [0.963861, -0.723546, 0.0955093] 
Sphere61.transform = startCamera * R * t
Sphere_Text61.transform = startCamera * R * t

progressupdate (100.0*62/287)
Sphere62 = Sphere name: "62_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[63] - min_value) * 255) / (max_value - min_value),255,255];
Sphere62.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text62 = Text text: (camera_altitude[63] as string) size: 0.15 
R.row1 = [0.9899760915136, 0.140287129175743, 0.0163358384873456]
R.row2 = [-0.0264622215789431, 0.29785585496248, -0.954244015173099]
R.row3 = [-0.138733878560946, 0.944246477913579, 0.29858248422712]
t.row4 = [0.964615, -0.735133, 0.0943856] 
Sphere62.transform = startCamera * R * t
Sphere_Text62.transform = startCamera * R * t

progressupdate (100.0*63/287)
Sphere63 = Sphere name: "63_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[64] - min_value) * 255) / (max_value - min_value),255,255];
Sphere63.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text63 = Text text: (camera_altitude[64] as string) size: 0.15 
R.row1 = [-0.14994268381, 0.98863614556179, -0.0107593336495301]
R.row2 = [-0.17394224398179, -0.0370906584180002, -0.984057101400472]
R.row3 = [-0.97327349051047, -0.145680660167528, 0.177527062508]
t.row4 = [1.14339, -0.56552, 0.0976193] 
Sphere63.transform = startCamera * R * t
Sphere_Text63.transform = startCamera * R * t

progressupdate (100.0*64/287)
Sphere64 = Sphere name: "64_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[65] - min_value) * 255) / (max_value - min_value),255,255];
Sphere64.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text64 = Text text: (camera_altitude[65] as string) size: 0.15 
R.row1 = [-0.0537862911239999, 0.998526858252005, -0.00715179952903078]
R.row2 = [-0.176031009504005, -0.0165315370599999, -0.984245798556151]
R.row3 = [-0.982914095218969, -0.0516799925678496, 0.17666086094]
t.row4 = [1.14582, -0.562852, 0.097565] 
Sphere64.transform = startCamera * R * t
Sphere_Text64.transform = startCamera * R * t

progressupdate (100.0*65/287)
Sphere65 = Sphere name: "65_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[66] - min_value) * 255) / (max_value - min_value),255,255];
Sphere65.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text65 = Text text: (camera_altitude[66] as string) size: 0.15 
R.row1 = [0.09933495239, 0.995029980038503, 0.00692142024827225]
R.row2 = [-0.183006956930503, 0.0251060745339999, -0.982790994431944]
R.row3 = [-0.978080273264272, 0.0963588285839445, 0.18459131942]
t.row4 = [1.15188, -0.559463, 0.0979346] 
Sphere65.transform = startCamera * R * t
Sphere_Text65.transform = startCamera * R * t

progressupdate (100.0*66/287)
Sphere66 = Sphere name: "66_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[67] - min_value) * 255) / (max_value - min_value),255,255];
Sphere66.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text66 = Text text: (camera_altitude[67] as string) size: 0.15 
R.row1 = [0.28765329564, 0.957718196765886, 0.00560687889523287]
R.row2 = [-0.189326061885886, 0.062601441648, -0.979916681047105]
R.row3 = [-0.938835035455233, 0.280814734455105, 0.199328525592]
t.row4 = [1.155, -0.549272, 0.0970424] 
Sphere66.transform = startCamera * R * t
Sphere_Text66.transform = startCamera * R * t

progressupdate (100.0*67/287)
Sphere67 = Sphere name: "67_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[68] - min_value) * 255) / (max_value - min_value),255,255];
Sphere67.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text67 = Text text: (camera_altitude[68] as string) size: 0.15 
R.row1 = [0.484139417478, 0.874847038282032, 0.0158645533570983]
R.row2 = [-0.165668190782032, 0.10945361583, -0.980088749320564]
R.row3 = [-0.859164172325098, 0.471871344320564, 0.197925135852]
t.row4 = [1.15185, -0.551205, 0.0971304] 
Sphere67.transform = startCamera * R * t
Sphere_Text67.transform = startCamera * R * t

progressupdate (100.0*68/287)
Sphere68 = Sphere name: "68_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[69] - min_value) * 255) / (max_value - min_value),255,255];
Sphere68.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text68 = Text text: (camera_altitude[69] as string) size: 0.15 
R.row1 = [0.645059718846, 0.764106617703343, 0.00624787197983168]
R.row2 = [-0.141092659047343, 0.127138466366, -0.981798692163038]
R.row3 = [-0.750993222795832, 0.632437259459038, 0.189821737856]
t.row4 = [1.15239, -0.547612, 0.0977084] 
Sphere68.transform = startCamera * R * t
Sphere_Text68.transform = startCamera * R * t

progressupdate (100.0*69/287)
Sphere69 = Sphere name: "69_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[70] - min_value) * 255) / (max_value - min_value),255,255];
Sphere69.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text69 = Text text: (camera_altitude[70] as string) size: 0.15 
R.row1 = [0.76163417759, 0.647822252504579, 0.0154825284336292]
R.row2 = [-0.117071383736579, 0.161059737566, -0.979976556885507]
R.row3 = [-0.637344232449629, 0.744571077933507, 0.19851004828]
t.row4 = [1.15489, -0.549203, 0.0970698] 
Sphere69.transform = startCamera * R * t
Sphere_Text69.transform = startCamera * R * t

progressupdate (100.0*70/287)
Sphere70 = Sphere name: "70_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[71] - min_value) * 255) / (max_value - min_value),255,255];
Sphere70.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text70 = Text text: (camera_altitude[71] as string) size: 0.15 
R.row1 = [0.903246168878, 0.429008073075574, 0.00992127225703621]
R.row2 = [-0.0803778751875743, 0.191850176462, -0.978127244775357]
R.row3 = [-0.421527882337036, 0.882692235735357, 0.20777069424]
t.row4 = [1.15752, -0.539389, 0.0984002] 
Sphere70.transform = startCamera * R * t
Sphere_Text70.transform = startCamera * R * t

progressupdate (100.0*71/287)
Sphere71 = Sphere name: "71_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[72] - min_value) * 255) / (max_value - min_value),255,255];
Sphere71.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text71 = Text text: (camera_altitude[72] as string) size: 0.15 
R.row1 = [0.97600377807902, 0.217203720521259, 0.015465088658067]
R.row2 = [-0.024609014217259, 0.1805887635395, -0.983250779253456]
R.row3 = [-0.216358548698067, 0.959275894763856, 0.18160048493952]
t.row4 = [1.16762, -0.541928, 0.0974701] 
Sphere71.transform = startCamera * R * t
Sphere_Text71.transform = startCamera * R * t

progressupdate (100.0*72/287)
Sphere72 = Sphere name: "72_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[73] - min_value) * 255) / (max_value - min_value),255,255];
Sphere72.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text72 = Text text: (camera_altitude[73] as string) size: 0.15 
R.row1 = [0.99014752343334, 0.139626160884165, 0.0106026900158666]
R.row2 = [-0.0217787697009655, 0.22835376778662, -0.973334599163087]
R.row3 = [-0.138324137550667, 0.963513929289247, 0.22914480364272]
t.row4 = [1.17358, -0.547692, 0.0961332] 
Sphere72.transform = startCamera * R * t
Sphere_Text72.transform = startCamera * R * t

progressupdate (100.0*73/287)
Sphere73 = Sphere name: "73_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[74] - min_value) * 255) / (max_value - min_value),255,255];
Sphere73.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text73 = Text text: (camera_altitude[74] as string) size: 0.15 
R.row1 = [-0.14244645378, 0.989801344347548, -0.00151872752306059]
R.row2 = [-0.141541806531548, -0.0218884308100002, -0.989690261445702]
R.row3 = [-0.97962999382894, -0.140762904646298, 0.143216199734]
t.row4 = [1.33682, -0.393528, 0.0982931] 
Sphere73.transform = startCamera * R * t
Sphere_Text73.transform = startCamera * R * t

progressupdate (100.0*74/287)
Sphere74 = Sphere name: "74_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[75] - min_value) * 255) / (max_value - min_value),255,255];
Sphere74.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text74 = Text text: (camera_altitude[75] as string) size: 0.15 
R.row1 = [0.119074584998, 0.992874791904166, 0.00457064643267213]
R.row2 = [-0.149126208864166, 0.02243537291, -0.98856361852548]
R.row3 = [-0.981622441184672, 0.11703119944548, 0.150735136312]
t.row4 = [1.34809, -0.388376, 0.0987737] 
Sphere74.transform = startCamera * R * t
Sphere_Text74.transform = startCamera * R * t

progressupdate (100.0*75/287)
Sphere75 = Sphere name: "75_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[76] - min_value) * 255) / (max_value - min_value),255,255];
Sphere75.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text75 = Text text: (camera_altitude[76] as string) size: 0.15 
R.row1 = [0.456393116476, 0.889368526776655, 0.0269990150273478]
R.row2 = [-0.133681246176655, 0.098536536518, -0.98611352053995]
R.row3 = [-0.879678718427348, 0.44644616086395, 0.163863289958]
t.row4 = [1.34625, -0.381744, 0.0997295] 
Sphere75.transform = startCamera * R * t
Sphere_Text75.transform = startCamera * R * t

progressupdate (100.0*76/287)
Sphere76 = Sphere name: "76_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[77] - min_value) * 255) / (max_value - min_value),255,255];
Sphere76.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text76 = Text text: (camera_altitude[77] as string) size: 0.15 
R.row1 = [0.75451995747, 0.656113452497931, 0.0146550752545038]
R.row2 = [-0.0847166627539305, 0.11951801184, -0.989211065393858]
R.row3 = [-0.650786232822504, 0.745137961921857, 0.145762467294]
t.row4 = [1.34329, -0.37061, 0.100364] 
Sphere76.transform = startCamera * R * t
Sphere_Text76.transform = startCamera * R * t

progressupdate (100.0*77/287)
Sphere77 = Sphere name: "77_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[78] - min_value) * 255) / (max_value - min_value),255,255];
Sphere77.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text77 = Text text: (camera_altitude[78] as string) size: 0.15 
R.row1 = [0.93713134511, 0.34884712715305, 0.00951440431061795]
R.row2 = [-0.05046747420505, 0.162450487846, -0.985425224482284]
R.row3 = [-0.345308378206618, 0.922992698170284, 0.16984287758]
t.row4 = [1.35056, -0.365762, 0.101076] 
Sphere77.transform = startCamera * R * t
Sphere_Text77.transform = startCamera * R * t

progressupdate (100.0*78/287)
Sphere78 = Sphere name: "78_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[79] - min_value) * 255) / (max_value - min_value),255,255];
Sphere78.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text78 = Text text: (camera_altitude[79] as string) size: 0.15 
R.row1 = [0.99321666231222, 0.116135694818935, 0.00575865386152326]
R.row2 = [-0.0272072645205346, 0.2802614310975, -0.959538063339069]
R.row3 = [-0.113050548263523, 0.952872515412269, 0.28152005773872]
t.row4 = [1.35819, -0.3676, 0.099933] 
Sphere78.transform = startCamera * R * t
Sphere_Text78.transform = startCamera * R * t

progressupdate (100.0*79/287)
Sphere79 = Sphere name: "79_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[80] - min_value) * 255) / (max_value - min_value),255,255];
Sphere79.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text79 = Text text: (camera_altitude[80] as string) size: 0.15 
R.row1 = [-0.167366022056, 0.985853527753295, -0.00902421617275045]
R.row2 = [-0.171736192273296, -0.0381661892180001, -0.984403383915377]
R.row3 = [-0.97082196870725, -0.163205893940623, 0.175694454262]
t.row4 = [1.65435, -0.0914974, 0.10538] 
Sphere79.transform = startCamera * R * t
Sphere_Text79.transform = startCamera * R * t

progressupdate (100.0*80/287)
Sphere80 = Sphere name: "80_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[81] - min_value) * 255) / (max_value - min_value),255,255];
Sphere80.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text80 = Text text: (camera_altitude[81] as string) size: 0.15 
R.row1 = [0.134025247832, 0.99097713755487, 0.00124329687795477]
R.row2 = [-0.15264203871487, 0.0218837673739999, -0.988039224293494]
R.row3 = [-0.979151490301955, 0.132232422533494, 0.154197747942]
t.row4 = [1.66299, -0.0902926, 0.10586] 
Sphere80.transform = startCamera * R * t
Sphere_Text80.transform = startCamera * R * t

progressupdate (100.0*81/287)
Sphere81 = Sphere name: "81_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[82] - min_value) * 255) / (max_value - min_value),255,255];
Sphere81.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text81 = Text text: (camera_altitude[82] as string) size: 0.15 
R.row1 = [0.414517806636, 0.909942713257648, 0.0133882997796167]
R.row2 = [-0.139700986497649, 0.0781633705980001, -0.987103906318045]
R.row3 = [-0.899254481419617, 0.407301787482045, 0.159520003638]
t.row4 = [1.66466, -0.0813395, 0.105862] 
Sphere81.transform = startCamera * R * t
Sphere_Text81.transform = startCamera * R * t

progressupdate (100.0*82/287)
Sphere82 = Sphere name: "82_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[83] - min_value) * 255) / (max_value - min_value),255,255];
Sphere82.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text82 = Text text: (camera_altitude[83] as string) size: 0.15 
R.row1 = [0.691714610328, 0.721774025437423, 0.0239406362204774]
R.row2 = [-0.0874671346374232, 0.11663918367, -0.98931531939575]
R.row3 = [-0.716854516772477, 0.68222984179575, 0.143812533342]
t.row4 = [1.66949, -0.079064, 0.104827] 
Sphere82.transform = startCamera * R * t
Sphere_Text82.transform = startCamera * R * t

progressupdate (100.0*83/287)
Sphere83 = Sphere name: "83_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[84] - min_value) * 255) / (max_value - min_value),255,255];
Sphere83.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text83 = Text text: (camera_altitude[84] as string) size: 0.15 
R.row1 = [0.888536111132, 0.458130662904627, 0.0248972874223022]
R.row2 = [-0.0449358662246275, 0.140900074214, -0.989003507078277]
R.row3 = [-0.456600861958302, 0.877646548898277, 0.145781302182]
t.row4 = [1.66316, -0.0648914, 0.105681] 
Sphere83.transform = startCamera * R * t
Sphere_Text83.transform = startCamera * R * t

progressupdate (100.0*84/287)
Sphere84 = Sphere name: "84_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[85] - min_value) * 255) / (max_value - min_value),255,255];
Sphere84.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text84 = Text text: (camera_altitude[85] as string) size: 0.15 
R.row1 = [0.97883118861662, 0.204253099779907, 0.0130451301900004]
R.row2 = [-0.0253518946999074, 0.18424572115712, -0.982553202463061]
R.row3 = [-0.2030930467212, 0.961423000279061, 0.1855236613155]
t.row4 = [1.66141, -0.0583194, 0.10852] 
Sphere84.transform = startCamera * R * t
Sphere_Text84.transform = startCamera * R * t

progressupdate (100.0*85/287)
Sphere85 = Sphere name: "85_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[86] - min_value) * 255) / (max_value - min_value),255,255];
Sphere85.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text85 = Text text: (camera_altitude[86] as string) size: 0.15 
R.row1 = [0.91819525168, 0.395896656917223, 0.0135394547182676]
R.row2 = [-0.0306975787732231, 0.10518981116, -0.993978250408723]
R.row3 = [-0.394936879070268, 0.912250481320723, 0.108737853944]
t.row4 = [2.06453, 0.391714, 0.117702] 
Sphere85.transform = startCamera * R * t
Sphere_Text85.transform = startCamera * R * t

progressupdate (100.0*86/287)
Sphere86 = Sphere name: "86_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[87] - min_value) * 255) / (max_value - min_value),255,255];
Sphere86.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text86 = Text text: (camera_altitude[87] as string) size: 0.15 
R.row1 = [0.793464310832, 0.60860852414312, -0.00317045363196095]
R.row2 = [-0.0738583157031202, 0.0911182906139999, -0.993097380077644]
R.row3 = [-0.604118644504039, 0.788221492637644, 0.117249912182]
t.row4 = [2.07657, 0.372065, 0.118405] 
Sphere86.transform = startCamera * R * t
Sphere_Text86.transform = startCamera * R * t

progressupdate (100.0*87/287)
Sphere87 = Sphere name: "87_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[88] - min_value) * 255) / (max_value - min_value),255,255];
Sphere87.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text87 = Text text: (camera_altitude[88] as string) size: 0.15 
R.row1 = [0.58981019051, 0.807523358732702, 0.00547396306283721]
R.row2 = [-0.086625042284702, 0.070006938246, -0.993778209987819]
R.row3 = [-0.802882333358837, 0.585666333075819, 0.11124255068]
t.row4 = [2.09113, 0.361301, 0.118877] 
Sphere87.transform = startCamera * R * t
Sphere_Text87.transform = startCamera * R * t

progressupdate (100.0*88/287)
Sphere88 = Sphere name: "88_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[89] - min_value) * 255) / (max_value - min_value),255,255];
Sphere88.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text88 = Text text: (camera_altitude[89] as string) size: 0.15 
R.row1 = [0.234925181804, 0.971923448495138, -0.0132275931172885]
R.row2 = [-0.107615554111138, 0.0124823258540001, -0.994114220829089]
R.row3 = [-0.966037810578711, 0.234965958825089, 0.107526493134]
t.row4 = [2.1004, 0.354208, 0.117748] 
Sphere88.transform = startCamera * R * t
Sphere_Text88.transform = startCamera * R * t

progressupdate (100.0*89/287)
Sphere89 = Sphere name: "89_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[90] - min_value) * 255) / (max_value - min_value),255,255];
Sphere89.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text89 = Text text: (camera_altitude[90] as string) size: 0.15 
R.row1 = [-0.0718975926580001, 0.997152032792209, -0.0227719052420007]
R.row2 = [-0.118130003672209, -0.031183379076, -0.992508387421389]
R.row3 = [-0.990391861033999, -0.0686689184986107, 0.120035583182]
t.row4 = [2.10092, 0.350291, 0.117016] 
Sphere89.transform = startCamera * R * t
Sphere_Text89.transform = startCamera * R * t

progressupdate (100.0*90/287)
Sphere90 = Sphere name: "90_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[91] - min_value) * 255) / (max_value - min_value),255,255];
Sphere90.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text90 = Text text: (camera_altitude[91] as string) size: 0.15 
R.row1 = [-0.270466328196, 0.962172255786475, -0.0327492825408445]
R.row2 = [-0.159976677694475, -0.0784615427399999, -0.983997585822596]
R.row3 = [-0.949344736071155, -0.260899092573404, 0.17514632622]
t.row4 = [2.10511, 0.348442, 0.120334] 
Sphere90.transform = startCamera * R * t
Sphere_Text90.transform = startCamera * R * t

progressupdate (100.0*91/287)
Sphere91 = Sphere name: "91_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[92] - min_value) * 255) / (max_value - min_value),255,255];
Sphere91.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text91 = Text text: (camera_altitude[92] as string) size: 0.15 
R.row1 = [0.747237542982, 0.664533889046487, 0.00554659057215184]
R.row2 = [-0.131791032814487, 0.156363109308, -0.978867560866752]
R.row3 = [-0.651357949232152, 0.730715600186752, 0.20441999319]
t.row4 = [1.86581, 1.0745, 0.0107079] 
Sphere91.transform = startCamera * R * t
Sphere_Text91.transform = startCamera * R * t

progressupdate (100.0*92/287)
Sphere92 = Sphere name: "92_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[93] - min_value) * 255) / (max_value - min_value),255,255];
Sphere92.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text92 = Text text: (camera_altitude[93] as string) size: 0.15 
R.row1 = [0.460299066188, 0.887706648837849, 0.0100834158662533]
R.row2 = [-0.163310143337849, 0.095834029388, -0.981909179045716]
R.row3 = [-0.872613641166253, 0.450325154105716, 0.1890838143]
t.row4 = [1.89947, 1.03478, -0.00640855] 
Sphere92.transform = startCamera * R * t
Sphere_Text92.transform = startCamera * R * t

progressupdate (100.0*93/287)
Sphere93 = Sphere name: "93_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[94] - min_value) * 255) / (max_value - min_value),255,255];
Sphere93.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text93 = Text text: (camera_altitude[94] as string) size: 0.15 
R.row1 = [0.0356738880299999, 0.999356837922572, -0.00364475105052336]
R.row2 = [-0.171670303578572, 0.00253514684, -0.985151196466685]
R.row3 = [-0.984508344597477, 0.0357698689946847, 0.171650330294]
t.row4 = [1.92774, 1.00291, 0.0140486] 
Sphere93.transform = startCamera * R * t
Sphere_Text93.transform = startCamera * R * t

progressupdate (100.0*94/287)
Sphere94 = Sphere name: "94_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[95] - min_value) * 255) / (max_value - min_value),255,255];
Sphere94.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text94 = Text text: (camera_altitude[95] as string) size: 0.15 
R.row1 = [-0.301191888928, 0.95356079523345, -0.00229256139127998]
R.row2 = [-0.188297284449451, -0.0618321354879999, -0.980163720859917]
R.row3 = [-0.93478745108872, -0.294785679460083, 0.198176245984]
t.row4 = [1.93323, 0.999777, 0.01297] 
Sphere94.transform = startCamera * R * t
Sphere_Text94.transform = startCamera * R * t

progressupdate (100.0*95/287)
Sphere95 = Sphere name: "95_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[96] - min_value) * 255) / (max_value - min_value),255,255];
Sphere95.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text95 = Text text: (camera_altitude[96] as string) size: 0.15 
R.row1 = [-0.26065032369, 0.961720740180265, 0.0845850262601029]
R.row2 = [-0.355585582552264, -0.0141784715940001, -0.934536176091768]
R.row3 = [-0.897563536604103, -0.273664372636232, 0.34566965286]
t.row4 = [1.92529, 0.997718, 0.0123502] 
Sphere95.transform = startCamera * R * t
Sphere_Text95.transform = startCamera * R * t

progressupdate (100.0*96/287)
Sphere96 = Sphere name: "96_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[97] - min_value) * 255) / (max_value - min_value),255,255];
Sphere96.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text96 = Text text: (camera_altitude[97] as string) size: 0.15 
R.row1 = [0.0994028264920001, 0.992079487421946, 0.0767943274077602]
R.row2 = [-0.451187548793946, 0.113724832988, -0.88515335291415]
R.row3 = [-0.88687590670776, 0.0533381008141502, 0.45891848198]
t.row4 = [1.96695, 1.01002, -0.0221601] 
Sphere96.transform = startCamera * R * t
Sphere_Text96.transform = startCamera * R * t

progressupdate (100.0*97/287)
Sphere97 = Sphere name: "97_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[98] - min_value) * 255) / (max_value - min_value),255,255];
Sphere97.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text97 = Text text: (camera_altitude[98] as string) size: 0.15 
R.row1 = [0.395689204302, 0.917694007266573, 0.0356056544086633]
R.row2 = [-0.476774467170573, 0.238401610502, -0.846079653203095]
R.row3 = [-0.784930672768663, 0.317808717843095, 0.531866014904]
t.row4 = [1.92736, 1.01581, -8.02113E-05] 
Sphere97.transform = startCamera * R * t
Sphere_Text97.transform = startCamera * R * t

progressupdate (100.0*98/287)
Sphere98 = Sphere name: "98_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[99] - min_value) * 255) / (max_value - min_value),255,255];
Sphere98.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text98 = Text text: (camera_altitude[99] as string) size: 0.15 
R.row1 = [0.745304953484, 0.666477560333754, -0.0181159566068073]
R.row2 = [-0.408607117601754, 0.43512681126, -0.80231220953435]
R.row3 = [-0.526840345605193, 0.60536957281835, 0.5966296427]
t.row4 = [1.9089, 1.03916, 0.0190171] 
Sphere98.transform = startCamera * R * t
Sphere_Text98.transform = startCamera * R * t

progressupdate (100.0*99/287)
Sphere99 = Sphere name: "99_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[100] - min_value) * 255) / (max_value - min_value),255,255];
Sphere99.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text99 = Text text: (camera_altitude[100] as string) size: 0.15 
R.row1 = [0.867602982318, 0.495468211137946, 0.0421463738022192]
R.row2 = [-0.263870810237946, 0.53057844027, -0.805517668474767]
R.row3 = [-0.421470355514219, 0.687748333674767, 0.591071035452]
t.row4 = [2.32171, 1.35542, -0.00660386] 
Sphere99.transform = startCamera * R * t
Sphere_Text99.transform = startCamera * R * t

progressupdate (100.0*100/287)
Sphere100 = Sphere name: "100_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[101] - min_value) * 255) / (max_value - min_value),255,255];
Sphere100.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text100 = Text text: (camera_altitude[101] as string) size: 0.15 
R.row1 = [0.89652487032, 0.44268320651302, -0.0165751491413637]
R.row2 = [-0.0823678678730196, 0.129814619312, -0.988111177426373]
R.row3 = [-0.435268527738636, 0.887231504898373, 0.152844906608]
t.row4 = [1.41876, 0.764004, 0.00607821] 
Sphere100.transform = startCamera * R * t
Sphere_Text100.transform = startCamera * R * t

progressupdate (100.0*101/287)
Sphere101 = Sphere name: "101_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[102] - min_value) * 255) / (max_value - min_value),255,255];
Sphere101.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text101 = Text text: (camera_altitude[102] as string) size: 0.15 
R.row1 = [0.894512543328, 0.446104619713671, -0.0289478513709371]
R.row2 = [-0.186515604497671, 0.313577179038, -0.93106459607561]
R.row3 = [-0.406274831989063, 0.83824818583561, 0.363704192766]
t.row4 = [1.4126, 0.77565, 0.00960764] 
Sphere101.transform = startCamera * R * t
Sphere_Text101.transform = startCamera * R * t

progressupdate (100.0*102/287)
Sphere102 = Sphere name: "102_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[103] - min_value) * 255) / (max_value - min_value),255,255];
Sphere102.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text102 = Text text: (camera_altitude[103] as string) size: 0.15 
R.row1 = [0.586381204272, 0.810027123780193, -0.00362519198194761]
R.row2 = [-0.273767336860194, 0.193965066294, -0.942034499541307]
R.row3 = [-0.762370335562052, 0.553383783461307, 0.335496437622]
t.row4 = [1.41018, 0.766729, 0.00722812] 
Sphere102.transform = startCamera * R * t
Sphere_Text102.transform = startCamera * R * t

progressupdate (100.0*103/287)
Sphere103 = Sphere name: "103_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[104] - min_value) * 255) / (max_value - min_value),255,255];
Sphere103.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text103 = Text text: (camera_altitude[104] as string) size: 0.15 
R.row1 = [0.62699516636, 0.778993864053286, -0.00675434145766662]
R.row2 = [-0.0748171859252859, 0.051584001606, -0.995862178952757]
R.row3 = [-0.775422110886333, 0.624906113384757, 0.09062504843]
t.row4 = [1.41961, 0.761984, 0.00392645] 
Sphere103.transform = startCamera * R * t
Sphere_Text103.transform = startCamera * R * t

progressupdate (100.0*104/287)
Sphere104 = Sphere name: "104_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[105] - min_value) * 255) / (max_value - min_value),255,255];
Sphere104.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text104 = Text text: (camera_altitude[105] as string) size: 0.15 
R.row1 = [0.1807531659, 0.983343785925465, -0.0190602124568462]
R.row2 = [-0.160165903921465, 0.0103090834200001, -0.987036273913001]
R.row3 = [-0.970399493115154, 0.181462727525001, 0.159361545804]
t.row4 = [1.41591, 0.764607, 0.00283839] 
Sphere104.transform = startCamera * R * t
Sphere_Text104.transform = startCamera * R * t

progressupdate (100.0*105/287)
Sphere105 = Sphere name: "105_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[106] - min_value) * 255) / (max_value - min_value),255,255];
Sphere105.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text105 = Text text: (camera_altitude[106] as string) size: 0.15 
R.row1 = [0.15804732519, 0.987000850897873, 0.029160989817915]
R.row2 = [-0.389034667169873, 0.0893848394939999, -0.916876424720724]
R.row3 = [-0.907564361761915, 0.133565230488724, 0.39810458232]
t.row4 = [1.41021, 0.766811, 0.00723995] 
Sphere105.transform = startCamera * R * t
Sphere_Text105.transform = startCamera * R * t

progressupdate (100.0*106/287)
Sphere106 = Sphere name: "106_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[107] - min_value) * 255) / (max_value - min_value),255,255];
Sphere106.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text106 = Text text: (camera_altitude[107] as string) size: 0.15 
R.row1 = [-0.236243108834, 0.971691771940418, 0.00207216595336551]
R.row2 = [-0.245436141076418, -0.0576081475240001, -0.967699541176067]
R.row3 = [-0.940186308229366, -0.229120932439933, 0.252097806686]
t.row4 = [1.41243, 0.760465, 0.00250643] 
Sphere106.transform = startCamera * R * t
Sphere_Text106.transform = startCamera * R * t

progressupdate (100.0*107/287)
Sphere107 = Sphere name: "107_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[108] - min_value) * 255) / (max_value - min_value),255,255];
Sphere107.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text107 = Text text: (camera_altitude[108] as string) size: 0.15 
R.row1 = [-0.195212388658, 0.980618943948515, -0.0166916171696308]
R.row2 = [-0.131955546028515, -0.0431251623999999, -0.990317097822859]
R.row3 = [-0.971843535342369, -0.191119614737141, 0.137816674158]
t.row4 = [1.41326, 0.760636, 0.000262269] 
Sphere107.transform = startCamera * R * t
Sphere_Text107.transform = startCamera * R * t

progressupdate (100.0*108/287)
Sphere108 = Sphere name: "108_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[109] - min_value) * 255) / (max_value - min_value),255,255];
Sphere108.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text108 = Text text: (camera_altitude[109] as string) size: 0.15 
R.row1 = [0.930854176782, 0.365293842153667, -0.00842083440741975]
R.row2 = [-0.0597663467976666, 0.129482031662, -0.989778958791882]
R.row3 = [-0.36046981199258, 0.921843160391882, 0.142361168444]
t.row4 = [1.02191, 0.399014, -0.00275143] 
Sphere108.transform = startCamera * R * t
Sphere_Text108.transform = startCamera * R * t

progressupdate (100.0*109/287)
Sphere109 = Sphere name: "109_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[110] - min_value) * 255) / (max_value - min_value),255,255];
Sphere109.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text109 = Text text: (camera_altitude[110] as string) size: 0.15 
R.row1 = [0.9375308166435, 0.346690916495252, -0.0290064865754869]
R.row2 = [-0.156449889993252, 0.34566555027, -0.925223626631766]
R.row3 = [-0.310740083936513, 0.871963723887766, 0.3783118613775]
t.row4 = [1.02162, 0.39887, 0.00571326] 
Sphere109.transform = startCamera * R * t
Sphere_Text109.transform = startCamera * R * t

progressupdate (100.0*110/287)
Sphere110 = Sphere name: "110_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[111] - min_value) * 255) / (max_value - min_value),255,255];
Sphere110.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text110 = Text text: (camera_altitude[111] as string) size: 0.15 
R.row1 = [0.80884363895, 0.587047450152884, -0.0338712119523276]
R.row2 = [-0.248567433504884, 0.289141671564, -0.924451905058328]
R.row3 = [-0.532903554811673, 0.756156323146328, 0.37979127983]
t.row4 = [1.02181, 0.399008, 0.00570586] 
Sphere110.transform = startCamera * R * t
Sphere_Text110.transform = startCamera * R * t

progressupdate (100.0*111/287)
Sphere111 = Sphere name: "111_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[112] - min_value) * 255) / (max_value - min_value),255,255];
Sphere111.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text111 = Text text: (camera_altitude[112] as string) size: 0.15 
R.row1 = [0.78869145627, 0.614640708155242, -0.0135124640658134]
R.row2 = [-0.0954326177192416, 0.10068496875, -0.990330829845797]
R.row3 = [-0.607337140542187, 0.782354994197797, 0.138066146364]
t.row4 = [1.01491, 0.410127, 0.000354389] 
Sphere111.transform = startCamera * R * t
Sphere_Text111.transform = startCamera * R * t

progressupdate (100.0*112/287)
Sphere112 = Sphere name: "112_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[113] - min_value) * 255) / (max_value - min_value),255,255];
Sphere112.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text112 = Text text: (camera_altitude[113] as string) size: 0.15 
R.row1 = [0.43236668492, 0.901159258713075, -0.0311615180469538]
R.row2 = [-0.146219009177075, 0.0359692365500002, -0.988598106096347]
R.row3 = [-0.889763480441046, 0.431993292144347, 0.147318513486]
t.row4 = [1.01073, 0.426635, -0.00453017] 
Sphere112.transform = startCamera * R * t
Sphere_Text112.transform = startCamera * R * t

progressupdate (100.0*113/287)
Sphere113 = Sphere name: "113_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[114] - min_value) * 255) / (max_value - min_value),255,255];
Sphere113.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text113 = Text text: (camera_altitude[114] as string) size: 0.15 
R.row1 = [0.40788553782, 0.913018575205821, 0.00514483881407574]
R.row2 = [-0.367216953141821, 0.16920579363, -0.914615279080379]
R.row3 = [-0.835931275502076, 0.371169072972379, 0.404292495486]
t.row4 = [1.01183, 0.417094, -0.00434247] 
Sphere113.transform = startCamera * R * t
Sphere_Text113.transform = startCamera * R * t

progressupdate (100.0*114/287)
Sphere114 = Sphere name: "114_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[115] - min_value) * 255) / (max_value - min_value),255,255];
Sphere114.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text114 = Text text: (camera_altitude[115] as string) size: 0.15 
R.row1 = [0.0253138201580001, 0.999521933047633, 0.0177515031964017]
R.row2 = [-0.325459616807633, 0.02502974966, -0.945224602652399]
R.row3 = [-0.945217037688402, 0.0181498481723995, 0.325937623902]
t.row4 = [1.00736, 0.418154, -0.00339683] 
Sphere114.transform = startCamera * R * t
Sphere_Text114.transform = startCamera * R * t

progressupdate (100.0*115/287)
Sphere115 = Sphere name: "115_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[116] - min_value) * 255) / (max_value - min_value),255,255];
Sphere115.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text115 = Text text: (camera_altitude[116] as string) size: 0.15 
R.row1 = [0.0416698371499999, 0.999131198705793, 0.000687346068693695]
R.row2 = [-0.171458870705793, 0.00782861070000007, -0.985160174038111]
R.row3 = [-0.984309646568694, 0.0409336124381113, 0.17163612395]
t.row4 = [1.00731, 0.417809, -0.00364926] 
Sphere115.transform = startCamera * R * t
Sphere_Text115.transform = startCamera * R * t

progressupdate (100.0*116/287)
Sphere116 = Sphere name: "116_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[117] - min_value) * 255) / (max_value - min_value),255,255];
Sphere116.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text116 = Text text: (camera_altitude[117] as string) size: 0.15 
R.row1 = [-0.281863197264, 0.959304541465874, -0.016968640224382]
R.row2 = [-0.193439880313874, -0.0741413338000001, -0.978306738874118]
R.row3 = [-0.939752175167618, -0.272466253589882, 0.20646546908]
t.row4 = [1.00399, 0.413539, -0.00360148] 
Sphere116.transform = startCamera * R * t
Sphere_Text116.transform = startCamera * R * t

progressupdate (100.0*117/287)
Sphere117 = Sphere name: "117_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[118] - min_value) * 255) / (max_value - min_value),255,255];
Sphere117.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text117 = Text text: (camera_altitude[118] as string) size: 0.15 
R.row1 = [-0.16883445913, 0.98563139507512, -0.00506739109920601]
R.row2 = [-0.42247184794712, -0.077010695476, -0.903098494337383]
R.row3 = [-0.890512472176794, -0.150333315750617, 0.42940357599]
t.row4 = [1.00442, 0.411676, 0.000694284] 
Sphere117.transform = startCamera * R * t
Sphere_Text117.transform = startCamera * R * t

progressupdate (100.0*118/287)
Sphere118 = Sphere name: "118_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[119] - min_value) * 255) / (max_value - min_value),255,255];
Sphere118.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text118 = Text text: (camera_altitude[119] as string) size: 0.15 
R.row1 = [0.99651218221756, 0.0828794560820185, 0.00971938534812079]
R.row2 = [-0.00168766143801848, 0.13646589877198, -0.990643331513026]
R.row3 = [-0.0834303451441208, 0.987171745053466, 0.13612980304558]
t.row4 = [0.591229, 0.0697116, -0.00805563] 
Sphere118.transform = startCamera * R * t
Sphere_Text118.transform = startCamera * R * t

progressupdate (100.0*119/287)
Sphere119 = Sphere name: "119_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[120] - min_value) * 255) / (max_value - min_value),255,255];
Sphere119.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text119 = Text text: (camera_altitude[120] as string) size: 0.15 
R.row1 = [0.99825920000664, 0.0577278435314823, -0.0120857636625829]
R.row2 = [-0.0318846925314823, 0.35582446109232, -0.934008736185338]
R.row3 = [-0.0496178998374171, 0.932768164641978, 0.35704567641432]
t.row4 = [0.589242, 0.0786076, 0.00573742] 
Sphere119.transform = startCamera * R * t
Sphere_Text119.transform = startCamera * R * t

progressupdate (100.0*120/287)
Sphere120 = Sphere name: "120_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[121] - min_value) * 255) / (max_value - min_value),255,255];
Sphere120.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text120 = Text text: (camera_altitude[121] as string) size: 0.15 
R.row1 = [0.912058730902, 0.409107870044654, -0.0279217129302539]
R.row2 = [-0.179808451784654, 0.33780709367, -0.923880559451834]
R.row3 = [-0.368534655157746, 0.847653890531834, 0.381660961868]
t.row4 = [0.588861, 0.0603402, 0.00358314] 
Sphere120.transform = startCamera * R * t
Sphere_Text120.transform = startCamera * R * t

progressupdate (100.0*121/287)
Sphere121 = Sphere name: "121_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[122] - min_value) * 255) / (max_value - min_value),255,255];
Sphere121.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text121 = Text text: (camera_altitude[122] as string) size: 0.15 
R.row1 = [0.91998679355, 0.391897624236651, -0.00636803040651218]
R.row2 = [-0.0483934124926511, 0.0974516675, -0.994063001086342]
R.row3 = [-0.388950353285488, 0.914833003678342, 0.108619510494]
t.row4 = [0.589766, 0.0740801, -0.0100859] 
Sphere121.transform = startCamera * R * t
Sphere_Text121.transform = startCamera * R * t

progressupdate (100.0*122/287)
Sphere122 = Sphere name: "122_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[123] - min_value) * 255) / (max_value - min_value),255,255];
Sphere122.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text122 = Text text: (camera_altitude[123] as string) size: 0.15 
R.row1 = [0.6746624496, 0.737717739976318, -0.0245584043447595]
R.row2 = [-0.130984291272318, 0.0869127864000001, -0.987567356183909]
R.row3 = [-0.72641151872724, 0.669491376855909, 0.155266228704]
t.row4 = [0.582053, 0.0638925, -0.0095816] 
Sphere122.transform = startCamera * R * t
Sphere_Text122.transform = startCamera * R * t

progressupdate (100.0*123/287)
Sphere123 = Sphere name: "123_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[124] - min_value) * 255) / (max_value - min_value),255,255];
Sphere123.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text123 = Text text: (camera_altitude[124] as string) size: 0.15 
R.row1 = [0.669749068796, 0.742552430887971, -0.00721610901082381]
R.row2 = [-0.317964838855971, 0.27798133987, -0.906435180217193]
R.row3 = [-0.671069702861176, 0.609378586813193, 0.42228330755]
t.row4 = [0.593506, 0.0542364, -0.00566061] 
Sphere123.transform = startCamera * R * t
Sphere_Text123.transform = startCamera * R * t

progressupdate (100.0*124/287)
Sphere124 = Sphere name: "124_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[125] - min_value) * 255) / (max_value - min_value),255,255];
Sphere124.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text124 = Text text: (camera_altitude[125] as string) size: 0.15 
R.row1 = [0.344705344462, 0.938238323797621, 0.0297837750589775]
R.row2 = [-0.365263511317621, 0.16328927111, -0.916471047682515]
R.row3 = [-0.864731630506977, 0.305033541922515, 0.398990909048]
t.row4 = [0.583198, 0.0567648, -0.0059911] 
Sphere124.transform = startCamera * R * t
Sphere_Text124.transform = startCamera * R * t

progressupdate (100.0*125/287)
Sphere125 = Sphere name: "125_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[126] - min_value) * 255) / (max_value - min_value),255,255];
Sphere125.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text125 = Text text: (camera_altitude[126] as string) size: 0.15 
R.row1 = [0.33467693694, 0.942331417626631, 0.00168737495613486]
R.row2 = [-0.139042745750631, 0.0511530794999999, -0.988964345824354]
R.row3 = [-0.932018488408135, 0.330748940756354, 0.148144103676]
t.row4 = [0.570328, 0.0631629, -0.00854325] 
Sphere125.transform = startCamera * R * t
Sphere_Text125.transform = startCamera * R * t

progressupdate (100.0*126/287)
Sphere126 = Sphere name: "126_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[127] - min_value) * 255) / (max_value - min_value),255,255];
Sphere126.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text126 = Text text: (camera_altitude[127] as string) size: 0.15 
R.row1 = [0.0159130176300001, 0.999858371985253, -0.0054783063904375]
R.row2 = [-0.175145988765253, -0.002606874418, -0.984539022499977]
R.row3 = [-0.984413865449562, 0.0166264902119774, 0.175079699948]
t.row4 = [0.572133, 0.0591869, -0.00739243] 
Sphere126.transform = startCamera * R * t
Sphere_Text126.transform = startCamera * R * t

progressupdate (100.0*127/287)
Sphere127 = Sphere name: "127_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[128] - min_value) * 255) / (max_value - min_value),255,255];
Sphere127.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text127 = Text text: (camera_altitude[128] as string) size: 0.15 
R.row1 = [-0.00825090272999984, 0.999947973945104, -0.0059976668147555]
R.row2 = [-0.381387824149104, -0.00869133488999985, -0.924374268512836]
R.row3 = [-0.924378304697244, -0.00533948507916349, 0.381439693404]
t.row4 = [0.569282, 0.0577638, -0.00335558] 
Sphere127.transform = startCamera * R * t
Sphere_Text127.transform = startCamera * R * t

progressupdate (100.0*128/287)
Sphere128 = Sphere name: "128_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[129] - min_value) * 255) / (max_value - min_value),255,255];
Sphere128.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text128 = Text text: (camera_altitude[129] as string) size: 0.15 
R.row1 = [0.999708200114886, -0.0240905109049969, 0.00177817529846589]
R.row2 = [0.00498105906883687, 0.133553923686329, -0.991029030108876]
R.row3 = [0.0236369133688941, 0.990748705147941, 0.133634948924557]
t.row4 = [-0.00101946, -0.454821, -0.0167321] 
Sphere128.transform = startCamera * R * t
Sphere_Text128.transform = startCamera * R * t

progressupdate (100.0*129/287)
Sphere129 = Sphere name: "129_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[130] - min_value) * 255) / (max_value - min_value),255,255];
Sphere129.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text129 = Text text: (camera_altitude[130] as string) size: 0.15 
R.row1 = [0.998990574308899, -0.0329183324039923, -0.0305649445233591]
R.row2 = [-0.0147488539008077, 0.402338952371619, -0.915371967406213]
R.row3 = [0.0424299864551991, 0.914898765326661, 0.40144731342128]
t.row4 = [0.00230923, -0.467302, -0.00699084] 
Sphere129.transform = startCamera * R * t
Sphere_Text129.transform = startCamera * R * t

progressupdate (100.0*130/287)
Sphere130 = Sphere name: "130_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[131] - min_value) * 255) / (max_value - min_value),255,255];
Sphere130.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text130 = Text text: (camera_altitude[131] as string) size: 0.15 
R.row1 = [0.93783747306288, 0.342038899089161, -0.0589089605145674]
R.row2 = [-0.183569941596361, 0.34478445711, -0.920557306569054]
R.row3 = [-0.294555513717433, 0.874147052643454, 0.38613984473688]
t.row4 = [0.00257201, -0.482837, -0.011416] 
Sphere130.transform = startCamera * R * t
Sphere_Text130.transform = startCamera * R * t

progressupdate (100.0*131/287)
Sphere131 = Sphere name: "131_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[132] - min_value) * 255) / (max_value - min_value),255,255];
Sphere131.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text131 = Text text: (camera_altitude[132] as string) size: 0.15 
R.row1 = [0.909959128446, 0.413999198371131, -0.0240634225715528]
R.row2 = [-0.0651451348351308, 0.085399196796, -0.994214810085784]
R.row3 = [-0.409549137424447, 0.906262456981783, 0.104679812286]
t.row4 = [-0.00897504, -0.450055, -0.0181909] 
Sphere131.transform = startCamera * R * t
Sphere_Text131.transform = startCamera * R * t

progressupdate (100.0*132/287)
Sphere132 = Sphere name: "132_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[133] - min_value) * 255) / (max_value - min_value),255,255];
Sphere132.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text132 = Text text: (camera_altitude[133] as string) size: 0.15 
R.row1 = [0.662638113144, 0.748722221966707, -0.0180489706686341]
R.row2 = [-0.0927293742227064, 0.0581062508639999, -0.99399442994757]
R.row3 = [-0.743176960195366, 0.66033226329157, 0.107931959544]
t.row4 = [-0.014694, -0.443991, -0.0105819] 
Sphere132.transform = startCamera * R * t
Sphere_Text132.transform = startCamera * R * t

progressupdate (100.0*133/287)
Sphere133 = Sphere name: "133_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[134] - min_value) * 255) / (max_value - min_value),255,255];
Sphere133.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text133 = Text text: (camera_altitude[134] as string) size: 0.15 
R.row1 = [0.271678897518, 0.96141914571992, -0.0431717834538244]
R.row2 = [-0.13044941633992, -0.00765664917000014, -0.991425400874953]
R.row3 = [-0.953505913154176, 0.274981093834953, 0.123336416412]
t.row4 = [-0.0168019, -0.447009, -0.0117896] 
Sphere133.transform = startCamera * R * t
Sphere_Text133.transform = startCamera * R * t

progressupdate (100.0*134/287)
Sphere134 = Sphere name: "134_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[135] - min_value) * 255) / (max_value - min_value),255,255];
Sphere134.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text134 = Text text: (camera_altitude[135] as string) size: 0.15 
R.row1 = [0.32047277942, 0.947208847829986, 0.00962269418667333]
R.row2 = [-0.390076348125986, 0.14121957647, -0.909888715093405]
R.row3 = [-0.863213554274674, 0.287840980081405, 0.414740798454]
t.row4 = [0.00110036, -0.460589, -0.0112785] 
Sphere134.transform = startCamera * R * t
Sphere_Text134.transform = startCamera * R * t

progressupdate (100.0*135/287)
Sphere135 = Sphere name: "135_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[136] - min_value) * 255) / (max_value - min_value),255,255];
Sphere135.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text135 = Text text: (camera_altitude[136] as string) size: 0.15 
R.row1 = [0.803005320428, 0.594842626317641, -0.0366702233406946]
R.row2 = [-0.266065947333641, 0.302756818038, -0.915176060002095]
R.row3 = [-0.533283570939305, 0.744647943022095, 0.401382702566]
t.row4 = [0.00647077, -0.482262, -0.0122969] 
Sphere135.transform = startCamera * R * t
Sphere_Text135.transform = startCamera * R * t

progressupdate (100.0*136/287)
Sphere136 = Sphere name: "136_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[137] - min_value) * 255) / (max_value - min_value),255,255];
Sphere136.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text136 = Text text: (camera_altitude[137] as string) size: 0.15 
R.row1 = [-0.0090761182800001, 0.999842365960278, -0.0152599904298955]
R.row2 = [-0.313295875000278, -0.0173355632080001, -0.949497326460729]
R.row3 = [-0.949612193890105, -0.0038368579872714, 0.313403828528]
t.row4 = [-0.0276628, -0.451005, -0.00433771] 
Sphere136.transform = startCamera * R * t
Sphere_Text136.transform = startCamera * R * t

progressupdate (100.0*137/287)
Sphere137 = Sphere name: "137_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[138] - min_value) * 255) / (max_value - min_value),255,255];
Sphere137.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text137 = Text text: (camera_altitude[138] as string) size: 0.15 
R.row1 = [0.0367229623500001, 0.999275660723841, -0.00997887374263712]
R.row2 = [-0.151919186563841, -0.00428713813199999, -0.98838362046344]
R.row3 = [-0.987710476197363, 0.0378123568634404, 0.151651709118]
t.row4 = [-0.0227808, -0.449546, -0.0110773] 
Sphere137.transform = startCamera * R * t
Sphere_Text137.transform = startCamera * R * t

progressupdate (100.0*138/287)
Sphere138 = Sphere name: "138_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[139] - min_value) * 255) / (max_value - min_value),255,255];
Sphere138.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text138 = Text text: (camera_altitude[139] as string) size: 0.15 
R.row1 = [0.14260657235, 0.989757169347576, 0.00664162989470402]
R.row2 = [-0.346105876863576, 0.0561521057900001, -0.936513567982784]
R.row3 = [-0.927293959606704, 0.131254282750784, 0.350568432316]
t.row4 = [-0.994016, -0.297421, -0.0443036] 
Sphere138.transform = startCamera * R * t
Sphere_Text138.transform = startCamera * R * t

progressupdate (100.0*139/287)
Sphere139 = Sphere name: "139_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[140] - min_value) * 255) / (max_value - min_value),255,255];
Sphere139.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text139 = Text text: (camera_altitude[140] as string) size: 0.15 
R.row1 = [0.10342206023, 0.994546734330203, -0.0134413797993757]
R.row2 = [-0.121421914602203, -0.000788518073999933, -0.992600673429946]
R.row3 = [-0.987198357024624, 0.104288884701946, 0.12067821848]
t.row4 = [-0.974824, -0.301905, -0.0492369] 
Sphere139.transform = startCamera * R * t
Sphere_Text139.transform = startCamera * R * t

progressupdate (100.0*140/287)
Sphere140 = Sphere name: "140_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[141] - min_value) * 255) / (max_value - min_value),255,255];
Sphere140.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text140 = Text text: (camera_altitude[141] as string) size: 0.15 
R.row1 = [0.4009683918, 0.916077913331417, -0.00506018613074916]
R.row2 = [-0.126584086299417, 0.0499336345739999, -0.990698289709825]
R.row3 = [-0.907304148493251, 0.397879239021825, 0.13598269479]
t.row4 = [-0.981524, -0.290064, -0.0461367] 
Sphere140.transform = startCamera * R * t
Sphere_Text140.transform = startCamera * R * t

progressupdate (100.0*141/287)
Sphere141 = Sphere name: "141_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[142] - min_value) * 255) / (max_value - min_value),255,255];
Sphere141.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text141 = Text text: (camera_altitude[142] as string) size: 0.15 
R.row1 = [0.433571172572, 0.900772316225643, 0.0250054521260974]
R.row2 = [-0.422799332957643, 0.227855739548, -0.877110304354934]
R.row3 = [-0.795774316226097, 0.369717454654934, 0.47963761462]
t.row4 = [-0.983892, -0.289556, -0.0446834] 
Sphere141.transform = startCamera * R * t
Sphere_Text141.transform = startCamera * R * t

progressupdate (100.0*142/287)
Sphere142 = Sphere name: "142_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[143] - min_value) * 255) / (max_value - min_value),255,255];
Sphere142.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text142 = Text text: (camera_altitude[143] as string) size: 0.15 
R.row1 = [0.723402186588, 0.690423685585252, 0.00210019584276488]
R.row2 = [-0.348614524265252, 0.36788856327, -0.862047515213893]
R.row3 = [-0.595950660634765, 0.622874898673893, 0.506823115782]
t.row4 = [-0.969924, -0.298478, -0.0549591] 
Sphere142.transform = startCamera * R * t
Sphere_Text142.transform = startCamera * R * t

progressupdate (100.0*143/287)
Sphere143 = Sphere name: "143_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[144] - min_value) * 255) / (max_value - min_value),255,255];
Sphere143.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text143 = Text text: (camera_altitude[144] as string) size: 0.15 
R.row1 = [0.71223204758, 0.701851733608069, 0.0113865899789293]
R.row2 = [-0.0685336326400695, 0.0856729428540001, -0.993963423904467]
R.row3 = [-0.698590474882929, 0.707152240252467, 0.10911946439]
t.row4 = [-0.986269, -0.279995, -0.045071] 
Sphere143.transform = startCamera * R * t
Sphere_Text143.transform = startCamera * R * t

progressupdate (100.0*144/287)
Sphere144 = Sphere name: "144_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[145] - min_value) * 255) / (max_value - min_value),255,255];
Sphere144.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text144 = Text text: (camera_altitude[145] as string) size: 0.15 
R.row1 = [0.931978033584, 0.362210773412736, 0.0148425247396897]
R.row2 = [-0.0198406379247358, 0.0918467774000001, -0.995575471055798]
R.row3 = [-0.36197139942769, 0.927559984639798, 0.0927856718000001]
t.row4 = [-0.969036, -0.308513, -0.0378897] 
Sphere144.transform = startCamera * R * t
Sphere_Text144.transform = startCamera * R * t

progressupdate (100.0*145/287)
Sphere145 = Sphere name: "145_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[146] - min_value) * 255) / (max_value - min_value),255,255];
Sphere145.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text145 = Text text: (camera_altitude[146] as string) size: 0.15 
R.row1 = [0.94174702871, 0.334572495831117, -0.0342604575162644]
R.row2 = [-0.195265555263117, 0.460985022284, -0.865658230572324]
R.row3 = [-0.273831876967736, 0.821920953780324, 0.49946175919]
t.row4 = [-0.971868, -0.328188, -0.0606161] 
Sphere145.transform = startCamera * R * t
Sphere_Text145.transform = startCamera * R * t

progressupdate (100.0*146/287)
Sphere146 = Sphere name: "146_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[147] - min_value) * 255) / (max_value - min_value),255,255];
Sphere146.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text146 = Text text: (camera_altitude[147] as string) size: 0.15 
R.row1 = [0.95501807482782, 0.0700069077420266, 0.288165767607056]
R.row2 = [0.157023452761973, 0.70495057273782, -0.691656218998519]
R.row3 = [-0.251563336030656, 0.705792974508119, 0.662247812454]
t.row4 = [-0.396685, -0.369218, -0.724326] 
Sphere146.transform = startCamera * R * t
Sphere_Text146.transform = startCamera * R * t

progressupdate (100.0*147/287)
Sphere147 = Sphere name: "147_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[148] - min_value) * 255) / (max_value - min_value),255,255];
Sphere147.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text147 = Text text: (camera_altitude[148] as string) size: 0.15 
R.row1 = [0.93442958818552, 0.0800638919738697, 0.347031868746137]
R.row2 = [0.28796808530613, 0.40349784879352, -0.868483660101975]
R.row3 = [-0.209560794445337, 0.911470931637975, 0.353984483008]
t.row4 = [-0.444836, -0.165559, -0.565145] 
Sphere147.transform = startCamera * R * t
Sphere_Text147.transform = startCamera * R * t

progressupdate (100.0*148/287)
Sphere148 = Sphere name: "148_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[149] - min_value) * 255) / (max_value - min_value),255,255];
Sphere148.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text148 = Text text: (camera_altitude[149] as string) size: 0.15 
R.row1 = [0.93104433291862, -0.269791730994516, 0.245700777424705]
R.row2 = [0.337779774042516, 0.38243859035, -0.86002648148699]
R.row3 = [0.138062574175295, 0.88371553482899, 0.44719747216862]
t.row4 = [-0.471192, 0.0234501, -0.490987] 
Sphere148.transform = startCamera * R * t
Sphere_Text148.transform = startCamera * R * t

progressupdate (100.0*149/287)
Sphere149 = Sphere name: "149_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[150] - min_value) * 255) / (max_value - min_value),255,255];
Sphere149.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text149 = Text text: (camera_altitude[150] as string) size: 0.15 
R.row1 = [0.93593816716152, -0.284964461435002, 0.206917865273625]
R.row2 = [0.343466426420602, 0.60885826103, -0.715068130947944]
R.row3 = [0.077785353198375, 0.740328895623144, 0.66772941011552]
t.row4 = [-0.38242, -0.434194, -0.734676] 
Sphere149.transform = startCamera * R * t
Sphere_Text149.transform = startCamera * R * t

progressupdate (100.0*150/287)
Sphere150 = Sphere name: "150_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[151] - min_value) * 255) / (max_value - min_value),255,255];
Sphere150.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text150 = Text text: (camera_altitude[151] as string) size: 0.15 
R.row1 = [0.90474952762968, -0.396521226307251, 0.155560950568146]
R.row2 = [0.35226164327205, 0.491237759532, -0.796616092160619]
R.row3 = [0.239457776931854, 0.775536189160619, 0.58412634966168]
t.row4 = [-0.326432, -0.228411, -0.404344] 
Sphere150.transform = startCamera * R * t
Sphere_Text150.transform = startCamera * R * t

progressupdate (100.0*151/287)
Sphere151 = Sphere name: "151_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[152] - min_value) * 255) / (max_value - min_value),255,255];
Sphere151.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text151 = Text text: (camera_altitude[152] as string) size: 0.15 
R.row1 = [0.434387531822, -0.899533340324018, 0.0463383409619465]
R.row2 = [-0.0551941053039822, -0.077931732082, -0.995429684043224]
R.row3 = [0.899033415918054, 0.429844640283224, -0.0835015106600001]
t.row4 = [-1.37989, 0.415971, 0.26787] 
Sphere151.transform = startCamera * R * t
Sphere_Text151.transform = startCamera * R * t

progressupdate (100.0*152/287)
Sphere152 = Sphere name: "152_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[153] - min_value) * 255) / (max_value - min_value),255,255];
Sphere152.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text152 = Text text: (camera_altitude[153] as string) size: 0.15 
R.row1 = [-0.07935796789, 0.996748938668915, -0.0139235841204794]
R.row2 = [-0.107050022756915, -0.0224081804239999, -0.994001089575776]
R.row3 = [-0.991081533255521, -0.0773913865522243, 0.10848026423]
t.row4 = [-0.660449, 0.0721007, -0.0475611] 
Sphere152.transform = startCamera * R * t
Sphere_Text152.transform = startCamera * R * t

progressupdate (100.0*153/287)
Sphere153 = Sphere name: "153_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[154] - min_value) * 255) / (max_value - min_value),255,255];
Sphere153.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text153 = Text text: (camera_altitude[154] as string) size: 0.15 
R.row1 = [-0.0486862185680002, 0.998808347151855, 0.00339673097667537]
R.row2 = [-0.351662618031855, -0.0139583391460001, -0.936022738958444]
R.row3 = [-0.934859912072675, -0.0467659109615565, 0.351923137022]
t.row4 = [-0.658262, 0.0729548, -0.0402803] 
Sphere153.transform = startCamera * R * t
Sphere_Text153.transform = startCamera * R * t

progressupdate (100.0*154/287)
Sphere154 = Sphere name: "154_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[155] - min_value) * 255) / (max_value - min_value),255,255];
Sphere154.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text154 = Text text: (camera_altitude[155] as string) size: 0.15 
R.row1 = [0.315191800374, 0.948848243325243, 0.0184699787654946]
R.row2 = [-0.368588203029243, 0.140326745324, -0.918940227182621]
R.row3 = [-0.874526652289495, 0.282834608358621, 0.393964108454]
t.row4 = [-0.61663, 0.0620744, -0.0327727] 
Sphere154.transform = startCamera * R * t
Sphere_Text154.transform = startCamera * R * t

progressupdate (100.0*155/287)
Sphere155 = Sphere name: "155_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[156] - min_value) * 255) / (max_value - min_value),255,255];
Sphere155.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text155 = Text text: (camera_altitude[156] as string) size: 0.15 
R.row1 = [0.32985471835, 0.943491039472418, 0.0319456290828423]
R.row2 = [-0.057814754392418, 0.0539655731120001, -0.996867679831801]
R.row3 = [-0.942259687642842, 0.326974579063801, 0.0723485016380001]
t.row4 = [-0.650334, 0.0751727, -0.0419437] 
Sphere155.transform = startCamera * R * t
Sphere_Text155.transform = startCamera * R * t

progressupdate (100.0*156/287)
Sphere156 = Sphere name: "156_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[157] - min_value) * 255) / (max_value - min_value),255,255];
Sphere156.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text156 = Text text: (camera_altitude[157] as string) size: 0.15 
R.row1 = [0.652939921388, 0.756752108601214, 0.0315547965521719]
R.row2 = [-0.047819251101214, 0.0827660821880001, -0.995421064104718]
R.row3 = [-0.755898656092172, 0.648441224604718, 0.0902285983000001]
t.row4 = [-0.639365, 0.077923, -0.0415492] 
Sphere156.transform = startCamera * R * t
Sphere_Text156.transform = startCamera * R * t

progressupdate (100.0*157/287)
Sphere157 = Sphere name: "157_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[158] - min_value) * 255) / (max_value - min_value),255,255];
Sphere157.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text157 = Text text: (camera_altitude[158] as string) size: 0.15 
R.row1 = [0.66760363239, 0.744222975654788, 0.0209177562661694]
R.row2 = [-0.312239060450788, 0.30537784311, -0.899583871613033]
R.row3 = [-0.675878805074169, 0.594034119765033, 0.436246839996]
t.row4 = [-0.622713, 0.0648526, -0.0303863] 
Sphere157.transform = startCamera * R * t
Sphere_Text157.transform = startCamera * R * t

progressupdate (100.0*158/287)
Sphere158 = Sphere name: "158_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[159] - min_value) * 255) / (max_value - min_value),255,255];
Sphere158.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text158 = Text text: (camera_altitude[159] as string) size: 0.15 
R.row1 = [0.95176512884382, 0.304938861886378, -0.03399161703049]
R.row2 = [-0.169522923108778, 0.430275721592, -0.886636781297245]
R.row3 = [-0.25574424344951, 0.849632328669245, 0.46121555483582]
t.row4 = [-0.631142, 0.0794867, -0.0159694] 
Sphere158.transform = startCamera * R * t
Sphere_Text158.transform = startCamera * R * t

progressupdate (100.0*159/287)
Sphere159 = Sphere name: "159_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[160] - min_value) * 255) / (max_value - min_value),255,255];
Sphere159.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text159 = Text text: (camera_altitude[160] as string) size: 0.15 
R.row1 = [0.95604214248032, 0.171137378406171, 0.238107999684812]
R.row2 = [0.248889934009829, -0.0442630297196802, -0.967519811140122]
R.row3 = [-0.155039422568012, 0.984252397463322, -0.0849116925840002]
t.row4 = [-0.875823, -0.198022, 0.363445] 
Sphere159.transform = startCamera * R * t
Sphere_Text159.transform = startCamera * R * t

progressupdate (100.0*160/287)
Sphere160 = Sphere name: "160_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[161] - min_value) * 255) / (max_value - min_value),255,255];
Sphere160.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text160 = Text text: (camera_altitude[161] as string) size: 0.15 
R.row1 = [0.96907910263358, 0.0332190404293117, 0.244503963550391]
R.row2 = [0.228678038194688, 0.25132839611358, -0.940500075573843]
R.row3 = [-0.0926932990367913, 0.967331655979443, 0.235960631576]
t.row4 = [-0.193887, 0.247253, -0.305614] 
Sphere160.transform = startCamera * R * t
Sphere_Text160.transform = startCamera * R * t

progressupdate (100.0*161/287)
Sphere161 = Sphere name: "161_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[162] - min_value) * 255) / (max_value - min_value),255,255];
Sphere161.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text161 = Text text: (camera_altitude[162] as string) size: 0.15 
R.row1 = [0.96915364058222, -0.176264351676513, 0.172255912160621]
R.row2 = [0.242290074556113, 0.553426305382, -0.796878186602458]
R.row3 = [0.0451302638793787, 0.814033293446458, 0.57906222156422]
t.row4 = [-0.607197, -0.00956852, -0.447825] 
Sphere161.transform = startCamera * R * t
Sphere_Text161.transform = startCamera * R * t

progressupdate (100.0*162/287)
Sphere162 = Sphere name: "162_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[163] - min_value) * 255) / (max_value - min_value),255,255];
Sphere162.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text162 = Text text: (camera_altitude[163] as string) size: 0.15 
R.row1 = [0.67315073766, 0.739504981787508, -0.00068286108020893]
R.row2 = [0.0188886188284917, -0.01811686897, -0.999657440895368]
R.row3 = [-0.739264028927791, 0.672907245443368, -0.0261636114340001]
t.row4 = [0.402137, 1.04347, -0.0387966] 
Sphere162.transform = startCamera * R * t
Sphere_Text162.transform = startCamera * R * t

progressupdate (100.0*163/287)
Sphere163 = Sphere name: "163_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[164] - min_value) * 255) / (max_value - min_value),255,255];
Sphere163.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text163 = Text text: (camera_altitude[164] as string) size: 0.15 
R.row1 = [0.9034033758, 0.428731227488831, 0.00720244188346422]
R.row2 = [-0.00033210556883051, 0.017496659352, -0.999846866583784]
R.row3 = [-0.428791593083464, 0.903262642583784, 0.015948925152]
t.row4 = [0.417007, 1.03734, -0.0389453] 
Sphere163.transform = startCamera * R * t
Sphere_Text163.transform = startCamera * R * t

progressupdate (100.0*164/287)
Sphere164 = Sphere name: "164_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[165] - min_value) * 255) / (max_value - min_value),255,255];
Sphere164.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text164 = Text text: (camera_altitude[165] as string) size: 0.15 
R.row1 = [0.999657902133426, 0.0214009190200907, 0.0150359358635506]
R.row2 = [0.0135000839447093, 0.0701847514032063, -0.99744265419319]
R.row3 = [-0.0224014828902706, 0.997304417585506, 0.0698718271462201]
t.row4 = [0.430199, 1.03564, -0.0399668] 
Sphere164.transform = startCamera * R * t
Sphere_Text164.transform = startCamera * R * t

progressupdate (100.0*165/287)
Sphere165 = Sphere name: "165_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[166] - min_value) * 255) / (max_value - min_value),255,255];
Sphere165.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text165 = Text text: (camera_altitude[166] as string) size: 0.15 
R.row1 = [0.999617633901446, 0.0224386201354342, -0.0161584132789227]
R.row2 = [-0.0230363149924142, 0.35257591888728, -0.935499625661262]
R.row3 = [-0.0152942533274773, 0.93551415261727, 0.352958008930166]
t.row4 = [0.439367, 1.00863, -0.0353427] 
Sphere165.transform = startCamera * R * t
Sphere_Text165.transform = startCamera * R * t

progressupdate (100.0*166/287)
Sphere166 = Sphere name: "166_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[167] - min_value) * 255) / (max_value - min_value),255,255];
Sphere166.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text166 = Text text: (camera_altitude[167] as string) size: 0.15 
R.row1 = [0.895959748144, 0.443266517845033, -0.0277655157214622]
R.row2 = [-0.176721886909033, 0.298452134854, -0.93792094437026]
R.row3 = [-0.407462273582538, 0.84524618742626, 0.345735995014]
t.row4 = [0.434052, 1.00837, -0.0119483] 
Sphere166.transform = startCamera * R * t
Sphere_Text166.transform = startCamera * R * t

progressupdate (100.0*167/287)
Sphere167 = Sphere name: "167_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[168] - min_value) * 255) / (max_value - min_value),255,255];
Sphere167.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text167 = Text text: (camera_altitude[168] as string) size: 0.15 
R.row1 = [-0.348779135784, 0.909089832156357, 0.227835009407451]
R.row2 = [-0.260696704620357, 0.139398831446, -0.955303718192061]
R.row3 = [-0.900216830903451, -0.392585841391939, 0.188377319486]
t.row4 = [-0.698685, 1.08607, 0.603769] 
Sphere167.transform = startCamera * R * t
Sphere_Text167.transform = startCamera * R * t

progressupdate (100.0*168/287)
Sphere168 = Sphere name: "168_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[169] - min_value) * 255) / (max_value - min_value),255,255];
Sphere168.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text168 = Text text: (camera_altitude[169] as string) size: 0.15 
R.row1 = [0.99746274114316, 0.0699229895935229, -0.0133736890003274]
R.row2 = [-0.0207716311219229, 0.10617007770118, -0.994131004416148]
R.row3 = [-0.0680927262760726, 0.991886430054988, 0.10735311127798]
t.row4 = [0.685902, 1.59963, -0.033634] 
Sphere168.transform = startCamera * R * t
Sphere_Text168.transform = startCamera * R * t

progressupdate (100.0*169/287)
Sphere169 = Sphere name: "169_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[170] - min_value) * 255) / (max_value - min_value),255,255];
Sphere169.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text169 = Text text: (camera_altitude[170] as string) size: 0.15 
R.row1 = [0.88357365347, 0.468165559376564, -0.0108907257473992]
R.row2 = [-0.0398731530405642, 0.0520405038199999, -0.99784864464946]
R.row3 = [-0.466591610040601, 0.88210702013746, 0.0646488550859999]
t.row4 = [0.665827, 1.61878, -0.0354156] 
Sphere169.transform = startCamera * R * t
Sphere_Text169.transform = startCamera * R * t

progressupdate (100.0*170/287)
Sphere170 = Sphere name: "170_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[171] - min_value) * 255) / (max_value - min_value),255,255];
Sphere170.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text170 = Text text: (camera_altitude[171] as string) size: 0.15 
R.row1 = [0.540998628174, 0.840453526347031, 0.0309572990535555]
R.row2 = [-0.592245110607031, 0.406845392942, -0.695501657225873]
R.row3 = [-0.597131654893555, 0.357931133449873, 0.717857291132]
t.row4 = [0.645089, 1.63791, 0.00515775] 
Sphere170.transform = startCamera * R * t
Sphere_Text170.transform = startCamera * R * t

progressupdate (100.0*171/287)
Sphere171 = Sphere name: "171_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[172] - min_value) * 255) / (max_value - min_value),255,255];
Sphere171.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text171 = Text text: (camera_altitude[172] as string) size: 0.15 
R.row1 = [0.526491944502, 0.848424609934184, 0.0546069009606965]
R.row2 = [-0.273928910034184, 0.230090479734, -0.933820819741808]
R.row3 = [-0.804841092776697, 0.476690730341808, 0.353548812732]
t.row4 = [0.671334, 1.59578, -0.0269255] 
Sphere171.transform = startCamera * R * t
Sphere_Text171.transform = startCamera * R * t

progressupdate (100.0*172/287)
Sphere172 = Sphere name: "172_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[173] - min_value) * 255) / (max_value - min_value),255,255];
Sphere172.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text172 = Text text: (camera_altitude[173] as string) size: 0.15 
R.row1 = [0.537395479142, 0.843234133449711, 0.0127395126694413]
R.row2 = [-0.0294409358497112, 0.033855496142, -0.998993011325541]
R.row3 = [-0.842816308749441, 0.536479264805541, 0.0430193926]
t.row4 = [0.675088, 1.60183, -0.0332814] 
Sphere172.transform = startCamera * R * t
Sphere_Text172.transform = startCamera * R * t

progressupdate (100.0*173/287)
Sphere173 = Sphere name: "173_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[174] - min_value) * 255) / (max_value - min_value),255,255];
Sphere173.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text173 = Text text: (camera_altitude[174] as string) size: 0.15 
R.row1 = [0.156264871622, 0.987709928226042, 0.00322297698830493]
R.row2 = [-0.0583095145380418, 0.0124823798879999, -0.998220512064679]
R.row3 = [-0.985992540748305, 0.155798869944679, 0.0595434439099999]
t.row4 = [0.681993, 1.58763, -0.0310789] 
Sphere173.transform = startCamera * R * t
Sphere_Text173.transform = startCamera * R * t

progressupdate (100.0*174/287)
Sphere174 = Sphere name: "174_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[175] - min_value) * 255) / (max_value - min_value),255,255];
Sphere174.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text174 = Text text: (camera_altitude[175] as string) size: 0.15 
R.row1 = [0.21259654264, 0.976406078234441, 0.0378666138485679]
R.row2 = [-0.334077039314441, 0.109047833558, -0.936216375523951]
R.row3 = [-0.918256631808568, 0.186385998355951, 0.349378044182]
t.row4 = [0.669718, 1.59415, -0.027066] 
Sphere174.transform = startCamera * R * t
Sphere_Text174.transform = startCamera * R * t

progressupdate (100.0*175/287)
Sphere175 = Sphere name: "175_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[176] - min_value) * 255) / (max_value - min_value),255,255];
Sphere175.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text175 = Text text: (camera_altitude[176] as string) size: 0.15 
R.row1 = [0.175690566588, 0.983821427153142, 0.0350460309641688]
R.row2 = [-0.626070428713142, 0.13913484735, -0.767253095493159]
R.row3 = [-0.759716159564169, 0.112857847433159, 0.640386182838]
t.row4 = [0.75676, 1.5842, -0.0835253] 
Sphere175.transform = startCamera * R * t
Sphere_Text175.transform = startCamera * R * t

progressupdate (100.0*176/287)
Sphere176 = Sphere name: "176_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[177] - min_value) * 255) / (max_value - min_value),255,255];
Sphere176.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text176 = Text text: (camera_altitude[177] as string) size: 0.15 
R.row1 = [-0.125167230498, 0.991589005784157, 0.0329303510070509]
R.row2 = [-0.509077712604157, -0.0357006873299999, -0.859979850609237]
R.row3 = [-0.851570928895051, -0.124405403950763, 0.509264419068]
t.row4 = [0.686107, 1.57653, -0.0410886] 
Sphere176.transform = startCamera * R * t
Sphere_Text176.transform = startCamera * R * t

progressupdate (100.0*177/287)
Sphere177 = Sphere name: "177_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[178] - min_value) * 255) / (max_value - min_value),255,255];
Sphere177.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text177 = Text text: (camera_altitude[178] as string) size: 0.15 
R.row1 = [-0.0532020686279999, 0.998143245800033, 0.0296580639536126]
R.row2 = [-0.199957673300033, 0.0184500485720002, -0.97963081035466]
R.row3 = [-0.978359069453613, -0.0580487430653399, 0.1986048203]
t.row4 = [0.664252, 1.57928, -0.0297863] 
Sphere177.transform = startCamera * R * t
Sphere_Text177.transform = startCamera * R * t

progressupdate (100.0*178/287)
Sphere178 = Sphere name: "178_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[179] - min_value) * 255) / (max_value - min_value),255,255];
Sphere178.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text178 = Text text: (camera_altitude[179] as string) size: 0.15 
R.row1 = [0.99397824682582, -0.104943428963716, -0.0315296932177721]
R.row2 = [-0.00424163747548437, 0.25067419295, -0.96806221778375]
R.row3 = [0.109495448985772, 0.96236652357935, 0.24871956285182]
t.row4 = [0.417775, 1.95333, -0.0273564] 
Sphere178.transform = startCamera * R * t
Sphere_Text178.transform = startCamera * R * t

progressupdate (100.0*179/287)
Sphere179 = Sphere name: "179_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[180] - min_value) * 255) / (max_value - min_value),255,255];
Sphere179.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text179 = Text text: (camera_altitude[180] as string) size: 0.15 
R.row1 = [0.99410933467436, -0.10834113256641, -0.00297148237903732]
R.row2 = [0.00163026183200976, 0.04236128509518, -0.999101027810223]
R.row3 = [0.108369612713437, 0.993210813734583, 0.04228837335518]
t.row4 = [0.418053, 1.95394, -0.0329062] 
Sphere179.transform = startCamera * R * t
Sphere_Text179.transform = startCamera * R * t

progressupdate (100.0*180/287)
Sphere180 = Sphere name: "180_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[181] - min_value) * 255) / (max_value - min_value),255,255];
Sphere180.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text180 = Text text: (camera_altitude[181] as string) size: 0.15 
R.row1 = [0.9693248732659, 0.244841806159311, 0.0214890675622062]
R.row2 = [0.0195638053606885, 0.01029290341118, -0.9997556269705]
R.row3 = [-0.245003158322206, 0.96950840434522, 0.00518712985472004]
t.row4 = [0.406451, 1.95445, -0.0334093] 
Sphere180.transform = startCamera * R * t
Sphere_Text180.transform = startCamera * R * t

progressupdate (100.0*181/287)
Sphere181 = Sphere name: "181_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[182] - min_value) * 255) / (max_value - min_value),255,255];
Sphere181.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text181 = Text text: (camera_altitude[182] as string) size: 0.15 
R.row1 = [0.96995594670432, 0.243079052002636, -0.00990130953087265]
R.row2 = [-0.0977111555802359, 0.351977858784, -0.930894256616188]
R.row3 = [-0.222795851685127, 0.903893888353788, 0.36515455230432]
t.row4 = [0.405337, 1.95137, -0.023254] 
Sphere181.transform = startCamera * R * t
Sphere_Text181.transform = startCamera * R * t

progressupdate (100.0*182/287)
Sphere182 = Sphere name: "182_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[183] - min_value) * 255) / (max_value - min_value),255,255];
Sphere182.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text182 = Text text: (camera_altitude[183] as string) size: 0.15 
R.row1 = [0.879699556126, 0.475236591619044, -0.0166994891548503]
R.row2 = [-0.185673406915044, 0.310941860246, -0.932116165245147]
R.row3 = [-0.43778313914115, 0.823082827869147, 0.361774213496]
t.row4 = [0.40317, 1.95556, -0.0226737] 
Sphere182.transform = startCamera * R * t
Sphere_Text182.transform = startCamera * R * t

progressupdate (100.0*183/287)
Sphere183 = Sphere name: "183_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[184] - min_value) * 255) / (max_value - min_value),255,255];
Sphere183.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text183 = Text text: (camera_altitude[184] as string) size: 0.15 
R.row1 = [0.863483868216, 0.504289814480964, 0.00934838710627009]
R.row2 = [0.0036962541910362, 0.0122072083200001, -0.999918657576699]
R.row3 = [-0.50436291203427, 0.863448184360699, 0.00867674412000009]
t.row4 = [0.394467, 1.96951, -0.0348366] 
Sphere183.transform = startCamera * R * t
Sphere_Text183.transform = startCamera * R * t

progressupdate (100.0*184/287)
Sphere184 = Sphere name: "184_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[185] - min_value) * 255) / (max_value - min_value),255,255];
Sphere184.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text184 = Text text: (camera_altitude[185] as string) size: 0.15 
R.row1 = [0.607118077944, 0.794593372596535, 0.00538624723230485]
R.row2 = [0.0661874776754652, -0.0438140600100001, -0.996844795313894]
R.row3 = [-0.791850274504305, 0.605558998257894, -0.0791924390100001]
t.row4 = [0.390259, 1.9529, -0.0340377] 
Sphere184.transform = startCamera * R * t
Sphere_Text184.transform = startCamera * R * t

progressupdate (100.0*185/287)
Sphere185 = Sphere name: "185_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[186] - min_value) * 255) / (max_value - min_value),255,255];
Sphere185.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text185 = Text text: (camera_altitude[186] as string) size: 0.15 
R.row1 = [0.63311157539, 0.772964222160233, 0.0411830592284946]
R.row2 = [-0.224151664568233, 0.234000496184, -0.946044290219508]
R.row3 = [-0.740895245212495, 0.589720339691508, 0.32140963983]
t.row4 = [0.394767, 1.95138, -0.0218449] 
Sphere185.transform = startCamera * R * t
Sphere_Text185.transform = startCamera * R * t

progressupdate (100.0*186/287)
Sphere186 = Sphere name: "186_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[187] - min_value) * 255) / (max_value - min_value),255,255];
Sphere186.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text186 = Text text: (camera_altitude[187] as string) size: 0.15 
R.row1 = [0.27729038775, 0.960455690503908, 0.0251973697062908]
R.row2 = [-0.356344051047908, 0.12716359995, -0.925661026580747]
R.row3 = [-0.892260588698291, 0.247697972188747, 0.377513915544]
t.row4 = [0.379237, 1.9233, -0.0262188] 
Sphere186.transform = startCamera * R * t
Sphere_Text186.transform = startCamera * R * t

progressupdate (100.0*187/287)
Sphere187 = Sphere name: "187_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[188] - min_value) * 255) / (max_value - min_value),255,255];
Sphere187.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text187 = Text text: (camera_altitude[188] as string) size: 0.15 
R.row1 = [0.282286194662, 0.95816355491385, 0.0472980585024391]
R.row2 = [0.0412604721261496, 0.03713131643, -0.998458230864017]
R.row3 = [-0.958442527094439, 0.283802514744017, -0.029052622632]
t.row4 = [0.386456, 1.94421, -0.0339687] 
Sphere187.transform = startCamera * R * t
Sphere_Text187.transform = startCamera * R * t

progressupdate (100.0*188/287)
Sphere188 = Sphere name: "188_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[189] - min_value) * 255) / (max_value - min_value),255,255];
Sphere188.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text188 = Text text: (camera_altitude[189] as string) size: 0.15 
R.row1 = [-0.0635179328640001, 0.997839979595479, 0.0167585000992939]
R.row2 = [-0.0507872540594791, 0.0135386776559999, -0.998617724172981]
R.row3 = [-0.996687577443294, -0.0642812517630187, 0.049817603736]
t.row4 = [0.398852, 1.93211, -0.0338145] 
Sphere188.transform = startCamera * R * t
Sphere_Text188.transform = startCamera * R * t

progressupdate (100.0*189/287)
Sphere189 = Sphere name: "189_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[190] - min_value) * 255) / (max_value - min_value),255,255];
Sphere189.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text189 = Text text: (camera_altitude[190] as string) size: 0.15 
R.row1 = [0.00684724171999995, 0.998985313168068, 0.0445135861880851]
R.row2 = [-0.373157736208068, 0.043851716848, -0.92673099162462]
R.row3 = [-0.927742647068085, -0.0102650379433795, 0.373079361272]
t.row4 = [0.381223, 1.92752, -0.0303642] 
Sphere189.transform = startCamera * R * t
Sphere_Text189.transform = startCamera * R * t

progressupdate (100.0*190/287)
Sphere190 = Sphere name: "190_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[191] - min_value) * 255) / (max_value - min_value),255,255];
Sphere190.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text190 = Text text: (camera_altitude[191] as string) size: 0.15 
R.row1 = [-0.27815442442, 0.959931428545563, 0.0340847277538478]
R.row2 = [-0.341385877729563, -0.0656288084499999, -0.937629213489133]
R.row3 = [-0.897822810281848, -0.272441758898867, 0.345961976734]
t.row4 = [0.391259, 1.92259, -0.0251306] 
Sphere190.transform = startCamera * R * t
Sphere_Text190.transform = startCamera * R * t

progressupdate (100.0*191/287)
Sphere191 = Sphere name: "191_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[192] - min_value) * 255) / (max_value - min_value),255,255];
Sphere191.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text191 = Text text: (camera_altitude[192] as string) size: 0.15 
R.row1 = [-0.2860321429, 0.957752264807362, 0.029936808186617]
R.row2 = [-0.0911822040593622, 0.00389540076399986, -0.995826607153959]
R.row3 = [-0.953871804222617, -0.287568122554041, 0.08621575262]
t.row4 = [0.398817, 1.92747, -0.0312727] 
Sphere191.transform = startCamera * R * t
Sphere_Text191.transform = startCamera * R * t

progressupdate (100.0*192/287)
Sphere192 = Sphere name: "192_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[193] - min_value) * 255) / (max_value - min_value),255,255];
Sphere192.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text192 = Text text: (camera_altitude[193] as string) size: 0.15 
R.row1 = [0.946001352678, -0.324026926505935, 0.00938038541381242]
R.row2 = [0.035448874089935, 0.0746431112880001, -0.996580043580546]
R.row3 = [0.322218587386188, 0.943098593380546, 0.0820988739660001]
t.row4 = [-0.0116134, 1.66035, -0.0414083] 
Sphere192.transform = startCamera * R * t
Sphere_Text192.transform = startCamera * R * t

progressupdate (100.0*193/287)
Sphere193 = Sphere name: "193_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[194] - min_value) * 255) / (max_value - min_value),255,255];
Sphere193.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text193 = Text text: (camera_altitude[194] as string) size: 0.15 
R.row1 = [0.95371836066008, -0.30067082412332, -0.00428299671410703]
R.row2 = [0.11272214038092, 0.37068326174, -0.921893507154562]
R.row3 = [0.278774115742107, 0.878743975789762, 0.38741969155608]
t.row4 = [-0.00352004, 1.67004, -0.032949] 
Sphere193.transform = startCamera * R * t
Sphere_Text193.transform = startCamera * R * t

progressupdate (100.0*194/287)
Sphere194 = Sphere name: "194_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[195] - min_value) * 255) / (max_value - min_value),255,255];
Sphere194.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text194 = Text text: (camera_altitude[195] as string) size: 0.15 
R.row1 = [0.9867459984024, 0.0864045141402498, -0.137355722753143]
R.row2 = [-0.16217946817465, 0.55375171065648, -0.816735491482775]
R.row3 = [0.00549133312034267, 0.828186756040695, 0.56042532274992]
t.row4 = [-0.013993, 1.66049, -0.0275116] 
Sphere194.transform = startCamera * R * t
Sphere_Text194.transform = startCamera * R * t

progressupdate (100.0*195/287)
Sphere195 = Sphere name: "195_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[196] - min_value) * 255) / (max_value - min_value),255,255];
Sphere195.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text195 = Text text: (camera_altitude[196] as string) size: 0.15 
R.row1 = [0.97588608562112, 0.215656743506771, -0.0337419156412718]
R.row2 = [-0.0399655456827713, 0.02456241414112, -0.998899115511591]
R.row3 = [-0.214590547437128, 0.976160261837991, 0.032588957624]
t.row4 = [-0.0125837, 1.67713, -0.0434575] 
Sphere195.transform = startCamera * R * t
Sphere_Text195.transform = startCamera * R * t

progressupdate (100.0*196/287)
Sphere196 = Sphere name: "196_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[197] - min_value) * 255) / (max_value - min_value),255,255];
Sphere196.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text196 = Text text: (camera_altitude[197] as string) size: 0.15 
R.row1 = [0.9805302193238, 0.185184807881798, -0.0653228591122758]
R.row2 = [-0.125822262411398, 0.33709372957502, -0.93302549577323]
R.row3 = [-0.150762220978924, 0.923078763925909, 0.35383096008478]
t.row4 = [-0.00895784, 1.67007, -0.03057] 
Sphere196.transform = startCamera * R * t
Sphere_Text196.transform = startCamera * R * t

progressupdate (100.0*197/287)
Sphere197 = Sphere name: "197_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[198] - min_value) * 255) / (max_value - min_value),255,255];
Sphere197.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text197 = Text text: (camera_altitude[198] as string) size: 0.15 
R.row1 = [0.98256576470496, -0.170650396606867, -0.0737764201332382]
R.row2 = [-0.0118024446763327, 0.33877298278368, -0.940794115859315]
R.row3 = [0.185540346904438, 0.925262831996275, 0.33085264302528]
t.row4 = [4.7005E-05, 1.67905, -0.0330915] 
Sphere197.transform = startCamera * R * t
Sphere_Text197.transform = startCamera * R * t

progressupdate (100.0*198/287)
Sphere198 = Sphere name: "198_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[199] - min_value) * 255) / (max_value - min_value),255,255];
Sphere198.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text198 = Text text: (camera_altitude[199] as string) size: 0.15 
R.row1 = [0.834645331286, 0.548713054033007, -0.0477614415219418]
R.row2 = [-0.229526900133007, 0.267680632358, -0.935769459416022]
R.row3 = [-0.500684105078058, 0.791998146080022, 0.349362796428]
t.row4 = [-0.0354943, 1.63811, -0.0125031] 
Sphere198.transform = startCamera * R * t
Sphere_Text198.transform = startCamera * R * t

progressupdate (100.0*199/287)
Sphere199 = Sphere name: "199_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[200] - min_value) * 255) / (max_value - min_value),255,255];
Sphere199.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text199 = Text text: (camera_altitude[200] as string) size: 0.15 
R.row1 = [0.795621882054, 0.604676521814764, -0.0367712491336679]
R.row2 = [-0.443094801022764, 0.53947571166, -0.715983906128856]
R.row3 = [-0.413101462238332, 0.585945612232855, 0.69714770415]
t.row4 = [-0.000443035, 1.65525, -0.101313] 
Sphere199.transform = startCamera * R * t
Sphere_Text199.transform = startCamera * R * t

progressupdate (100.0*200/287)
Sphere200 = Sphere name: "200_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[201] - min_value) * 255) / (max_value - min_value),255,255];
Sphere200.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text200 = Text text: (camera_altitude[201] as string) size: 0.15 
R.row1 = [0.830008561004, 0.557672110260142, 0.00935981292917276]
R.row2 = [-0.0104039936881421, 0.0322588099000001, -0.999425397965838]
R.row3 = [-0.557653607157173, 0.829434256961837, 0.0325771055000001]
t.row4 = [-0.0543771, 1.68452, -0.0375105] 
Sphere200.transform = startCamera * R * t
Sphere_Text200.transform = startCamera * R * t

progressupdate (100.0*201/287)
Sphere201 = Sphere name: "201_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[202] - min_value) * 255) / (max_value - min_value),255,255];
Sphere201.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text201 = Text text: (camera_altitude[202] as string) size: 0.15 
R.row1 = [0.80444681999102, 0.586540684530731, -0.0939964850223491]
R.row2 = [-0.537778355424731, 0.651890705862, -0.534633470751145]
R.row3 = [-0.252308846937651, 0.480633470537545, 0.83984029002902]
t.row4 = [-0.00555557, 1.65249, -0.107836] 
Sphere201.transform = startCamera * R * t
Sphere_Text201.transform = startCamera * R * t

progressupdate (100.0*202/287)
Sphere202 = Sphere name: "202_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[203] - min_value) * 255) / (max_value - min_value),255,255];
Sphere202.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text202 = Text text: (camera_altitude[203] as string) size: 0.15 
R.row1 = [0.97139726106958, -0.030852590102387, -0.235447401494458]
R.row2 = [-0.123542481897613, 0.78110196263758, -0.612059620568371]
R.row3 = [0.202792051996858, 0.623640795368371, 0.754948701568]
t.row4 = [-0.00688929, 1.65498, -0.0468074] 
Sphere202.transform = startCamera * R * t
Sphere_Text202.transform = startCamera * R * t

progressupdate (100.0*203/287)
Sphere203 = Sphere name: "203_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[204] - min_value) * 255) / (max_value - min_value),255,255];
Sphere203.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text203 = Text text: (camera_altitude[204] as string) size: 0.15 
R.row1 = [0.89276773643, -0.413271514544362, -0.179366730627124]
R.row2 = [0.105176882160362, 0.5783261687, -0.808997321414481]
R.row3 = [0.438068022399124, 0.703381473926481, 0.559777553934]
t.row4 = [-0.00945609, 1.65252, -0.0468387] 
Sphere203.transform = startCamera * R * t
Sphere_Text203.transform = startCamera * R * t

progressupdate (100.0*204/287)
Sphere204 = Sphere name: "204_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[205] - min_value) * 255) / (max_value - min_value),255,255];
Sphere204.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text204 = Text text: (camera_altitude[205] as string) size: 0.15 
R.row1 = [0.781072163468, 0.621373003204988, -0.0618212450815409]
R.row2 = [-0.614150668084988, 0.74652789707, -0.255959090065203]
R.row3 = [-0.112894784406459, 0.237890079205203, 0.964708804702]
t.row4 = [-0.0282654, 1.67243, -0.0443832] 
Sphere204.transform = startCamera * R * t
Sphere_Text204.transform = startCamera * R * t

progressupdate (100.0*205/287)
Sphere205 = Sphere name: "205_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[206] - min_value) * 255) / (max_value - min_value),255,255];
Sphere205.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text205 = Text text: (camera_altitude[206] as string) size: 0.15 
R.row1 = [0.889350306998, -0.456878225297722, -0.0178414879246855]
R.row2 = [0.0392451528417225, 0.115154646508, -0.992572025278794]
R.row3 = [0.455539075624686, 0.882044043478794, 0.120343076006]
t.row4 = [-0.359735, 1.37631, -0.048237] 
Sphere205.transform = startCamera * R * t
Sphere_Text205.transform = startCamera * R * t

progressupdate (100.0*206/287)
Sphere206 = Sphere name: "206_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[207] - min_value) * 255) / (max_value - min_value),255,255];
Sphere206.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text206 = Text text: (camera_altitude[207] as string) size: 0.15 
R.row1 = [0.886011652848, -0.46362791441181, -0.00570157835260063]
R.row2 = [0.15276482021981, 0.303505810992, -0.940503658896284]
R.row3 = [0.437774212032601, 0.832426200736284, 0.33973572024]
t.row4 = [-0.360113, 1.37621, -0.0410236] 
Sphere206.transform = startCamera * R * t
Sphere_Text206.transform = startCamera * R * t

progressupdate (100.0*207/287)
Sphere207 = Sphere name: "207_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[208] - min_value) * 255) / (max_value - min_value),255,255];
Sphere207.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text207 = Text text: (camera_altitude[208] as string) size: 0.15 
R.row1 = [0.886244249048, -0.462937430085902, -0.0161265884429039]
R.row2 = [0.259535232261902, 0.525086848728, -0.810509262444088]
R.row3 = [0.383682934522904, 0.714123754764088, 0.585503773376]
t.row4 = [-0.349772, 1.39164, -0.0276263] 
Sphere207.transform = startCamera * R * t
Sphere_Text207.transform = startCamera * R * t

progressupdate (100.0*208/287)
Sphere208 = Sphere name: "208_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[209] - min_value) * 255) / (max_value - min_value),255,255];
Sphere208.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text208 = Text text: (camera_altitude[209] as string) size: 0.15 
R.row1 = [0.9839755973135, -0.153003771406268, -0.0915525522691708]
R.row2 = [0.0555161861790684, 0.75084094240632, -0.658145753065778]
R.row3 = [0.169440186979571, 0.642516711955298, 0.74730335065118]
t.row4 = [-0.35953, 1.37658, -0.0355131] 
Sphere208.transform = startCamera * R * t
Sphere_Text208.transform = startCamera * R * t

progressupdate (100.0*209/287)
Sphere209 = Sphere name: "209_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[210] - min_value) * 255) / (max_value - min_value),255,255];
Sphere209.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text209 = Text text: (camera_altitude[210] as string) size: 0.15 
R.row1 = [0.86371934006208, 0.471876898146381, -0.176977666948334]
R.row2 = [-0.493536531191181, 0.72086948639, -0.486589021630775]
R.row3 = [-0.102032318323666, 0.507621292488375, 0.85551740451608]
t.row4 = [-0.360103, 1.37761, -0.0314787] 
Sphere209.transform = startCamera * R * t
Sphere_Text209.transform = startCamera * R * t

progressupdate (100.0*210/287)
Sphere210 = Sphere name: "210_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[211] - min_value) * 255) / (max_value - min_value),255,255];
Sphere210.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text210 = Text text: (camera_altitude[211] as string) size: 0.15 
R.row1 = [0.60996222767, 0.323549095563662, -0.723368553073596]
R.row2 = [-0.721335043571662, 0.604612486076, -0.337815773161152]
R.row3 = [0.328057671349596, 0.727845948289152, 0.60217807983]
t.row4 = [-1.22934, 0.746382, 0.214006] 
Sphere210.transform = startCamera * R * t
Sphere_Text210.transform = startCamera * R * t

progressupdate (100.0*211/287)
Sphere211 = Sphere name: "211_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[212] - min_value) * 255) / (max_value - min_value),255,255];
Sphere211.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text211 = Text text: (camera_altitude[212] as string) size: 0.15 
R.row1 = [0.04319953679, 0.998240211972965, -0.0406236288543826]
R.row2 = [-0.0378564314049653, -0.0389968320359999, -0.998521976569588]
R.row3 = [-0.998348982381617, 0.0446735524815882, 0.0361051670299999]
t.row4 = [-0.349259, 1.32836, -0.0327309] 
Sphere211.transform = startCamera * R * t
Sphere_Text211.transform = startCamera * R * t

progressupdate (100.0*212/287)
Sphere212 = Sphere name: "212_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[213] - min_value) * 255) / (max_value - min_value),255,255];
Sphere212.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text212 = Text text: (camera_altitude[213] as string) size: 0.15 
R.row1 = [0.937543276828, -0.3468788176354, 0.0262238431676829]
R.row2 = [0.0353064906153998, 0.01988896286, -0.999178603091949]
R.row3 = [0.346072327404317, 0.937699053551949, 0.030893837132]
t.row4 = [-0.709164, 1.03217, -0.0591646] 
Sphere212.transform = startCamera * R * t
Sphere_Text212.transform = startCamera * R * t

progressupdate (100.0*213/287)
Sphere213 = Sphere name: "213_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[214] - min_value) * 255) / (max_value - min_value),255,255];
Sphere213.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text213 = Text text: (camera_altitude[214] as string) size: 0.15 
R.row1 = [0.926516806086, -0.375674508107581, 0.0208631732563548]
R.row2 = [0.124303273747581, 0.253287165948, -0.959371829741558]
R.row3 = [0.355127166203645, 0.891467484277558, 0.281372387238]
t.row4 = [-0.707483, 1.03696, -0.0505262] 
Sphere213.transform = startCamera * R * t
Sphere_Text213.transform = startCamera * R * t

progressupdate (100.0*214/287)
Sphere214 = Sphere name: "214_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[215] - min_value) * 255) / (max_value - min_value),255,255];
Sphere214.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text214 = Text text: (camera_altitude[215] as string) size: 0.15 
R.row1 = [0.92311737587, -0.384206861909402, -0.0154724797177121]
R.row2 = [0.179004849749402, 0.465003368958, -0.867023143072839]
R.row3 = [0.340310996197712, 0.797594479744839, 0.498027581312]
t.row4 = [-0.727856, 1.01968, -0.0507102] 
Sphere214.transform = startCamera * R * t
Sphere_Text214.transform = startCamera * R * t

progressupdate (100.0*215/287)
Sphere215 = Sphere name: "215_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[216] - min_value) * 255) / (max_value - min_value),255,255];
Sphere215.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text215 = Text text: (camera_altitude[216] as string) size: 0.15 
R.row1 = [0.97605263449324, -0.217275745107696, -0.010606850932343]
R.row2 = [-0.0107387462915035, 0.000573722415820066, -0.999942173413381]
R.row3 = [0.217269266181143, 0.976110096982141, -0.00177328582657993]
t.row4 = [-0.709441, 1.03534, -0.0602371] 
Sphere215.transform = startCamera * R * t
Sphere_Text215.transform = startCamera * R * t

progressupdate (100.0*216/287)
Sphere216 = Sphere name: "216_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[217] - min_value) * 255) / (max_value - min_value),255,255];
Sphere216.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text216 = Text text: (camera_altitude[217] as string) size: 0.15 
R.row1 = [0.982182997023, -0.185207667486683, -0.0318540462588331]
R.row2 = [0.0234702990310829, 0.28906545348678, -0.957021582130661]
R.row3 = [0.186455639288033, 0.939222701761741, 0.28826205278022]
t.row4 = [-0.704958, 1.04416, -0.0491071] 
Sphere216.transform = startCamera * R * t
Sphere_Text216.transform = startCamera * R * t

progressupdate (100.0*217/287)
Sphere217 = Sphere name: "217_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[218] - min_value) * 255) / (max_value - min_value),255,255];
Sphere217.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text217 = Text text: (camera_altitude[218] as string) size: 0.15 
R.row1 = [0.97921898927406, -0.190343760663836, -0.0699958843178414]
R.row2 = [0.0564792026226362, 0.58742863799928, -0.80730272818158]
R.row3 = [0.194782624266641, 0.78657284979502, 0.58597174099878]
t.row4 = [-0.731488, 1.01182, -0.0570009] 
Sphere217.transform = startCamera * R * t
Sphere_Text217.transform = startCamera * R * t

progressupdate (100.0*218/287)
Sphere218 = Sphere name: "218_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[219] - min_value) * 255) / (max_value - min_value),255,255];
Sphere218.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text218 = Text text: (camera_altitude[219] as string) size: 0.15 
R.row1 = [0.8280197271, -0.55390013935908, -0.0870515200972033]
R.row2 = [0.17754787313908, 0.406282975788, -0.89633191192138]
R.row3 = [0.531845921557203, 0.72672469285338, 0.434754110412]
t.row4 = [-0.72108, 1.023, -0.0546317] 
Sphere218.transform = startCamera * R * t
Sphere_Text218.transform = startCamera * R * t

progressupdate (100.0*219/287)
Sphere219 = Sphere name: "219_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[220] - min_value) * 255) / (max_value - min_value),255,255];
Sphere219.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text219 = Text text: (camera_altitude[220] as string) size: 0.15 
R.row1 = [0.76282201262, -0.646379085617437, -0.0172236679815475]
R.row2 = [0.104766813437437, 0.149837431548, -0.983144271665794]
R.row3 = [0.638064645521547, 0.748159623197794, 0.182018368172]
t.row4 = [-0.698114, 1.02394, -0.0571396] 
Sphere219.transform = startCamera * R * t
Sphere_Text219.transform = startCamera * R * t

progressupdate (100.0*220/287)
Sphere220 = Sphere name: "220_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[221] - min_value) * 255) / (max_value - min_value),255,255];
Sphere220.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text220 = Text text: (camera_altitude[221] as string) size: 0.15 
R.row1 = [-0.330390636672, 0.942678302688817, 0.0469003714185969]
R.row2 = [-0.363749917280817, -0.0813202409279999, -0.927940200709944]
R.row3 = [-0.870935143898597, -0.323642759930056, 0.3697666008]
t.row4 = [-0.729791, 1.03469, -0.043111] 
Sphere220.transform = startCamera * R * t
Sphere_Text220.transform = startCamera * R * t

progressupdate (100.0*221/287)
Sphere221 = Sphere name: "221_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[222] - min_value) * 255) / (max_value - min_value),255,255];
Sphere221.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text221 = Text text: (camera_altitude[222] as string) size: 0.15 
R.row1 = [-0.37235427444, 0.927910842626322, 0.0182691664497985]
R.row2 = [-0.128200852738322, -0.0319288372559999, -0.991234125072703]
R.row3 = [-0.919193578993799, -0.371432386159297, 0.13084780032]
t.row4 = [-0.723779, 1.03317, -0.049424] 
Sphere221.transform = startCamera * R * t
Sphere_Text221.transform = startCamera * R * t

progressupdate (100.0*222/287)
Sphere222 = Sphere name: "222_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[223] - min_value) * 255) / (max_value - min_value),255,255];
Sphere222.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text222 = Text text: (camera_altitude[223] as string) size: 0.15 
R.row1 = [0.672639020294, -0.739616975362718, -0.0228796445171782]
R.row2 = [0.0777821728107181, 0.10141914278, -0.991798412516684]
R.row3 = [0.735871375969178, 0.665342684060684, 0.12574748823]
t.row4 = [-1.3586, 0.41553, -0.0833212] 
Sphere222.transform = startCamera * R * t
Sphere_Text222.transform = startCamera * R * t

progressupdate (100.0*223/287)
Sphere223 = Sphere name: "223_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[224] - min_value) * 255) / (max_value - min_value),255,255];
Sphere223.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text223 = Text text: (camera_altitude[224] as string) size: 0.15 
R.row1 = [0.859519735664, -0.511067906348912, -0.00595139514961823]
R.row2 = [0.0444790625729123, 0.086395294904, -0.995267534892546]
R.row3 = [0.509163467853618, 0.855187376028546, 0.096990282424]
t.row4 = [-1.40829, 0.356918, -0.0696397] 
Sphere223.transform = startCamera * R * t
Sphere_Text223.transform = startCamera * R * t

progressupdate (100.0*224/287)
Sphere224 = Sphere name: "224_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[225] - min_value) * 255) / (max_value - min_value),255,255];
Sphere224.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text224 = Text text: (camera_altitude[225] as string) size: 0.15 
R.row1 = [0.853072775, -0.516991178289012, -0.07061842624371]
R.row2 = [0.147891942969012, 0.369350998462, -0.917446354366278]
R.row3 = [0.50039465800371, 0.772204611166278, 0.391542111062]
t.row4 = [-1.41036, 0.357447, -0.0721283] 
Sphere224.transform = startCamera * R * t
Sphere_Text224.transform = startCamera * R * t

progressupdate (100.0*225/287)
Sphere225 = Sphere name: "225_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[226] - min_value) * 255) / (max_value - min_value),255,255];
Sphere225.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text225 = Text text: (camera_altitude[226] as string) size: 0.15 
R.row1 = [0.729148546206, -0.680411503303264, -0.0733660939281178]
R.row2 = [0.198521306055264, 0.31289109552, -0.928810235401401]
R.row3 = [0.654928766056118, 0.662675900057401, 0.36322026771]
t.row4 = [-1.40061, 0.382411, -0.0648027] 
Sphere225.transform = startCamera * R * t
Sphere_Text225.transform = startCamera * R * t

progressupdate (100.0*226/287)
Sphere226 = Sphere name: "226_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[227] - min_value) * 255) / (max_value - min_value),255,255];
Sphere226.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text226 = Text text: (camera_altitude[227] as string) size: 0.15 
R.row1 = [0.906197912486, 0.407148854093947, -0.114171598990298]
R.row2 = [-0.335464656593947, 0.527843826118, -0.780284793780717]
R.row3 = [-0.257427286009702, 0.745392987516717, 0.614915023868]
t.row4 = [-1.41357, 0.398109, -0.0316319] 
Sphere226.transform = startCamera * R * t
Sphere_Text226.transform = startCamera * R * t

progressupdate (100.0*227/287)
Sphere227 = Sphere name: "227_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[228] - min_value) * 255) / (max_value - min_value),255,255];
Sphere227.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text227 = Text text: (camera_altitude[228] as string) size: 0.15 
R.row1 = [0.902589753942, 0.429360257541373, -0.031328985347853]
R.row2 = [-0.144244104525373, 0.233053609292, -0.961706635885209]
R.row3 = [-0.405617275752147, 0.872545577285209, 0.272284485734]
t.row4 = [-1.41683, 0.407049, -0.0564914] 
Sphere227.transform = startCamera * R * t
Sphere_Text227.transform = startCamera * R * t

progressupdate (100.0*228/287)
Sphere228 = Sphere name: "228_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[229] - min_value) * 255) / (max_value - min_value),255,255];
Sphere228.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text228 = Text text: (camera_altitude[229] as string) size: 0.15 
R.row1 = [0.885006467516, 0.465068360757726, 0.0217938586985526]
R.row2 = [0.0253530836422736, -0.00139938800200015, -0.999677579454019]
R.row3 = [-0.464887915098553, 0.88527366477002, -0.0130293844820002]
t.row4 = [-1.43183, 0.42088, -0.0926719] 
Sphere228.transform = startCamera * R * t
Sphere_Text228.transform = startCamera * R * t

progressupdate (100.0*229/287)
Sphere229 = Sphere name: "229_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[230] - min_value) * 255) / (max_value - min_value),255,255];
Sphere229.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text229 = Text text: (camera_altitude[230] as string) size: 0.15 
R.row1 = [0.997629357761167, 0.0642846564542097, -0.0245590610082165]
R.row2 = [-0.0436995968943697, 0.31610952545238, -0.947715734357904]
R.row3 = [-0.0531602272785835, 0.946542260473792, 0.318169356432787]
t.row4 = [-1.37089, 0.408938, -0.0489303] 
Sphere229.transform = startCamera * R * t
Sphere_Text229.transform = startCamera * R * t

progressupdate (100.0*230/287)
Sphere230 = Sphere name: "230_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[231] - min_value) * 255) / (max_value - min_value),255,255];
Sphere230.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text230 = Text text: (camera_altitude[231] as string) size: 0.15 
R.row1 = [0.16722073014, 0.98565413648674, -0.0228724864854049]
R.row2 = [-0.22938639680674, 0.0163330047019999, -0.973198393914327]
R.row3 = [-0.958863446154595, 0.167985583262327, 0.228826867838]
t.row4 = [-1.59498, 0.246174, -0.0597084] 
Sphere230.transform = startCamera * R * t
Sphere_Text230.transform = startCamera * R * t

progressupdate (100.0*231/287)
Sphere231 = Sphere name: "231_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[232] - min_value) * 255) / (max_value - min_value),255,255];
Sphere231.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text231 = Text text: (camera_altitude[232] as string) size: 0.15 
R.row1 = [0.79329268888022, 0.461397691872175, -0.397239071220619]
R.row2 = [-0.606299315244174, 0.539123174838, -0.584591603332652]
R.row3 = [-0.0555684272193805, 0.704598021773852, 0.70742757764222]
t.row4 = [-0.321583, 1.48876, 0.0594138] 
Sphere231.transform = startCamera * R * t
Sphere_Text231.transform = startCamera * R * t

progressupdate (100.0*232/287)
Sphere232 = Sphere name: "232_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[233] - min_value) * 255) / (max_value - min_value),255,255];
Sphere232.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text232 = Text text: (camera_altitude[233] as string) size: 0.15 
R.row1 = [0.585935836782, 0.810329111125014, -0.00677693425693338]
R.row2 = [0.0825165178549863, -0.0679816081299998, -0.994268336636115]
R.row3 = [-0.806145284335066, 0.582018240796115, -0.106698397012]
t.row4 = [-2.03244, -0.142402, -0.085315] 
Sphere232.transform = startCamera * R * t
Sphere_Text232.transform = startCamera * R * t

progressupdate (100.0*233/287)
Sphere233 = Sphere name: "233_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[234] - min_value) * 255) / (max_value - min_value),255,255];
Sphere233.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text233 = Text text: (camera_altitude[234] as string) size: 0.15 
R.row1 = [0.571010902686, 0.820942335966886, 0.000479615421157042]
R.row2 = [-0.229006413402886, 0.159847634846, -0.960210808236653]
R.row3 = [-0.788354369325157, 0.548181005372653, 0.279275802236]
t.row4 = [-2.03229, -0.142489, -0.0732747] 
Sphere233.transform = startCamera * R * t
Sphere_Text233.transform = startCamera * R * t

progressupdate (100.0*234/287)
Sphere234 = Sphere name: "234_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[235] - min_value) * 255) / (max_value - min_value),255,255];
Sphere234.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text234 = Text text: (camera_altitude[235] as string) size: 0.15 
R.row1 = [0.155295193294, 0.987867526966527, -0.0010733614570842]
R.row2 = [-0.409540523062527, 0.063391923374, -0.91008682224314]
R.row3 = [-0.898977175966916, 0.14177169398714, 0.414416244704]
t.row4 = [-2.02774, -0.150803, -0.0773622] 
Sphere234.transform = startCamera * R * t
Sphere_Text234.transform = startCamera * R * t

progressupdate (100.0*235/287)
Sphere235 = Sphere name: "235_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[236] - min_value) * 255) / (max_value - min_value),255,255];
Sphere235.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text235 = Text text: (camera_altitude[236] as string) size: 0.15 
R.row1 = [0.194428307936, 0.980915584488111, 0.00149972713886631]
R.row2 = [-0.145312094808111, 0.0303144300779999, -0.988921346938939]
R.row3 = [-0.970093824418866, 0.192056375674939, 0.148432881758]
t.row4 = [-2.0342, -0.149001, -0.0763621] 
Sphere235.transform = startCamera * R * t
Sphere_Text235.transform = startCamera * R * t

progressupdate (100.0*236/287)
Sphere236 = Sphere name: "236_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[237] - min_value) * 255) / (max_value - min_value),255,255];
Sphere236.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text236 = Text text: (camera_altitude[237] as string) size: 0.15 
R.row1 = [-0.33562316025, 0.941961576554536, -0.00809213190053837]
R.row2 = [-0.036828942706536, -0.0217051109640001, -0.999085840724989]
R.row3 = [-0.941276114263462, -0.335018322563011, 0.0419761868699999]
t.row4 = [-2.01311, -0.160433, -0.078389] 
Sphere236.transform = startCamera * R * t
Sphere_Text236.transform = startCamera * R * t

progressupdate (100.0*237/287)
Sphere237 = Sphere name: "237_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[238] - min_value) * 255) / (max_value - min_value),255,255];
Sphere237.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text237 = Text text: (camera_altitude[238] as string) size: 0.15 
R.row1 = [-0.377306276946, 0.924358487890725, -0.0565805553306272]
R.row2 = [-0.329585805838724, -0.19112490661, -0.924577993823646]
R.row3 = [-0.865455469661373, -0.330200932672354, 0.37676806406]
t.row4 = [-2.01335, -0.151766, -0.0574606] 
Sphere237.transform = startCamera * R * t
Sphere_Text237.transform = startCamera * R * t

progressupdate (100.0*238/287)
Sphere238 = Sphere name: "238_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[239] - min_value) * 255) / (max_value - min_value),255,255];
Sphere238.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text238 = Text text: (camera_altitude[239] as string) size: 0.15 
R.row1 = [-0.384130595898, 0.918857123325464, -0.0902511618157906]
R.row2 = [-0.601391028225464, -0.323180590426, -0.730673071312896]
R.row3 = [-0.700551580160209, -0.226397643287104, 0.676735982972]
t.row4 = [-1.98531, -0.144224, -0.111281] 
Sphere238.transform = startCamera * R * t
Sphere_Text238.transform = startCamera * R * t

progressupdate (100.0*239/287)
Sphere239 = Sphere name: "239_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[240] - min_value) * 255) / (max_value - min_value),255,255];
Sphere239.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text239 = Text text: (camera_altitude[240] as string) size: 0.15 
R.row1 = [0.98665470534494, 0.160798880105907, 0.0256166464896533]
R.row2 = [0.0397517237284933, -0.08531337160768, -0.995560861567761]
R.row3 = [-0.157899629136053, 0.983293114377202, -0.09056687218338]
t.row4 = [-2.33382, -0.404538, -0.085318] 
Sphere239.transform = startCamera * R * t
Sphere_Text239.transform = startCamera * R * t

progressupdate (100.0*240/287)
Sphere240 = Sphere name: "240_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[241] - min_value) * 255) / (max_value - min_value),255,255];
Sphere240.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text240 = Text text: (camera_altitude[241] as string) size: 0.15 
R.row1 = [0.99282983984576, 0.119357547229375, -0.00653337824023777]
R.row2 = [-0.0371270706101752, 0.25595176447448, -0.965976332469025]
R.row3 = [-0.113624336036562, 0.959292692655265, 0.25854794541528]
t.row4 = [-2.33413, -0.410391, -0.0740973] 
Sphere240.transform = startCamera * R * t
Sphere_Text240.transform = startCamera * R * t

progressupdate (100.0*241/287)
Sphere241 = Sphere name: "241_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[242] - min_value) * 255) / (max_value - min_value),255,255];
Sphere241.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text241 = Text text: (camera_altitude[242] as string) size: 0.15 
R.row1 = [0.98662771519884, 0.158207034673477, -0.0391954816444705]
R.row2 = [-0.116011249780677, 0.51272831514702, -0.850676827456128]
R.row3 = [-0.11448642507233, 0.843848451456968, 0.52422576190782]
t.row4 = [-2.34643, -0.399903, -0.0533021] 
Sphere241.transform = startCamera * R * t
Sphere_Text241.transform = startCamera * R * t

progressupdate (100.0*242/287)
Sphere242 = Sphere name: "242_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[243] - min_value) * 255) / (max_value - min_value),255,255];
Sphere242.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text242 = Text text: (camera_altitude[243] as string) size: 0.15 
R.row1 = [0.770739810048, 0.634619643150988, -0.0567278920292806]
R.row2 = [-0.376138758414988, 0.381332233088, -0.844455660426378]
R.row3 = [-0.514275976130719, 0.672193154186378, 0.532612977536]
t.row4 = [-2.34671, -0.418498, -0.0754336] 
Sphere242.transform = startCamera * R * t
Sphere_Text242.transform = startCamera * R * t

progressupdate (100.0*243/287)
Sphere243 = Sphere name: "243_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[244] - min_value) * 255) / (max_value - min_value),255,255];
Sphere243.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text243 = Text text: (camera_altitude[244] as string) size: 0.15 
R.row1 = [0.783602510462, 0.620729131632465, -0.0257381184327249]
R.row2 = [-0.124786212432465, 0.116674125004, -0.985299725840473]
R.row3 = [-0.608601270771275, 0.775295101040473, 0.168884574542]
t.row4 = [-2.34912, -0.409007, -0.0780948] 
Sphere243.transform = startCamera * R * t
Sphere_Text243.transform = startCamera * R * t

progressupdate (100.0*244/287)
Sphere244 = Sphere name: "244_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[245] - min_value) * 255) / (max_value - min_value),255,255];
Sphere244.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text244 = Text text: (camera_altitude[245] as string) size: 0.15 
R.row1 = [0.768681151262, 0.639455119106714, -0.0150478683787747]
R.row2 = [-0.0109306098267137, -0.0103901011200001, -0.999886277317342]
R.row3 = [-0.639538747429225, 0.768758217157342, -0.000997040482000083]
t.row4 = [-2.35139, -0.407179, -0.0837562] 
Sphere244.transform = startCamera * R * t
Sphere_Text244.transform = startCamera * R * t

progressupdate (100.0*245/287)
Sphere245 = Sphere name: "245_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[246] - min_value) * 255) / (max_value - min_value),255,255];
Sphere245.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text245 = Text text: (camera_altitude[246] as string) size: 0.15 
R.row1 = [0.377887134268, 0.925848565217489, -0.00239750692069329]
R.row2 = [-0.0151250786214895, 0.003584123228, -0.999879185730646]
R.row3 = [-0.925728116539307, 0.377877742590646, 0.0153579263960001]
t.row4 = [-2.36217, -0.414588, -0.0829762] 
Sphere245.transform = startCamera * R * t
Sphere_Text245.transform = startCamera * R * t

progressupdate (100.0*246/287)
Sphere246 = Sphere name: "246_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[247] - min_value) * 255) / (max_value - min_value),255,255];
Sphere246.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text246 = Text text: (camera_altitude[247] as string) size: 0.15 
R.row1 = [0.33716430528, 0.941077996962828, -0.0263141573584751]
R.row2 = [-0.307982437666828, 0.08384322027, -0.947690420181377]
R.row3 = [-0.889644338673525, 0.327631680469377, 0.318104436654]
t.row4 = [-2.34877, -0.418824, -0.0766429] 
Sphere246.transform = startCamera * R * t
Sphere_Text246.transform = startCamera * R * t

progressupdate (100.0*247/287)
Sphere247 = Sphere name: "247_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[248] - min_value) * 255) / (max_value - min_value),255,255];
Sphere247.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text247 = Text text: (camera_altitude[248] as string) size: 0.15 
R.row1 = [-0.3208417433, 0.942311182242751, -0.0954474283387786]
R.row2 = [-0.601592661858751, -0.28058810485, -0.747901453812191]
R.row3 = [-0.731537316173221, -0.182537533775809, 0.656911869134]
t.row4 = [-2.338, -0.419764, -0.0638033] 
Sphere247.transform = startCamera * R * t
Sphere_Text247.transform = startCamera * R * t

progressupdate (100.0*248/287)
Sphere248 = Sphere name: "248_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[249] - min_value) * 255) / (max_value - min_value),255,255];
Sphere248.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text248 = Text text: (camera_altitude[249] as string) size: 0.15 
R.row1 = [-0.3079352641, 0.950803945565257, -0.0338781673235577]
R.row2 = [-0.279589252145257, -0.124471493652, -0.952017172824575]
R.row3 = [-0.909398550256442, -0.283687688075425, 0.304163726348]
t.row4 = [-2.34631, -0.428598, -0.0731791] 
Sphere248.transform = startCamera * R * t
Sphere_Text248.transform = startCamera * R * t

progressupdate (100.0*249/287)
Sphere249 = Sphere name: "249_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[250] - min_value) * 255) / (max_value - min_value),255,255];
Sphere249.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text249 = Text text: (camera_altitude[250] as string) size: 0.15 
R.row1 = [-0.365388278442, 0.930825906746879, 0.00738493778190497]
R.row2 = [0.0125959373971213, 0.0128768949979999, -0.999837750805749]
R.row3 = [-0.930769976061905, -0.365235974274251, -0.0164296913439999]
t.row4 = [-2.34005, -0.430152, -0.0846814] 
Sphere249.transform = startCamera * R * t
Sphere_Text249.transform = startCamera * R * t

progressupdate (100.0*250/287)
Sphere250 = Sphere name: "250_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[251] - min_value) * 255) / (max_value - min_value),255,255];
Sphere250.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text250 = Text text: (camera_altitude[251] as string) size: 0.15 
R.row1 = [0.841535708796, -0.539474082449511, 0.0280243677265272]
R.row2 = [0.0315544439375114, -0.00269914557000001, -0.999498390034214]
R.row3 = [0.539279118721473, 0.841997879438214, 0.01475137731]
t.row4 = [-2.63733, -1.18405, -0.19707] 
Sphere250.transform = startCamera * R * t
Sphere_Text250.transform = startCamera * R * t

progressupdate (100.0*251/287)
Sphere251 = Sphere name: "251_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[252] - min_value) * 255) / (max_value - min_value),255,255];
Sphere251.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text251 = Text text: (camera_altitude[252] as string) size: 0.15 
R.row1 = [0.83360669331, -0.55203096856157, 0.0190181654673173]
R.row2 = [0.21120013580957, 0.286734850496, -0.934439740242813]
R.row3 = [0.510386504036683, 0.782971861090813, 0.35561310611]
t.row4 = [-2.38614, -0.806097, -0.436374] 
Sphere251.transform = startCamera * R * t
Sphere_Text251.transform = startCamera * R * t

progressupdate (100.0*252/287)
Sphere252 = Sphere name: "252_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[253] - min_value) * 255) / (max_value - min_value),255,255];
Sphere252.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text252 = Text text: (camera_altitude[253] as string) size: 0.15 
R.row1 = [0.928617694358, -0.357964915707587, -0.0976232392808818]
R.row2 = [0.0929498081475869, 0.47915309528, -0.872795877882636]
R.row3 = [0.359206780128882, 0.801419634402636, 0.478222812822]
t.row4 = [-2.6083, -0.658473, -0.0734353] 
Sphere252.transform = startCamera * R * t
Sphere_Text252.transform = startCamera * R * t

progressupdate (100.0*253/287)
Sphere253 = Sphere name: "253_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[254] - min_value) * 255) / (max_value - min_value),255,255];
Sphere253.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text253 = Text text: (camera_altitude[254] as string) size: 0.15 
R.row1 = [0.98711817787134, 0.06708099458814, -0.145250965852319]
R.row2 = [-0.15156097100734, 0.68289680297982, -0.7146196390719]
R.row3 = [0.0512540240691189, 0.72742841341606, 0.68426670850752]
t.row4 = [-2.6077, -0.656434, -0.0707189] 
Sphere253.transform = startCamera * R * t
Sphere_Text253.transform = startCamera * R * t

progressupdate (100.0*254/287)
Sphere254 = Sphere name: "254_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[255] - min_value) * 255) / (max_value - min_value),255,255];
Sphere254.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text254 = Text text: (camera_altitude[255] as string) size: 0.15 
R.row1 = [0.999318382184239, -0.0366155393870964, 0.00469822350115754]
R.row2 = [0.0134271156581364, 0.24196797170318, -0.970191328159014]
R.row3 = [0.0343872591780425, 0.969593112055382, 0.242294683105059]
t.row4 = [-2.61648, -0.672533, -0.0767504] 
Sphere254.transform = startCamera * R * t
Sphere_Text254.transform = startCamera * R * t

progressupdate (100.0*255/287)
Sphere255 = Sphere name: "255_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[256] - min_value) * 255) / (max_value - min_value),255,255];
Sphere255.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text255 = Text text: (camera_altitude[256] as string) size: 0.15 
R.row1 = [0.999853531758064, 0.00778481822344647, 0.0152417727365947]
R.row2 = [0.0153805823573535, -0.018093573469005, -0.999717990378022]
R.row3 = [-0.00750684469499465, 0.999805990782387, -0.0182106583729314]
t.row4 = [-2.61848, -0.664139, -0.0817748] 
Sphere255.transform = startCamera * R * t
Sphere_Text255.transform = startCamera * R * t

progressupdate (100.0*256/287)
Sphere256 = Sphere name: "256_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[257] - min_value) * 255) / (max_value - min_value),255,255];
Sphere256.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text256 = Text text: (camera_altitude[257] as string) size: 0.15 
R.row1 = [0.92340484931, 0.383756223982395, 0.00739221384634653]
R.row2 = [0.0052088243696051, 0.00672847079599982, -0.999963797259398]
R.row3 = [-0.383792069250347, 0.923409924267398, 0.00421418378999981]
t.row4 = [-2.6379, -0.658861, -0.0802345] 
Sphere256.transform = startCamera * R * t
Sphere_Text256.transform = startCamera * R * t

progressupdate (100.0*257/287)
Sphere257 = Sphere name: "257_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[258] - min_value) * 255) / (max_value - min_value),255,255];
Sphere257.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text257 = Text text: (camera_altitude[258] as string) size: 0.15 
R.row1 = [0.923996897614, 0.382377513195847, -0.00414374249475921]
R.row2 = [-0.0976635822878472, 0.22549486267, -0.969336830830307]
R.row3 = [-0.369718214177241, 0.896068917166307, 0.24570091126]
t.row4 = [-2.63815, -0.660916, -0.0723062] 
Sphere257.transform = startCamera * R * t
Sphere_Text257.transform = startCamera * R * t

progressupdate (100.0*258/287)
Sphere258 = Sphere name: "258_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[259] - min_value) * 255) / (max_value - min_value),255,255];
Sphere258.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text258 = Text text: (camera_altitude[259] as string) size: 0.15 
R.row1 = [0.508747263692, 0.860915726161606, 0.000578042850340521]
R.row2 = [-0.143508628341606, 0.0854666050039998, -0.985951688989172]
R.row3 = [-0.848870717646341, 0.501517269769172, 0.167029736412]
t.row4 = [-2.66133, -0.671904, -0.076158] 
Sphere258.transform = startCamera * R * t
Sphere_Text258.transform = startCamera * R * t

progressupdate (100.0*259/287)
Sphere259 = Sphere name: "259_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[260] - min_value) * 255) / (max_value - min_value),255,255];
Sphere259.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text259 = Text text: (camera_altitude[260] as string) size: 0.15 
R.row1 = [0.457441062392, 0.888989809832018, 0.0210901031887078]
R.row2 = [0.0433668997679817, 0.00138633862999987, -0.999058251589825]
R.row3 = [-0.888181843116708, 0.457924880389824, -0.0379185637620001]
t.row4 = [-2.6644, -0.670402, -0.0829403] 
Sphere259.transform = startCamera * R * t
Sphere_Text259.transform = startCamera * R * t

progressupdate (100.0*260/287)
Sphere260 = Sphere name: "260_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[261] - min_value) * 255) / (max_value - min_value),255,255];
Sphere260.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text260 = Text text: (camera_altitude[261] as string) size: 0.15 
R.row1 = [0.719161649884, -0.69478930059344, 0.00862259340346444]
R.row2 = [0.25111353134144, 0.24831156422, -0.93556579750002]
R.row3 = [0.647880016448535, 0.67498829238402, 0.35304714902]
t.row4 = [-2.94754, -0.274183, -0.0912708] 
Sphere260.transform = startCamera * R * t
Sphere_Text260.transform = startCamera * R * t

progressupdate (100.0*261/287)
Sphere261 = Sphere name: "261_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[262] - min_value) * 255) / (max_value - min_value),255,255];
Sphere261.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text261 = Text text: (camera_altitude[262] as string) size: 0.15 
R.row1 = [0.727251430686, -0.685736143696878, 0.0295177538593547]
R.row2 = [0.0356236850088776, -0.00523705408, -0.999351552923671]
R.row3 = [0.685446066172645, 0.72783137778767, 0.02061979331]
t.row4 = [-2.94238, -0.283453, -0.0928074] 
Sphere261.transform = startCamera * R * t
Sphere_Text261.transform = startCamera * R * t

progressupdate (100.0*262/287)
Sphere262 = Sphere name: "262_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[263] - min_value) * 255) / (max_value - min_value),255,255];
Sphere262.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text262 = Text text: (camera_altitude[263] as string) size: 0.15 
R.row1 = [0.925526599206, -0.378300624376391, 0.017004462902682]
R.row2 = [0.0293224664803914, 0.026824415516, -0.999210009803611]
R.row3 = [0.377545635813318, 0.92529405505961, 0.035919417446]
t.row4 = [-2.95805, -0.284991, -0.0980331] 
Sphere262.transform = startCamera * R * t
Sphere_Text262.transform = startCamera * R * t

progressupdate (100.0*263/287)
Sphere263 = Sphere name: "263_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[264] - min_value) * 255) / (max_value - min_value),255,255];
Sphere263.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text263 = Text text: (camera_altitude[264] as string) size: 0.15 
R.row1 = [0.923497337646, -0.383468574239447, 0.0102234989859568]
R.row2 = [0.125509978623447, 0.276863460876, -0.952677211492804]
R.row3 = [0.362491258690043, 0.881078019588805, 0.303811801566]
t.row4 = [-2.9556, -0.271193, -0.0876627] 
Sphere263.transform = startCamera * R * t
Sphere_Text263.transform = startCamera * R * t

progressupdate (100.0*264/287)
Sphere264 = Sphere name: "264_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[265] - min_value) * 255) / (max_value - min_value),255,255];
Sphere264.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text264 = Text text: (camera_altitude[265] as string) size: 0.15 
R.row1 = [0.930425565558, -0.366051338563299, 0.0177393486941632]
R.row2 = [0.223716759071299, 0.528969433302, -0.818622104724027]
R.row3 = [0.290274143985837, 0.765635524364027, 0.57405850326]
t.row4 = [-2.95694, -0.285955, -0.0972347] 
Sphere264.transform = startCamera * R * t
Sphere_Text264.transform = startCamera * R * t

progressupdate (100.0*265/287)
Sphere265 = Sphere name: "265_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[266] - min_value) * 255) / (max_value - min_value),255,255];
Sphere265.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text265 = Text text: (camera_altitude[266] as string) size: 0.15 
R.row1 = [0.374358290364, 0.927271825913025, 0.00477821134607581]
R.row2 = [-0.154613936389025, 0.0674998739639999, -0.985666423131647]
R.row3 = [-0.914303232582076, 0.368253618967647, 0.168638284524]
t.row4 = [-2.98474, -0.276792, -0.0927968] 
Sphere265.transform = startCamera * R * t
Sphere_Text265.transform = startCamera * R * t

progressupdate (100.0*266/287)
Sphere266 = Sphere name: "266_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[267] - min_value) * 255) / (max_value - min_value),255,255];
Sphere266.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text266 = Text text: (camera_altitude[267] as string) size: 0.15 
R.row1 = [0.38452258775, 0.921582470044069, 0.0531801694009785]
R.row2 = [0.107211343795931, 0.0126350052220002, -0.994155965834592]
R.row3 = [-0.916868642320978, 0.387976942034592, -0.0939456501279999]
t.row4 = [-2.98314, -0.279311, -0.101267] 
Sphere266.transform = startCamera * R * t
Sphere_Text266.transform = startCamera * R * t

progressupdate (100.0*267/287)
Sphere267 = Sphere name: "267_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[268] - min_value) * 255) / (max_value - min_value),255,255];
Sphere267.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text267 = Text text: (camera_altitude[268] as string) size: 0.15 
R.row1 = [0.67003602774, 0.74198398472239, 0.022616099263261]
R.row2 = [0.0872124911776098, -0.0484272205480001, -0.995011952537551]
R.row3 = [-0.737187698563261, 0.668666262589552, -0.0971582542120001]
t.row4 = [-2.97556, -0.271448, -0.101034] 
Sphere267.transform = startCamera * R * t
Sphere_Text267.transform = startCamera * R * t

progressupdate (100.0*268/287)
Sphere268 = Sphere name: "268_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[269] - min_value) * 255) / (max_value - min_value),255,255];
Sphere268.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text268 = Text text: (camera_altitude[269] as string) size: 0.15 
R.row1 = [-0.582361624282, 0.812255168915371, -0.0331131263080472]
R.row2 = [0.0346485722606287, -0.0158953238919999, -0.999273143399075]
R.row3 = [-0.812191119751953, -0.583085653440925, -0.0188866552739999]
t.row4 = [-2.47146, 0.149677, -0.0962721] 
Sphere268.transform = startCamera * R * t
Sphere_Text268.transform = startCamera * R * t

progressupdate (100.0*269/287)
Sphere269 = Sphere name: "269_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[270] - min_value) * 255) / (max_value - min_value),255,255];
Sphere269.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text269 = Text text: (camera_altitude[270] as string) size: 0.15 
R.row1 = [-0.337941113338, 0.940985466666613, -0.0184974440961564]
R.row2 = [0.0119287307333873, -0.0153697744160001, -0.999810719795248]
R.row3 = [-0.941091658287844, -0.338097798804752, -0.00603068357799996]
t.row4 = [-2.47964, 0.148653, -0.0961421] 
Sphere269.transform = startCamera * R * t
Sphere_Text269.transform = startCamera * R * t

progressupdate (100.0*270/287)
Sphere270 = Sphere name: "270_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[271] - min_value) * 255) / (max_value - min_value),255,255];
Sphere270.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text270 = Text text: (camera_altitude[271] as string) size: 0.15 
R.row1 = [-0.05697339157, 0.998245843628658, -0.0161018114235488]
R.row2 = [-0.0124502928086584, -0.0168371511220001, -0.999780726235045]
R.row3 = [-0.998298063136451, -0.0567604265329552, 0.0133877226520001]
t.row4 = [-2.49069, 0.152105, -0.0943373] 
Sphere270.transform = startCamera * R * t
Sphere_Text270.transform = startCamera * R * t

progressupdate (100.0*271/287)
Sphere271 = Sphere name: "271_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[272] - min_value) * 255) / (max_value - min_value),255,255];
Sphere271.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text271 = Text text: (camera_altitude[272] as string) size: 0.15 
R.row1 = [-0.074602210036, 0.996654510597875, -0.0333810839047172]
R.row2 = [-0.242436841869875, -0.0505967552899999, -0.968846915698391]
R.row3 = [-0.967294623143283, -0.0641853165376092, 0.24540040175]
t.row4 = [-2.48817, 0.149451, -0.086555] 
Sphere271.transform = startCamera * R * t
Sphere_Text271.transform = startCamera * R * t

progressupdate (100.0*272/287)
Sphere272 = Sphere name: "272_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[273] - min_value) * 255) / (max_value - min_value),255,255];
Sphere272.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text272 = Text text: (camera_altitude[273] as string) size: 0.15 
R.row1 = [-0.416940442756, 0.907912985941418, -0.0430659628171555]
R.row2 = [-0.193151466937418, -0.134800314276, -0.971864901151912]
R.row3 = [-0.888174069658844, -0.396891528292089, 0.231568427804]
t.row4 = [-2.48155, 0.14608, -0.0889431] 
Sphere272.transform = startCamera * R * t
Sphere_Text272.transform = startCamera * R * t

progressupdate (100.0*273/287)
Sphere273 = Sphere name: "273_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[274] - min_value) * 255) / (max_value - min_value),255,255];
Sphere273.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text273 = Text text: (camera_altitude[274] as string) size: 0.15 
R.row1 = [-0.715209758074, 0.698530574652512, -0.023022559183579]
R.row2 = [-0.142672585404512, -0.17816776901, -0.973601961511988]
R.row3 = [-0.684192615664421, -0.693044935312012, 0.22708849004]
t.row4 = [-2.42554, 0.1854, -0.107642] 
Sphere273.transform = startCamera * R * t
Sphere_Text273.transform = startCamera * R * t

progressupdate (100.0*274/287)
Sphere274 = Sphere name: "274_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[275] - min_value) * 255) / (max_value - min_value),255,255];
Sphere274.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text274 = Text text: (camera_altitude[275] as string) size: 0.15 
R.row1 = [-0.696382614306, 0.71730259097272, -0.0229836349640953]
R.row2 = [-0.33520797730872, -0.353415248916, -0.873346021793331]
R.row3 = [-0.634576131319905, -0.600478688062669, 0.486557785614]
t.row4 = [-2.44776, 0.174581, -0.0966161] 
Sphere274.transform = startCamera * R * t
Sphere_Text274.transform = startCamera * R * t

progressupdate (100.0*275/287)
Sphere275 = Sphere name: "275_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[276] - min_value) * 255) / (max_value - min_value),255,255];
Sphere275.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text275 = Text text: (camera_altitude[276] as string) size: 0.15 
R.row1 = [-0.36639706909, 0.92830905439148, -0.0632098670861832]
R.row2 = [-0.41269308754348, -0.223021674004, -0.88314537218868]
R.row3 = [-0.833929015717817, -0.29749560073932, 0.46482121755]
t.row4 = [-2.47368, 0.145571, -0.084409] 
Sphere275.transform = startCamera * R * t
Sphere_Text275.transform = startCamera * R * t

progressupdate (100.0*276/287)
Sphere276 = Sphere name: "276_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[277] - min_value) * 255) / (max_value - min_value),255,255];
Sphere276.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text276 = Text text: (camera_altitude[277] as string) size: 0.15 
R.row1 = [0.01693910134, 0.999054403109764, -0.0400420587980431]
R.row2 = [-0.424425824837764, -0.029075995106, -0.904995749006248]
R.row3 = [-0.905304250545957, 0.0323246985382478, 0.42353196787]
t.row4 = [-2.483, 0.150974, -0.0842608] 
Sphere276.transform = startCamera * R * t
Sphere_Text276.transform = startCamera * R * t

progressupdate (100.0*277/287)
Sphere277 = Sphere name: "277_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[278] - min_value) * 255) / (max_value - min_value),255,255];
Sphere277.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text277 = Text text: (camera_altitude[278] as string) size: 0.15 
R.row1 = [-0.979396362754, 0.200915911839612, -0.0203853131909253]
R.row2 = [-0.049261097163612, -0.335578591794, -0.940723313751601]
R.row3 = [-0.195847157065075, -0.920336788952399, 0.338561790476]
t.row4 = [-2.97437, 0.620078, -0.0961599] 
Sphere277.transform = startCamera * R * t
Sphere_Text277.transform = startCamera * R * t

progressupdate (100.0*278/287)
Sphere278 = Sphere name: "278_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[279] - min_value) * 255) / (max_value - min_value),255,255];
Sphere278.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text278 = Text text: (camera_altitude[279] as string) size: 0.15 
R.row1 = [-0.978294891808, 0.205158850357088, -0.0291367599868586]
R.row2 = [0.0191904535149124, -0.0503052852236799, -0.9985495004117]
R.row3 = [-0.206327000550741, -0.9774350231083, 0.04527631218432]
t.row4 = [-2.98023, 0.611556, -0.110777] 
Sphere278.transform = startCamera * R * t
Sphere_Text278.transform = startCamera * R * t

progressupdate (100.0*279/287)
Sphere279 = Sphere name: "279_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[280] - min_value) * 255) / (max_value - min_value),255,255];
Sphere279.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text279 = Text text: (camera_altitude[280] as string) size: 0.15 
R.row1 = [-0.71717667537, 0.695125353110338, -0.0495818491835677]
R.row2 = [0.0461979746896625, -0.0235684306080001, -0.998654232561625]
R.row3 = [-0.695358442416432, -0.718502103366375, -0.015210654762]
t.row4 = [-2.81026, 0.39534, -0.103147] 
Sphere279.transform = startCamera * R * t
Sphere_Text279.transform = startCamera * R * t

progressupdate (100.0*280/287)
Sphere280 = Sphere name: "280_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[281] - min_value) * 255) / (max_value - min_value),255,255];
Sphere280.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text280 = Text text: (camera_altitude[281] as string) size: 0.15 
R.row1 = [-0.937310728116, 0.345346828016367, -0.0467350760958793]
R.row2 = [0.039455307303633, -0.0280829436580001, -0.998826625096206]
R.row3 = [-0.346254065224121, -0.938054858019794, 0.012696679142]
t.row4 = [-2.81146, 0.378207, -0.101683] 
Sphere280.transform = startCamera * R * t
Sphere_Text280.transform = startCamera * R * t

progressupdate (100.0*281/287)
Sphere281 = Sphere name: "281_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[282] - min_value) * 255) / (max_value - min_value),255,255];
Sphere281.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text281 = Text text: (camera_altitude[282] as string) size: 0.15 
R.row1 = [-0.956023118818, 0.292618257664184, -0.0198582871134811]
R.row2 = [-0.0608602844381842, -0.26416177321922, -0.962556275418627]
R.row3 = [-0.286907340553719, -0.919017471461372, 0.27035359269878]
t.row4 = [-2.81197, 0.376418, -0.0934838] 
Sphere281.transform = startCamera * R * t
Sphere_Text281.transform = startCamera * R * t

progressupdate (100.0*282/287)
Sphere282 = Sphere name: "282_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[283] - min_value) * 255) / (max_value - min_value),255,255];
Sphere282.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text282 = Text text: (camera_altitude[283] as string) size: 0.15 
R.row1 = [0.91772955203, 0.397037858317494, -0.0115502551258881]
R.row2 = [-0.071873587501494, 0.13739232174, -0.987905631802227]
R.row3 = [-0.390649019902112, 0.907460351194227, 0.154625529134]
t.row4 = [2.30213, -0.48431, 0.145761] 
Sphere282.transform = startCamera * R * t
Sphere_Text282.transform = startCamera * R * t

progressupdate (100.0*283/287)
Sphere283 = Sphere name: "283_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[284] - min_value) * 255) / (max_value - min_value),255,255];
Sphere283.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text283 = Text text: (camera_altitude[284] as string) size: 0.15 
R.row1 = [0.83649937776, 0.547857298033945, 0.0110078153181005]
R.row2 = [-0.0703300324339455, 0.127262807192, -0.989372459917625]
R.row3 = [-0.543435808118101, 0.826835267085624, 0.144986080568]
t.row4 = [2.31415, -0.504018, 0.143362] 
Sphere283.transform = startCamera * R * t
Sphere_Text283.transform = startCamera * R * t

progressupdate (100.0*284/287)
Sphere284 = Sphere name: "284_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[285] - min_value) * 255) / (max_value - min_value),255,255];
Sphere284.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text284 = Text text: (camera_altitude[285] as string) size: 0.15 
R.row1 = [0.785010083014, 0.619434293715631, 0.00776693860993516]
R.row2 = [-0.0823358574276307, 0.11675450363, -0.989741982773172]
R.row3 = [-0.613986951121935, 0.776317938509172, 0.14265511628]
t.row4 = [2.3128, -0.504207, 0.143696] 
Sphere284.transform = startCamera * R * t
Sphere_Text284.transform = startCamera * R * t

progressupdate (100.0*285/287)
Sphere285 = Sphere name: "285_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[286] - min_value) * 255) / (max_value - min_value),255,255];
Sphere285.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text285 = Text text: (camera_altitude[286] as string) size: 0.15 
R.row1 = [0.664692071564, 0.747049152417852, 0.0101001916678344]
R.row2 = [-0.0982474434298521, 0.10080183758, -0.990043650249823]
R.row3 = [-0.740629387655834, 0.657081846813823, 0.14039785158]
t.row4 = [2.31384, -0.50522, 0.144973] 
Sphere285.transform = startCamera * R * t
Sphere_Text285.transform = startCamera * R * t

progressupdate (100.0*286/287)
Sphere286 = Sphere name: "286_red_centre_sensor" radius: 0.2
RGBcolor = HSV_to_RGB [((camera_altitude[287] - min_value) * 255) / (max_value - min_value),255,255];
Sphere286.material = standardMaterial diffuse_Color: (color RGBcolor[1] RGBcolor[2] RGBcolor[3]) opacity: 20 showInViewport: true
Sphere_Text286 = Text text: (camera_altitude[287] as string) size: 0.15 
R.row1 = [0.94030886576, 0.339777201879126, -0.019253312866466]
R.row2 = [-0.069833554375126, 0.13727087051, -0.988068814806319]
R.row3 = [-0.333080338141534, 0.930434393814319, 0.152804866254]
t.row4 = [2.15292, -0.709897, 0.134909] 
Sphere286.transform = startCamera * R * t
Sphere_Text286.transform = startCamera * R * t


progressend()

selectionSets["red_centre_sensor"] = $*_red_centre_sensor --all the current objects named "*_red_centre_sensor"



messageBox "Sensor points added!"
)
