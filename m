From: "Gavin Lambert" <gavinl@compacsort.com>
Subject: RE: [eGalax] no click events with touchscreen
Date: Fri, 9 Jan 2015 15:58:13 +1300
Message-ID: <001001d02bb8$1d41e920$57c5bb60$@compacsort.com>
References: <000701d02af4$cab68350$602389f0$@compacsort.com>	<CAN+gG=Hw98OCcJZj-jUk6H64D+C_eyyXo52uvOdyomFFwELXQw@mail.gmail.com>	<000b01d02b91$4303a8f0$c90afad0$@compacsort.com>	<CAN+gG=GKpPhXm8HkxC6WAOQ5RY24WpSXUrOyY6xiPzJ6hGL=yw@mail.gmail.com>	<000f01d02b99$89843d00$9c8cb700$@compacsort.com> <CAN+gG=H+AaoF2YDJcnJWBvpK1d5fy4uMtPYPR_vWNpSD7Cy54A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.compacsort.com ([202.180.125.98]:35806 "EHLO
	mail.compacsort.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbbAIC6R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 21:58:17 -0500
In-Reply-To: <CAN+gG=H+AaoF2YDJcnJWBvpK1d5fy4uMtPYPR_vWNpSD7Cy54A@mail.gmail.com>
Content-Language: en-nz
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Benjamin Tissoires' <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On 9 January 2015 13:08, quoth Benjamin Tissoires:
> You can also make an udev rule which write 1040 in
> /sys/bus/hid/devices/0003\:0EEF\:0001.*/quirks on plug in an udev rule (you
> should probably rely on the path given by the udev rule instead of writing
> the wildcard).

I get a "permission denied" error trying to write to that pseudo-file after boot, even with sudo.  (It currently contains 3088.)

I also tried writing the following udev rule and rebooting, but it had no effect; not sure if I'm doing it wrong or if it's having the same problem:

SUBSYSTEM=="usb", ATTRS{idVendor}=="0eef", ATTRS{idProduct}=="0001", RUN+="echo 1040 > /sys/bus/hid/devices/0003\:0EEF\:0001.0002/quirks"


