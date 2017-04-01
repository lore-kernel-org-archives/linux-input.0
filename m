From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [PATCH 06/33] docs: input/bcm5974: convert it to ReST format
Date: Sat,  1 Apr 2017 15:15:49 -0300
Message-ID: <e954f11fce1eb50321c88c96cbdb24d87e857108.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
 <1756e375bc7fbc9daae3ca1267cb96972d7962a2.1491069870.git.mchehab@s-opensource.com>
 <d22052c26786b30ed6d38f5ddd977be232bca61c.1491069870.git.mchehab@s-opensource.com>
 <f05b5191b0c6d52d5672d5b4dd4f3367580eec03.1491069870.git.mchehab@s-opensource.com>
 <40f1698c0fe55c303f70eac042540c1ce3b76385.1491069870.git.mchehab@s-opensource.com>
 <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <564bab77d213c4995418de5debc9149f01b44c67.1491069870.git.mchehab@s-opensource.com>
In-Reply-To: <cover.1491069870.git.mchehab@s-opensource.com>
References: <cover.1491069870.git.mchehab@s-opensource.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-input@vger.kernel.org

This file require minimum adjustments to be a valid ReST file.
Do it, in order to be able to parse it with Sphinx.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 Documentation/input/bcm5974.txt | 43 +++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/Documentation/input/bcm5974.txt b/Documentation/input/bcm5974.txt
index 74d3876d6f34..4aca199b0aa6 100644
--- a/Documentation/input/bcm5974.txt
+++ b/Documentation/input/bcm5974.txt
@@ -1,19 +1,25 @@
+.. include:: <isonum.txt>
+
+------------------------
 BCM5974 Driver (bcm5974)
 ------------------------
-	Copyright (C) 2008-2009	Henrik Rydberg <rydberg@euromail.se>
+
+:Copyright: |copy| 2008-2009	Henrik Rydberg <rydberg@euromail.se>
 
 The USB initialization and package decoding was made by Scott Shawcroft as
 part of the touchd user-space driver project:
-	Copyright (C) 2008	Scott Shawcroft (scott.shawcroft@gmail.com)
+
+:Copyright: |copy| 2008	Scott Shawcroft (scott.shawcroft@gmail.com)
 
 The BCM5974 driver is based on the appletouch driver:
-	Copyright (C) 2001-2004	Greg Kroah-Hartman (greg@kroah.com)
-	Copyright (C) 2005	Johannes Berg (johannes@sipsolutions.net)
-	Copyright (C) 2005	Stelian Pop (stelian@popies.net)
-	Copyright (C) 2005	Frank Arnold (frank@scirocco-5v-turbo.de)
-	Copyright (C) 2005	Peter Osterlund (petero2@telia.com)
-	Copyright (C) 2005	Michael Hanselmann (linux-kernel@hansmi.ch)
-	Copyright (C) 2006	Nicolas Boichat (nicolas@boichat.ch)
+
+:Copyright: |copy| 2001-2004	Greg Kroah-Hartman (greg@kroah.com)
+:Copyright: |copy| 2005		Johannes Berg (johannes@sipsolutions.net)
+:Copyright: |copy| 2005		Stelian Pop (stelian@popies.net)
+:Copyright: |copy| 2005		Frank Arnold (frank@scirocco-5v-turbo.de)
+:Copyright: |copy| 2005		Peter Osterlund (petero2@telia.com)
+:Copyright: |copy| 2005		Michael Hanselmann (linux-kernel@hansmi.ch)
+:Copyright: |copy| 2006		Nicolas Boichat (nicolas@boichat.ch)
 
 This driver adds support for the multi-touch trackpad on the new Apple
 Macbook Air and Macbook Pro laptops. It replaces the appletouch driver on
@@ -44,22 +50,21 @@ Debug output
 
 To ease the development for new hardware version, verbose packet output can
 be switched on with the debug kernel module parameter. The range [1-9]
-yields different levels of verbosity. Example (as root):
+yields different levels of verbosity. Example (as root)::
 
-echo -n 9 > /sys/module/bcm5974/parameters/debug
+    echo -n 9 > /sys/module/bcm5974/parameters/debug
 
-tail -f /var/log/debug
+    tail -f /var/log/debug
 
-echo -n 0 > /sys/module/bcm5974/parameters/debug
+    echo -n 0 > /sys/module/bcm5974/parameters/debug
 
 Trivia
 ------
 
-The driver was developed at the ubuntu forums in June 2008 [1], and now has
-a more permanent home at bitmath.org [2].
+The driver was developed at the ubuntu forums in June 2008 [#f1]_, and now has
+a more permanent home at bitmath.org [#f2]_.
 
-Links
------
+.. Links
 
-[1] http://ubuntuforums.org/showthread.php?t=840040
-[2] http://bitmath.org/code/
+.. [#f1] http://ubuntuforums.org/showthread.php?t=840040
+.. [#f2] http://bitmath.org/code/
-- 
2.9.3


