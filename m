From: =?iso-8859-1?Q?Nicolas_L=E9veill=E9?= <knos@free.fr>
Subject: Re: [PATCH 1/3] (uu.6cd36bd9ef57) joystick/xpad.c -- Support HORI RAP.EX/MadCatz Fightpad
Date: Thu, 26 Nov 2009 11:27:58 +0100
Message-ID: <75261F2D-4244-4587-9B17-98322189DDCD@free.fr>
References: <4B08FC8A.6030404@free.fr> <20091126060443.GJ23244@core.coreip.homeip.net>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:46266 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754795AbZKZK2B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2009 05:28:01 -0500
In-Reply-To: <20091126060443.GJ23244@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi, thanks for the feedback.

I'll soon resend the first two patches as properly formatted ones. (git=
 format-patch this time)

About the third one adding a "trigger_mapping" option:

When reusing the dpad_mapping field to add new options to it are you th=
inking about turning it into a numerical constant that goes 0-1-2-3  fo=
r all mapping combinations?=20

It does not needlessly break user space's configuration scripts, howeve=
r the name and semantics of the option are more complicated.

In particular the semantics of the existing dpad_mapping option is a bi=
t strange already, since it only act on "unknown" devices / do not act =
on known devices.=20

Which I'm not sure works anyway? My devices only started to work when I=
 registered their vendor and product id.=20

Why not allow overriding mappings of a known device?

Cheers,
Nicolas

On 2009-11-26, at 07:04 , Dmitry Torokhov wrote:

> Hi Nicolas,
>=20
> On Sun, Nov 22, 2009 at 09:55:38AM +0100, Nicolas L=E9veill=E9 wrote:
>> Part one of three patches against latest head of
>> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>>=20
>=20
> It looks like your mailer wrapped the mails so the patches won't appl=
y.
> Please resend. Also, instead of creating a new field maybe chnage
> dpad_mapping to be a bitmap of options?
>=20
> Thanks.
>=20
> --=20
> Dmitry
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
