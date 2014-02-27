From: shawn wilson <ag4ve.us@gmail.com>
Subject: Re: Unknown ALPS device
Date: Thu, 27 Feb 2014 11:28:10 -0500
Message-ID: <CAH_OBieFt+WDfm9SyHxF=upfL4jTv0vZMpfQB6OgxYo9OHdpxg@mail.gmail.com>
References: <20140227164625.5e8da800@hboeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:49869 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbaB0Q2b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Feb 2014 11:28:31 -0500
Received: by mail-ve0-f181.google.com with SMTP id jw12so4024487veb.26
        for <linux-input@vger.kernel.org>; Thu, 27 Feb 2014 08:28:30 -0800 (PST)
In-Reply-To: <20140227164625.5e8da800@hboeck.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Hanno_B=C3=B6ck?= <hanno@hboeck.de>
Cc: linux-input@vger.kernel.org

What kernel are you running? My ALPS device is identified correctly
and seems to work on 3.13 (IIRC, it also worked with 3.12 but not
before).

There's also this (I didn't write it, just modified it to work with
lesser kernel versions - linking to this version because i know where
it is off hand):
https://github.com/ag4ve/psmouse-alps

On Thu, Feb 27, 2014 at 10:46 AM, Hanno B=C3=B6ck <hanno@hboeck.de> wro=
te:
> Hi,
>
> I have an IBM Thinkpad T61 laptop and dmesg shows me this:
> psmouse serio2: alps: Unknown ALPS touchpad: E7=3D10 00 64, EC=3D10 0=
0 64
>
> Now the touchpad works, but this message sounds like it'd make sense =
to
> add it to the table in alps.c (?).
>
> I'd gladly assist if this would improve anything.
>
> cu,
> --
> Hanno B=C3=B6ck
> http://hboeck.de/
>
> mail/jabber: hanno@hboeck.de
> GPG: BBB51E42
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
