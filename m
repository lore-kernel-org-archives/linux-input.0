From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: 35022: hid-magicmouse broken
Date: Thu, 19 May 2011 16:54:49 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1105191648480.28291@pobox.suse.cz>
References: <4DD26CB8.7070409@canonical.com> <alpine.LNX.2.00.1105171448230.28291@pobox.suse.cz> <4DD2C913.4000403@canonical.com> <alpine.LNX.2.00.1105191357350.28291@pobox.suse.cz> <4DD51763.1020209@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40190 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab1ESOyv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2011 10:54:51 -0400
In-Reply-To: <4DD51763.1020209@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input <linux-input@vger.kernel.org>, Michael Poole <mdpoole@troilus.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Ott <alan@signal11.us>

On Thu, 19 May 2011, Chase Douglas wrote:

> Here's the output in dmesg:
>=20
> [  195.491735] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
> [  222.693947] input: cndougla=92s trackpad as
> /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3.3/1-1.3.3:1.0/b=
luetooth/hci0/hci0:12/input16
> [  222.694119] magicmouse 0005:05AC:030E.0005: input,hidraw3: BLUETOO=
TH
> HID v1.60 Mouse [cndougla=92s trackpad] on 50:63:13:90:AF:A4
> [  222.694128] hidp_output_raw_report, report_type: 2
> [  222.808111] session ffff88012d9b1200 param 0x02
> [  222.808198] hidp: returnign -EIO because of !output_report_success
> [  222.808209] magicmouse 0005:05AC:030E.0005: unable to request touc=
h
> data (-5)
> [  222.809358] session ffff88012d9b1200 param 0x02
> [  222.810606] session ffff88012d9b1200 param 0x02
> [  222.813113] session ffff88012d9b1200 param 0x00
> [  223.045363] magicmouse: probe of 0005:05AC:030E.0005 failed with e=
rror -5

Ok, so what is happening here is that magicmouse_probe() sends the { 0x=
d7,=20
0x01 } feature report to the device, and it responds with=20
HIDP_HSHK_ERR_INVALID_REPORT_ID.

That's why the _raw callback (correctly) returns error.

So the question to the driver authors is -- what is the point behind th=
e {=20
0xd7, 0x01 } report? Clearly the device doesn't like it during probe=20
because of invalid report ID.
And it never did, we just silently ignored the error with the older=20
kernels.

Michael?

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
