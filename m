From: Thorsten Wissmann <re06huxa@stud.informatik.uni-erlangen.de>
Subject: Re: Mixed "pen" and multitouch input devices
Date: Fri, 16 Mar 2012 02:52:24 +0100
Message-ID: <20120316015224.GA8230@stud.informatik.uni-erlangen.de>
References: <20120315155235.GA6783@stud.informatik.uni-erlangen.de>
 <CAGzDe_b0XPUBZKAGnj9kxzuRb9Fw7aph_Q+VgmdVbpVNU2Sf3w@mail.gmail.com>
 <20120315175635.GA23155@stud.informatik.uni-erlangen.de>
 <4F623511.3040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55464 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758654Ab2CPBw1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 21:52:27 -0400
Content-Disposition: inline
In-Reply-To: <4F623511.3040907@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chasedouglas@gmail.com>
Cc: Chris Bagwell <chris@cnpbagwell.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Maximilian =?iso-8859-1?Q?Kr=FCger?= <maxfragg@gmail.com>, i4passt@lists.informatik.uni-erlangen.de

On Thu, Mar 15, 2012 at 11:29:37AM -0700, Chase Douglas wrote:
> On 03/15/2012 10:56 AM, Thorsten Wissmann wrote:
> > On Thu, Mar 15, 2012 at 12:27:22PM -0500, Chris Bagwell wrote:
> >> If you want to work with other unmodified user land apps (perhaps
> >> xf86-input-evdev for touches) then its probably easiest to split pen
> >> and touch to separate input devices.  drivers/input/tablet/wacom_wac.c
> >> shows some examples of that approach but that driver doesn't have to
> >> work to hard to split in to 2 input devices because the USB device
> >> already puts the events on separate USB  interfaces.
> > 
> > OK. We want the device to work with the xf86-input-evdev driver. So we
> > will split it into two devices.
> 
> Or you could teach evdev to know how to handle mixed devices :). I think
> that's the "better" approach over all, but it's up to you.

Thanks! We didn't thought about this. It turned out that the problem
isn't caused by the usage of both BTN_TOOL_PEN and BTN_TOOL_FINGER.

It turned out xf86-input-evdev really discards all non-multitouch events
(especially ABS_X and ABS_Y) events in EvdevProcessAbsoluteMotionEvent()
in evdev.c, if the device is configured as a multitouch device. So there
is a quick fix (or only workaround?), which processes ABS_X and ABS_Y
events even if it is a multitouch device:

diff --git a/src/evdev.c b/src/evdev.c
index d540b87..b857b83 100644
--- a/src/evdev.c
+++ b/src/evdev.c
@@ -832,7 +832,7 @@ EvdevProcessAbsoluteMotionEvent(InputInfoPtr pInfo,
struct input_event *ev)
     if (ev->code >= ABS_MT_SLOT) {
         EvdevProcessTouchEvent(pInfo, ev);
         pEvdev->abs_queued = 1;
-    } else if (!pEvdev->mt_mask) {
+    } else if (!pEvdev->mt_mask || ev->code == ABS_X || ev->code ==
ABS_Y) {
         map = pEvdev->axis_map[ev->code];
         valuator_mask_set(pEvdev->vals, map, value);
         pEvdev->abs_queued = 1;

This patch already is submitted to the xorg bugtracker and can be found
at [1].

The only remaining question is: Does it break other drivers?

    Max and Thorsten

[1] https://bugs.freedesktop.org/show_bug.cgi?id=47382
-- 
1.7.9.3




