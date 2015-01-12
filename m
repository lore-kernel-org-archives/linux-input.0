From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [eGalax] no click events with touchscreen
Date: Mon, 12 Jan 2015 10:51:59 -0500
Message-ID: <CAN+gG=FKeAwtk7EGL4MQMxOsFgheo1pNgsr2rhTL-r2=45TVBA@mail.gmail.com>
References: <000701d02af4$cab68350$602389f0$@compacsort.com>
	<CAN+gG=Hw98OCcJZj-jUk6H64D+C_eyyXo52uvOdyomFFwELXQw@mail.gmail.com>
	<000b01d02b91$4303a8f0$c90afad0$@compacsort.com>
	<CAN+gG=GKpPhXm8HkxC6WAOQ5RY24WpSXUrOyY6xiPzJ6hGL=yw@mail.gmail.com>
	<000f01d02b99$89843d00$9c8cb700$@compacsort.com>
	<CAN+gG=H+AaoF2YDJcnJWBvpK1d5fy4uMtPYPR_vWNpSD7Cy54A@mail.gmail.com>
	<001001d02bb8$1d41e920$57c5bb60$@compacsort.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:61971 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750921AbbALPwA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2015 10:52:00 -0500
Received: by mail-qc0-f171.google.com with SMTP id r5so18644067qcx.2
        for <linux-input@vger.kernel.org>; Mon, 12 Jan 2015 07:51:59 -0800 (PST)
In-Reply-To: <001001d02bb8$1d41e920$57c5bb60$@compacsort.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gavin Lambert <gavinl@compacsort.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Thu, Jan 8, 2015 at 9:58 PM, Gavin Lambert <gavinl@compacsort.com> wrote:
> On 9 January 2015 13:08, quoth Benjamin Tissoires:
>> You can also make an udev rule which write 1040 in
>> /sys/bus/hid/devices/0003\:0EEF\:0001.*/quirks on plug in an udev rule (you
>> should probably rely on the path given by the udev rule instead of writing
>> the wildcard).
>
> I get a "permission denied" error trying to write to that pseudo-file after boot, even with sudo.  (It currently contains 3088.)

You need root access, so you'll need a true root shell to be able to
write on the file.

>
> I also tried writing the following udev rule and rebooting, but it had no effect; not sure if I'm doing it wrong or if it's having the same problem:
>
> SUBSYSTEM=="usb", ATTRS{idVendor}=="0eef", ATTRS{idProduct}=="0001", RUN+="echo 1040 > /sys/bus/hid/devices/0003\:0EEF\:0001.0002/quirks"
>

IIRC, plain redirection can not work anymore with recent udev/systemd
versions. Also, the .0002 at the end should not be encoded directly in
the udev rule. You can rely on %k, which is the name of the device
given by udev.

I think, you should use something like that:

DRIVER=="hid-multitouch",
ENV{MODALIAS}=="hid:b0003g0004v00000EEFp00000001", RUN+="/bin/sh
/etc/udev/fix_hid_multitouch.sh %k"

With /etc/udev/fix_hid_multitouch.sh being:

#> cat > /etc/udev/fix_hid_multitouch.sh << EOF
#!/bin/bash

DEVICE=$1

echo 1040 > "/sys/bus/hid/devices/${DEVICE}/quirks"
EOF

This is untested, but it should give you some more clues to go further
if it does not work directly.

Cheers,
Benjamin
