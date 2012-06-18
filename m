From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [RFC/PATCH] Revert "Input: wacom - add 0xE5 (MT device) support"
Date: Sun, 17 Jun 2012 21:39:48 -0500
Message-ID: <CAGzDe_bmMK1V6_gw7vOA+BMJnBsck-OJMyVvXQbXwFvcs2Z3AQ@mail.gmail.com>
References: <1335402856-11256-1-git-send-email-pinglinux@gmail.com>
	<20120614212335.GA4210@burratino>
	<CAF8JNh+dzJdoYC5AD+4HnOKmjumMR5acLCBFsi=ZAYtGZCja+w@mail.gmail.com>
	<20120615002705.GA7140@burratino>
	<CAF8JNh+-5z7xDJrTTTE1GP5E-MD1AnWPJiC43aTbjNLGv8pbwA@mail.gmail.com>
	<20120616222545.GA1660@burratino>
	<CAGzDe_YkhZGOLb-0xqmGDHV=rGujbBr9ohd-qkCty8=VMXr5rw@mail.gmail.com>
	<1339967336.3826.4.camel@x220tablet.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58286 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab2FRCjt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Jun 2012 22:39:49 -0400
Received: by lbbgm6 with SMTP id gm6so3969862lbb.19
        for <linux-input@vger.kernel.org>; Sun, 17 Jun 2012 19:39:48 -0700 (PDT)
In-Reply-To: <1339967336.3826.4.camel@x220tablet.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nils Kanning <nils@kanning.de>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Ping Cheng <pinglinux@gmail.com>, dmitry.torokhov@gmail.com, =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>, linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>

On Sun, Jun 17, 2012 at 4:08 PM, Nils Kanning <nils@kanning.de> wrote:
> On Sat, 2012-06-16 at 19:43 -0500, Chris Bagwell wrote:
>> > The exact patch used is at [2]. =A0That produced:
>
>> Can you "rmmod wacom" and this run "lsusb -vvv" and email me directl=
y
>> or post to debian bug report the section for Wacom? =A0I'd like to l=
ook
>
> With this kernel I could not remove the wacom module using "rmmod
> wacom" (the options -f or -w do not help). Furthermore "lsusb -vvv"
> hangs at the wacom device and does not produce more then:
> Bus 002 Device 004: ID 056a:00e6 Wacom Co., Ltd
>
> The output of "lsusb -vvv" using the Debian kernel from linux-image
> 3.2.17 and after doing "rmmod wacom" is in the attached file.
>
> Nils
>

The HID report didn't help me yet; other then now knowing the i++ is co=
rrect.

Your dmesg log file from 3.5-rc2 gives best hint yet at problem.

[    2.159684] input: Wacom ISDv4 E6 Pen as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5:1.0/input/input5
[    2.164406] input: Wacom ISDv4 E6 Pen as
/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5:1.1/input/input6

Instead of opps, it loads 2 input devices.  That second device should
say "Finger" instead of "Pen".

Thats related to device_type that gets set while parsing the HID
report.  I'll need some more time to study your HID report to see if I
can figure out why its getting confused.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
