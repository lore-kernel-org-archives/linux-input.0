From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH v2 32/33] docs: input/interactive: convert from xfig to svg
Date: Tue,  4 Apr 2017 07:52:42 -0300
Message-ID: <a016a7ed8bf8b5e9f292f188c0763a15937c28c5.1491302719.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
 <67ed7b07043e6fac94528044ebaf541d5deb7c82.1491302719.git.mchehab@s-opensource.com>
 <8e64d13bfc6952bc9370593ddc556a539f589654.1491302719.git.mchehab@s-opensource.com>
 <781a89b410f25a2fb39d081d1ebd696317b6d2c2.1491302719.git.mchehab@s-opensource.com>
 <6800b2c4e8f67b699c22533f7574d380b37cb6d6.1491302719.git.mchehab@s-opensource.com>
 <9f6ae6ca543f4aa294afd000b7c8a8f49b2e8382.1491302719.git.mchehab@s-opensource.com>
 <b1d2cca45a3704e3cb8e2c9030d8c1044fee7720.1491302719.git.mchehab@s-opensource.com>
 <00ec4ed3ae000ee03c3fd725a5fadf33c1353d16.1491302719.git.mchehab@s-opensource.com>
 <e67db9bffc4a93a93b8559ed85d6e77045a99157.1491302719.git.mchehab@s-opensource.com>
 <9794ec8a2147f66e9e183f612fa7e834c9245dd9.1491302719.git.mchehab@s-opensource.com>
 <3bb792c867ec11d1e5b998b2d44e99fbd654ff95.1491302719.git.mchehab@s-opensource.com>
 <f3c0d0286d93d05416ce501ce3ef668d5fd9cc8f.1491302719.git.mchehab@s-opensource.com>
 <95dd0d035385dac833029e1db56846f02b3ae69c.1491302719.git.mchehab@s-opensource.com>
 <3efc02b3379dc908bfc0ade34185469295fee2bc.1491302719.git.mchehab@s-opensource.com>
 <9b1b818d7cde485713aced6b077f0e276a24bddd.1491302719.git.mchehab@s-opensource.com>
 <b46575603db084d1b32b83a4fc455551207f11ad.1491302719.git.mchehab@s-opensource.com>
 <8e0ef882aa235e4e6e758662dc434567266fb541.1491302719.git.mchehab@s-opensource.com>
 <daebe3de3017721f77bdf11680796042bd05fe53.1491302719.git.mchehab@s-opensource.com>
 <c4d96be24099f525b771369e2c0dd9bdfd376fa0.1491302719.git.mchehab@s-opensource.com>
 <23b1473a9202301d9fdb8f07564467e3091e9810.1491302719.git.mchehab@s-opensource.com>
 <8606760958a9fbf4cd032f66003d6074e0463584.1491302719.git.mchehab@s-opensource.com>
 <e297fc785d72be336c2e4a85705c24eedb16cf7d.1491302719.git.mchehab@s-opensource.com>
 <4b1b04eebf96c72c4e8adee8232077ba89edca6c.1491302719.git.mchehab@s-opensource.com>
 <c6f7140e3bdbfb30a338550b700d25667b764594.1491302719.git.mchehab@s-opensource.com>
 <3552e3986d3848001b89449926d04f44930c681e.1491302719.git.mchehab@s-opensource.com>
 <226042dcaf8bc66f46abe97d235904dce8962bd1.1491302719.git.mchehab@s-opensource.com>
 <679c283194489e852074900b0133b5b6acd9395f.1491302719.git.mchehab@s-opensource.com>
 <64a9b32549546f6a5b1a5d95fcae550f98ace1d7.1491302719.git.mchehab@s-opensource.com>
 <ff44ad91600b12a8475e3e46a8a121dcbd3eedd9.1491302719.git.mchehab@s-opensource.com>
 <55d263f13237495276213de295ae1c6d67f0588b.1491302719.git.mchehab@s-opensource.com>
 <026c16b07bc58fc2b4b8f2ed6ba1eb4d9f8f37b1.1491302719.git.mchehab@s-opensource.com>
 <a6e09069e3a232652651c2aac6d0906e728422e2.1491302719.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:34407
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754155AbdDDMDf (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 4 Apr 2017 08:03:35 -0400
In-Reply-To: <a6e09069e3a232652651c2aac6d0906e728422e2.1491302719.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491302719.git.mchehab@s-opensource.com>
References: <cover.1491302719.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>

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


