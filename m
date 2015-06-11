From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] Input - synaptics: pin 3 touches when the firmware
 reports 3 fingers
Date: Thu, 11 Jun 2015 13:29:09 -0400
Message-ID: <20150611172909.GB32361@mail.corp.redhat.com>
References: <1429717509-27396-1-git-send-email-benjamin.tissoires@redhat.com>
 <1429717509-27396-3-git-send-email-benjamin.tissoires@redhat.com>
 <20150423163818.GC34808@dtor-ws>
 <20150423184825.GB10937@mail.corp.redhat.com>
 <20150424225049.GA14791@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38233 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420AbbFKR3N (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Jun 2015 13:29:13 -0400
Content-Disposition: inline
In-Reply-To: <20150424225049.GA14791@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Hans de Goede <hdegoede@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>

On Apr 24 2015 or thereabouts, Benjamin Tissoires wrote:
> Hi Dmitry,
> 
> [ adding more relevant people to the discussion ]
> 
> On Apr 23 2015 or thereabouts, Benjamin Tissoires wrote:
> > On Apr 23 2015 or thereabouts, Dmitry Torokhov wrote:
> > > On Wed, Apr 22, 2015 at 11:45:09AM -0400, Benjamin Tissoires wrote:
> > > > Synaptics PS/2 touchpad can send only 2 touches in a report. They can
> > > > detect 4 or 5 and this information is valuable.
> > > > 
> > > > In commit 63c4fda3c0bb ("Input: synaptics - allocate 3 slots to keep
> > > > stability in image sensors"), we allocate 3 slots, but we still continue
> > > > to report the 2 available fingers. That means that the client sees 2 used
> > > > slots while there is a total of 3 fingers advertised by BTN_TOOL_TRIPLETAP.
> > > > 
> > > > For old kernels this is not a problem because max_slots was 2 and libinput/
> > > > xorg-synaptics knew how to deal with that. Now that max_slot is 3, the
> > > > clients ignore BTN_TOOL_TRIPLETAP and count the actual used slots (so 2).
> > > > It then gets confused when receiving the BTN_TOOL_TRIPLETAP and DOUBLETAP
> > > > information, and goes wild.
> > > > 
> > > > We can pin the 3 slots until we get a total number of fingers below 2.
> > > > 
> > > > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1212230
> > > 
> > > Benjamin, I do not quite like it. It seems that original patch was not
> > > quite right and we are adding more workarounds.
> > 
> > Agree. And I am starting to hate more and more the synaptics PS/2 and all
> > the PS/2 drivers to be honest :) - trying to fit a heavy load data like
> > multitouch in a simple and lightweight protocol like PS/2 is insane...
> > 
> > We are internally trying to figure out if we can finally take advantage
> > of the SMBus/RMI4 protocol, but we tried for one year without much
> > success.
> > 
> > > 
> > > Synaptics can only track 2 contacts, correct? Why 2 slots to track them
> > > is not enough?
> > 
> > IIRC, the problem was that upon a third finger down, with only 2 slots,
> > the fingers were silently inverted in most cases. The thing is that the
> > firmware forwards 2 fingers, but not necessarily the two first. So you
> > generally get fingers 1+3 so the slot 2 needs to be removed. And that
> > means the kernel tracking has to track 3 fingers upon transitions.
> > 
> > This may be completely bullshit and we might not need to use 3 slots at
> > all. I'll need to do further experiments to validate which one is best
> > then.
> > 
> > I am perfectly fine holding this one up for a little bit more testings
> > and then we can decide which one needs to be done (revert or an other
> > band-aid).
> > 
> 
> So I carefully recorded each situation (initial with 2 slots, 2 slots
> and then with the pinning in this patch*), and I am now convinced that
> the pinning is the best sequence that we forward to the user space (best
> among the 3).
> 
> With 2 slots declared, there are 2 problems:
> - the first finger jumps to the position of the 3rd when it lands
> - the transition between 2 to 3 fingers goes to a state where the kernel
>   removes the second finger (while jumping the first to the position of
>   the 3rd finger), send a sync and then reallocate the first finger
>   position as the second slot in use
> 
> -> that means that user space sees a small transition where the slots
> count is 1 while the BTN_TOOL advertise triple tap :/
> 
> With 3 slots, we have the problem reported in the rhbz bug  #1212230:
> - during the transition, the fingers are stable, but we have at most 2
>   active slots in one frame, which confuses libinput/xorg-synaptics.
> 
> With the pinning, the user space is no more confused because BTN_TOOL is
> always greater or equal than the active slots.
> 
> So I think for now we have 3 possibilities:
> 1. Just carry this patch, and hope that we will be able to switch the
>    synaptics device in the non-PS/2 mode
> 2. Revert to 2 patches and fix the kernel tracking to accept 3 fingers
>    and return the 2 best matches
> 3. Revert the use of the kernel tracking at all and re-introduce the
>    spaghetti code that was here before and hope that all cases where
>    properly handled.
> 
> IMO that the solution 2. is the best, but I can not do it because I
> don't understand what the code does. I can guess things but I can not
> accurately change it because it is not readable IMO.
> 
> (yes, there is also the solution 4: "screw up and let the user space deal
> with it", but I'd rather not do that given the history of the multitouch
> protocol)

Dmitry, I feel like this discussion fell a little bit between the cracks
and that we all forgot about it.

I still believe that the patch is needed (even if it is not the best
solution), so I am sending a gently ping on this one :)

Cheers,
Benjamin

 
> * I tried to put side by side the 3 test cases in the following logs:
> 
> 
> (init slots 2, no pinning)    | (init slots 3, no pinning)    | (init slots 3, pinning)
> ----------------------------- | ----------------------------- | ---------------------------
> ------------------------------|-----  one finger down  -------|----------------------------
>                               |                               |
> ABS_MT_SLOT          0        | ABS_MT_SLOT          0        | ABS_MT_SLOT          0
> ABS_MT_TRACKING_ID   53       | ABS_MT_TRACKING_ID   53       | ABS_MT_TRACKING_ID   53
> ABS_MT_POSITION_X    2000     | ABS_MT_POSITION_X    2000     | ABS_MT_POSITION_X    2000
> ABS_MT_POSITION_Y    2000     | ABS_MT_POSITION_Y    2000     | ABS_MT_POSITION_Y    2000
> ABS_MT_PRESSURE      68       | ABS_MT_PRESSURE      68       | ABS_MT_PRESSURE      68
> BTN_TOUCH            1        | BTN_TOUCH            1        | BTN_TOUCH            1
> ABS_X                2000     | ABS_X                2000     | ABS_X                2000
> ABS_Y                2000     | ABS_Y                2000     | ABS_Y                2000
> ABS_PRESSURE         68       | ABS_PRESSURE         68       | ABS_PRESSURE         68
> BTN_TOOL_FINGER      1        | BTN_TOOL_FINGER      1        | BTN_TOOL_FINGER      1
> --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ----------
>                               |                               |
> ...                           | ...                           | ...
>                               |                               |
> ------------------------------------  second finger down ------------------------------------
>                               |                               |
> --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ----------
> ABS_MT_POSITION_X    2000     | ABS_MT_POSITION_X    2000     | ABS_MT_POSITION_X    2000
> ABS_MT_POSITION_Y    2000     | ABS_MT_POSITION_Y    2000     | ABS_MT_POSITION_Y    2000
> ABS_MT_PRESSURE      78       | ABS_MT_PRESSURE      78       | ABS_MT_PRESSURE      78
> ABS_MT_SLOT          1        | ABS_MT_SLOT          1        | ABS_MT_SLOT          1
> ABS_MT_TRACKING_ID   54       | ABS_MT_TRACKING_ID   54       | ABS_MT_TRACKING_ID   54
> ABS_MT_POSITION_X    3000     | ABS_MT_POSITION_X    3000     | ABS_MT_POSITION_X    3000
> ABS_MT_POSITION_Y    3000     | ABS_MT_POSITION_Y    3000     | ABS_MT_POSITION_Y    3000
> ABS_MT_PRESSURE      64       | ABS_MT_PRESSURE      64       | ABS_MT_PRESSURE      64
> ABS_X                2000     | ABS_X                2000     | ABS_X                2000
> ABS_Y                2000     | ABS_Y                2000     | ABS_Y                2000
> ABS_PRESSURE         78       | ABS_PRESSURE         78       | ABS_PRESSURE         78
> BTN_TOOL_FINGER      0        | BTN_TOOL_FINGER      0        | BTN_TOOL_FINGER      0
> BTN_TOOL_DOUBLETAP   1        | BTN_TOOL_DOUBLETAP   1        | BTN_TOOL_DOUBLETAP   1
> --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ----------
>                               |                               |
> ...                           | ...                           | ...
>                               |                               |
> ------------------------------------  third finger down ------------------------------------
>                               |                               |
> --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ----------
> ABS_MT_SLOT          0        | ABS_MT_SLOT          0        | ABS_MT_SLOT          0
> ABS_MT_POSITION_X    4000     | ABS_MT_POSITION_X    2000     | ABS_MT_POSITION_X    2000
> ABS_MT_POSITION_Y    4000     | ABS_MT_POSITION_Y    2000     | ABS_MT_POSITION_Y    2000
> ABS_MT_PRESSURE      78       | ABS_MT_PRESSURE      78       | ABS_MT_PRESSURE      78
> ABS_MT_SLOT          1        | ABS_MT_SLOT          2        | ABS_MT_SLOT          2
> ABS_MT_TRACKING_ID   -1       | ABS_MT_TRACKING_ID   55       | ABS_MT_TRACKING_ID   55
>                               | ABS_MT_POSITION_X    4000     | ABS_MT_POSITION_X    4000
>                               | ABS_MT_POSITION_Y    4000     | ABS_MT_POSITION_Y    4000
>                               | ABS_MT_PRESSURE      72       | ABS_MT_PRESSURE      72
>                               | ABS_MT_SLOT          1        |
>                               | ABS_MT_TRACKING_ID   -1       |
> ABS_X                4000     | ABS_X                2000     | ABS_X                2000
> ABS_Y                4000     | ABS_Y                2000     | ABS_Y                2000
> ABS_PRESSURE         78       | ABS_PRESSURE         78       | ABS_PRESSURE         78
> BTN_TOOL_DOUBLETAP   0        | BTN_TOOL_DOUBLETAP   0        | BTN_TOOL_DOUBLETAP   0
> BTN_TOOL_TRIPLETAP   1        | BTN_TOOL_TRIPLETAP   1        | BTN_TOOL_TRIPLETAP   1
> --- SYN_REPORT (0) ---------- |                               |
> ABS_MT_SLOT          0        |                               |
> ABS_MT_POSITION_X    4000     |                               |
> ABS_MT_POSITION_Y    4000     |                               |
> ABS_MT_PRESSURE      78       |                               |
> ABS_MT_SLOT          1        |                               |
> ABS_MT_TRACKING_ID   55       |                               |
> ABS_MT_POSITION_X    2000     |                               |
> ABS_MT_POSITION_Y    2000     |                               |
> ABS_MT_PRESSURE      72       |                               |
> ABS_X                4000     |                               |
> ABS_Y                4000     |                               |
> ABS_PRESSURE         78       |                               |
> --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ----------
>                               |                               |
> ...                           | ...                           | ...
>                               |                               |
> ------------------------------------  3 fingers release ------------------------------------
>                               |                               |
>                               |                               |
> --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ----------
>                               |                               | ABS_MT_SLOT          2
>                               |                               | ABS_MT_POSITION_X    4000
>                               |                               | ABS_MT_POSITION_Y    4000
>                               |                               | ABS_MT_PRESSURE      45
> ABS_MT_SLOT          0        | ABS_MT_SLOT          0        | ABS_MT_SLOT          0
> ABS_MT_TRACKING_ID   -1       | ABS_MT_TRACKING_ID   -1       | ABS_MT_TRACKING_ID   -1
> ABS_MT_SLOT          1        | ABS_MT_SLOT          2        | ABS_MT_SLOT          1
> ABS_MT_TRACKING_ID   -1       | ABS_MT_TRACKING_ID   -1       | ABS_MT_TRACKING_ID   -1
>                               |                               | ABS_X                4000
>                               |                               | ABS_Y                4000
> BTN_TOUCH            0        | BTN_TOUCH            0        | ABS_PRESSURE         45
> ABS_PRESSURE         0        | ABS_PRESSURE         0        | BTN_TOOL_FINGER      1
> BTN_TOOL_TRIPLETAP   0        | BTN_TOOL_TRIPLETAP   0        | BTN_TOOL_TRIPLETAP   0
> --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ---------- | --- SYN_REPORT (0) ----------
>                               |                               | ABS_MT_SLOT          2
>                               |                               | ABS_MT_TRACKING_ID   -1
>                               |                               | BTN_TOUCH            0
>                               |                               | ABS_PRESSURE         0
>                               |                               | BTN_TOOL_FINGER      0
>                               |                               | --- SYN_REPORT (0) ----------
> 
> 
