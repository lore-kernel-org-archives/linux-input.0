From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 09 Mar 2010 23:39:13 +0100
Message-ID: <4B96CE11.2040307@euromail.se>
References: <4B75E14A.2050602@seas.upenn.edu> <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu> <4B760D60.6020907@seas.upenn.edu> <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz> <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu> <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz> <4B96C7EB.2000801@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070100000309000203020805"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:54646 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752290Ab0CIWj1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 17:39:27 -0500
In-Reply-To: <4B96C7EB.2000801@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chatty@enac.fr, Mika.Kuoppala@nokia.com

This is a multi-part message in MIME format.
--------------070100000309000203020805
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dmitry,

Since the topic is being discussed right now, I might as well send the mt
documentation patches prematurely (I first wanted to hear Mika's view on this,
since he pointed out the problem).

Henrik

--------------070100000309000203020805
Content-Type: text/x-diff;
 name="0001-input-mt-clarify-the-no-finger-event.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-input-mt-clarify-the-no-finger-event.patch"

>From ac8fda4c30f6ac682755151e23f4002a4ad8c1c5 Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Tue, 9 Mar 2010 20:53:26 +0100
Subject: [PATCH] input: mt: clarify the no-finger event

The current documentation does not explicitly specify how to report
zero fingers, leaving a potential problem in the driver implementations
and giving no parsing directive to userland. This patch defines two
equally valid ways.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 Documentation/input/multi-touch-protocol.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentation/input/multi-touch-protocol.txt
index 8490480..eacb226 100644
--- a/Documentation/input/multi-touch-protocol.txt
+++ b/Documentation/input/multi-touch-protocol.txt
@@ -68,6 +68,22 @@ like:
    SYN_MT_REPORT
    SYN_REPORT
 
+Here is the sequence after lifting one of the fingers:
+
+   ABS_MT_POSITION_X
+   ABS_MT_POSITION_Y
+   SYN_MT_REPORT
+   SYN_REPORT
+
+And here is the sequence after lifting the remaining finger:
+
+   SYN_MT_REPORT
+   SYN_REPORT
+
+If the driver reports one of BTN_TOUCH or ABS_PRESSURE in addition to the
+ABS_MT events, the last SYN_MT_REPORT event may be omitted. Otherwise, the
+last SYN_REPORT will be dropped by the input core, resulting in no
+zero-finger event reaching userland.
 
 Event Semantics
 ---------------
-- 
1.6.3.3


--------------070100000309000203020805
Content-Type: text/x-diff;
 name="0001-input-mt-update-the-status-of-the-Multitouch-X-drive.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-input-mt-update-the-status-of-the-Multitouch-X-drive.pa";
 filename*1="tch"

>From d6c3b34c78f442a3d27ce99a5f12bb49ddab71b5 Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@euromail.se>
Date: Tue, 9 Mar 2010 21:21:31 +0100
Subject: [PATCH] input: mt: update the status of the Multitouch X driver project

The Multitouch X driver project has moved to alpha status.
This patch updates the documentation accordingly.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 Documentation/input/multi-touch-protocol.txt |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/Documentation/input/multi-touch-protocol.txt b/Documentation/input/multi-touch-protocol.txt
index eacb226..c0fc1c7 100644
--- a/Documentation/input/multi-touch-protocol.txt
+++ b/Documentation/input/multi-touch-protocol.txt
@@ -233,11 +233,6 @@ where examples can be found.
 difference between the contact position and the approaching tool position
 could be used to derive tilt.
 [2] The list can of course be extended.
-[3] The multi-touch X driver is currently in the prototyping stage. At the
-time of writing (April 2009), the MT protocol is not yet merged, and the
-prototype implements finger matching, basic mouse support and two-finger
-scrolling. The project aims at improving the quality of current multi-touch
-functionality available in the Synaptics X driver, and in addition
-implement more advanced gestures.
+[3] Multitouch X driver project: http://bitmath.org/code/multitouch/.
 [4] See the section on event computation.
 [5] See the section on finger tracking.
-- 
1.6.3.3


--------------070100000309000203020805--
