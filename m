From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [PATCH v2] synaptics: add support for Relative mode
Date: Tue, 8 Nov 2011 12:41:21 -0800
Message-ID: <4EB993F1.7050905@synaptics.com>
References: <20111027164420.91B1A9D401E@zog.reactivated.net>	<20111108063445.GB1837@core.coreip.homeip.net> <CAMLZHHSKXvcC6NasLS9wcRfoD3v4KdE486_fRGgEHBKq+PiZRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx3.synaptics.com ([12.239.217.85]:1344 "EHLO
	us-mx3.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386Ab1KHUuw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2011 15:50:52 -0500
In-Reply-To: <CAMLZHHSKXvcC6NasLS9wcRfoD3v4KdE486_fRGgEHBKq+PiZRg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, pgf@laptop.org, djkurtz@google.com

On 11/08/2011 10:36 AM, Daniel Drake wrote:
> On Tue, Nov 8, 2011 at 12:34 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com>  wrote:
>>> >>  @@ -968,11 +1030,29 @@ int synaptics_init(struct psmouse *psmouse)
>>> >>                 psmouse->rate = 40;
>>> >>         }
>>> >>
>>> >>  +     err = sysfs_create_file(&psmouse->ps2dev.serio->dev.kobj,
>>> >>  +&psmouse_attr_synaptics_disable_gesture.dattr.attr);
>>> >>  +     if (err) {
>>> >>  +             dev_err(&psmouse->ps2dev.serio->dev,
>>> >>  +                     "Failed to create disable_gesture attribute (%d)", err);
>>> >>  +             goto init_fail;
>>> >>  +     }
>> >
>> >  This attribute does not make sense in absolute mode so we should only
>> >  create it when relative mode is requested.
> I think it could make some sense - to me it seems possible that there
> would be a use case where absolute input is requested but the software
> chooses to let the hardware do the gesture detection. But I don't know
> of such a use case, and it isn't interesting for OLPC, so either way
> is fine with me.

I agree with Daniel's statement.

						Chris
