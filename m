From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys: allocate pins
Date: Thu, 25 Oct 2012 10:20:17 +0200
Message-ID: <5088F641.9050409@gmail.com>
References: <1350057346-15998-1-git-send-email-zonque@gmail.com> <CACRpkdayOh=i4Fp6zWCy2yt7ZJU=ETD3x6N3KTAg++QhPOzH-w@mail.gmail.com> <50788B53.6040309@gmail.com> <CACRpkda==SXUtS1AExnjaQfnCYssGbfH=LrgqWhBiq85Ln02og@mail.gmail.com> <50788E3D.2060404@gmail.com> <CACRpkdb+u2ho3KhRsuE_ykM8arCL7B=SmHNS7qarAwh2mGHsjg@mail.gmail.com> <20121025075830.GF971@gmail.com> <CACRpkdbr4VHJ+gNZjK43FmSU=p5FGdxqmOkkAz-VWqUCQ=R=5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51181 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758591Ab2JYIUY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 04:20:24 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so592873bkc.19
        for <linux-input@vger.kernel.org>; Thu, 25 Oct 2012 01:20:23 -0700 (PDT)
In-Reply-To: <CACRpkdbr4VHJ+gNZjK43FmSU=p5FGdxqmOkkAz-VWqUCQ=R=5A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonas ABERG <jonas.aberg@stericsson.com>

On 25.10.2012 10:08, Linus Walleij wrote:
> On Thu, Oct 25, 2012 at 9:58 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> On Fri, 12 Oct 2012, Linus Walleij wrote:
> (...)
>>> Is biasing what you need to do?
> (...)
>>> All I really want is that platforms have a clear idea about
>>> how and where the pins will be handled, and that if GPIO
>>> and pinctrl handle the same lines, they need to interact.
>>>
>>> Yours,
>>> Linus Walleij
>>
>> Friendly poke.
> 
> I don't know how to respond to that? I asked a question about
> what the intent of the patch was and the generic thinking
> behind this approach and it remains unanswered.
> 
> I think I have seen other patches doing the proper thing
> for pinctrl-single by implementing the proper
> pinctrl_request_gpio()
> pinctrl_free_gpio()
> pinctrl_gpio_direction_input()
> pinctrl_gpio_direction_output()
> in that very GPIO driver.
> 
> So I suspect that this patch should be dropped, unless you
> have some other compelling usecase to bring to the show?

I think so too. I misunderstood the concept of pinctrl in this area,
thanks for taking the time of explaining this. Shortly after I worked on
it, I was distracted by other topics so I didn't find time to continue.
But once I will, I'll follow up here again.


Thanks,
Daniel

