From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH] INPUT:  Remove uses of long obsolete __MODULE__ and MODULE_PARM
 macros.
Date: Sat, 17 May 2008 17:32:58 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0805171731200.27679@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:52555 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759614AbYEQVdC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 17 May 2008 17:33:02 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: trivial@kernel.org


Both of the macros __MODULE__ and MODULE_PARM have been gone for quite
some time.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/drivers/input/mouse/atarimouse.c b/drivers/input/mouse/atarimouse.c
index 98a3561..c3889d1 100644
--- a/drivers/input/mouse/atarimouse.c
+++ b/drivers/input/mouse/atarimouse.c
@@ -59,9 +59,6 @@ MODULE_LICENSE("GPL");

 static int mouse_threshold[2] = {2,2};

-#ifdef __MODULE__
-MODULE_PARM(mouse_threshold, "2i");
-#endif
 #ifdef FIXED_ATARI_JOYSTICK
 extern int atari_mouse_buttons;
 #endif

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
