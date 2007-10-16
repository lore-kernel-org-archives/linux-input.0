From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Power button policy and mechanism
Date: Tue, 16 Oct 2007 22:29:15 +0200
Message-ID: <E1Iht2R-0001Yr-NW@be1.lrz>
References: <9eSWm-5sS-7@gated-at.bofh.it> <9eVKz-1xq-17@gated-at.bofh.it>
Reply-To: 7eggert@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S935684AbXJPU3g@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, linux-main <linux-kernel@vger.kerne>
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 10/16/07, Kristoffer Ericson <kristoffer.ericson@gmail.com> wrote:

>> Is the suggested approach on handling powerbutton (in keyboard drive=
r) to
>> simply push out the event and let userland handle it?
>=20
> Yes.
>=20
>> The reason Im asking this is because as you might know Im maintainer=
 for two
>> mini-laptop style pda's (HP7xx & HP6xx) and it would simplify my lif=
e alot if
>> I didn't need to depend on userland applications to be able to
>> suspend/resume.
>>
>> For instance HP6XX receives an interrupt call whenever the powerbutt=
on is
>> pressed. Now I could just push out the event and let another program=
 handle
>> it but considering it would take a minimum amount of lines to let it=
 simply
>> suspend/resume I feel its a waste.
>>
>> Previously the hp6xx has been allowed to do this "policy" way but th=
at was
>> when LinuxSH stod as a side branch to main tree. Now when everything=
 gets
>> merged into mainline I need to decide how to do this.
>>
>> This is mainly an embedded issue, but I feel it's quite important. I=
t should
>> apply to other devices also like for example Zaurus branches (those =
with
>> keyboard and designated power button).
>>
>> So in short:
>> 1. Does mainline policy allow static power button events inside kern=
el (power
>> button =3D=3D suspend/resume)?
>>        Why/Why Not?
>=20
> Could it be that you may want to prevent suspend from happening? Or
> delay it until system completes some important operation?

If I want to prevent the suspend/shutdown from happening, I don't press
the button. If my system insists on not shutting down in order to inste=
ad
run out to power while doing something important - I'm not happy, too.

OTOH, maybe you could allocate the storage for the suspend image here i=
nstead
of creating HUGE swap space and letting the kernel prevent suspend by u=
sing
it or watching the kernel thrash for hours before each OOM.

> Do something
> else, like cleanly disconnect your network connections?

Not needed, possibly not desired.

> With actual
> handling done in userspace it's all possible. With suspend done
> directly in kernel it is much harder and couples input subsystem with
> power management too tightly.

You can do something like control_alt_delete() - in fact I'm dedicating
400 KB of RAM for "kill -INT 1" on my desktop, not using suspend. Havin=
g
an ACPI userspace event is not bad if you intend to use it, but for peo=
ple
who just want shutdown or suspend to happen, it's overkill.
--=20
Top 100 things you don't want the sysadmin to say:
79. What's this "any" key I'm supposed to press?

=46ri=DF, Spammer: v@7eggert.dyndns.org 3dvkv3To@ifmpc.7eggert.dyndns.o=
rg
