From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: 35022: hid-magicmouse broken
Date: Thu, 19 May 2011 11:40:24 -0400
Message-ID: <4DD539E8.8090301@canonical.com>
References: <4DD26CB8.7070409@canonical.com> <alpine.LNX.2.00.1105171448230.28291@pobox.suse.cz> <4DD2C913.4000403@canonical.com> <alpine.LNX.2.00.1105191357350.28291@pobox.suse.cz> <4DD51763.1020209@canonical.com> <alpine.LNX.2.00.1105191648480.28291@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:40821 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751527Ab1ESPk3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2011 11:40:29 -0400
In-Reply-To: <alpine.LNX.2.00.1105191648480.28291@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Michael Poole <mdpoole@troilus.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Ott <alan@signal11.us>

On 05/19/2011 10:54 AM, Jiri Kosina wrote:
> On Thu, 19 May 2011, Chase Douglas wrote:
>=20
>> Here's the output in dmesg:
>>
>> [  195.491735] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
>> [  222.693947] input: cndougla=92s trackpad as
>> /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3.3/1-1.3.3:1.0/=
bluetooth/hci0/hci0:12/input16
>> [  222.694119] magicmouse 0005:05AC:030E.0005: input,hidraw3: BLUETO=
OTH
>> HID v1.60 Mouse [cndougla=92s trackpad] on 50:63:13:90:AF:A4
>> [  222.694128] hidp_output_raw_report, report_type: 2
>> [  222.808111] session ffff88012d9b1200 param 0x02
>> [  222.808198] hidp: returnign -EIO because of !output_report_succes=
s
>> [  222.808209] magicmouse 0005:05AC:030E.0005: unable to request tou=
ch
>> data (-5)
>> [  222.809358] session ffff88012d9b1200 param 0x02
>> [  222.810606] session ffff88012d9b1200 param 0x02
>> [  222.813113] session ffff88012d9b1200 param 0x00
>> [  223.045363] magicmouse: probe of 0005:05AC:030E.0005 failed with =
error -5
>=20
> Ok, so what is happening here is that magicmouse_probe() sends the { =
0xd7,=20
> 0x01 } feature report to the device, and it responds with=20
> HIDP_HSHK_ERR_INVALID_REPORT_ID.
>=20
> That's why the _raw callback (correctly) returns error.
>=20
> So the question to the driver authors is -- what is the point behind =
the {=20
> 0xd7, 0x01 } report? Clearly the device doesn't like it during probe=20
> because of invalid report ID.
> And it never did, we just silently ignored the error with the older=20
> kernels.

The feature report is what flips the devices (magic mouse, magic
trackpad) into multitouch mode. Without the report, the mouse will not
emit the location of any touches on its surface, and the trackpad will
only emit single touch data.

What do you think we should do? We can't get rid of the report. Should
we silently ignore the error?

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
