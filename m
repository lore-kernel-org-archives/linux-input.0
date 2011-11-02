From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Wed, 2 Nov 2011 09:23:43 +0100
Message-ID: <CAN+gG=FOJv=J9=DF4HKsZT5HcLBkBM4rAWE7peOGLo4XZJ4GNg@mail.gmail.com>
References: <20111026213705.GA32664@pequod.mess.org>
	<CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com>
	<4EA9466F.4000508@gmail.com>
	<20111028111605.GA23693@polaris.bitmath.org>
	<CAN+gG=EiJJR464q_eoJuJYpWOPMsk61W6sAKD18SdT+2tQfmQA@mail.gmail.com>
	<20111028140033.GA2155@polaris.bitmath.org>
	<alpine.LNX.2.00.1110281913010.3541@pobox.suse.cz>
	<20111101141704.GA2135@polaris.bitmath.org>
	<alpine.LNX.2.00.1111011526350.348@pobox.suse.cz>
	<20111101153348.GB2191@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37253 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416Ab1KBIXp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Nov 2011 04:23:45 -0400
Received: by wyh15 with SMTP id 15so1196411wyh.19
        for <linux-input@vger.kernel.org>; Wed, 02 Nov 2011 01:23:43 -0700 (PDT)
In-Reply-To: <20111101153348.GB2191@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Sean Young <sean@mess.org>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

Hi Henrik

On Tue, Nov 1, 2011 at 16:33, Henrik Rydberg <rydberg@euromail.se> wrote:
>> > 1. It still does not resolve the
>> > hid-multitouch-gets-loaded-for-every-hid-device problem, and
>>
>> Hmm, I thought it should work. What is the catch?
>
> Everyone with an umatched hid device, even completely unrelated to
> touch, will be surprised to find the hid-multitouch module loaded.
>

Well, this is a problem that can not be easily solved: IIRC, we can
not force the load of an external driver from within the kernel.
The best solution would be to merge hid-input and hid-multitouch.
Indeed both systems aim at handling generic devices.However, I'd
rather not doing it now as we are not as "good" as the Win 7 driver
(i.e. there are some fallback modes that allow every devices to be
handled even if they don't send clean hid reports).

And, even if hid-multitouch is loaded, only 2 or 3 lines of codes will
be executed to reject the driver in mt_probe, which won't be very time
consuming for end user.

For your second point:
>> > 2. It did not work after removing the tested device from the hid core
>> > whitelist; the device quirk seemed to get lost in the process.

Didn't you forget to remove the following line?

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1230,7 +1230,6 @@ int hid_connect(struct hid_device *hdev,
unsigned int connect_mask)
               hdev->claimed |= HID_CLAIMED_INPUT;
       if (hdev->quirks & HID_QUIRK_MULTITOUCH) {
               /* this device should be handled by hid-multitouch, skip it */
-               hdev->quirks &= ~HID_QUIRK_MULTITOUCH;
               return -ENODEV;
       }


If not, that's maybe that you encountered the only case that is not
correctly handled:
if you register hid-multitouch before hid, then it will be the first
driver tested, and hid-input won't set the quirk correctly.
BTW, it's not a big deal, because if systems do have this behavior, we
can easily put the device from the user space by using
/sys/module/hid_multitouch/drivers/hid\:hid-multitouch/new_id

Cheers,
Benjamin
