From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3 v2] input - wacom_w8001: Add one finger touch support
Date: Sun, 2 Jan 2011 00:59:26 -0800
Message-ID: <20110102085926.GG5429@core.coreip.homeip.net>
References: <1292607474-22674-1-git-send-email-pinglinux@gmail.com>
 <20101229074058.GA13061@core.coreip.homeip.net>
 <20101229074220.GB13061@core.coreip.homeip.net>
 <AANLkTi=C1np-r2jxgFPwwgm2LOs6Yb-aKMK1MwUMGJdU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:47298 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004Ab1ABI7c (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Jan 2011 03:59:32 -0500
Received: by pxi15 with SMTP id 15so2335248pxi.19
        for <linux-input@vger.kernel.org>; Sun, 02 Jan 2011 00:59:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=C1np-r2jxgFPwwgm2LOs6Yb-aKMK1MwUMGJdU@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Dec 29, 2010 at 02:54:14PM -0800, Ping Cheng wrote:
> On Tue, Dec 28, 2010 at 11:42 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Tue, Dec 28, 2010 at 11:40:58PM -0800, Dmitry Torokhov wrote:
> >> Hi Ping,
> >>
> >> On Fri, Dec 17, 2010 at 09:37:54AM -0800, Ping Cheng wrote:
> >> > Signed-off-by: Ping Cheng <pingc@wacom.com>
> >> > ---
> >> > =A0drivers/input/touchscreen/wacom_w8001.c | =A0 89 ++++++++++++=
++++++++++++++++---
> >> > =A01 files changed, 82 insertions(+), 7 deletions(-)
> >> >
> >> > diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/i=
nput/touchscreen/wacom_w8001.c
> >> > index 59664a8..763eb8f 100644
> >> > --- a/drivers/input/touchscreen/wacom_w8001.c
> >> > +++ b/drivers/input/touchscreen/wacom_w8001.c
> >> > @@ -3,6 +3,7 @@
> >> > =A0 *
> >> > =A0 * Copyright (c) 2008 Jaya Kumar
> >> > =A0 * Copyright (c) 2010 Red Hat, Inc.
> >> > + * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
> >> > =A0 *
> >> > =A0 * This file is subject to the terms and conditions of the GN=
U General Public
> >> > =A0 * License. See the file COPYING in the main directory of thi=
s archive for
> >> > @@ -86,6 +87,12 @@ struct w8001 {
> >> > =A0 =A0 char phys[32];
> >> > =A0 =A0 int type;
> >> > =A0 =A0 unsigned int pktlen;
> >> > + =A0 bool pen_in_prox;
> >> > + =A0 bool has_touch;
> >>
> >> We already have type, why do we need these 2 fields a well?
> >>
> >> Actually, I tried massaging the patch a bit, could you please tell=
 me if
> >> the patch below still works for you?
> >>
> >> Thanks.
> >>
> >
> > And while we are at it could you please try this patch as well...
> >
> > Thank you!
> >
> > --
> > Dmitry
> >
> > Input: wacom_w8001 - add single-touch pointer emulation
> >
> > Let's emit single-touch compatible events for the 2-finger panels s=
o that
> > they can be used with legacy clients.
>=20
> Depending on which legacy clients we are talking about, this patch ma=
y
> introduce issue instead of support. We added
> mt_report_pointer_emulation for Bamboo since it is a touchpad, that
> can be driven by xf86-input-synaptics in relative mode. This device i=
s
> a touchscreen, that should be run in absolute mode. If we emulate ST
> events, which X driver do we expect it to use? xf86-input-wacom does
> not process emulated single touch data once we know MT is supported.
> That's why I didn't want to add ST emulation for this device.
>=20
> We expect clients that support this MT device will be in MT format
> since this driver is new and the clients have to run inputattach to
> enable the port before they can talk to the device. The client must
> have a reason to do so. Do you see any legacy clients would like to
> walk the extra mile to use this driver?
>=20

Anything that is using mousedev / PS/2 protocol can use this device if
we provide ST emulation. It won't be pretty but some level of
fucntionality will be available which is handy for bootsrapping.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
