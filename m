From: Yufeng Shen <miletus@chromium.org>
Subject: Is the hid-multitouch default driver for multitouch screen ?
Date: Thu, 30 Jan 2014 17:52:44 -0500
Message-ID: <CAPDwgkMf2j9kmDa1Q7LgMjtqGXfqEDMv7JNC+eO6j3Vk9DPysQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:49887 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275AbaA3Wwp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 17:52:45 -0500
Received: by mail-oa0-f54.google.com with SMTP id i4so4432704oah.41
        for <linux-input@vger.kernel.org>; Thu, 30 Jan 2014 14:52:44 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I was under the impression that in recent kernel (I am testing on 3.8)
hid-multitouch
is the default driver for touchscreen. And I found one case that there is this
RNDPLUS PulseIR Touchscreen pid/vid 2512:5004 defaults to generic-usb driver.

If you search
"HID-Multitouch Kernel Driver Installation for Android OS IDSPulse"
there is a setup document shows one need to add its pid/vid to
hid_have_special_driver[]
list so it will pick up hid-multitouch.  Do we still need to do that
in recent kernel ?


Thanks,

Yufeng Shen
