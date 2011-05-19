From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: 35022: hid-magicmouse broken
Date: Thu, 19 May 2011 09:13:07 -0400
Message-ID: <4DD51763.1020209@canonical.com>
References: <4DD26CB8.7070409@canonical.com> <alpine.LNX.2.00.1105171448230.28291@pobox.suse.cz> <4DD2C913.4000403@canonical.com> <alpine.LNX.2.00.1105191357350.28291@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:48710 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932671Ab1ESNNL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2011 09:13:11 -0400
In-Reply-To: <alpine.LNX.2.00.1105191357350.28291@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Michael Poole <mdpoole@troilus.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alan Ott <alan@signal11.us>

On 05/19/2011 07:59 AM, Jiri Kosina wrote:
> On Tue, 17 May 2011, Chase Douglas wrote:
>=20
>>>> It seems hid_output_raw_report() is returning a different (incorre=
ct?)
>>>> value than in the past. Do you know what might be going on?
>>>
>>> So we are getting EIO from the transport-level _raw callback.
>>>
>>> Hmm, commit 0825411ade seems like a suspect here. Might be possible=
 that=20
>>> magicmouse doesn't send ACK back, right?
>>>
>>> Could you please try reverting that commit and re-test?
>>
>> Yes, reverting that commit makes it work.
>>
>> I'm just speculating here, based on commit message names and what yo=
u've
>> said, that the magicmouse is not protocol compliant because it is no=
t
>> sending an ACK back?=20
>=20
> Yes, I believe that's what is happening. Could you please report what=
 is=20
> the dmesg output with the patch below, just to make sure that we=20
> understand the situation precisely?

Here's the output in dmesg:

[  195.491735] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[  222.693947] input: cndougla=92s trackpad as
/devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.3/1-1.3.3/1-1.3.3:1.0/blu=
etooth/hci0/hci0:12/input16
[  222.694119] magicmouse 0005:05AC:030E.0005: input,hidraw3: BLUETOOTH
HID v1.60 Mouse [cndougla=92s trackpad] on 50:63:13:90:AF:A4
[  222.694128] hidp_output_raw_report, report_type: 2
[  222.808111] session ffff88012d9b1200 param 0x02
[  222.808198] hidp: returnign -EIO because of !output_report_success
[  222.808209] magicmouse 0005:05AC:030E.0005: unable to request touch
data (-5)
[  222.809358] session ffff88012d9b1200 param 0x02
[  222.810606] session ffff88012d9b1200 param 0x02
[  222.813113] session ffff88012d9b1200 param 0x00
[  223.045363] magicmouse: probe of 0005:05AC:030E.0005 failed with err=
or -5

>> What do you think we should do in the driver? Should we ignore the=20
>> return, or should we look specifically for EIO? (neither sounds very=
=20
>> good to me, so I'm hoping you have a better solution :).
>=20
> Well if the device indeed doesn't send the ACK and it should (I will =
have=20
> to check the specs first), we'll have to put a quirk into the driver.=
=20
> Otherwise if the ACK is not mandatory, we'll have to revert that comm=
it=20
> (or at least make it non-fatal failure).
>=20
> But I'll have to check the specs first.

Sounds good to me :).

Thanks!

-- Chase
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
