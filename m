From: Eric Andersson <eric.andersson@unixphere.com>
Subject: Re: [PATCH v6 1/1] input: add driver for Bosch Sensortec's BMA150
 accelerometer
Date: Mon, 8 Aug 2011 22:27:42 +0200
Message-ID: <20110808202742.GA8448@skinner.xfiles.lan>
References: <1311800027-25982-1-git-send-email-eric.andersson@unixphere.com>
 <1311800027-25982-2-git-send-email-eric.andersson@unixphere.com>
 <20110730191726.GG5686@core.coreip.homeip.net>
 <20110730224917.GA8519@skinner.xfiles.lan>
 <20110731070844.GA23383@core.coreip.homeip.net>
 <CAH+e7S2LU7zr6fcp+f+2UuzyXX_=icBa4OtO7m1YQQ2BtOyMAQ@mail.gmail.com>
 <20110807162325.GA7280@skinner.xfiles.lan>
 <20110808051504.GA7329@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp3.one.com ([91.198.169.23]:30339 "EHLO csmtp3.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923Ab1HHUXO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Aug 2011 16:23:14 -0400
Content-Disposition: inline
In-Reply-To: <20110808051504.GA7329@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, zhengguang.guo@bosch-sensortec.com, stefan.nilsson@unixphere.com, alan@lxorguk.ukuu.org.uk, jic23@cam.ac.uk, xu.zhang@bosch-sensortec.com

On 22:15 Sun 07 Aug     , Dmitry Torokhov wrote:
> On Sun, Aug 07, 2011 at 06:23:25PM +0200, Eric Andersson wrote:
> > > On Sun, Jul 31, 2011 at 12:49:17AM +0200, Dmitry Torokhov wrote:
> > > > > > +static int bma150_open(struct bma150_data *bma150)
> > > > > > +{
> > > > > > + int ret;
> > > > > > +
> > > > > > + ret =3D pm_runtime_set_active(&bma150->client->dev);
> > > > > > + if (ret < 0)
> > > > > > + =A0 =A0 =A0 =A0 return ret;
> > > > > > +
> > > > > > + pm_runtime_enable(&bma150->client->dev);
> > > > >
> > > > > I am pretty sure you want to call pm_runtime_enable() in bma1=
50_probe()
> > > > > so that parent controller can be suspended until somebody cal=
ls
> > > > > bma150_open() and we mark the device as active (which, in tur=
n, should
> > > > > wake up its parent).
> > > >
> > > > If I call pm_runtime_enable() I cannot use pm_runtime_set_activ=
e() later
> > > > according to the comment in __pm_runtime_set_status (runtime.c)=
:
> > > > "If runtime PM of the device is disabled or its power.runtime_e=
rror
> > > > field is different from zero, the status may be changed either =
to
> > > > RPM_ACTIVE, or to RPM_SUSPENDED..."
> > > >
> > > > If the PM of the device is enabled it will return -EAGAIN. Of c=
ourse, we
> > > > could enable() in probe, then disable(); set_active(); enable()=
; in
> > > > open, but that seems a bit confused, right?
> > >=20
> > > Hmm, indeed. I do not like the idea about disable/set_active/enab=
le so I
> > > guess we'll have to keep track of the current mode themselves and=
 call
> > > bma150_set_mode() ourselves if, after calling pm_runtime_get/put_=
sync()
> > > we find that our mode is different from what we expect it to be.
> > >=20
> > > I also noticed that you did not properly free IRQ on device remov=
al and
> > > also polled devices need to be freed always (unlike regular input
> > > devices that should be only unregistered). The default_cfg can't =
be
> > > __initdata because it is used by __devinit functions. And my vers=
ion of
> > > GCC can't figure out that ipoll_dev never used uninitialized and =
gives
> > > false warning.
> > >=20
> > > I tried correcting these issues in the patch below, along with re=
naming
> > > 'ret' to 'error' which I prefer when we dealing with error handli=
ng.
> > > Could you please git it a try and if everything still works I'll =
fold it
> > > and commit.
> >=20
> > Thanks Dmitry! I tried your patch and it worked like a charm!
>=20
> Excellent, thanks for testing.
>=20
> >=20
> > Do you take it from here or would you like me to send an updated
> > version that includes your patch?
>=20
> No, there is no need for that. I'll fold them all together and queue =
for
> 2.6.32.
Great thanks! Don't forget to add Alan as reviewer. I think he forgot
reply-all when he mailed me:
"I'm happy with this one.
Reviewed-by: Alan Cox <alan@linux.intel.com>"

> I take the other patch that makes polled devices do poll upon opening
> working well for you too.. Should I queue for .2 as well?
Yes, why not!

--=20
Best regards,
 Eric

http://www.unixphere.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
