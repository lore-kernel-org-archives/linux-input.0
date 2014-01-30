From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Is the hid-multitouch default driver for multitouch screen ?
Date: Thu, 30 Jan 2014 18:47:05 -0500
Message-ID: <CAN+gG=GJgwDL7jvk3KNZmJN_Tc9usASU4eP6uBp6D=bcC6ysWg@mail.gmail.com>
References: <CAPDwgkMf2j9kmDa1Q7LgMjtqGXfqEDMv7JNC+eO6j3Vk9DPysQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:54485 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbaA3XrH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 18:47:07 -0500
Received: by mail-bk0-f43.google.com with SMTP id mx11so1834598bkb.30
        for <linux-input@vger.kernel.org>; Thu, 30 Jan 2014 15:47:05 -0800 (PST)
In-Reply-To: <CAPDwgkMf2j9kmDa1Q7LgMjtqGXfqEDMv7JNC+eO6j3Vk9DPysQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yufeng Shen <miletus@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Yufeng,

On Thu, Jan 30, 2014 at 5:52 PM, Yufeng Shen <miletus@chromium.org> wrote:
> Hi,
>
> I was under the impression that in recent kernel (I am testing on 3.8)
> hid-multitouch
> is the default driver for touchscreen.

yes, and no. hid-multitouch is the default for Win 7 / Win 8 certified
touchscreens, which tends to be a lot.
For instance, here is a list of device I know of:
http://lii-enac.fr/en/architecture/linux-input/multitouch-devices.html

So given that on x86 most manufacturers wants the Microsoft
certification, their devices use hid-multitouch. However, on the
Android side, or the embedded world more generally, people use their
own protocol and communication bus and they have to write their own
driver.
Side note, I think they should consider switching to HID over i2c,
they will not need to write any driver this way. But that's just my
opinion.

> And I found one case that there is this
> RNDPLUS PulseIR Touchscreen pid/vid 2512:5004 defaults to generic-usb driver.

Hmm... the RNDPLUS 5003 (as written in the table I mentioned above)
uses hid-multitouch. And given the fact that you refer to generic-usb
driver, I think (but I may be wrong) that last time you checked this
device, it was on a kernel before 3.2. Now it should be handled by
hid-multitouch. Or it is just a single touch touchscreen.

>
> If you search
> "HID-Multitouch Kernel Driver Installation for Android OS IDSPulse"
> there is a setup document shows one need to add its pid/vid to
> hid_have_special_driver[]
> list so it will pick up hid-multitouch.  Do we still need to do that
> in recent kernel ?

No.
- Starting from 3.2 multitouch devices where rejected by hid-core and
had to be added manually to hid-multiouch
- in 3.4, there were a non generic attempt to automatically bind them
to hid-multitouch (attempt which was doing its job though)
- starting from 3.5, there is a much better generic solution and
multitouch screens are bound to hid-multitouch, and sensors to
hid-sensorhub for instance.

So to sum up, no, multitouch screen do not need to be added to
hid_have_special_driver[] except some rare cases which are already in
the kernel.

Cheers,
Benjamin

>
>
> Thanks,
>
> Yufeng Shen
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
