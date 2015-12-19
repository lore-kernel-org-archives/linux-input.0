From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Quanta touchscreen 0408:3003 does not work with hid-multitouch
Date: Sat, 19 Dec 2015 09:41:54 -0800
Message-ID: <20151219174154.GC27255@dtor-ws>
References: <CACcJrhR8iv0FKRrH7V2nbefZBLfhmr_Kn9ctg4O4bhzd_3oFnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36425 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbbLSRl5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Dec 2015 12:41:57 -0500
Received: by mail-pa0-f46.google.com with SMTP id q3so56478411pav.3
        for <linux-input@vger.kernel.org>; Sat, 19 Dec 2015 09:41:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACcJrhR8iv0FKRrH7V2nbefZBLfhmr_Kn9ctg4O4bhzd_3oFnA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, Jim lovell <jimlovell777@gmail.com>

On Tue, Nov 10, 2015 at 10:21:15PM -0600, Jim lovell wrote:
> [1.] 0408:3003 Quanta Computer, Inc. Touchscreen Controller Detected
> But Doesn't Work
>=20
> [2.] Booting my computer using the newest mainline kernel, the
> built-in USB 0408:3003 Quanta Computer, Inc. touchscreen controller i=
s
> detected but doesn't work. The touchscreen controller is detected but
> no touches are acknowleged. Using "xinput [id] test" no output is
> generated while single or multi touching the screen.

=2E..

>=20
> [X.] Launchpad Bug Report
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1514310
>     Workaround that 70% of the time allows single touches to work
> until the system is rebooted.
>     xinput set-mode [id] RELATIVE
>     xinput set-mode [id] ABSOLUTE
>     sudo rmmod hid-multitouch
>     sudo modprobe hid-multitouch
>=20
>     xinput --list
>         =E2=86=B3 Quanta Computer OpticalTouchScreen id=3D12 [slave p=
ointer (2)]
>     lsusb
>             Bus 001 Device 005: ID 0408:3003 Quanta Computer, Inc.
>     lsmod
>         hid 118784 7 hid_multitouch,usbhid,hid_logitech_dj,hid_logite=
ch_hidpp
>     dmesg (most recent output after many attempts following elmarikon=
's "fix")
>         input: Quanta Computer OpticalTouchScreen as
> /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.6/1-1.6:1.0/0003:0408:3=
003.0007/input/input16
>         hid-multitouch 0003:0408:3003.0007: input,hiddev0,hidraw4: US=
B
> HID v1.10 Mouse [Quanta Computer OpticalTouchScreen] on
> usb-0000:00:1a.0-1.6/input0
>         hid-multitouch 0003:0408:3003.0007: usb_submit_urb(ctrl) fail=
ed: -1
>         hid-multitouch 0003:0408:3003.0007: usb_submit_urb(ctrl) fail=
ed: -1

Benjamin, any ideas?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
