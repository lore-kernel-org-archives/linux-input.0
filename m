From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] input/joystick: new Blackfin
	rotary input driver
Date: Thu, 23 Jul 2009 01:13:04 -0700
Message-ID: <20090723081304.GD3997@dtor-d630.eng.vmware.com>
References: <1247592827-16878-1-git-send-email-vapier@gentoo.org> <1247592827-16878-2-git-send-email-vapier@gentoo.org> <20090723044338.GB2782@dtor-d630.eng.vmware.com> <8bd0f97a0907222346x7e80799fkf88c7b59c61091b7@mail.gmail.com> <20090723072550.GA3997@dtor-d630.eng.vmware.com> <8bd0f97a0907230046t108e9ff1y747caf16aadc6de4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f184.google.com ([209.85.216.184]:57065 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbZGWINI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2009 04:13:08 -0400
Received: by pxi14 with SMTP id 14so304220pxi.33
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2009 01:13:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0907230046t108e9ff1y747caf16aadc6de4@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Thu, Jul 23, 2009 at 03:46:18AM -0400, Mike Frysinger wrote:
> On Thu, Jul 23, 2009 at 03:25, Dmitry Torokhov wrote:
> > On Thu, Jul 23, 2009 at 02:46:11AM -0400, Mike Frysinger wrote:
> >> On Thu, Jul 23, 2009 at 00:43, Dmitry Torokhov wrote:
> >> > On Tue, Jul 14, 2009 at 01:33:47PM -0400, Mike Frysinger wrote:
> >> >> +struct platform_driver bfin_rotary_device_driver =3D {
> >> >> + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D bfin_rotary_probe,
> >> >> + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __devexit_p(bfin_rotary_r=
emove),
> >> >> + =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D bfin_rotary_suspend,
> >> >> + =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D bfin_rotary_resume,
> >> >
> >> > Need to use dev_pm_ops so platform code won;t yell at us.
> >>
> >> looks like something new post 2.6.30 ... guess i'll have to keep t=
his
> >> in mind for migrating drivers when 2.6.31 comes out
> >>
> >> > I also think that this driver should too live in drivers/input/m=
isc so I
> >> > moved it there. I did a bit of reshuffling in the patch, could y=
ou
> >> > please give it a try and if it still works I'll apply to the 'ne=
xt'
> >> > branch.
> >>
> >> could you toss like a standard dev_info("initialized") into the en=
d of
> >> bfin_rotary_probe ? =A0otherwise, builds and works fine for me wit=
h
> >> 2.6.31-rc4. =A0thanks!
> >
> > Don't you find the boot to be too noisy? The input core already
> > prints a message when a new input device is registered...
>=20
> you're right.  when i was testing, i didnt update my board resources
> and so was seeing no output, so i added the dev_info() while also
> fixing the resources.  didnt notice the additional input core output.
> current behavior is fine then, thanks!

Cool. Then I'll also zap the similar message in bf54x-keys while applyi=
ng
your other patch.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
