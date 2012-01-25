From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC] Microsoft Touch Mouse driver [was: Re: your mail]
Date: Wed, 25 Jan 2012 16:00:35 +0100
Message-ID: <20120125150035.GA4222@polaris.bitmath.org>
References: <BROWNM3h3vLgAusVxON00000cfa@brown.emailprod.vodafone.se>
 <20120125132612.GA3890@polaris.bitmath.org>
 <4F200D14.80702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:40669 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648Ab2AYPAg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jan 2012 10:00:36 -0500
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 3942BEBC24
	for <linux-input@vger.kernel.org>; Wed, 25 Jan 2012 16:00:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F200D14.80702@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

> In my first tests, I was doing readouts in userspace using hidraw,
> which performed quite well.
> 
> Bandwidth could be an issue, but I'd like to use the current APIs as
> much as possible so I don't need to go modifying mtdev, X, ...

Unless you do clustering, filtering and what not in-kernel, something
will have to change for sure.

> >One possible option could be to use the
> >slots, but only send ABS_MT_TOUCH_MAJOR or ABS_MT_PRESSURE, nothing
> >else. The device would (rightfully) not be recognized as MT since the
> >position is missing, all data would be available for processing in
> >userspace, and bandwidth would be minimized since there could only be
> >so many changes coming in per millisecond.
> 
> So how does userspace then finds out where these pressure points are
> located?
> Or do you mean to just dump all data to user space (15 * 13 *
> sizeof(ABS_MT_PRESSURE value) + overhead)?

Having each pressure point represented by one slot id was the idea.
Userspace would have to know how the points are mapped, of
course. Still not overly happy about the general fit, though. Dmitry?

> >>+	/* HACK: get rid of ABS_MT_* params */
> >>+	if ((usage->hid&  HID_USAGE_PAGE) == HID_UP_GENDESK)
> >>+		return -1;
> >I am not sure about the hack here, nor its explanation. ;-)
> 
> The HID tables specify some ABS_MT_* values and I didn't know
> whether these were going to conflict with the ones I report above,
> so I just discard all GenericDesktop fields.
> 
> root@hp4530s:~# grep MT /sys/kernel/debug/hid/0003\:045E\:0773.0006/rdesc
> GenericDesktop.MultiAxis ---> Absolute.MTMajor
> GenericDesktop.0009 ---> Absolute.MTMinor
> GenericDesktop.000a ---> Absolute.MTMajorW
> GenericDesktop.000b ---> Absolute.MTMinorW
> GenericDesktop.000c ---> Absolute.MTOrientation
> GenericDesktop.000d ---> Absolute.MTPositionX
> GenericDesktop.000e ---> Absolute.MTPositionY
> GenericDesktop.000f ---> Absolute.MTToolType
> GenericDesktop.0010 ---> Absolute.MTBlobID

Right, they would conflict. You can also use the input_mapped() hook.

Thanks,
Henrik
