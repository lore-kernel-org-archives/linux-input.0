From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2 v3] input: keyboard: Add D-Link DIR-685 touchkeys driver
Date: Wed, 31 May 2017 01:50:38 +0200
Message-ID: <CACRpkdZq-DxGwjzqyd=JdcD2Cx=JreVZfAX0C3KntYPHZCJTXA@mail.gmail.com>
References: <20170530120918.27357-1-linus.walleij@linaro.org>
 <20170530120918.27357-2-linus.walleij@linaro.org> <20170530164021.GB12922@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35729 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdE3Xuk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 19:50:40 -0400
Received: by mail-io0-f171.google.com with SMTP id f102so2582636ioi.2
        for <linux-input@vger.kernel.org>; Tue, 30 May 2017 16:50:39 -0700 (PDT)
In-Reply-To: <20170530164021.GB12922@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Tue, May 30, 2017 at 6:40 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, May 30, 2017 at 02:09:18PM +0200, Linus Walleij wrote:
>> +     /*
>> +      * This key appears in the vendor driver, but I have
>> +      * not been able to provoke it.
>> +      */
>> +     tk->codes[6] = KEY_O;
>
> If there is no way to make the device produce this key, should we mark
> is as KEY_RESERVED? KEY_O would not be suitable in any case, we'd need
> to find more suitable keycode for whatever function is has.

OK I'm in on this.

> If it is OK I can make the change locally.

Sure go ahead when applying!

Yours,
Linus Walleij
