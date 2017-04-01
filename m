From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 32/33] docs: input/interactive: convert from xfig to svg
Date: Sat,  1 Apr 2017 15:16:15 -0300
Message-ID: <620a1378683c5f42a20a39ab5912fbbbf1801838.1491069870.git.mchehab@s-opensource.com>
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
 <fc33390a47c20cab804b2599771cefab92a7f6a9.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <fc33390a47c20cab804b2599771cefab92a7f6a9.1491069870.git.mchehab@s-opensource.com>
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
 Documentation/input/interactive.fig | 42 -------------------------------------
 Documentation/input/interactive.svg | 24 +++++++++++++++++++++
 2 files changed, 24 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/input/interactive.fig
 create mode 100644 Documentation/input/interactive.svg

diff --git a/Documentation/input/interactive.fig b/Documentation/input/interactive.fig
deleted file mode 100644
index 1e7de387723a..000000000000
--- a/Documentation/input/interactive.fig
+++ /dev/null
@@ -1,42 +0,0 @@
-#FIG 3.2
-Landscape
-Center
-Inches
-Letter  
-100.00
-Single
--2
-1200 2
-2 1 0 2 0 7 50 0 -1 6.000 0 0 -1 0 0 6
-	 1200 3600 1800 3600 2400 4800 3000 4800 4200 5700 4800 5700
-2 2 0 1 0 7 50 0 -1 4.000 0 0 -1 0 0 5
-	 1200 3150 4800 3150 4800 6300 1200 6300 1200 3150
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 1200 4800 4800 4800
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 4
-	 2400 4800 2400 6525 1950 7125 1950 7800
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 4
-	 3000 4800 3000 6525 3600 7125 3600 7800
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 0 1 3
-	0 0 1.00 60.00 120.00
-	 3825 5400 4125 5100 5400 5100
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 0 1 3
-	0 0 1.00 60.00 120.00
-	 2100 4200 2400 3900 5400 3900
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 4800 5700 5400 5700
-2 1 1 1 0 7 50 0 -1 4.000 0 0 -1 0 0 2
-	 1800 3600 5400 3600
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 0 1 3
-	0 0 1.00 60.00 120.00
-	 2700 4800 2700 4425 5400 4425
-2 1 0 1 0 7 50 0 -1 4.000 0 0 -1 1 1 2
-	0 0 1.00 60.00 120.00
-	0 0 1.00 60.00 120.00
-	 1950 7800 3600 7800
-4 1 0 50 0 0 12 0.0000 4 135 810 2775 7725 Dead band\001
-4 0 0 50 0 0 12 0.0000 4 180 1155 5400 5700 right saturation\001
-4 0 0 50 0 0 12 0.0000 4 135 1065 5400 3600 left saturation\001
-4 0 0 50 0 0 12 0.0000 4 180 2505 5400 3900 left coeff ( positive in that case )\001
-4 0 0 50 0 0 12 0.0000 4 180 2640 5475 5100 right coeff ( negative in that case )\001
-4 0 0 50 0 0 12 0.0000 4 105 480 5400 4425 center\001
diff --git a/Documentation/input/interactive.svg b/Documentation/input/interactive.svg
new file mode 100644
index 000000000000..a3513709a09b
--- /dev/null
+++ b/Documentation/input/interactive.svg
@@ -0,0 +1,24 @@
+<svg width="5.75in" height="3.90in" version="1.1" viewBox="1178 3138 6779.9424 4671.3427" xmlns="http://www.w3.org/2000/svg">
+ <polyline transform="translate(-18.5,-16.294)" points="1200 3600 1800 3600 2400 4800 3e3 4800 4200 5700 4800 5700" fill="none" stroke="#000" stroke-width="15"/>
+ <rect x="1181.5" y="3133.7" width="3600" height="3150" rx="0" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="1200 4800 4800 4800" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="2400 4800 2400 6525 1950 7125 1950 7800" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="3e3 4800 3e3 6525 3600 7125 3600 7800" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="3837 5389 4125 5100 5400 5100" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="3889 5292 3826 5398 3932 5334" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="2112 4189 2400 3900 5400 3900" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="2164 4092 2101 4198 2207 4134" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="4800 5700 5400 5700" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="1800 3600 5400 3600" fill="none" stroke="#000" stroke-dasharray="40, 40" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="2700 4784 2700 4425 5400 4425" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="2670 4678 2700 4798 2730 4678" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="1967 7800 3583 7800" fill="none" stroke="#000" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="3478 7830 3598 7800 3478 7770" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <polyline transform="translate(-18.5,-16.294)" points="2072 7770 1952 7800 2072 7830" fill="none" stroke="#000" stroke-miterlimit="8" stroke-width="7"/>
+ <text x="2775" y="7725" font-family="sans-serif" font-size="144px" stroke="#000000" stroke-width=".025in" text-anchor="middle" xml:space="preserve">Dead band</text>
+ <text x="5400" y="5700" font-family="sans-serif" font-size="144px" stroke="#000000" stroke-width=".025in" xml:space="preserve">right saturation</text>
+ <text x="5400" y="3600" font-family="sans-serif" font-size="144px" stroke="#000000" stroke-width=".025in" xml:space="preserve">left saturation</text>
+ <text x="5400" y="3900" font-family="sans-serif" font-size="144px" stroke="#000000" stroke-width=".025in" xml:space="preserve">left coeff ( positive in that case )</text>
+ <text x="5475" y="5100" font-family="sans-serif" font-size="144px" stroke="#000000" stroke-width=".025in" xml:space="preserve">right coeff ( negative in that case )</text>
+ <text x="5400" y="4425" font-family="sans-serif" font-size="144px" stroke="#000000" stroke-width=".025in" xml:space="preserve">center</text>
+</svg>
-- 
2.9.3


