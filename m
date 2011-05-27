From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: g_hid and hid-multitouch compatibility?
Date: Fri, 27 May 2011 18:09:40 +0200
Message-ID: <BANLkTin=OOGVbomx81SqHiSX4nmg5huhXA@mail.gmail.com>
References: <8B252890F5150E47AD8B8AEC92FDBA2201118CAC80@fg-dc1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49994 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837Ab1E0QJm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 May 2011 12:09:42 -0400
Received: by wwa36 with SMTP id 36so2019047wwa.1
        for <linux-input@vger.kernel.org>; Fri, 27 May 2011 09:09:40 -0700 (PDT)
In-Reply-To: <8B252890F5150E47AD8B8AEC92FDBA2201118CAC80@fg-dc1>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pablo Cases <pablo.cases@flatfrog.com>
Cc: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Pablo,

Adding St=E9phane, Henrik and Jiri in CC.

On Fri, May 27, 2011 at 17:33, Pablo Cases <pablo.cases@flatfrog.com> w=
rote:
>
> Hi all,
>
> I have searched the net and the archives of linux-input for informati=
on on how to use the Linux g_hid kernel module on a device and the hid-=
multitouch kernel module on a host to communicate multitouch events. Bu=
t unfortunately I can only get single touch working.

Excuse my ignorance, I didn't know g_hid existed before your mail. If
I understand it well enough, it's an hid emulation from user-space.
Are you trying to inject events from a device in user-space to the
kernel? If so, I think it would be easier to use uinput. And the funny
think was that I'm currently writing a small lib to inject mulitouch
events in a uinput device in an easier way.

>
> Q: Has anyone successfully completed a g_hid <-> hid-multitouch setup=
? And is there a description somewhere of such setup?

I don't think so, hid-multitouch is really new (since 2.6.38, and was
not very generic at this time).

> Q: Is the Windows 7 multitouch USB HID descriptor the correct one to =
use also for Linux hid-multitouch? Or is some tweaking necessary?

Normally, any valid Windows 7 multitouch USB HID descriptor can be
handled by hid-multitouch.
But it's more the events that are sent to hid-multitouch that will
tell if your device is compatible or not.

>
> DETAILED DESCRIPTION BELOW
> The device is a Linux device that uses g_hid (currently 2.6.37 kernel=
) and a USB HID Report Descriptor for multitouch using two-touch parall=
el mode according to Microsoft document http://msdn.microsoft.com/en-us=
/windows/hardware/gg487437.
>
> On the host (ubuntu 11.04, 2.6.38 kernel) I register dynamically acco=
rding to the description at http://lii-enac.fr/en/architecture/linux-in=
put/multitouch-ubuntu-howto.html. Using the events/rdesc files in debug=
fs on Ubuntu 11.04 I have validated the parsing of the report descripto=
r and the input reports.

This is really a bad idea to use these howto with ubuntu 11.04 ATM. I
didn't found the time to update this stuff, and this branch can not be
used in ubuntu 11.04 (it contains code for 2.6.35 only, and there were
changes in the hid layer after). If you only used the part "How to add
your device to hid-multitouch from the user space" without updating
your hid module, then it's as if you have'nt done anything (the
generic hid module can not autodetect multitouch devices).

>
> Example multitouch input report from /sys/kernel/debug/hid/0003:xxxx:=
yyyy.0002/events looks correct:
> report (size 14) (numbered) =3D =A005 03 00 a5 12 32 0e 03 01 99 14 3=
2 0e 02
> Digitizers.TipSwitch =3D 1
> Digitizers.InRange =3D 1
> Digitizers.ContactID =3D 0
> GenericDesktop.X =3D 4773
> GenericDesktop.Y =3D 3634
> Digitizers.TipSwitch =3D 1
> Digitizers.InRange =3D 1
> Digitizers.ContactID =3D 1
> GenericDesktop.X =3D 5273
> GenericDesktop.Y =3D 3634
> Digitizers.ContactCount =3D 2
>

Most of the time, the problematic part comes from the releases. But
it's a good start.

> The first touch in the report is correctly presented both on Windows =
and on Ubuntu 11.04 (using ENAC's mtdiag tool with a minor tweak to dis=
play data from all devices not just multitouch ones). I can see in the =
debugfs files that the data for the second touch data is correctly tran=
sferred and interpreted (see above), but the mapping to the linux input=
 system seems a bit strange though (see below). My guess is that I have=
 not been correctly registered as a multitouch device. I'm assuming thi=
s also because I cannot see any activity from the hid-multitouch module=
 other than it being initialized when I connect my device (probably ano=
ther reason for the needed tweak in mtdiag above).
>
> Example mapping from /sys/kernel/debug/hid/0003:xxxx:yyyy.0002/rdesc =
that does not look entirely correct for the second touch:
> Digitizers.TipSwitch ---> Key.Touch
> Digitizers.InRange ---> Key.ToolPen
> Digitizers.ContactID ---> Absolute.Misc
> GenericDesktop.X ---> Absolute.X
> GenericDesktop.Y ---> Absolute.Y
> Digitizers.TipSwitch ---> Key.Touch
> Digitizers.InRange ---> Key.ToolRubber
> Digitizers.ContactID ---> Absolute.?
> GenericDesktop.X ---> Absolute.Z
> GenericDesktop.Y ---> Absolute.Rx

This means that your device is handled by the generic usbhid and not
hid-multitouch.

If you are trying to inject events from the user space, I strongly
recommend to use uinput instead. Let me know if you want to have my
little uinput-multitouch lib.

Cheers,
Benjamin

> Digitizers.ContactCount ---> Absolute.?
> Button.0001 ---> Key.LeftBtn
> Button.0002 ---> Key.RightBtn
> Button.0003 ---> Key.MiddleBtn
> GenericDesktop.X ---> Relative.X
> GenericDesktop.Y ---> Relative.Y
> GenericDesktop.Wheel ---> Relative.Wheel
>
>
> Regards,
> Pablo Cases
>
> -------------------------
> Pablo Cases, M.Sc.
> Development Engineer Software
> FlatFrog Laboratories AB
> Magistratsv=E4gen 10
> 22643 Lund
> Sweden
> Tel: +46 708 393816
> Mail: pc@flatfrog.com
> Web: www.flatfrog.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
