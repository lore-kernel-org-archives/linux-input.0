From: ajaxas <ajaxas@gmail.com>
Subject: Re: ALPS touchpad no longer recognizing 'taps' as mouseclick in 3.3-rc3
Date: Mon, 13 Feb 2012 13:19:31 +0700
Message-ID: <CAKanTDeJepAY9FjSBJuQ6sK6kaGJwGH1hm3_T5hEQY4GDVuPeA@mail.gmail.com>
References: <20120212164728.GA19629@kroah.com>
	<20120212201236.GA9389@core.coreip.homeip.net>
	<20120213022221.GF25382@kroah.com>
	<20120213051243.GA10056@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54759 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab2BMGTc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Feb 2012 01:19:32 -0500
Received: by vcge1 with SMTP id e1so2913731vcg.19
        for <linux-input@vger.kernel.org>; Sun, 12 Feb 2012 22:19:31 -0800 (PST)
In-Reply-To: <20120213051243.GA10056@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org

Hello

On Mon, Feb 13, 2012 at 12:12 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sun, Feb 12, 2012 at 06:22:21PM -0800, Greg KH wrote:
>> On Sun, Feb 12, 2012 at 12:12:36PM -0800, Dmitry Torokhov wrote:
>> > Hi Greg,
>> >
>> > On Sun, Feb 12, 2012 at 08:47:28AM -0800, Greg KH wrote:
>> > > Hi,
>> > >
>> > > This problem has been since 3.3-rc1, but I only now am getting a=
round to
>> > > reporting it, sorry about that.
>> > >
>> > > In 3.3-rc3, my alps touchpad isn't recognizing a tap on the touc=
hpad as
>> > > a mouse click. =C2=A0Is there a new Kconfig option that I need t=
o enable?
>> > >
>> > > My /proc/bus/input/devices entry for this thing is:
>> > > I: Bus=3D0011 Vendor=3D0002 Product=3D0008 Version=3D7326
>> > > N: Name=3D"AlpsPS/2 ALPS DualPoint TouchPad"
>> > > P: Phys=3Disa0060/serio1/input0
>> > > S: Sysfs=3D/devices/platform/i8042/serio1/input/input6
>> > > U: Uniq=3D
>> > > H: Handlers=3Dmouse1 event6
>> > > B: PROP=3D8
>> > > B: EV=3Db
>> > > B: KEY=3De420 70000 0 0 0 0
>> > > B: ABS=3D260800001000003
>> > >
>> > > Is there anything else you need me to report to help track this =
down?
>> > >
>> >
>> > Please make sure you have xorg-x11-drv-synaptics installed and the=
n
>> > check if tap to click is enabled in your DE. I think Gnome for som=
e
>> > reason has it off my default.
>>
>> Is this a new thing for the 3.3 kernel? =C2=A0I ask as 3.2 and older=
 kernels
>> work just fine this way. =C2=A0I can do a 'git bisect' to track it d=
own to a
>> specific patch if that will help out.
>
> No, there is no need. I am pretty sure pre-3.3 your touchpad worked i=
n
> PS/2 compatibility mode; in 3.3 we merged support for native multitou=
ch
> protocol so your touchpad works in absolute mode, can support various
> gestures (vertical/hrizontal scroll, user-selected sensitivity, etc.)
> and is recognozed as a proper touchpad by the entire stack. For some
> reason though Gnome has disabled tap to click for touchpads by defaul=
t.
> I do not remember what is the default for KDE.
>
> Hope this helps.
>
> --
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

Since I'm using the same ALPS touchpad as Greg, I might be of some help=
 here.

I don't know how to check whether my touchpad is in absoulte mode or
not, but KDE system settings ->  input devices doesn't list any
additional touchpads at all, only a mouse. Which affects both mouse
and touchpad.

Could this be not a DE, but a xorg/driver problem afetr all?

As I messed up sending previous letter, to what Greg has pointed me, I
will quote myself:

Can't confirm this.

Sony Vaio VPCEH2L1R (p.d. November 2011)
archlinux, 3.3-rc3 (linux-mainline from AUR)

I: Bus=3D0011 Vendor=3D0002 Product=3D0008 Version=3D7326
N: Name=3D"AlpsPS/2 ALPS DualPoint TouchPad"
P: Phys=3Disa0060/serio1/input0
S: Sysfs=3D/devices/platform/i8042/serio1/input/input12
U: Uniq=3D
H: Handlers=3Dmouse2 event12
B: PROP=3D8
B: EV=3Db
B: KEY=3De420 70000 0 0 0 0
B: ABS=3D260800001000003

/etc/X11/xorg.conf.d/10-synaptics.conf :

Section "InputClass"
   Identifier      "touchpad catchall"
   Driver          "synaptics"
   MatchIsTouchpad "on"
   MatchDevicePath "/dev/input/event*"
   Option          "SHMConfig" "on"
   Option          "TapButton1" "1"
   Option          "TapButton2" "2"
   Option          "TapButton3" "3"
   Option          "VertTwoFingerScroll" "on"
   Option          "HorizTwoFingerScroll" "on"

Works okay and worked with 3.3-rc2 (and earlier).

--
Best regards,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
