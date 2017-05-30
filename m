From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2 v2] input: keyboard: Add D-Link DIR-685 touchkeys driver
Date: Tue, 30 May 2017 14:03:14 +0200
Message-ID: <CACRpkdZMHLyEOqR7bebZaD2NLs4Ud=8bz6vwvM7SzDkET-0xrg@mail.gmail.com>
References: <20170520165746.13356-1-linus.walleij@linaro.org>
 <20170520165746.13356-2-linus.walleij@linaro.org> <20170520172648.GA38800@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36270 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdE3MDP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 08:03:15 -0400
Received: by mail-io0-f173.google.com with SMTP id o12so54873530iod.3
        for <linux-input@vger.kernel.org>; Tue, 30 May 2017 05:03:15 -0700 (PDT)
In-Reply-To: <20170520172648.GA38800@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Sat, May 20, 2017 at 7:26 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Sat, May 20, 2017 at 06:57:46PM +0200, Linus Walleij wrote:
>> +     tk->codes[0] = KEY_UP;
>> +     tk->codes[1] = KEY_DOWN;
>> +     tk->codes[2] = KEY_LEFT;
>> +     tk->codes[3] = KEY_RIGHT;
>> +     tk->codes[4] = KEY_ENTER;
>> +     tk->codes[5] = KEY_W;
>> +     tk->codes[6] = KEY_O;
>
> Why 'W' and 'O'? I do not think the router software expects users to
> "type" these letters? Could it have something to do with WPS and maybe
> something else?

Yeah, they had these values in the vendor tree.
Here is a photo of this beast:
https://dflund.se/~triad/krad/dlink-dir-685/dir-685-touchkeys.jpg

As you can see I marked only 6 keys on the image.

The key "O" I haven't been able to provoke by poking around
but the vendor driver handles this, maybe something from an
earlier or alternative hardware revision?

KEY_W is indeed WPS, I will change that to the right keycode.

Yours,
Linus Walleij
