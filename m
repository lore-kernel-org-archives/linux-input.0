From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input question: ambient light sensor button
Date: Wed, 13 Nov 2013 08:28:40 -0800
Message-ID: <20131113162840.GB11657@core.coreip.homeip.net>
References: <201309151553.34000@pali>
 <alpine.LNX.2.00.1311131146410.22940@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:45712 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754138Ab3KMQ2o (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Nov 2013 11:28:44 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1311131146410.22940@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Nov 13, 2013 at 11:47:18AM +0100, Jiri Kosina wrote:
> On Sun, 15 Sep 2013, Pali Roh=E1r wrote:
>=20
> > I do not know where to ask this question, but I think that kernel=20
> > developers could help me.
> >=20
> > I have notebook with one special button on keyboard which is=20
> > designed for turning ambient light sensor on and off. By default=20
> > pressing button do nothing (I can turn ambient light sensor on/off=20
> > via sysfs platform wmi module). Button press is reported by=20
> > kernel input device AT Translated Set 2 keyboard and reports it=20
> > as button "touchpad off".
> >=20
> > Of course "touchpad off" is incorrect and I'd like to ask which=20
> > kernel key or button from /usr/include/linux/input.h should be=20
> > mapped for my ambient light sensor button? Is there already some?=20
> > And what is strategy for allocating KEY_* and BTN_* numbers?
>=20
> This is maintained by Dmitry, so he's the one to answer this. I am ad=
ding=20
> him to CC.

I guess we need patch adding

	#define KEY_ALS_TOGGLE	0x230

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
