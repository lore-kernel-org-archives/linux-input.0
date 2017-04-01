From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 31/33] docs: input/shape: convert it from xfig to svg
Date: Sat,  1 Apr 2017 15:16:14 -0300
Message-ID: <fc33390a47c20cab804b2599771cefab92a7f6a9.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
 <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
 <57e5da3e598139b8ab24ff1dda1afaa612bd3e9b.1491069870.git.mchehab@s-opensource.com>
 <55ed0f35fc4dc65436ef2cf4abcf5e458b70add7.1491069870.git.mchehab@s-opensource.com>
 <c1c2d69dddb0f6281452ee3a4db7023c5adbe9a0.1491069870.git.mchehab@s-opensource.com>
 <d3aeee7338003eb50db47a510e4f523d800bcf8c.1491069870.git.mchehab@s-opensource.com>
 <828662d0c5d9fa24a8ccc21f573bf2039a3cb95c.1491069870.git.mchehab@s-opensource.com>
 <ccecd15f5c80b96476fd41c046b19efc9cba28d5.1491069870.git.mchehab@s-opensource.com>
 <0b3e07c981ca9c1e5ac466704bbc96a4bb91b136.1491069870.git.mchehab@s-opensource.com>
 <6af7af2b604dc23c6a1000ec7619f4428622fc7a.1491069870.git.mchehab@s-opensource.com>
 <d02fc4145bff1d73e28317d1bfadeab9394a59cf.1491069870.git.mchehab@s-opensource.com>
 <da8f3bb404822abd36a480d83b7538577010097f.1491069870.git.mchehab@s-opensource.com>
 <011680ea06ad0b73922b17a6c453d5891bfd5386.1491069870.git.mchehab@s-opensource.com>
 <87be2676f773a689c9b39c4f79cd843fb3678133.1491069870.git.mchehab@s-opensource.com>
 <6730cd298d203d22aec9a5a708cd1d15982e624b.1491069870.git.mchehab@s-opensource.com>
 <b9b1a9e27971fd899876825f2ccfd638c6c62668.1491069870.git.mchehab@s-opensource.com>
 <07a688fbc69c47362aca5882a3bcf72329d0fe1a.1491069870.git.mchehab@s-opensource.com>
 <13245dfb9e3a0f34547925ef3e6efc87b8165ae2.1491069870.git.mchehab@s-opensource.com>
 <355358d79dca250017195f1e0309d64edd432a07.1491069870.git.mchehab@s-opensource.com>
 <74a6c5b672275a8a40317a76c72845a939089c89.1491069870.git.mchehab@s-opensource.com>
 <d55bc5210e28c8c0bb4179e58359a8ff7b234f41.1491069870.git.mchehab@s-opensource.com>
 <84c4c711e5b98aafca81460742d5c25fbb24474b.1491069870.git.mchehab@s-opensource.com>
 <2aece6cda8b5835832b4a3987c8818697aacc583.1491069870.git.mchehab@s-opensource.com>
 <4f55d4a177f311a1bc1c8ee5547ec53c3f92fefe.1491069870.git.mchehab@s-opensource.com>
 <c73bfd1906e067331ed9717d62a2eae4aaf2ce9a.1491069870.git.mchehab@s-opensource.com>
 <721d8a1164997d61e5c0b6e9f4cc300f84643ebc.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <721d8a1164997d61e5c0b6e9f4cc300f84643ebc.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

We're using svg as the standard format for vectorial images.

Convert it to .svg, in a way that it is easily editable.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/shape.fig | 65 -------------------------------------------
 Documentation/input/shape.svg | 39 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/input/shape.fig
 create mode 100644 Documentation/input/shape.svg

diff --git a/Documentation/input/shape.fig b/Documentation/input/shape.fig
deleted file mode 100644
index c22bff83d06f..000000000000
--- a/Documentation/input/shape.fig
+++ /dev/null
@@ -1,65 +0,0 @@
-#FIG 3.2
-Landscape
-Center
-Inches
-Letter  
-100.00
-Single
--2
-1200 2
-2 1 0 2 0 7 50 0 -1 0.000 0 0 -1 0 0 6
-	 4200 3600 4200 3075 4950 2325 7425 2325 8250 3150 8250 3600
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 4200 3675 4200 5400
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 8250 3675 8250 5400
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 3675 3600 8700 3600
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 8775 3600 10200 3600
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 8325 3150 9075 3150
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 7500 2325 10200 2325
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 3600 3600 3000 3600
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 4125 3075 3000 3075
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 1 1 2
-	0 0 1.00 60.00 120.00
-	0 0 1.00 60.00 120.00
-	 4200 5400 8175 5400
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 1 1 2
-	0 0 1.00 60.00 120.00
-	0 0 1.00 60.00 120.00
-	 10125 2325 10125 3600
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 1 1 2
-	0 0 1.00 60.00 120.00
-	0 0 1.00 60.00 120.00
-	 3000 3150 3000 3600
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 1 1 2
-	0 0 1.00 60.00 120.00
-	0 0 1.00 60.00 120.00
-	 9075 3150 9075 3600
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 4950 2325 4950 1200
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 7425 2325 7425 1200
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 4
-	 4200 3075 4200 2400 3600 1800 3600 1200
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 4
-	 8250 3150 8250 2475 8775 1950 8775 1200
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 1 1 2
-	0 0 1.00 60.00 120.00
-	0 0 1.00 60.00 120.00
-	 3600 1275 4950 1275
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 1 1 2
-	0 0 1.00 60.00 120.00
-	0 0 1.00 60.00 120.00
-	 7425 1275 8700 1275
-4 1 0 50 0 0 12 0.0000 4 135 1140 6075 5325 Effect duration\001
-4 0 0 50 0 0 12 0.0000 4 180 1305 10200 3000 Effect magnitude\001
-4 0 0 50 0 0 12 0.0000 4 135 780 9150 3450 Fade level\001
-4 1 0 50 0 0 12 0.0000 4 180 1035 4275 1200 Attack length\001
-4 1 0 50 0 0 12 0.0000 4 180 885 8175 1200 Fade length\001
-4 2 0 50 0 0 12 0.0000 4 135 930 2925 3375 Attack level\001
diff --git a/Documentation/input/shape.svg b/Documentation/input/shape.svg
new file mode 100644
index 000000000000..fc0af44db3f7
--- /dev/null
+++ b/Documentation/input/shape.svg
@@ -0,0 +1,39 @@
+<svg width="7.95in" height="3.70in" version="1.1" viewBox="1956 1041 9354.492 4306.001" xmlns="http://www.w3.org/2000/svg">
+ <polyline transform="translate(-121.88 -68.4)" points="4200 3600 4200 3075 4950 2325 7425 2325 8250 3150 8250 3600" fill="none" stroke="#000" stroke-width="15"/>
+ <polyline transform="translate(-121.88 -68.4)" points="4200 3675 4200 5400" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="8250 3675 8250 5400" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="3675 3600 8700 3600" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="8775 3600 10200 3600" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="8325 3150 9075 3150" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="7500 2325 10200 2325" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="3600 3600 3e3 3600" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="4125 3075 3e3 3075" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="4217 5400 8158 5400" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="8053 5430 8173 5400 8053 5370" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="4322 5370 4202 5400 4322 5430" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="10125 2342 10125 3583" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="10095 3478 10125 3598 10155 3478" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="10155 2447 10125 2327 10095 2447" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="3e3 3167 3e3 3583" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="2970 3478 3e3 3598 3030 3478" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="3030 3272 3e3 3152 2970 3272" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="9075 3167 9075 3583" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="9045 3478 9075 3598 9105 3478" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="9105 3272 9075 3152 9045 3272" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="4950 2325 4950 1200" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="7425 2325 7425 1200" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="4200 3075 4200 2400 3600 1800 3600 1200" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="8250 3150 8250 2475 8775 1950 8775 1200" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="3617 1275 4933 1275" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="4828 1305 4948 1275 4828 1245" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="3722 1245 3602 1275 3722 1305" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="7442 1275 8683 1275" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="8578 1305 8698 1275 8578 1245" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-121.88 -68.4)" points="7547 1245 7427 1275 7547 1305" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <text x="5953.125" y="5256.6001" fill="#000000" font-family="sans-serif" font-size="144px" stroke-width=".025in" text-anchor="middle" xml:space="preserve">Effect duration</text>
+ <text x="10078.125" y="2931.5999" fill="#000000" font-family="sans-serif" font-size="144px" stroke-width=".025in" xml:space="preserve">Effect magnitude</text>
+ <text x="9028.125" y="3381.5999" fill="#000000" font-family="sans-serif" font-size="144px" stroke-width=".025in" xml:space="preserve">Fade level</text>
+ <text x="4153.125" y="1131.6" fill="#000000" font-family="sans-serif" font-size="144px" stroke-width=".025in" text-anchor="middle" xml:space="preserve">Attack length</text>
+ <text x="8053.125" y="1131.6" fill="#000000" font-family="sans-serif" font-size="144px" stroke-width=".025in" text-anchor="middle" xml:space="preserve">Fade length</text>
+ <text x="2803.125" y="3306.5999" fill="#000000" font-family="sans-serif" font-size="144px" stroke-width=".025in" text-anchor="end" xml:space="preserve">Attack level</text>
+</svg>
-- 
2.9.3


