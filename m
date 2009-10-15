From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not work
	anymore
Date: Thu, 15 Oct 2009 11:13:37 -0700
Message-ID: <20091015181336.GB8544@core.coreip.homeip.net>
References: <928C125D-D36B-47C9-A549-3EE502C9EC73@gmail.com> <4AD75AC0.6020705@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:15862 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554AbZJOSPm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Oct 2009 14:15:42 -0400
Content-Disposition: inline
In-Reply-To: <4AD75AC0.6020705@tremplin-utc.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <eric.piel@tremplin-utc.net>
Cc: Greg KH <gregkh@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Oct 15, 2009 at 07:24:16PM +0200, =C9ric Piel wrote:
> Op 14-10-09 04:05, Dmitry Torokhov schreef:
> > On Tue, Oct 13, 2009 at 11:52:19AM +0200, =C9ric Piel wrote:
> >>> Could you please try and let me know if unloading at suspend and
> >>> reloading after resume atkbd and/or psmouse drivers and leaving i=
8042
> >>> alone "fixes" the issue?
> >>>
> >> Unloading the modules before suspend and reloading them after work=
s
> >> around the issue, indeed.
> >>
> >=20
> > Do both of them need to be reloaded? Or only one (my guess psmouse)=
 is
> > enough. Hmm, this is HP laptop so it most likely has Synaptics touc=
hpad.
> > I wonder what happens if you force it to bare PS/2 protocol (or may=
be
> > Intellimouse)... Try adding "option psmouse proto=3Dimps" and
> > "option psmouse proto=3Dbare" and suspend/resume.
> Sorry for taking some time to answer back. The keyboard fails to come
> back only on the first suspend-resume (the next suspends, the keyboar=
d
> comes back fine). So I need to reboot the computer for every single t=
est.
>=20
> So far, what I can tell is that once the keyboard is not working
> anymore, just unloading and reloading atkbd fixes the problem. Attach=
ed
> is a dmesg log from just before supsending to after resume. The keybo=
ard
> doesn't work anymore but the touchpad do. The lines at the very end o=
f
> the log correspond to keypresses: although the keyboard doesn't work,
> there are still 3 interrupt per keypress generated:
>=20
> drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, 0, 1) [320670]
> drivers/input/serio/i8042.c: f0 <- i8042 (interrupt, 0, 1) [320751]
> drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, 0, 1) [320753]
>=20
> That's all the date for now. I'll test your questions about psmouse
> later on, and report back.
>=20

It lokks like the keyboard controller switched from translated to
non-translated mode: '1c' is make code and 'f0 1c' is break (aka
release) code.

Could you tell me how the keyboard indentified (in dmesg) after fresh
boot and after you do the bind/unbind trick on the older kernel?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
