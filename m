From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 31/37] docs: input/shape: convert it from xfig to svg
Date: Tue,  4 Apr 2017 09:22:31 -0300
Message-ID: <a6e09069e3a232652651c2aac6d0906e728422e2.1491308444.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491308444.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491308444.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491308444.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491308444.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491308444.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491308444.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491308444.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491308444.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491308444.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491308444.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491308444.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491308444.git.mchehab@s-opensource.com>
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491308444.git.mchehab@s-opensource.com>
 <b46575603db084d1b32b83a4fc455551207f11ad.1491308444.git.mchehab@s-opensource.com>
 <8e0ef882aa235e4e6e758662dc434567266fb541.1491308444.git.mchehab@s-opensource.com>
 <daebe3de3017721f77bdf11680796042bd05fe53.1491308444.git.mchehab@s-opensource.com>
 <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491308444.git.mchehab@s-opensource.com>
 <23b1473a9202301d9fdb8f07564467e3091e9810.1491308444.git.mchehab@s-opensource.com>
 <8606760958a9fbf4cd032f66003d6074e0463584.1491308444.git.mchehab@s-opensource.com>
 <e297fc785d72be336c2e4a85705c24eedb16cf7d.1491308444.git.mchehab@s-opensource.com>
 <4b1b04eebf96c72c4e8adee8232077ba89edca6c.1491308444.git.mchehab@s-opensource.com>
 <c6f7140e3bdbfb30a338550b700d25667b764594.1491308444.git.mchehab@s-opensource.com>
 <3552e3986d3848001b89449926d04f44930c681e.1491308444.git.mchehab@s-opensource.com>
 <226042dcaf8bc66f46abe97d235904dce8962bd1.1491308444.git.mchehab@s-opensource.com>
 <679c283194489e852074900b0133b5b6acd9395f.1491308444.git.mchehab@s-opensource.com>
 <64a9b32549546f6a5b1a5d95fcae550f98ace1d7.1491308444.git.mchehab@s-opensource.com>
 <ff44ad91600b12a8475e3e46a8a121dcbd3eedd9.1491308444.git.mchehab@s-opensource.com>
 <55d263f13237495276213de295ae1c6d67f0588b.1491308444.git.mchehab@s-opensource.com>
 <026c16b07bc58fc2b4b8f2ed6ba1eb4d9f8f37b1.1491308444.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34549
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752841AbdDDMXA (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 08:23:00 -0400
In-Reply-To: <026c16b07bc58fc2b4b8f2ed6ba1eb4d9f8f37b1.1491308444.git.mchehab@s-opensource.com>
In-Reply-To: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
References: <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491308444.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>

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

