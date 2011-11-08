From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH v2] synaptics: add support for Relative mode
Date: Tue, 8 Nov 2011 12:36:46 -0600
Message-ID: <CAMLZHHSKXvcC6NasLS9wcRfoD3v4KdE486_fRGgEHBKq+PiZRg@mail.gmail.com>
References: <20111027164420.91B1A9D401E@zog.reactivated.net>
	<20111108063445.GB1837@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55632 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290Ab1KHSh3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2011 13:37:29 -0500
Received: by ywf7 with SMTP id 7so855532ywf.19
        for <linux-input@vger.kernel.org>; Tue, 08 Nov 2011 10:37:28 -0800 (PST)
In-Reply-To: <20111108063445.GB1837@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pgf@laptop.org, djkurtz@google.com

On Tue, Nov 8, 2011 at 12:34 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>> @@ -968,11 +1030,29 @@ int synaptics_init(struct psmouse *psmouse)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 psmouse->rate =3D 40;
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 err =3D sysfs_create_file(&psmouse->ps2dev.serio->dev.kobj=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &psmouse_a=
ttr_synaptics_disable_gesture.dattr.attr);
>> + =A0 =A0 if (err) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&psmouse->ps2dev.serio->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Failed to create disable_=
gesture attribute (%d)", err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto init_fail;
>> + =A0 =A0 }
>
> This attribute does not make sense in absolute mode so we should only
> create it when relative mode is requested.

I think it could make some sense - to me it seems possible that there
would be a use case where absolute input is requested but the software
chooses to let the hardware do the gesture detection. But I don't know
of such a use case, and it isn't interesting for OLPC, so either way
is fine with me.

> Does the version of the patch below still work for you? Thanks!

Yes, it works fine. Thanks for touching it up.

Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
