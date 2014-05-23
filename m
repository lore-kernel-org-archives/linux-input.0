From: Jan Kandziora <jjj@gmx.de>
Subject: Aiptek T-6000U staying in relative mode.
Date: Fri, 23 May 2014 03:48:17 +0200
Message-ID: <537EA8E1.6020109@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:64627 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbaEWBsU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2014 21:48:20 -0400
Received: from janskasten.localdomain ([79.242.235.32]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0M1jKo-1X2QWW1QpG-00tnV3 for
 <linux-input@vger.kernel.org>; Fri, 23 May 2014 03:48:18 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

recently I tried wanted to use my tablet again with linux-3.11.6. After
a while I found out the kernel driver doesn't succeed to bring the
tablet to absolute mode. After fiddling around with the kernel driver,
I found it is related to the order of commands sent to the tablet while
initialization. My tablet insists the absolute mode command the last
one sent. So I patched my aiptek.c as follows:

-----------------------------------------------------------------------------------------
--- drivers/input/tablet/aiptek.c.orig  2014-05-23 03:35:05.402422214 +0200
+++ drivers/input/tablet/aiptek.c       2014-05-23 03:31:27.351508397 +0200
@@ -1003,6 +1003,18 @@
                return ret;
        input_set_abs_params(aiptek->inputdev, ABS_PRESSURE, 0, ret - 1, 0, 0);
 
+       /* Enable the macro keys */
+       if ((ret = aiptek_command(aiptek, 0x11, 0x02)) < 0)
+               return ret;
+#if 0
+       /* Execute FilterOn */
+       if ((ret = aiptek_command(aiptek, 0x17, 0x00)) < 0)
+               return ret;
+#endif
+       /* Execute AutoGainOn */
+       if ((ret = aiptek_command(aiptek, 0x12, 0xff)) < 0)
+               return ret;
+
        /* Depending on whether we are in absolute or relative mode, we will
         * do a switchToTablet(absolute) or switchToMouse(relative) command.
         */
@@ -1019,19 +1031,6 @@
                }
        }
 
-       /* Enable the macro keys */
-       if ((ret = aiptek_command(aiptek, 0x11, 0x02)) < 0)
-               return ret;
-#if 0
-       /* Execute FilterOn */
-       if ((ret = aiptek_command(aiptek, 0x17, 0x00)) < 0)
-               return ret;
-#endif
-
-       /* Execute AutoGainOn */
-       if ((ret = aiptek_command(aiptek, 0x12, 0xff)) < 0)
-               return ret;
-
        /* Reset the eventCount, so we track events from last (re)programming
         */
        aiptek->diagnostic = AIPTEK_DIAGNOSTIC_NA;
-----------------------------------------------------------------------------------------
That way it works in both relative and absolute mode and the macro keys are enabled, too.

There are some problems remaining with aiptek.c and my tablet. Anyone else here who has
aiptek hardware to test if my patches break anything with their tablets?

Kind regards

	Jan
