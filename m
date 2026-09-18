Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8E4973B9;
	Fri, 18 Sep 2026 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748319; cv=none; b=OQdmvpM96XOh09DcBBSL3SodenFZbxme2IZMrrscOB6UIp50DFLCjCK2QiUlMEcNgTqFq8nXHi4EoKBybsuk15QnHrudu4odOCtRPmIt+lcdnkbP33hoYjwAExE8LwGljzXCu/vFMp4Z2LHi61Bzx63Vyn6eZkGbMkuV2NkeE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748319; c=relaxed/simple;
	bh=a5xY3F5hJTZZ2dhneKi/TS8TliENLtPR+poXokB0mFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIbxfIJaWioG+hF/Xav27TEcI8mBVSHcSzZAfPUqACxI29WrJaPnAm5ddXEzPHJ4vp6E9CBRHLjOGjDmgj0B9TWo6qPUfdrr7rOKkrpOwl5a8+TQEX0rkagpI+KO3+9xhvdde3k2aSBO3wnzMEbAGHnvSqwtXyXEY8f8LjAUxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCjvW0JL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCjvW0JL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0861F000FF;
	Fri, 18 Sep 2026 16:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789748317;
	bh=AtP45Vc9PjcrbxAfypTuhGfztdb/0M88gKRbEhBnpgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lCjvW0JLwlPE9FJ9dsR0IX1u95tD5JK6GbFzV0Qh1Ed6WL48Atvk2tVsXSv+ynpkJ
	 jnfLtToWyHtwZea/NQfb0UzJl1diPp4/pa1Krtm5+TSmHFyf6c8rCJgPt5ZC2I2M3v
	 wRzrkorxyaCDuspkkGp0tTwrY0H/ASSAb6lDXcjnq1MGQcqJD1+NwWrkXiAvbCt1pq
	 Gs9vsvGXFpJwenRXGfth4C6HIFrMGnET7QUxwHhDQxGkfRlDyrjrvX2xJnMqDIyCK4
	 HBPkBoOWV1mAcL1xn5iwNbnicF0Ob5NsC5SQQPm+4l/qq/BNgXSCZVAG4og1f7GqJT
	 k6IOAQERUfd2w==
Date: Fri, 18 Sep 2026 18:18:32 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Ruzal <daminovruzal7@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] HID: multitouch: add support for Goodix GXTP7863
 touchpad
Message-ID: <aqwUYWPz_nORoFr6@beelink>
References: <20260814171247.16707-1-daminovruzal7@gmail.com>
 <20260819123326.3242-1-daminovruzal7@gmail.com>
 <aquWNXpJuQr8HLBU@beelink>
 <51055e02-5bf1-4b1e-b430-382d00d3d004@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51055e02-5bf1-4b1e-b430-382d00d3d004@gmail.com>

On Sep 17 2026, Ruzal wrote:
> On 9/17/26 10:30 AM, Benjamin Tissoires wrote:
> > Hi,
> > 
> > sorry it looks like this one fell through the cracks.
> > 
> > On Aug 19 2026, Ruzal Daminov wrote:
> >> The Goodix GXTP7863 touchpad controller (VID: 0x27c6, PID: 0x01e0)
> >> found on Honor MagicBook laptops (e.g. FMI-76 / X14 Plus)
> >> was missing from the mt_devices[] table.
> >>
[...]
> >>  
> >> +	/* Goodix GXTP7863 Touchpad */
> >> +	{ .driver_data = MT_CLS_WIN_8,
> >> +	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
> > 
> > I'm puzzled here: HID_GROUP_ANY? How can this even be working with hid-multitouch?
> > 
> > Are you sure the touchpad part is not already handled by hid-multitouch, but only
> > the telemetry/phantom event gets assigned to hid-generic?
> > 
> > Can you share the report descriptors of all nodes with hid-recorder so I
> > can understand why we suddenly have to map to non multitouch devices.
> > 
> > Cheers,
> > Benjamin
> 
> Hi Benjamin,
> 
> Thanks for pointing that out. You were completely right, and I apologize
> for the inaccurate explanation in my previous commit messages.

no need to apologize, we can make mistakes, and that's our job as
maintainers to catch them :)

> 
> I re-checked the device binding: the touchpad is indeed claimed by
> hid-multitouch out of the box under HID_GROUP_MULTITOUCH_WIN_8 (using
> MT_CLS_WIN_8). It was never claimed by hid-generic.

Well, I guess it was the first time you started the laptop, until
hid-multitouch gets loaded.

> 
> The actual root cause is that MT_CLS_WIN_8 sets `.export_all_inputs = true`.
> Because of this, hid-multitouch exports the vendor application collection
> (Usage Page 0xFF01, Usage 0x01, Report ID 8) to an input node.

Actually, it's even worse than that.

Because some vendors are not using standard HID usages, we do have a
`HID_UP_HPVENDOR2` definition of (Usage Page 0xFF01). And hid-input.c
considers that this is only used by HP laptops/keyboards, and then we
have some fancy mapping of non standard usages.

The real fix would be to actually ensure this mapping is only triggered
for:
- keyboards
- HP platforms

But, there is always a but, `HID_UP_HPVENDOR` was there since the origin
of time (git conversion IIRC), and `HID_UP_HPVENDOR2` appeared in 2012.

We do have some info on the affected devices (VID/PID) but nothing else
like the report descriptor. So it's the typical case of "damn, we can't
fix this without possibly regressing a lot of existing hardware".

> 
> As captured in the hid-recorder trace below, the firmware sends a 1-Hz
> heartbeat packet on Report ID 8:
>   E: 000000.000000 30 08 ab 00 00 2a ...
>   E: 000001.006503 30 08 ab 00 00 2a ...
>   E: 000002.012748 30 08 ab 00 00 2a ...
> 
> hid-input interprets these changing payload bytes as key events, resulting
> in the endless KEY_BRIGHTNESSUP autorepeat loop.
> 
> So, adding the device entry with HID_GROUP_ANY to mt_devices[] is indeed
> completely redundant. The only thing needed is to ignore the 0xFF01 vendor
> collection so that no phantom input node is created for it.
> 
> Here is the report descriptor and event recording from hid-recorder:
> 
> # GXTP7863:00 27C6:01E0
> # 0x05, 0x01,                    // Usage Page (Generic Desktop)        0
> # 0x09, 0x02,                    // Usage (Mouse)                       2
[...]
> # 0xc0,                          // End Collection                      624
> # 0x06, 0x01, 0xff,              // Usage Page (Vendor Usage Page 0xff01) 625
> # 0x09, 0x01,                    // Usage (Vendor Usage 0x01)           628
> # 0xa1, 0x01,                    // Collection (Application)            630
> # 0x85, 0x08,                    //  Report ID (8)                      632
> # 0x09, 0x01,                    //  Usage (Vendor Usage 0x01)          634
> # 0x19, 0x00,                    //  Usage Minimum (0)                  636
> # 0x29, 0xff,                    //  Usage Maximum (255)                638
> # 0x15, 0x00,                    //  Logical Minimum (0)                640
> # 0x25, 0xff,                    //  Logical Maximum (255)              642
> # 0x95, 0x40,                    //  Report Count (64)                  644
> # 0x75, 0x08,                    //  Report Size (8)                    646
> # 0x91, 0x02,                    //  Output (Data,Var,Abs)              648
> # 0x09, 0x01,                    //  Usage (Vendor Usage 0x01)          650
> # 0x19, 0x00,                    //  Usage Minimum (0)                  652

Technically, we could simply convert these 0x01 and 0x00 into 0x05 and
this would make the mapping ignored by hid-input.c

However, when changing those bytes in the hid-recorder output and
replaying the device this creates a 10 seconds freeze on my desktop
because some component is not happy about the empty input node it creates.

I'm trying to investigate what is going on, without much success. I'll
continue working on it on Monday.

> # 0x29, 0xff,                    //  Usage Maximum (255)                654
> # 0x15, 0x00,                    //  Logical Minimum (0)                656
> # 0x25, 0xff,                    //  Logical Maximum (255)              658
> # 0x95, 0x1d,                    //  Report Count (29)                  660
> # 0x81, 0x02,                    //  Input (Data,Var,Abs)               662
> # 0xc0,                          // End Collection                      664
[...]
> 
> Would you prefer handling this by simply dropping the 0xff010001 collection
> in mt_input_mapping() in hid-multitouch, or should this device quirk be
> implemented via HID-BPF instead?

So:
- mt_input_mapping() in hid-multitouch -> probably not. Having such
  quirk in the hid-multitouch code would be better handled with a proper
  quirk, not a random check in mt_input_mapping().
- HID-BPF: so far, if it weren't for that 10s freeze, I would have said
  yes, go for it. But right now there is something fishy in the code
  that creates empty input devices that are not properly cleaned up by
  hid-input and that messes up userspace.
 
Ideally we should fix the generic mapping, but that has a strong chance
of regressing existing HW, which is a PITA.

And to add to the bucket, when replaying your device, I see that fwupd
is trying to communicate with the device, so we should be sure to not
break this as well :(

Hopefully I'll have a better understanding next week.

Cheers,
Benjamin
