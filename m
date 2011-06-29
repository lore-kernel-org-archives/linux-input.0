From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [questions]touch driver.
Date: Wed, 29 Jun 2011 09:40:35 +0200
Message-ID: <BANLkTin+BwR7XBO3swqnsuxw_V2Nkz4GdA@mail.gmail.com>
References: <BANLkTinXNa9Uu+d1=pwH6aDJ-wtOVJ+jiQ@mail.gmail.com>
	<BANLkTinAHXnz98dJNQFeDSVRMR5U7WdKbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48511 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab1F2Hkg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 03:40:36 -0400
Received: by wwe5 with SMTP id 5so951414wwe.1
        for <linux-input@vger.kernel.org>; Wed, 29 Jun 2011 00:40:35 -0700 (PDT)
In-Reply-To: <BANLkTinAHXnz98dJNQFeDSVRMR5U7WdKbA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Austin Zhang <zhang.austin@gmail.com>, linux-input <linux-input@vger.kernel.org>

Hi Austin,

On Wed, Jun 29, 2011 at 05:08, Austin Zhang <zhang.austin@gmail.com> wrote:
> Ben, sorry if disturbing you, seemed people pay most
> efforts/attentions on patch rather than below simple question in ML,
> can you please shed some light on this. Thanks.

Sorry, I'm on holidays, and sometimes, I don't take the time to answer
to many messages....

>
>
> ---------- Forwarded message ----------
> From: Austin Zhang <zhang.austin@gmail.com>
> Date: 2011/6/23
> Subject: [questions]touch driver.
> To: linux-input@vger.kernel.org, Benjamin Tissoires
> <benjamin.tissoires@gmail.com>, Chase Douglas
> <chase.douglas@canonical.com>
>
>
> hi, team,
>
> I have several questions on touch driver.
>
> 1 For touch panel, if it is HID type panel, then for enabling
> autosuspend for this device, can we only let its parent device enable
> autosuspend as default, don't need do anything within that touch
> driver?

I don't really understand this point.
The hid multitouch panel sleep issue has been solved in
hid-multitouch. Normally there are no problems with suspend to ram (if
you mean that by autosuspend) except if the device need to be in a
special mode (as for most multitouch devices).
See the function mt_reset_resume in hid-multitouch.c

>
> 2 When setting fuzz parameter by input_set_abs_params, what is the
> typical rule/scenarios in general? For example, if one device which
> supports logical max sample in X/Y as 4096*3072 and the screen LCD
> resolution as 1024*768, then fuzz=100 is meaning that the driver will
> not report (by input_event) contact point within 50 sample point
> (fuzz/2) to userspace? And if in this case, the high level gesture
> recognizer is setting Manhattan length as 60, does it means it is ok
> if the Manhattan length of contact point coordinator from driver is
> less than 240? (60*4)

Personally, I don't care with fuzz. My idea of the kernel is that it
needs to send data from the device with less transformations (or we
won't be able to use it in user space).
You should ask Henrik Rydberg on fuzz as he is the one to introduce it
in hid-multitouch.

There is also a problem with your explanation: fuzz should not be
related to screen resolution as in the kernel we are not aware of the
screen resolution and the mapping.
I think, and it's my own opinion that fuzz should be used when the
device is not stable, i.e. when it has a range of 4096 for instance
and the values are floating in a range of 10 for instance.

Then, on some integrated platforms (tablets, and others) fuzz can be
used to not awake too much the different processes that rely on input.
But I would say this is a side effect of the original goal (again,
it's my only guess).

>
> 3 Seemed few drivers (only egalax and intel-mid-touch) are using this
> fuzz param, so in most cases, it is one in-case params to leave to
> user for 'tuning' only? Then should it be exported as module
> parameter?

With the current implementation, I don't think so. If you want to
submit a patch, I won't vote against. Dimitry and Jiri may have a
different view on this.

Cheers,
Benjamin

>
> Thanks for your answer in advance.
>
