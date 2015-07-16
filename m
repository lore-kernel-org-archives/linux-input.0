From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Conversion between unsigned and signed for "ff_effects_max" in
 uinput and input.
Date: Thu, 16 Jul 2015 15:50:38 -0700
Message-ID: <20150716225038.GF32571@dtor-ws>
References: <CADbOyBRErT7oTFbJObOr8sbFdEZWFCqoiGD=oFRMkuLXMG8bjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33985 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbbGPWun (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2015 18:50:43 -0400
Received: by pdbbh15 with SMTP id bh15so5791938pdb.1
        for <linux-input@vger.kernel.org>; Thu, 16 Jul 2015 15:50:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADbOyBRErT7oTFbJObOr8sbFdEZWFCqoiGD=oFRMkuLXMG8bjA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Elias Vanderstuyft <elias.vds@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, vojtech@suse.cz

Hi Elias,

On Fri, Jul 17, 2015 at 12:09:37AM +0200, Elias Vanderstuyft wrote:
> Hi everyone,
> 
> Making observations based on the following headers:
> 
> uinput.h: "(struct uinput_device).ff_effects_max" is defined as "unsigned int".
> uapi/uinput.h: "(struct uinput_user_dev).ff_effects_max" is defined as "__u32".
> 
> vs
> 
> input.h: "(struct ff_device).max_effects" is defined as "int",
> however, signature of input_ff_create() in input.h is:
>     int input_ff_create(struct input_dev *dev, unsigned int max_effects)
> 
> Why is "(struct ff_device).max_effects" defined as a signed integer,
> instead of an unsigned integer, as defined in the majority of the headers?

The effect->id is signed (because we treat -1 as special value when
given to us by userspace) and so it made sense to have max_effects the
same type...

> 
> If that question is cleared out,
> I would like to point to a potential integer overflow in the assignment in
> ff-core.c::input_ff_create():
>     ff->max_effects = max_effects;
> (http://lxr.free-electrons.com/source/drivers/input/ff-core.c#L337)
> Although physically unlikely that max_effects would exceed 0x7FFFFFFF,
> shouldn't there be a check to prevent "ff->max_effects" becoming negative?
> Note that using UInput, the user can define its own value of max_effects,
> so adding a check might be justified.


Yes, we should compare against INT_MAX and fail with -EINVAL I guess.

Thanks.

-- 
Dmitry
