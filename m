From: Michele Baldessari <michele@acksyn.org>
Subject: Re: [PATCH] HID: usbhid: Add a quirk for Xin-Mo Dual Arcade
Date: Mon, 26 Oct 2015 13:06:01 +0100
Message-ID: <20151026120601.GB4814@palahniuk.int.rhx>
References: <1445701499-13748-1-git-send-email-michele@acksyn.org>
 <alpine.LNX.2.00.1510242210360.21100@pobox.suse.cz>
 <2A323439-5639-475A-AB8A-1CF915CF4316@ithink.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from palahniuk.acksyn.org ([5.9.7.26]:33520 "EHLO
	palahniuk.acksyn.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489AbbJZMGI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2015 08:06:08 -0400
Content-Disposition: inline
In-Reply-To: <2A323439-5639-475A-AB8A-1CF915CF4316@ithink.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Olivier Scherler <oscherler@ithink.ch>
Cc: Jiri Kosina <jikos@kernel.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Olivier,

On Mon, Oct 26, 2015 at 12:00:50PM +0100, Olivier Scherler wrote:
> > On 24 oct. 2015, at 22:11, Jiri Kosina <jikos@kernel.org> wrote:
> > On Sat, 24 Oct 2015, Michele Baldessari wrote:
> >=20
> >> The Xin-Mo Dual Arcade controller (16c0:05e1) needs this quirk in =
order
> >> to have the two distinct joysticks working.
> >>=20
> >> Before the change:
> >> $ jstest /dev/input/js0
> >> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> >> ...
> >> $ jstest /dev/input/js1
> >> jstest: No such file or directory
> >>=20
> >> After the change:
> >> $ jstest /dev/input/js0
> >> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> >> ...
> >> $ jstest /dev/input/js1
> >> Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
> >> ...
> >>=20
> >> Signed-off-by: Michele Baldessari <michele@acksyn.org>
> >=20
> > Adding Oliver to CC.
> >=20
> > Oliver, how come that you didn't need this while working on the ini=
gial=20
> > Xin-Mo Dual Arcade support?
>=20
> Because I didn=E2=80=99t mind whether the controller announced itself=
 as two
> joysticks with two axes each, or one joystick with four axes. In the
> software I use it for (a MAME for the Raspberry Pi), I can map a
> single device=E2=80=99s buttons and axes to several players.
>=20
> I=E2=80=99m a bit surprised with this, though:
>=20
> > $ jstest /dev/input/js0
> > Joystick (Xin-Mo Xin-Mo Dual Arcade) has 2 axes (X, Y)
>=20
> because in my case I had four axes, at least using evtest (I don=E2=80=
=99t
> remember if I tried jstest as well).

Ah that is the crux of the matter. It never showed up with four
axes in my tests (raspbian, kernel 4.1.7), hence I submitted the patch
given that the two joysticks were indistinguishable without it on my
setup.

Which kernel version did you run your tests on? (Maybe some other chang=
e
skewed things around?)


> What bothered me at the time, though, is that even though the custom
> driver was made as a kernel module, an entry had to be added in the
> hid_have_special_driver table in hid-core.c for the kernel to use it,
> which means, if I understand properly, that the kernel still needs
> recompiling. Is that normal?

I had that line in my kernel prior to my patch:
https://github.com/raspberrypi/linux/blob/rpi-4.1.y/drivers/hid/hid-cor=
e.c#L2008

Kind regards,
Michele
--=20
Michele Baldessari            <michele@acksyn.org>
C2A5 9DA3 9961 4FFB E01B  D0BC DDD4 DCCB 7515 5C6D
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
