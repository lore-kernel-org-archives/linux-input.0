From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Logitech Alto Cordless
Date: Wed, 03 Dec 2008 09:57:21 +0100
Message-ID: <493649F1.8090001@gmail.com>
References: <4933E4BC.5090801@gmail.com> <alpine.LRH.1.10.0812011734130.28179@twin.jikos.cz> <493424C7.30209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:12978 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYLCI50 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Dec 2008 03:57:26 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1788467nfc.21
        for <linux-input@vger.kernel.org>; Wed, 03 Dec 2008 00:57:24 -0800 (PST)
In-Reply-To: <493424C7.30209@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Julian Sikorski pisze:
> Jiri Kosina pisze:
>> On Mon, 1 Dec 2008, Julian Sikorski wrote:
>>
>>> during a discussion on fedora-devel-list, I was suggested to check if
>>> the said keyboard is compliant with the standards before requesting
>>> xkeyboard-config changes. The problem exists with two keys:
>>> - Fn-F3, has MSIE logo on it, emits XF86HomePage, should emit XF86WWW
>>> - Fn-F4, has a tune on it, emit XF86Tools, should XF86AudioMedia
>>> This is under Fedora 10 x86_64, using evdev driver and evdev-managed
>>> keyboard map.
>> In order to answer this question, we need to know what the keyboard is 
>> acutally sending when these keys are being pressed (and also product ID 
>> would be useful -- this can be obtained from lsusb output).
>>
>> Assuming that Fedora has the CONFIG_HID_DEBUG kernel option turned on (I 
>> don't know whether this is true or not), could you please
>>
>> 	rmmod usbhid
>> 	rmmod hid
>> 	modprobe hid debug=2
>> 	modprobe usbhid
>>
>> press the keys, and send the dmesg output?
>>
>> Thanks,
>>
> OK, got it. hid is builtin.
Here is what evtest reports:
Event: time 1228294575.277680, type 4 (Misc), code 4 (ScanCode), value c0223
Event: time 1228294575.277708, type 1 (Key), code 172 (HomePage), value 1
Event: time 1228294575.277716, -------------- Report Sync ------------
Event: time 1228294575.437667, type 4 (Misc), code 4 (ScanCode), value c0223
Event: time 1228294575.437692, type 1 (Key), code 172 (HomePage), value 0
Event: time 1228294575.437699, -------------- Report Sync ------------
Event: time 1228294576.165695, type 4 (Misc), code 4 (ScanCode), value c0183
Event: time 1228294576.165724, type 1 (Key), code 171 (Config), value 1
Event: time 1228294576.165732, -------------- Report Sync ------------
Event: time 1228294576.325660, type 4 (Misc), code 4 (ScanCode), value c0183
Event: time 1228294576.325690, type 1 (Key), code 171 (Config), value 0
Event: time 1228294576.325697, -------------- Report Sync ------------

Julian
