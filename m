From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/kms: Implement KDB debug hooks
 for nouveau KMS.
Date: Wed, 22 Sep 2010 19:07:05 +0200
Message-ID: <1285175225.2960.10.camel@maxim-laptop>
References: <m3iq9yqd7w.fsf@pullcord.laptop.org>
	 <4C5ACF3F.8050409@windriver.com> <m3hbj0fju3.fsf_-_@pullcord.laptop.org>
	 <m3aaoimqrp.fsf_-_@pullcord.laptop.org>
	 <1283335002.2741.5.camel@maxim-laptop>  <4C7E3A73.5070503@windriver.com>
	 <1283424363.2736.1.camel@maxim-laptop>
	 <1285119735.5949.5.camel@maxim-laptop>
	 <1285164198.3159.8.camel@maxim-laptop>
	 <1285164387.3159.10.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40370 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab0IVRRO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Sep 2010 13:17:14 -0400
Received: by fxm12 with SMTP id 12so177933fxm.19
        for <linux-input@vger.kernel.org>; Wed, 22 Sep 2010 10:17:13 -0700 (PDT)
In-Reply-To: <1285164387.3159.10.camel@maxim-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Chris Ball <cjb@laptop.org>, David Airlie <airlied@linux.ie>, kgdb-bugreport@lists.sourceforge.net, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-input <linux-input@vger.kernel.org>

On Wed, 2010-09-22 at 16:06 +0200, Maxim Levitsky wrote:=20
> On Wed, 2010-09-22 at 16:03 +0200, Maxim Levitsky wrote:=20
> > On Wed, 2010-09-22 at 03:42 +0200, Maxim Levitsky wrote:=20
> > > On Thu, 2010-09-02 at 13:46 +0300, Maxim Levitsky wrote:=20
> > > > On Wed, 2010-09-01 at 06:35 -0500, Jason Wessel wrote:=20
> > > > > On 09/01/2010 04:56 AM, Maxim Levitsky wrote:
> > > > > > On Thu, 2010-08-19 at 13:55 -0400, Chris Ball wrote:=20
> > > > > >  =20
> > > > > >> Hi,
> > > > > >>
> > > > > >> Here's a patch to add support for KMS debugging to Nouveau=
, along the
> > > > > >> style of the previous patches for Intel=C2=B9 and Radeon=C2=
=B2.  I'm only able
> > > > > >> to test on nv50 here, so a test on nv04 would be much appr=
eciated,
> > > > > >> and I've published instructions on how to test here=C2=B3.=
  Thanks!
> > > > > >>
> > > > > >> - Chris.
> > > > > >>    =20
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > I just tried that patch, but unfortunately nether with nor =
without it
> > > > > > kdb seems not to work.
> > > > > > It could be id10t error from my side, but I did test the kd=
b in the past
> > > > > > with few KMS patches, and it seemed to work.
> > > > > >
> > > > > > Now I can't even get its prompt on the console.
> > > > > >
> > > > > > This is what I do:
> > > > > >
> > > > > > echo kbd | sudo tee /sys/module/kgdboc/parameters/kgdboc
> > > > > > (also tried booting with kgdboc=3Dkbd)
> > > > > >  =20
> > > > >=20
> > > > > Try changing it to kgdboc=3Dkms,kbd  or the "echo kms,kbd"
> > > > >=20
> > > > > When you use only the kbd, the kms feature is not activated.
> > > > This doesn't help.
> > > >=20
> > > > I am afraid that this bug isn't related to kms, but rather is g=
eneric.
> > >=20
> > > I turns out that it was the NMI watchdog that I had enabled.
> > > Without it kdb works very well, including the kms support.
> > Please disregard this. kdb works with nmi watchdog now as well.
> > Probably something was fixed, maybe unrelated to it.
> >=20
> > >=20
> > > It would be better if you were to detect kms instead of adding an
> > > explicit param to kgdboc cmd line.
> > >=20
> > > Also found out that after a debug session with Alt+SysRQ+g and X
> > > running, these keys aren't released. I had to press on all of the=
m to
> > > make them release.
> > > It makes sense as kgdboc in that case reads directly from keyboar=
d port.
> > And I see that kgdb actually has a code that works that around.
> > I suspect that what happens is that keys are released before X cont=
inues
> > running, and therefore it doesn't pick these events up.
>=20
> However an evtest on input event running on kernel tty, still only pi=
cks
> release of the alt key.

[Dropped nouveau list, because this is offtopic there]

I pretty much got to the bottom of this.
There are 2 separate issues:


1. SysRq handler is now a input 'filter', which means that it can 'eat'
input events, so they don't show up on input bus.
It does so while sysrq key is down.
So sysrq and 'g' events never reach the kernel kbd driver and therefore
the hack to release them doesn't work.

2. The kbd_clear_keys_helper injects the keyup events alright, but it
doesn't inject SYN events, and therefore X evdev driver doesn't pick
these injected events untill next SYN event.=20

This patch makes key release work in expense of showing sysrq key to us=
erspace, which isn't that good,
because now Alt+SysRQ causes a screen capture by default.
In my opinion the sysrq filter should stay.
We should just make kdb hook into atkbd and do the key release there.
This should both result in cleaner/more robust code, and make this issu=
e disappear.
I'll look at doing that.


diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 0c6c641..7df6af5 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -368,6 +368,7 @@ static int kbd_clear_keys_helper(struct input_handl=
e *handle, void *data)
 {
 	unsigned int *keycode =3D data;
 	input_inject_event(handle, EV_KEY, *keycode, 0);
+	input_inject_event(handle, EV_SYN, SYN_REPORT, 0);
 	return 0;
 }
=20
diff --git a/drivers/char/sysrq.c b/drivers/char/sysrq.c
index ef31bb8..db1eb12 100644
--- a/drivers/char/sysrq.c
+++ b/drivers/char/sysrq.c
@@ -601,7 +601,7 @@ static bool sysrq_filter(struct input_handle *handl=
e, unsigned int type,
 	}
=20
 out:
-	return sysrq_down;
+	return 0;
 }
=20
 static int sysrq_connect(struct input_handler *handler,


Best regards,
	Maxim Levitsky

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
