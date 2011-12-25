From: Alec Moskvin <alecmn@gmail.com>
Subject: Re: [PATCH 1/1] hid_wiimote: add INPUT_FF_MEMLESS dependency
Date: Sun, 25 Dec 2011 11:13:20 -0500
Message-ID: <20111225161320.GA12841@thinkpad>
References: <1324744926-24793-1-git-send-email-alecmn@gmail.com>
 <CANq1E4Qab2sO2QagwmU-66+kUWhpStxVWawEGX=1HCdrM7bgLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f53.google.com ([209.85.216.53]:58740 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab1LYQNo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 Dec 2011 11:13:44 -0500
Content-Disposition: inline
In-Reply-To: <CANq1E4Qab2sO2QagwmU-66+kUWhpStxVWawEGX=1HCdrM7bgLA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi David,

On Sunday 25 December 2011 11:06:58, David Herrmann wrote:
> Hi Alec
>=20
> On Sat, Dec 24, 2011 at 5:42 PM, Alec Moskvin <alecmn@gmail.com> wrot=
e:
> > This fixes build error:
> > ...
> > CRC 17a7c33e
> > Kernel: arch/x86/boot/bzImage is ready =C2=A0(#1)
> > =C2=A0Building modules, stage 2.
> > =C2=A0MODPOST 7 modules
> > ERROR: "input_ff_create_memless" [drivers/hid/hid-wiimote.ko]
> > undefined!
> > make[1]: *** [__modpost] Error 1
> > make: *** [modules] Error 2
> >
> > Signed-off-by: Alec Moskvin <alecmn@gmail.com>
> > ---
> > =C2=A0drivers/hid/Kconfig | =C2=A0 =C2=A01 +
> > =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 22a4a05..332c22a 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -620,6 +620,7 @@ config HID_WIIMOTE
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on BT_HIDP
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on LEDS_CLASS
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0select POWER_SUPPLY
> > + =C2=A0 =C2=A0 =C2=A0 select INPUT_FF_MEMLESS
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0---help---
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0Support for the Nintendo Wii Remote blue=
tooth device.
> >
>=20
> This fix is already in Jiri's tree. See here:
> http://git.kernel.org/?p=3Dlinux/kernel/git/jikos/hid.git;a=3Dcommitd=
iff;h=3Def6f41157f3864d9bf42671b2ed66062dcafb72e
>=20
> Regards
> David

I wasn't aware of that. Shouldn't it be pushed to the main tree, then?

It's not in 3.2-rc7 (released yesterday), which is why I reported it.

Thanks,
Alec
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
