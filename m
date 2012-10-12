From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys: allocate pins
Date: Fri, 12 Oct 2012 23:27:47 +0200
Message-ID: <50788B53.6040309@gmail.com>
References: <1350057346-15998-1-git-send-email-zonque@gmail.com> <CACRpkdayOh=i4Fp6zWCy2yt7ZJU=ETD3x6N3KTAg++QhPOzH-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46583 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365Ab2JLV2F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Oct 2012 17:28:05 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1747978bkc.19
        for <linux-input@vger.kernel.org>; Fri, 12 Oct 2012 14:28:02 -0700 (PDT)
In-Reply-To: <CACRpkdayOh=i4Fp6zWCy2yt7ZJU=ETD3x6N3KTAg++QhPOzH-w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonas ABERG <jonas.aberg@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On 12.10.2012 23:26, Linus Walleij wrote:
> On Fri, Oct 12, 2012 at 5:55 PM, Daniel Mack <zonque@gmail.com> wrote:
> 
>> This allows DT driven boards to allocate and configure the pinmux once
>> the driver is probed.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> (...)
>> +       /* request pin mux */
>> +       pinctrl = devm_pinctrl_get_select_default(dev);
>> +       if (IS_ERR(pinctrl))
>> +               dev_warn(dev, "pins are not configured from the driver\n");
> 
> I think dev_warn() is rather nasty to throw in here, dev_info() is OK.

Well, dev_warn is used everywhere else for this particular warning, but
I can change that of course.

> However I suspect this driver could actually handle default, idle and sleep
> states, especially after the runtime PM patches discussed elsewhere,
> but that can be patched later.

Ok.


Thanks,
Daniel

