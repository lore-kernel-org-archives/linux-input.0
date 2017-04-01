From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 33/33] docs: ff.rst: use svg files instead of xfig
Date: Sat,  1 Apr 2017 15:16:16 -0300
Message-ID: <6508ad4af7f4b3740de0014f3cc4c210bb720cea.1491069870.git.mchehab@s-opensource.com>
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
 <620a1378683c5f42a20a39ab5912fbbbf1801838.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:39611 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbdDASQd (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 1 Apr 2017 14:16:33 -0400
In-Reply-To: <620a1378683c5f42a20a39ab5912fbbbf1801838.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>

Now that the images got converted to svg, add them at the
ff.rst file.

NOTE: After merging upstream, the "figure" tag should be
replaced by the new "kernel-figure" tag, in order for the
SVG images to be included at the PDF files.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/ff.rst | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/input/ff.rst b/Documentation/input/ff.rst
index 449aade4e1fb..19ab983c81fc 100644
--- a/Documentation/input/ff.rst
+++ b/Documentation/input/ff.rst
@@ -5,8 +5,8 @@ Force feedback for Linux
 :Author: Johann Deneux <johann.deneux@gmail.com> on 2001/04/22.
 :Updated: Anssi Hannula <anssi.hannula@gmail.com> on 2006/04/09.
 
-You may redistribute this file. Please remember to include shape.fig and
-interactive.fig as well.
+You may redistribute this file. Please remember to include shape.svg and
+interactive.svg as well.
 
 Introduction
 ~~~~~~~~~~~~
@@ -127,8 +127,15 @@ allocate a new effect.
 Effects are file descriptor specific.
 
 See <linux/input.h> for a description of the ff_effect struct. You should also
-find help in a few sketches, contained in files shape.fig and interactive.fig.
-You need xfig to visualize these files.
+find help in a few sketches, contained in files shape.svg and interactive.svg:
+
+.. figure:: shape.svg
+
+    Shape
+
+.. figure:: interactive.svg
+
+    Interactive
 
 
 Removing an effect from the device
-- 
2.9.3


