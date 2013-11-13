From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: input question: ambient light sensor button
Date: Wed, 13 Nov 2013 11:47:18 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311131146410.22940@pobox.suse.cz>
References: <201309151553.34000@pali>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46269 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751375Ab3KMKrW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Nov 2013 05:47:22 -0500
In-Reply-To: <201309151553.34000@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sun, 15 Sep 2013, Pali Roh=C3=A1r wrote:

> I do not know where to ask this question, but I think that kernel=20
> developers could help me.
>=20
> I have notebook with one special button on keyboard which is=20
> designed for turning ambient light sensor on and off. By default=20
> pressing button do nothing (I can turn ambient light sensor on/off=20
> via sysfs platform wmi module). Button press is reported by=20
> kernel input device AT Translated Set 2 keyboard and reports it=20
> as button "touchpad off".
>=20
> Of course "touchpad off" is incorrect and I'd like to ask which=20
> kernel key or button from /usr/include/linux/input.h should be=20
> mapped for my ambient light sensor button? Is there already some?=20
> And what is strategy for allocating KEY_* and BTN_* numbers?

This is maintained by Dmitry, so he's the one to answer this. I am addi=
ng=20
him to CC.

> I'd like to know this, so udev could have correct DMI keymap=20
> hooks and other userspace programs can understand ambient light=20
> sensor button correctly.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
