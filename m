From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 1/1] input: add driver for Bosch Sensortec's BMA150
 accelerometer
Date: Sun, 7 Aug 2011 22:15:04 -0700
Message-ID: <20110808051504.GA7329@core.coreip.homeip.net>
References: <1311800027-25982-1-git-send-email-eric.andersson@unixphere.com>
 <1311800027-25982-2-git-send-email-eric.andersson@unixphere.com>
 <20110730191726.GG5686@core.coreip.homeip.net>
 <20110730224917.GA8519@skinner.xfiles.lan>
 <20110731070844.GA23383@core.coreip.homeip.net>
 <CAH+e7S2LU7zr6fcp+f+2UuzyXX_=icBa4OtO7m1YQQ2BtOyMAQ@mail.gmail.com>
 <20110807162325.GA7280@skinner.xfiles.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:52477 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab1HHFPM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Aug 2011 01:15:12 -0400
Content-Disposition: inline
In-Reply-To: <20110807162325.GA7280@skinner.xfiles.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Andersson <eric.andersson@unixphere.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zhengguang.guo@bosch-sensortec.com, stefan.nilsson@unixphere.com, alan@lxorguk.ukuu.org.uk, jic23@cam.ac.uk, xu.zhang@bosch-sensortec.com

On Sun, Aug 07, 2011 at 06:23:25PM +0200, Eric Andersson wrote:
> > On Sun, Jul 31, 2011 at 12:49:17AM +0200, Dmitry Torokhov wrote:
> > > > > +static int bma150_open(struct bma150_data *bma150)
> > > > > +{
> > > > > + int ret;
> > > > > +
> > > > > + ret =3D pm_runtime_set_active(&bma150->client->dev);
> > > > > + if (ret < 0)
> > > > > + =A0 =A0 =A0 =A0 return ret;
> > > > > +
> > > > > + pm_runtime_enable(&bma150->client->dev);
> > > >
> > > > I am pretty sure you want to call pm_runtime_enable() in bma150=
_probe()
> > > > so that parent controller can be suspended until somebody calls
> > > > bma150_open() and we mark the device as active (which, in turn,=
 should
> > > > wake up its parent).
> > >
> > > If I call pm_runtime_enable() I cannot use pm_runtime_set_active(=
) later
> > > according to the comment in __pm_runtime_set_status (runtime.c):
> > > "If runtime PM of the device is disabled or its power.runtime_err=
or
> > > field is different from zero, the status may be changed either to
> > > RPM_ACTIVE, or to RPM_SUSPENDED..."
> > >
> > > If the PM of the device is enabled it will return -EAGAIN. Of cou=
rse, we
> > > could enable() in probe, then disable(); set_active(); enable(); =
in
> > > open, but that seems a bit confused, right?
> >=20
> > Hmm, indeed. I do not like the idea about disable/set_active/enable=
 so I
> > guess we'll have to keep track of the current mode themselves and c=
all
> > bma150_set_mode() ourselves if, after calling pm_runtime_get/put_sy=
nc()
> > we find that our mode is different from what we expect it to be.
> >=20
> > I also noticed that you did not properly free IRQ on device removal=
 and
> > also polled devices need to be freed always (unlike regular input
> > devices that should be only unregistered). The default_cfg can't be
> > __initdata because it is used by __devinit functions. And my versio=
n of
> > GCC can't figure out that ipoll_dev never used uninitialized and gi=
ves
> > false warning.
> >=20
> > I tried correcting these issues in the patch below, along with rena=
ming
> > 'ret' to 'error' which I prefer when we dealing with error handling=
=2E
> > Could you please git it a try and if everything still works I'll fo=
ld it
> > and commit.
>=20
> Thanks Dmitry! I tried your patch and it worked like a charm!

Excellent, thanks for testing.

>=20
> Do you take it from here or would you like me to send an updated
> version that includes your patch?

No, there is no need for that. I'll fold them all together and queue fo=
r
2.6.32.

I take the other patch that makes polled devices do poll upon opening
working well for you too.. Should I queue for .2 as well?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
