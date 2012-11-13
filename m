From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 11/13] HID: hid-multitouch: support for hovering
 devices
Date: Tue, 13 Nov 2012 19:04:53 +0100
Message-ID: <20121113180453.GA3622@polaris.bitmath.org>
References: <1352306256-12180-1-git-send-email-benjamin.tissoires@gmail.com>
 <1352306256-12180-12-git-send-email-benjamin.tissoires@gmail.com>
 <20121113164239.GA712@polaris.bitmath.org>
 <CAN+gG=EbAdfOG_vwt2uamV+JcAKLFqM=zTo9oRQ9RLayrpdsoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAN+gG=EbAdfOG_vwt2uamV+JcAKLFqM=zTo9oRQ9RLayrpdsoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

> > Why [-1,1] here?
> 
> At first, I only used [0,1]. However, it's still the same problem with
> the information being kept between the touches:
> if you start an application after having touched your device, you
> normally have to ask for the different per-touche states to get x, y,
> distance, pressure, etc...
> However, this is not much mandatory because the protocol in its
> current form ensures that you will get the new states of the axes when
> a new touch occurs.

Right, the stateful communication requires a full state read after
opening the deivce, although in most cases this is not really
necessary. This is no different for ABS_MT_DISTANCE, of course.

> ABS_MT_DISTANCE is a little bit different here because the protocol
> guarantees that once you get the "not in range" state through
> tracking_id == -1, distance should be 1.
> When the new touch of the very same slot occurs, you also have the
> guarantee that distance is at 1 too.

ABS_MT_DISTANCE is just another attribute of the slot, so it really is
no different.

> So basically, if you don't ask for the slot states, you will never get
> that very first distance.

Which will not be important either; as long as the slot is unused, it
does not matter what the attributes of that slot are.

> I know that it's a user-space problem, but honestly, I don't want to
> fix several user-space problems when we could fix it through the
> protocol.
> 
> I can see 2 solutions:
> - set the range to: [0,1] and still sending -1 (or 2) for the invalid
> distance value (if it's not clamped)
> - set the range to: [0,2] and having: 0 for touch, 1 for hovering, and
> 2 for not in range
> 
> Does that make sense?

I just do not see what problem you want to solve here.

Thanks,
Henrik
