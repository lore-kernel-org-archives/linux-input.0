From: ajaxas <ajaxas@gmail.com>
Subject: Re: ALPS touchpad no longer recognizing 'taps' as mouseclick in 3.3-rc3
Date: Mon, 13 Feb 2012 00:01:50 +0700
Message-ID: <CAKanTDdKuOdF0HqL+iqV4nVJS+U4WB-D_iwLBGcrL__a2KBBJw@mail.gmail.com>
References: <20120212164728.GA19629@kroah.com>
	<CAKanTDf908L7XoyuVWGh5oy6L8V0nuPUpReyKTR7FBdQDHjovw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33463 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab2BLRBv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Feb 2012 12:01:51 -0500
Received: by vbjk17 with SMTP id k17so2651056vbj.19
        for <linux-input@vger.kernel.org>; Sun, 12 Feb 2012 09:01:50 -0800 (PST)
In-Reply-To: <CAKanTDf908L7XoyuVWGh5oy6L8V0nuPUpReyKTR7FBdQDHjovw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Can't confirm this.

Sony Vaio=C2=A0VPCEH2L1R (p.d. November 2011)
archlinux,=C2=A03.3-rc3 (linux-mainline from AUR)

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
=C2=A0 =C2=A0 Identifier =C2=A0 =C2=A0 =C2=A0"touchpad catchall"
=C2=A0 =C2=A0 Driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"synaptics"
=C2=A0 =C2=A0 MatchIsTouchpad "on"
=C2=A0 =C2=A0 MatchDevicePath "/dev/input/event*"
=C2=A0 =C2=A0 Option =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"SHMConfig" "on"
=C2=A0 =C2=A0 Option =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"TapButton1" "1"
=C2=A0 =C2=A0 Option =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"TapButton2" "2"
=C2=A0 =C2=A0 Option =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"TapButton3" "3"
=C2=A0 =C2=A0 Option =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"VertTwoFingerSc=
roll" "on"
=C2=A0 =C2=A0 Option =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"HorizTwoFingerS=
croll" "on"

Works okay and worked with 3.3-rc2.

On Sun, Feb 12, 2012 at 11:47 PM, Greg KH <gregkh@linuxfoundation.org> =
wrote:
>
> Hi,
>
> This problem has been since 3.3-rc1, but I only now am getting around=
 to
> reporting it, sorry about that.
>
> In 3.3-rc3, my alps touchpad isn't recognizing a tap on the touchpad =
as
> a mouse click. =C2=A0Is there a new Kconfig option that I need to ena=
ble?
>
> My /proc/bus/input/devices entry for this thing is:
> I: Bus=3D0011 Vendor=3D0002 Product=3D0008 Version=3D7326
> N: Name=3D"AlpsPS/2 ALPS DualPoint TouchPad"
> P: Phys=3Disa0060/serio1/input0
> S: Sysfs=3D/devices/platform/i8042/serio1/input/input6
> U: Uniq=3D
> H: Handlers=3Dmouse1 event6
> B: PROP=3D8
> B: EV=3Db
> B: KEY=3De420 70000 0 0 0 0
> B: ABS=3D260800001000003
>
> Is there anything else you need me to report to help track this down?
>
> thanks,
>
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml


--
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
