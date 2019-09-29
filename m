From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] HID: hyperv: Add the support of hibernation
Date: Sun, 29 Sep 2019 17:44:09 +0000
Message-ID: <PU1P153MB01698048162343130F34DAE0BF830@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568244952-66716-1-git-send-email-decui@microsoft.com>
 <PU1P153MB01695CEE01D65E8CD5CFA4E9BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <nycvar.YFH.7.76.1909261521410.24354@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1909261522380.24354@cbobk.fhfr.pm>
 <PU1P153MB016973F30CC1A52E46D15230BF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190927120513.GM8171@sasha-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190927120513.GM8171@sasha-vm>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Kelley <mikelley@microsoft.com>
List-Id: linux-input@vger.kernel.org

> From: Sasha Levin <sashal@kernel.org>
> Sent: Friday, September 27, 2019 5:05 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: Jiri Kosina <jikos@kernel.org>; KY Srinivasan <kys@microsoft.com>;
> Haiyang Zhang <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; benjamin.tissoires@redhat.com;
> linux-hyperv@vger.kernel.org; linux-input@vger.kernel.org;
> linux-kernel@vger.kernel.org; Michael Kelley <mikelley@microsoft.com>
> Subject: Re: [PATCH] HID: hyperv: Add the support of hibernation
>=20
> On Fri, Sep 27, 2019 at 05:42:31AM +0000, Dexuan Cui wrote:
> >> From: Jiri Kosina <jikos@kernel.org>
> >> Sent: Thursday, September 26, 2019 6:23 AM
> >> To: Dexuan Cui <decui@microsoft.com>
> >>
> >> On Thu, 26 Sep 2019, Jiri Kosina wrote:
> >>
> >> > > > This patch is basically a pure Hyper-V specific change and it ha=
s a
> >> > > > build dependency on the commit 271b2224d42f ("Drivers: hv: vmbus=
:
> >> > > > Implement
> >> > > > suspend/resume for VSC drivers for hibernation"), which is on Sa=
sha
> >> Levin's
> >> > > > Hyper-V tree's hyperv-next branch [ ... snipped ...]
> >> > > >
> >> > > > I request this patch should go through Sasha's tree rather than =
the
> >> > > > input subsystem's tree.
> >> > > >
> >> > > > Hi Jiri, Benjamin, can you please Ack?
> >> > >
> >> > > Hi Jiri, Benjamin,
> >> > > Can you please take a look at the patch?
> >> >
> >> > Hi Dexuan,
> >> >
> >> > I am planning to process it once 5.4 merge window is over and thus h=
id.git
> >> > is open again for 5.5 material.
> >>
> >> Ah, now I see you asked for this go through hyperv tree. For that, fee=
l
> >> free to add
> >> 	Acked-by: Jiri Kosina <jkosina@suse.cz>
> >> Jiri Kosina
> >
> >Thanks for the Ack, Jiri!
> >
> >I have a bunch of patches, including this one, to support Linux VM's
> hibernation
> >when the VM runs on Hyper-V. I just feel it would be better for all of t=
hem to
> >go through the Hyper-V tree. :-)
>=20
> Thank Dexuan, Jiri,
>=20
> Dexuan, I've been silently ignoring your patches for the past few weeks
> for the same reason as Jiri has mentioned. I'll pick them all up once
> the 5.4 merge window closes in a few days.
>=20
> Thanks,
> Sasha

Thanks, Sasha!

BTW, I'll post a v2 for this patch, as IMO I may be able to get rid of the
mousevsc_pm_notify in this patch by disabling the channel callback
in the suspend function.

Thanks,
-- Dexuan
