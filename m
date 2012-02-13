From: ajaxas <ajaxas@gmail.com>
Subject: Re: ALPS touchpad no longer recognizing 'taps' as mouseclick in 3.3-rc3
Date: Mon, 13 Feb 2012 16:28:28 +0700
Message-ID: <CAKanTDcURNVGZQsNo-=GZ9FQAMzy8o8JPESUj9oGGqPxYLOiig@mail.gmail.com>
References: <20120212164728.GA19629@kroah.com>
	<20120212201236.GA9389@core.coreip.homeip.net>
	<20120213022221.GF25382@kroah.com>
	<20120213051243.GA10056@core.coreip.homeip.net>
	<CAKanTDeJepAY9FjSBJuQ6sK6kaGJwGH1hm3_T5hEQY4GDVuPeA@mail.gmail.com>
	<20120213063928.GB10056@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34063 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab2BMJ23 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Feb 2012 04:28:29 -0500
Received: by vbjk17 with SMTP id k17so2928678vbj.19
        for <linux-input@vger.kernel.org>; Mon, 13 Feb 2012 01:28:29 -0800 (PST)
In-Reply-To: <20120213063928.GB10056@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org

Hi!

I see the problem is solved, but I will reply anyway.

On Mon, Feb 13, 2012 at 1:39 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Feb 13, 2012 at 01:19:31PM +0700, ajaxas wrote:
>> Hello
>>
>> On Mon, Feb 13, 2012 at 12:12 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Sun, Feb 12, 2012 at 06:22:21PM -0800, Greg KH wrote:
>> >> On Sun, Feb 12, 2012 at 12:12:36PM -0800, Dmitry Torokhov wrote:
>> >> > Hi Greg,
>> >> >
>> >> > On Sun, Feb 12, 2012 at 08:47:28AM -0800, Greg KH wrote:
>> >> > > Hi,
>> >> > >
>> >> > > This problem has been since 3.3-rc1, but I only now am gettin=
g around to
>> >> > > reporting it, sorry about that.
>> >> > >
>> >> > > In 3.3-rc3, my alps touchpad isn't recognizing a tap on the t=
ouchpad as
>> >> > > a mouse click. =C2=A0Is there a new Kconfig option that I nee=
d to enable?
>> >> > >
>> >> > > My /proc/bus/input/devices entry for this thing is:
>> >> > > I: Bus=3D0011 Vendor=3D0002 Product=3D0008 Version=3D7326
>> >> > > N: Name=3D"AlpsPS/2 ALPS DualPoint TouchPad"
>> >> > > P: Phys=3Disa0060/serio1/input0
>> >> > > S: Sysfs=3D/devices/platform/i8042/serio1/input/input6
>> >> > > U: Uniq=3D
>> >> > > H: Handlers=3Dmouse1 event6
>> >> > > B: PROP=3D8
>> >> > > B: EV=3Db
>> >> > > B: KEY=3De420 70000 0 0 0 0
>> >> > > B: ABS=3D260800001000003
>> >> > >
>> >> > > Is there anything else you need me to report to help track th=
is down?
>> >> > >
>> >> >
>> >> > Please make sure you have xorg-x11-drv-synaptics installed and =
then
>> >> > check if tap to click is enabled in your DE. I think Gnome for =
some
>> >> > reason has it off my default.
>> >>
>> >> Is this a new thing for the 3.3 kernel? =C2=A0I ask as 3.2 and ol=
der kernels
>> >> work just fine this way. =C2=A0I can do a 'git bisect' to track i=
t down to a
>> >> specific patch if that will help out.
>> >
>> > No, there is no need. I am pretty sure pre-3.3 your touchpad worke=
d in
>> > PS/2 compatibility mode; in 3.3 we merged support for native multi=
touch
>> > protocol so your touchpad works in absolute mode, can support vari=
ous
>> > gestures (vertical/hrizontal scroll, user-selected sensitivity, et=
c.)
>> > and is recognozed as a proper touchpad by the entire stack. For so=
me
>> > reason though Gnome has disabled tap to click for touchpads by def=
ault.
>> > I do not remember what is the default for KDE.
>> >
>> > Hope this helps.
>> >
>> > --
>> > Dmitry
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-in=
put" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info=
=2Ehtml
>>
>> Since I'm using the same ALPS touchpad as Greg, I might be of some h=
elp here.
>>
>> I don't know how to check whether my touchpad is in absoulte mode or
>> not, but KDE system settings -> =C2=A0input devices doesn't list any
>> additional touchpads at all, only a mouse. Which affects both mouse
>> and touchpad.
>
> What mouse does it identify? Also, do you have kcm_touchpad module
> installed?
>
> [dtor@dtor-d630 ~]$ rpm -qa "kcm*touchpad*"
> kcm_touchpad-0.3.1-6.fc15.x86_64
> [dtor@dtor-d630 ~]$ locate kcm_touchpad.so
> /usr/lib64/kde4/kcm_touchpad.so

Just mouse, nothing specific.
Can't remeber installing such package, but I don't think my touchpad
must be configured by DE. I strongly believe this should be done via
/etc/X11/xorg.conf.d/ and therefore left DE-independent. My one and
only pain is that I can't configure per-window or per-application
keymap settings via Xorg.

>>
>> Could this be not a DE, but a xorg/driver problem afetr all?
>
> It could but it most likely is as most distributions install and set =
up
> synaptics X driver by default. I am not sure what DE Greg is using
> though.
>
> --
> Dmitry

Hah, I see. I use archlinux which, as a matter of fact, doesn't
configure synaptics driver or indeed Xorg by default.

Anyway, thank you for your time!

--
Best regards,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
