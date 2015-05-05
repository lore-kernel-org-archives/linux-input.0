From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/5] hid: sony: Add support for the Sony Motion Controller
Date: Tue, 5 May 2015 23:47:36 +0200
Message-ID: <20150505214736.GA16332@amd>
References: <1430793272-11545-1-git-send-email-frank.praznik@oh.rr.com>
 <1430793272-11545-3-git-send-email-frank.praznik@oh.rr.com>
 <20150505211640.GA10272@amd>
 <20150505213606.GB15218@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57671 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbbEEVrj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2015 17:47:39 -0400
Content-Disposition: inline
In-Reply-To: <20150505213606.GB15218@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

Hi!

> Not sure how this is expected to work. I tried: (and did not get any
> vibrations).

Hmm. Seems I tried wrong device. But no vibrations with the right
device, either:

root@duo:/sys/class/leds/0003:054C:03D5.0002:global# echo 4 | fftest
/dev/input/event8
Force feedback test program.
HOLD FIRMLY YOUR WHEEL OR JOYSTICK TO PREVENT DAMAGES

Device /dev/input/event8 opened
Features:
  * Absolute axes: X, Y, Z, RZ, Misc ,
      [27 00 00 00 00 FF FF 7F ]
        * Relative axes:
	    [00 00 ]
	      * Force feedback effects types: Periodic, Rumble, Gain,
	          Force feedback periodic effects: Square, Triangle,
		  Sine,
		      [00 00 00 00 00 00 00 00 00 00 03 07 01 00 00 00
		      ]
		        * Number of simultaneous effects: 16

Setting master gain to 75% ... OK
Uploading effect #0 (Periodic sinusoidal) ... OK (id 0)
Uploading effect #1 (Constant) ... Error: Invalid argument
Uploading effect #2 (Spring) ... Error: Invalid argument
Uploading effect #3 (Damper) ... Error: Invalid argument
Uploading effect #4 (Strong rumble, with heavy motor) ... OK (id 1)
Uploading effect #5 (Weak rumble, with light motor) ... OK (id 2)
Enter effect number, -1 to exit
Now Playing: Strong Rumble
Enter effect number, -1 to exit
Read error
Stopping effects
root@duo:/sys/class/leds/0003:054C:03D5.0002:global#

If it has just one motor, should it say so in the description? Not
advertising both heavy and light motor.

If I do this, I can control vibrations using the "red" led. Value of
70 is lowest that produces anything...

Best regards,
								Pavel

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 46e4ceb..de02a35 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1751,6 +1751,8 @@ static void motion_state_worker(struct work_struct *work)
 
 #ifdef CONFIG_SONY_FF
 	report->rumble = max(sc->right, sc->left);
+	report->rumble = report->r;
+	printk("Rumble: %d\n", report->r);
 #endif
 
 	hid_hw_output_report(hdev, (__u8 *)report,
@@ -1770,7 +1772,7 @@ static int sony_allocate_output_report(struct sony_sc *sc)
 		sc->output_report_dmabuf = kmalloc(DS4_REPORT_0x05_SIZE,
 						GFP_KERNEL);
 	else if (sc->quirks & MOTION_CONTROLLER)
-		kmalloc(sizeof(struct motion_output_report_02),
+		sc->output_report_dmabuf = kmalloc(sizeof(struct motion_output_report_02),
 				GFP_KERNEL);
 	else
 		return 0;


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
