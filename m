From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] Input: samsung-keypad: Add support for pinctrl
Date: Mon, 31 Dec 2012 09:15:38 +0530
Message-ID: <CAK9yfHy3j5R+OmVcDP_oByjz7yrGR4Bs9+u92Y9u3mjTY0jcdQ@mail.gmail.com>
References: <1354789126-28304-1-git-send-email-sachin.kamat@linaro.org>
	<CACRpkdYjmpB7gPd-z9pia=R2NQPxkeVegpKDrLfViET+2=UOXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:50174 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab2LaDpj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Dec 2012 22:45:39 -0500
Received: by mail-ob0-f177.google.com with SMTP id uo13so11019062obb.8
        for <linux-input@vger.kernel.org>; Sun, 30 Dec 2012 19:45:38 -0800 (PST)
In-Reply-To: <CACRpkdYjmpB7gPd-z9pia=R2NQPxkeVegpKDrLfViET+2=UOXA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, Linus Walleij <linus.walleij@linaro.org>

Hi Dmitry,

On 7 December 2012 00:59, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Dec 6, 2012 at 11:18 AM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>
>> Added support for pin configuration using pinctrl subsystem
>> to the Samsung keypad driver.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> So we've tried to add some pinctrl default fetchers into the input drivers
> and Dmitry don't like sprinking calls like that all over the drivers so
> we're trying to come up with some other scheme.
>
> I sent one patch that tried to pick the pinctrl handles by using
> notifiers but it doesn't work basically due to probe deferral.
>
> So next approach will be to try and modify the device core to
> fetch default pinctrl states.
>
> You might try to lobby Dmitry to accepting this in the meantime,
> as a stepping stone. (I'm OK with it, Acked-by).

What is your opinion about this patch? Can you please accept this
until we have some common scheme to handle this.

>
> Yours,
> Linus Walleij



-- 
With warm regards,
Sachin
