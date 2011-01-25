From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/4] Pegatron Lucid tablet acceleromter/ALS
Date: Tue, 25 Jan 2011 09:12:38 -0800
Message-ID: <20110125171238.GE19701@core.coreip.homeip.net>
References: <1295909288-32650-1-git-send-email-andy.ross@windriver.com>
 <20110124230557.GA18135@core.coreip.homeip.net>
 <AANLkTinfDR4TnVC-NPLsCqXsc9nP+UWXKO6n8jXuT7ne@mail.gmail.com>
 <4D3EFDCF.7090308@windriver.com>
 <AANLkTi=tQpQ0wjfx-Cp13FuCSQNFitN7XAg-V2AcSHz2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44698 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222Ab1AYRMq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 12:12:46 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=tQpQ0wjfx-Cp13FuCSQNFitN7XAg-V2AcSHz2@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Andy Ross <andy.ross@windriver.com>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Tue, Jan 25, 2011 at 05:05:05PM +0000, Corentin Chary wrote:
> On Tue, Jan 25, 2011 at 4:43 PM, Andy Ross <andy.ross@windriver.com> =
wrote:
> > On 01/24/2011 11:30 PM, Corentin Chary wrote:
> >> Dmitry Torokhov wrote:
> >> > I am happy with the input part but I wonder if it really needs t=
o be
> >> > separate? If you roll it up into asus-laptop you would not need =
a new
> >> > platform device and then it would be what - 20 lines of code?
> >> >
> >> > Corentin, what do you think?
> >>
> >> I think that it should be consistent, if there is already some cod=
e
> >> for pegatron tablet in asus-laptop, then why a new platform device
> >> only for the accelerometer ?
> >
> > No strong feelings here. =A0I made it a separate file because
> > asus-laptop.c is already very large and this was something that cou=
ld
> > be fairly easily split out, but obviously it's a really trivial
> > device.
> >
> >> Andy, what is shared with asus-laptop exactly ? What sysfs files a=
re
> >> working and enabled ? =A0Are backlight and led classes working ?
> >
> > Just the key device, which exports the single touch area in the cor=
ner
> > of the tablet as KEY_MEDIA. =A0Some of the other sysfs devices
> > (bluetooth, display, leds) appear because the methods exist, but
> > they're stubbed out in the ASL and thus noops.
> >
> > Andy
>=20
> If everybody is ok with that, I think you should move the code back
> into asus-laptop.c. But if you do so, don't forget to modify the help
> text of ASUS_LAPTOP section in KConfig.
>=20
> Should we also change the description to
> "Asus/Medion/JVC/Lenovo/Pegatron Extra" ? That seems really ugly
> but....

"Kitchen sink" so we do not need to adjust the description going
forward? ;P

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
