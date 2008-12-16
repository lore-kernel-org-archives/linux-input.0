From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Logitech Alto Cordless
Date: Tue, 16 Dec 2008 21:24:33 +0100
Message-ID: <49480E81.3070803@gmail.com>
References: <4933E4BC.5090801@gmail.com> <alpine.LRH.1.10.0812011734130.28179@twin.jikos.cz> <493424C7.30209@gmail.com> <493649F1.8090001@gmail.com> <4947F556.4000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f17.google.com ([209.85.219.17]:36710 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759997AbYLPUYi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Dec 2008 15:24:38 -0500
Received: by ewy10 with SMTP id 10so3906230ewy.13
        for <linux-input@vger.kernel.org>; Tue, 16 Dec 2008 12:24:36 -0800 (PST)
In-Reply-To: <4947F556.4000700@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Julian Sikorski pisze:
> Julian Sikorski pisze:
>> Julian Sikorski pisze:
>>> Jiri Kosina pisze:
>>>> On Mon, 1 Dec 2008, Julian Sikorski wrote:
>>>>
>>>>> during a discussion on fedora-devel-list, I was suggested to check if
>>>>> the said keyboard is compliant with the standards before requesting
>>>>> xkeyboard-config changes. The problem exists with two keys:
>>>>> - Fn-F3, has MSIE logo on it, emits XF86HomePage, should emit XF86WWW
>>>>> - Fn-F4, has a tune on it, emit XF86Tools, should XF86AudioMedia
>>>>> This is under Fedora 10 x86_64, using evdev driver and evdev-managed
>>>>> keyboard map.
>>>> In order to answer this question, we need to know what the keyboard is 
>>>> acutally sending when these keys are being pressed (and also product ID 
>>>> would be useful -- this can be obtained from lsusb output).
>>>>
>>>> Assuming that Fedora has the CONFIG_HID_DEBUG kernel option turned on (I 
>>>> don't know whether this is true or not), could you please
>>>>
>>>> 	rmmod usbhid
>>>> 	rmmod hid
>>>> 	modprobe hid debug=2
>>>> 	modprobe usbhid
>>>>
>>>> press the keys, and send the dmesg output?
>>>>
>>>> Thanks,
>>>>
>>> OK, got it. hid is builtin.
>> Here is what evtest reports:
>> Event: time 1228294575.277680, type 4 (Misc), code 4 (ScanCode), value c0223
>> Event: time 1228294575.277708, type 1 (Key), code 172 (HomePage), value 1
>> Event: time 1228294575.277716, -------------- Report Sync ------------
>> Event: time 1228294575.437667, type 4 (Misc), code 4 (ScanCode), value c0223
>> Event: time 1228294575.437692, type 1 (Key), code 172 (HomePage), value 0
>> Event: time 1228294575.437699, -------------- Report Sync ------------
>> Event: time 1228294576.165695, type 4 (Misc), code 4 (ScanCode), value c0183
>> Event: time 1228294576.165724, type 1 (Key), code 171 (Config), value 1
>> Event: time 1228294576.165732, -------------- Report Sync ------------
>> Event: time 1228294576.325660, type 4 (Misc), code 4 (ScanCode), value c0183
>> Event: time 1228294576.325690, type 1 (Key), code 171 (Config), value 0
>> Event: time 1228294576.325697, -------------- Report Sync ------------
>>
>> Julian
> Could somebody help me in preparation of an appropriate patch? I took a
> look into drivers/hid/hid-input-quirks.c, but unfortunately that's
> beyond my skills. Thanks in advance!
> 
> Regards,
> Julian
I opened a bug at kernel bugzilla:
http://bugzilla.kernel.org/show_bug.cgi?id=12238

Regards,
Julian
