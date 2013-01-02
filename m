From: "Przemo Firszt" <przemo@firszt.eu>
Subject: Re: HID battery strength does not emit power_suppy udev events
Date: Wed, 2 Jan 2013 15:04:43 -0000
Message-ID: <9b7bd03f727fb619965e081b2fb61727.squirrel@webmail.firszt.eu>
References: <CACo8zOe7MFp_O_2rQhkSPc_+LaSUBxHvsQwSY38ukKRioDHusA@mail.gmail.com>
    <CAD2FfiEbqUvfuUYpgQFaXoUBAn_7TnV4FnGXNDeD-jHCCfpGVQ@mail.gmail.com>
    <CACo8zOeSf_0ump=ChJKvgLQL1_OVoOE5Ts0ybw=5S3ZFMzZcGw@mail.gmail.com>
    <CACo8zOc5QkhotrEPdeK23rfkjPeOa5PgXpXjBUeFPrPWbTAJ1w@mail.gmail.com>
    <1357069586.8915.11.camel@localhost>
    <CACo8zOf9LdPA_OZSLZp3iQj80+DvVvQh_Wc6Or902SSJ2hMWVg@mail.gmail.com>
Reply-To: przemo@firszt.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wren.arvixe.com ([50.97.138.99]:53372 "EHLO wren.arvixe.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894Ab3ABPEr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Jan 2013 10:04:47 -0500
In-Reply-To: <CACo8zOf9LdPA_OZSLZp3iQj80+DvVvQh_Wc6Or902SSJ2hMWVg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Nicoletti <dantti12@gmail.com>
Cc: Przemo Firszt <przemo@firszt.eu>, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jeremy Fitzhardinge <jeremy@goop.org>


Dnia 1 Stycznia 2013, 8:39 pm, Wt, Daniel Nicoletti napisa=B3(a):
> Well from your logs you can see the udev emitted an 'add ' for
> wacom_battery, the odd part is that it sends several add for the batt=
ery.

It's KERNEL and UDEV, so i think it's OK - no duplicates.

> Wacom tablets have a different code from handling the battery, i wrot=
e the
> code that'sgeneric for hid devices, and the battery part looks like a=
 lot
> when looking to tje wacom one but it doesn't emits 'add ' or 'del '
> events...
> I'm not kernel dev and after reading docs and digging some code I 'm =
still
> clueless about it...
>
You might add a few "printk" in hidinput_setup_battery (in kernel
drivers/hid/hid-input.c) to see if everything goes OK.

What's your device?
--=20
Regards,
Przemo Firszt

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
