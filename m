From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mt: only perform pointer emulation on drivers
 desiring this functionality
Date: Thu, 27 Oct 2016 16:54:06 -0700
Message-ID: <20161027235406.GE12312@dtor-ws>
References: <1477603873-9143-1-git-send-email-roderick@gaikai.com>
 <20161027231942.GB12312@dtor-ws>
 <CANndSKmxgUM-u+jZF611Ko5supENX95-JR2xKp++3YPGZHAJtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36180 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933978AbcJ0XyK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 19:54:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id n85so3855774pfi.3
        for <linux-input@vger.kernel.org>; Thu, 27 Oct 2016 16:54:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANndSKmxgUM-u+jZF611Ko5supENX95-JR2xKp++3YPGZHAJtw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, Oct 27, 2016 at 04:46:01PM -0700, Roderick Colenbrander wrote:
> On Thu, Oct 27, 2016 at 4:19 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Thu, Oct 27, 2016 at 02:31:13PM -0700, Roderick Colenbrander wrote:
> >> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> >>
> >> The input-mt driver pointer emulation from 'input_mt_sync_frame' regardless
> >> of the flags passed in to 'input_mt_init_slots' by device drivers.
> >
> > Right, because needing single-touch (pointer) emulation is not property
> > of device or driver but rather consumer. If we get to the point where
> > everything is ready to accept multi-touch (are we there yet) then we can
> > stop doing pointer emulation altogether.
> >
> >>
> >> Pointer emulation is undesired on drivers, which didn't request this
> >> capability like the hid-sony driver for the Dualshock 4. This gamepad already
> >> reports ABS_X / ABS_Y for gamepad stick purposes. Pointer emulation would
> >> inject touchpad values into these sticks, which is undesired.
> >
> > The driver should not be re-purposing events like that.
> > ABS_MT_POSITION_X and ABS_X should match.
> >
> > Why doesn't driver follow Documentation/input/gamepad.txt?
> >
> 
> The original hid-sony code and the multitouch handling code for the Dualshock 4
> were written by the community. We are stepping in to make the hid-sony driver
> properly handle the Dualshock 4.
> The driver doesn't fully follow the gamepad spec yet, which we will
> try to improve. At
> least the left analog stick is reported as ABS_X and ABS_Y already,
> but the buttons
> are inconsistent and right stick is wrong as well.
> While it would be great to conform to the spec, the conflict with
> multitouch would still
> exist as the Dualshock 4 has both analog sticks and a multitouch touchpad.
> 
> Disabling the pointer emulation feature avoids the conflict. This
> issue was only exposed
> recently by adding of the input_mt_sync_frame call as recommended by Benjamin as
> part of some improvements we did for touchpad handling in hid-sony.

As I mentioned, ABS_MT_POSITION_X and ABS_X should represent the same
data, so the driver's use of them for different sub-devices is not
correct. Maybe the multitouch "touchpad" should be reported as
completely separate input device and userspace should "stitch" it back
into composite device.

In any case, as I mentioned above, the pointer emulation is requirement
of client and thus this patch is not appropriate.

Thanks.

-- 
Dmitry
