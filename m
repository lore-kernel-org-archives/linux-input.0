From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Conversion between unsigned and signed for "ff_effects_max" in uinput
 and input.
Date: Fri, 17 Jul 2015 00:09:37 +0200
Message-ID: <CADbOyBRErT7oTFbJObOr8sbFdEZWFCqoiGD=oFRMkuLXMG8bjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33842 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198AbbGPWJi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2015 18:09:38 -0400
Received: by obre1 with SMTP id e1so55765829obr.1
        for <linux-input@vger.kernel.org>; Thu, 16 Jul 2015 15:09:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, vojtech@suse.cz, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi everyone,

Making observations based on the following headers:

uinput.h: "(struct uinput_device).ff_effects_max" is defined as "unsigned int".
uapi/uinput.h: "(struct uinput_user_dev).ff_effects_max" is defined as "__u32".

vs

input.h: "(struct ff_device).max_effects" is defined as "int",
however, signature of input_ff_create() in input.h is:
    int input_ff_create(struct input_dev *dev, unsigned int max_effects)

Why is "(struct ff_device).max_effects" defined as a signed integer,
instead of an unsigned integer, as defined in the majority of the headers?

If that question is cleared out,
I would like to point to a potential integer overflow in the assignment in
ff-core.c::input_ff_create():
    ff->max_effects = max_effects;
(http://lxr.free-electrons.com/source/drivers/input/ff-core.c#L337)
Although physically unlikely that max_effects would exceed 0x7FFFFFFF,
shouldn't there be a check to prevent "ff->max_effects" becoming negative?
Note that using UInput, the user can define its own value of max_effects,
so adding a check might be justified.

Feedback would be nice.

Thanks,
Elias
