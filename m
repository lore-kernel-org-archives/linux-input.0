From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Thu, 25 Sep 2014 12:26:06 +0200
Message-ID: <CANq1E4TgMtOgDbnwn78NvPSCT38oCVPdV5e8BBT8pxZyuivY2A@mail.gmail.com>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
	<CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
	<CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
	<20140915215728.GB13468@core.coreip.homeip.net>
	<CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
	<20140915225809.GA31798@core.coreip.homeip.net>
	<CANq1E4R80GwEL43ngV5-8cWXTQAchfCOwpYSxUZfL7Hxy5yVSw@mail.gmail.com>
	<20140923163756.GC40700@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:40134 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbaIYK0H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Sep 2014 06:26:07 -0400
Received: by mail-ig0-f170.google.com with SMTP id a13so8311937igq.5
        for <linux-input@vger.kernel.org>; Thu, 25 Sep 2014 03:26:07 -0700 (PDT)
In-Reply-To: <20140923163756.GC40700@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Wright <michaelwr@android.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

Hi

On Tue, Sep 23, 2014 at 6:37 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>> It's the same discussion we had with
>> backlights for years and we're trying eagerly to merge them into the
>> DRM char-devs.
>>
>
> So keyboard backlight is going to be controlled by display chardev? Or
> we are fragmenting backlights into different classes?

The idea is to make DRM property changes propagate into a linked
backlight. Applied to input-LEDs, it would mean setting LED_XYZ via
input would cause an kernel-internal call into the linked led_class
set_brightness(). This allows us to register an led-class per LED as
you request, but at the same time allow easy access via input devices
where it makes sense.

Thanks
David
