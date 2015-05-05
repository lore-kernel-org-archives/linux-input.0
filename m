From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/5] hid: sony: Add support for the Sony Motion Controller
Date: Tue, 5 May 2015 23:24:06 +0200
Message-ID: <20150505212406.GA15218@amd>
References: <1430793272-11545-1-git-send-email-frank.praznik@oh.rr.com>
 <1430793272-11545-3-git-send-email-frank.praznik@oh.rr.com>
 <20150505211640.GA10272@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57130 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945943AbbEEVYI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2015 17:24:08 -0400
Content-Disposition: inline
In-Reply-To: <20150505211640.GA10272@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On Tue 2015-05-05 23:16:40, Pavel Machek wrote:
> Hi!
> 
> > Add a fixed-up HID descriptor for the Sony motion controller and enable
> > controls for the LED light as well as force-feedback.
> > 
> > The LED is multi-colored (red, green, blue) and has a 'global' control to
> > allow it to be flashed or switched on an off atomically.

Oh... I don't think the global control at this level is good idea. Let
me test how it works, but assigning different triggers to global and
red would be interesting, for example.

> > The motion controller has a single rumble motor so the higher of the left and
> > right values is used to set the speed.
> > 
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> > ---
> > 
> >  Pavel, can you please test this and make sure it works?  
> 
> I tried (on 4.1-rc2), and got this (full dmesg in attachment)

Ok, that one was easy.

Now it registers but the LEDs do not light.
								Pavel

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 46e4ceb..09a8328 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1770,7 +1770,7 @@ static int sony_allocate_output_report(struct sony_sc *sc)
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
