From: Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH] input: atmel_mxt_ts: detect touchpad from devicetree
Date: Mon, 9 Oct 2017 19:35:16 +0200
Message-ID: <CANBLGcw9YJNjzyM46pnG+jFLB6D69Phobd5+nASKKu7MHYXBKA@mail.gmail.com>
References: <20171004193531.9038-1-kernel@esmil.dk> <20171008195601.GC29090@lava.h.shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34257 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdJIRfi (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 9 Oct 2017 13:35:38 -0400
In-Reply-To: <20171008195601.GC29090@lava.h.shmanahar.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 8 October 2017 at 21:56, Nick Dyer <nick@shmanahar.org> wrote:
> On Wed, Oct 04, 2017 at 09:35:31PM +0200, Emil Renner Berthing wrote:
>> The Samsung Chromebook Plus (rk3399-gru-kevin) has two of
>> these controllers. One for the touchscreen and one for
>> the touchpad. However the touchpad doesn't have any
>> associated gpio buttons, so it shows up as another
>> touchscreen.
>>
>> This patch fixes it by matching the "atmel,atmel_mxt_tp"
>> compatibility string in the device tree.
>
> Thanks. I think this makes sense, given there are already devices out
> there using "atmel_mxt_tp".
>
> Is the hardcoded MXT_PIXELS_PER_MM going to cause issues on this new
> device?

I'm not exactly sure what kind of issues a wrong value would give, but
the touchpad feels totally usable in X with libinput.
I just checked google's chromeos kernel and it seems to use the same
hard-coded value.

> I think you need to add this to
> Documentation/devicetree/bindings/input/atmel,maxtouch.txt

Speaking of issues I was just about to complain that the "click
button" in the touchpad
didn't work, but only touch. It turns out I completely misunderstood what those
"gpio buttons" was all about. Adding

+               linux,gpio-keymap = <KEY_RESERVED
+                                    KEY_RESERVED
+                                    KEY_RESERVED
+                                    BTN_LEFT>;

to the device tree fixes exactly that, and hence the current logic
in the driver is fine for detecting the touchpad.

I'll submit another patch to add this to the device tree rather than
this misunderstood patch.

> Reviewed-by: Nick Dyer <nick@shmanahar.org>

Thank you for the review, and sorry about the noise.

/Emil
