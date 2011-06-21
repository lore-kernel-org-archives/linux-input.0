From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Tue, 21 Jun 2011 08:55:57 +0200
Message-ID: <20110621085557.78509a8f@archvile>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
	<1308042491-20203-4-git-send-email-david@protonic.nl>
	<20110616192732.GJ3795@ponder.secretlab.ca>
	<20110618101706.GB2401@core.coreip.homeip.net>
	<BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
	<ADE657CA350FB648AAC2C43247A983F001F38227BCFE@AUSP01VMBX24.collaborationhost.net>
	<BANLkTin1aZEm5EKHFi7kB4zK4mija9P=pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:18248 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab1FUGzz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2011 02:55:55 -0400
In-Reply-To: <BANLkTin1aZEm5EKHFi7kB4zK4mija9P=pw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: H Hartley Sweeten <hartleys@visionengravers.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Jander <david@protonic.nl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, 20 Jun 2011 12:20:30 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Mon, Jun 20, 2011 at 11:03 AM, H Hartley Sweeten
> <hartleys@visionengravers.com> wrote:
> > On Saturday, June 18, 2011 6:18 AM, Grant Likely wrote:
> >> On Sat, Jun 18, 2011 at 4:17 AM, Dmitry Torokhov wrote:
> >>> On Thu, Jun 16, 2011 at 01:27:32PM -0600, Grant Likely wrote:
> >>>> On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrote:
> >>>>> Use a threaded interrupt handler in order to permit the handler=
 to use
> >>>>> a GPIO driver that causes things like I2C transactions being do=
ne
> >>>>> inside the handler context.
> >>>>> Also, gpio_keys_init needs to be declared as a late_initcall, t=
o make
> >>>>> sure all needed GPIO drivers have been loaded if the drivers ar=
e built
> >>>>> into the kernel.
> >>>>
> >>>> ...which is a horrid hack, but until device dependencies can be
> >>>> described, it isn't one that can be solved easily.
> >>>>
> >>>
> >>> I really do not want to apply this... Currently the order of
> >>> initialization does not matter since nothing actually happens unt=
il
> >>> corresponding device appears on the bus. Does the OF code creates
> >>> devices before all resources are ready?
> >>
> >> It's not an OF problem. =C2=A0The problem is that all the platform=
_devices
> >> typically get registered all at once at machine_init time (on arm)=
,
> >> and if the gpio expander isn't a platform_device, (like an i2c gpi=
o
> >> expander which would end up being a child of a platform_device), t=
hen
> >> it won't be ready. =C2=A0The real problem is that we have no mecha=
nism for
> >> holding off or deferring a driver probe if it depends on an
> >> asynchronous resource.
> >
> > To avoid the registration order issue, isn't the proper fix to use =
a
> > "setup" method in the gpio expander driver? =C2=A0The gpio-pca953x.=
c driver has
> > this and I use it to hook the gpio_keys driver to those gpios. =C2=A0=
The
> > registration order ends up being:
> >
> > i2c-gpio as a platform_device in the machine init code
> > pca9539 as part of the i2c_board_info for the i2c-gpio device
> > gpio-keys as a platform_device via the .setup callback of pca9539
>=20
> Blech!  That approach fell out of the ugly tree and hit every branch
> on the way down!  Points for creativity though.  :-)  Essentially tha=
t
> ends up being a driver-specific notifier implementation.
>=20
> Yes, that works, but to me it just highlights a deficiency in the
> Linux device model.

Especially, how would I specify this setup handler in a device-tree? Th=
e DT
compiler still has no support for something like embedded DT-script ;-)
Still, an interesting (albeit smelly) idea I hadn't thought of before.

Best regards,

--=20
David Jander
Protonic Holland.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
