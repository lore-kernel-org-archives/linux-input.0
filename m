From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 2/3] Input: ALPS - Add code to support "Rushmore" touchpads
Date: Sat, 26 Jan 2013 12:53:29 +0100
Message-ID: <87zjzwqhxi.fsf@dell.be.48ers.dk>
References: <10bf6ea5c8f86eca66cd39498ca38d58@localhost>
	<092b691c8e994d31cb235fd7c45afee4@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:43116 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab3AZMAT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Jan 2013 07:00:19 -0500
Received: by mail-ee0-f42.google.com with SMTP id b47so584135eek.15
        for <linux-input@vger.kernel.org>; Sat, 26 Jan 2013 04:00:18 -0800 (PST)
In-Reply-To: <092b691c8e994d31cb235fd7c45afee4@localhost> (Kevin Cernekee's
	message of "Sun, 20 Jan 2013 01:31:15 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: dmitry.torokhov@gmail.com, seth.forshee@canonical.com, linux-input@vger.kernel.org

>>>>> "Kevin" == Kevin Cernekee <cernekee@gmail.com> writes:

 Kevin> These touchpads mostly speak the V3 protocol, but they use a different
 Kevin> method for detection.  The manufacturer's driver follows a sequence that
 Kevin> looks something like:

 Kevin>   Send E7 query and look for an exact match: 73 03 50 ("Dolphin")
 Kevin>   If no match, send EC query and look for 88 {07,08} xx ("Pinnacle")
 Kevin>   If no match, send E7 query and look for 73 02 {0a,14,3c,50} ("Mercury II")
 Kevin>   If no match, send a more complicated query and look for 88 05 xx ("Mercury")

 Kevin> This patch adds the new EC query before the usual E7 query.  It is
 Kevin> presumed (hoped) that anything that isn't in the Pinnacle series will not
 Kevin> return "88 07 xx" or "88 08 xx".

 Kevin> Tested on:

 Kevin> Dell E6230 ("Rushmore" model from the "Pinnacle" series)
 Kevin> Dell E6430 (same as above, but with trackstick + more buttons)

 Kevin> On both PCs, the E7 report is 73 03 0a, and the EC report is 88 08 1d.

 Kevin> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Thanks. I've tested it here on a e6230 (bios rev 08), and it gets
correctly detected (but twice?):

input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input14
input: AlpsPS/2 ALPS DualPoint TouchPad as /devices/platform/i8042/serio1/input/input16

But the input events seem very noisy (E.G. the cursor jumps up and down
if I keep my finger pressed on the touchpad). Especially the Y
coordinate seems unstable:


Event: time 1359201123.864208, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1042
Event: time 1359201123.864208, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 669
Event: time 1359201123.864208, type 3 (EV_ABS), code 0 (ABS_X), value 1042
Event: time 1359201123.864208, type 3 (EV_ABS), code 1 (ABS_Y), value 669
Event: time 1359201123.864208, -------------- SYN_REPORT ------------
Event: time 1359201123.874130, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1043
Event: time 1359201123.874130, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 659
Event: time 1359201123.874130, type 3 (EV_ABS), code 0 (ABS_X), value 1043
Event: time 1359201123.874130, type 3 (EV_ABS), code 1 (ABS_Y), value 659
Event: time 1359201123.874130, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 32
Event: time 1359201123.874130, -------------- SYN_REPORT ------------
Event: time 1359201123.883495, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1038
Event: time 1359201123.883495, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 660
Event: time 1359201123.883495, type 3 (EV_ABS), code 0 (ABS_X), value 1038
Event: time 1359201123.883495, type 3 (EV_ABS), code 1 (ABS_Y), value 660
Event: time 1359201123.883495, -------------- SYN_REPORT ------------
Event: time 1359201123.893641, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1037
Event: time 1359201123.893641, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 655
Event: time 1359201123.893641, type 3 (EV_ABS), code 0 (ABS_X), value 1037
Event: time 1359201123.893641, type 3 (EV_ABS), code 1 (ABS_Y), value 655
Event: time 1359201123.893641, -------------- SYN_REPORT ------------
Event: time 1359201123.904044, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1039
Event: time 1359201123.904044, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 651
Event: time 1359201123.904044, type 3 (EV_ABS), code 0 (ABS_X), value 1039
Event: time 1359201123.904044, type 3 (EV_ABS), code 1 (ABS_Y), value 651
Event: time 1359201123.904044, -------------- SYN_REPORT ------------
Event: time 1359201123.914023, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1040
Event: time 1359201123.914023, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 645
Event: time 1359201123.914023, type 3 (EV_ABS), code 0 (ABS_X), value 1040
Event: time 1359201123.914023, type 3 (EV_ABS), code 1 (ABS_Y), value 645
Event: time 1359201123.914023, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 30
Event: time 1359201123.914023, -------------- SYN_REPORT ------------
Event: time 1359201123.924340, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1035
Event: time 1359201123.924340, type 3 (EV_ABS), code 0 (ABS_X), value 1035
Event: time 1359201123.924340, -------------- SYN_REPORT ------------
Event: time 1359201123.934719, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1040
Event: time 1359201123.934719, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 635
Event: time 1359201123.934719, type 3 (EV_ABS), code 0 (ABS_X), value 1040
Event: time 1359201123.934719, type 3 (EV_ABS), code 1 (ABS_Y), value 635
Event: time 1359201123.934719, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 29
Event: time 1359201123.934719, -------------- SYN_REPORT ------------
Event: time 1359201123.946719, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1050
Event: time 1359201123.946719, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 665
Event: time 1359201123.946719, type 3 (EV_ABS), code 0 (ABS_X), value 1050
Event: time 1359201123.946719, type 3 (EV_ABS), code 1 (ABS_Y), value 665
Event: time 1359201123.946719, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 23

Any idea why? Do you see this as well?

-- 
Bye, Peter Korsgaard
