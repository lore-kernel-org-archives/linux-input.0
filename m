From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Wed, 2 Nov 2011 11:12:38 +0100
Message-ID: <20111102101238.GA2249@polaris.bitmath.org>
References: <CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com>
 <4EA9466F.4000508@gmail.com>
 <20111028111605.GA23693@polaris.bitmath.org>
 <CAN+gG=EiJJR464q_eoJuJYpWOPMsk61W6sAKD18SdT+2tQfmQA@mail.gmail.com>
 <20111028140033.GA2155@polaris.bitmath.org>
 <alpine.LNX.2.00.1110281913010.3541@pobox.suse.cz>
 <20111101141704.GA2135@polaris.bitmath.org>
 <alpine.LNX.2.00.1111011526350.348@pobox.suse.cz>
 <20111101153348.GB2191@polaris.bitmath.org>
 <CAN+gG=FOJv=J9=DF4HKsZT5HcLBkBM4rAWE7peOGLo4XZJ4GNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:58398 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab1KBKDS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Nov 2011 06:03:18 -0400
Received: from iph5.telenor.se (iph5.telenor.se [195.54.127.136])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 082CCCBEB
	for <linux-input@vger.kernel.org>; Wed,  2 Nov 2011 11:03:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAN+gG=FOJv=J9=DF4HKsZT5HcLBkBM4rAWE7peOGLo4XZJ4GNg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Sean Young <sean@mess.org>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>

Hi Benjamin,

> > Everyone with an umatched hid device, even completely unrelated to
> > touch, will be surprised to find the hid-multitouch module loaded.
> >
> 
> Well, this is a problem that can not be easily solved: IIRC, we can
> not force the load of an external driver from within the kernel.
> The best solution would be to merge hid-input and hid-multitouch.

Yes, or actually adding a dynamic mechanism.  With hid, it would
clearly be beneficial to be able to load modules based on the result
of the report parsing.

> Indeed both systems aim at handling generic devices.However, I'd
> rather not doing it now as we are not as "good" as the Win 7 driver
> (i.e. there are some fallback modes that allow every devices to be
> handled even if they don't send clean hid reports).

What's wrong with having a generic handling in addition to the
specific device list in hid-multitouch?

> And, even if hid-multitouch is loaded, only 2 or 3 lines of codes will
> be executed to reject the driver in mt_probe, which won't be very time
> consuming for end user.

The time to load the module will hit _every_ user, which is worse than
having the code merged with hid-input. Not to mention the annoyance,
it is simply unacceptable.

> For your second point:
> >> > 2. It did not work after removing the tested device from the hid core
> >> > whitelist; the device quirk seemed to get lost in the process.
> 
> Didn't you forget to remove the following line?
> 
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1230,7 +1230,6 @@ int hid_connect(struct hid_device *hdev,
> unsigned int connect_mask)
>                hdev->claimed |= HID_CLAIMED_INPUT;
>        if (hdev->quirks & HID_QUIRK_MULTITOUCH) {
>                /* this device should be handled by hid-multitouch, skip it */
> -               hdev->quirks &= ~HID_QUIRK_MULTITOUCH;
>                return -ENODEV;
>        }
> 
>

Gah, how did that end up there? Yes, I missed that line in my testing,
which explains it (although I won't test again right now).

> If not, that's maybe that you encountered the only case that is not
> correctly handled:
> if you register hid-multitouch before hid, then it will be the first
> driver tested, and hid-input won't set the quirk correctly.
> BTW, it's not a big deal, because if systems do have this behavior, we
> can easily put the device from the user space by using
> /sys/module/hid_multitouch/drivers/hid\:hid-multitouch/new_id

This is also hackish. I _do_ understand the benefits of what we are
aiming at here, but we are piling up crap in the kernel.

To summarize, the idea looked good at first glance, but I think it
creates unacceptable dependencies between modules.

To try again later on, at the very least one should move the essence
of hid-multitouch to something like hid-input-mt, and have hid-input
either include it, select it or depend dynamically on it, in a
try_module_get fashion. The hid_multitouch would then simply contain
the device white list, leaving the general case to hid-input.

Henrik
