From: Andreas Ericsson <ae@op5.se>
Subject: Re: Touchpad gone berserk on dell XPS 1530 (AlpsPS/2 ALPS GlidePoint)
Date: Fri, 11 Jul 2008 08:41:47 +0200
Message-ID: <487700AB.8030704@op5.se>
References: <487398FD.2050305@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.op5.se ([193.201.96.20]:36813 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805AbYGKGm4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jul 2008 02:42:56 -0400
In-Reply-To: <487398FD.2050305@op5.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>

This problem is not in v2.6.26-rc9-56-g6329d30 from Linus' tree
(6329d3021bcfa9038621e6e917d98929421d8ec8). Now it's just the
touchpad tapping that doesn't work any more, which I personally
don't really care about.

Kristian, I'll update https://bugzilla.redhat.com/show_bug.cgi?id=3D448=
656
as well. Would you mind pushing for a quick release once 2.6.26
goes stable?

Andreas Ericsson wrote:
> Hi all.
>=20
> I'm a happy owner of a Dell XPS 1530 laptop where I use an external m=
ouse
> and usually keep the internal touchpad disabled.
>=20
> Fedora bugzilla link:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D448656
> The bugzilla entry has more text, but I've tried to distil the info h=
ere
> so one doesn't have to wade over several pages of postings in order t=
o
> get to the info. Kristian H=F6gsberg Cc'd as he's the assigned redhat
> resource for that particular bug.
>=20
>=20
> The problem:
> Some time ago (I'm not sure when as I've been suspending the computer
> rather than rebooting it) I started noticing that I got some really w=
eird
> input from the keyboard without me pressing any keys. The most freque=
ntly
> "fake-pressed" key is the equivalent of F7 (^[[18~). It seems to alwa=
ys
> generate escape-sequences similar to those of pressing either of the =
=46-keys
> for some reason (not a blessing when 14000 help-browser windows sudde=
nly
> try to spawn after the touchpad generating F1 sequences under Gnome).
>=20
> The mouse-pointer also jumps around the screen like a wild monkey ran=
domly
> activating left or right button at near-tachyon speed. So far I haven=
't
> noticed it scrolling or middle-clicking.
>=20
>=20
> The troubleshooting:
> At first I thought it was the motherboard acting up (and got it repla=
ced
> as it actually broke down 4 days after the problems started). After t=
hat
> I upgraded from Fedora 8 to Fedora 9, and none of the fedora9-shipped
> kernels work. Suspecting the technician was a bit clumsy or perhaps
> managed to short-circuit the touchpad, I loaded up Windows Vista,
> which works perfectly, ruling out hardware errors. Unfortunately, I n=
eed
> this laptop for more than watching porn and playing games, so running
> vista isn't really an option.
>=20
> I've tried booting latest master from linux-input.git
> (eff88f9927b8a54b378b4d4863eef488612b6dd7, v2.6.26-rc9-80-geff88f9 as
> of this writing), but to no avail. Finally, I located an ancient kern=
el
> (2.6.23.1-42) that doesn't have this particular problem but exhibits =
a
> much more common and less serious problem (tapping the touchpad doesn=
't
> work - everything else is fine). The next released kernel from fedora
> (2.6.24.3-12) doesn't work.
>=20
> dmesg output gets flooded with entries like this:
> psmouse.c: bad data from KBC - bad parity
> <about 10-30 of those> followed by
> input: Virtual ThinkFinger Keyboard as /devices/virtual/input/input11
> psmouse.c: bad data from KBC - bad parity
> psmouse.c: Mouse at isa0060/serio1/input0 lost synchronization, throw=
ing=20
> 1 bytes away.
> psmouse.c: failed to re-enable mouse on isa0060/serio1
> psmouse.c: resync failed, issuing reconnect request
> psmouse.c: Failed to reset mouse on isa0060/serio1
> input: PS/2 Generic Mouse as /devices/platform/i8042/serio1/input/inp=
ut12
> psmouse.c: Failed to enable mouse on isa0060/serio1
>=20
>=20
> It loops over every 1.5-3 minutes or so.
>=20
>=20
> Progress so far:
>  From what information I've been able to gather from simple printk()=20
> debugging
> is that it seems the kernel doesn't get further than the initial chec=
k in
> alps_detect on the touchpad but falls back to some version of "generi=
c=20
> ps/2"
> mode.
> The patches the fedora team apply to their kernels are numerous, and =
I=20
> haven't
> been able to find a listing showing which git commit any particular f=
edora
> kernel is built upon. Not very many of them touch the drivers/input s=
ection
> though, and those that do do it either for the macbook touchpad drive=
r or
> to suppress some user-scaring message.
>=20
> I've set my hopes to finding the bug somewhere in the range=20
> v2.6.23..v2.6.24,
> and that's what I'm currently bisecting. So far it's slow going thoug=
h as
> I'm not very familiar with kernel hacking and I don't know a quick wa=
y to
> boot a kernel so that all the hardware with 100% certainty gets a har=
d
> reset.
>=20
>=20
> Any hints, help or pointers would be much appreciated.
>=20
> TIA
>=20


--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
