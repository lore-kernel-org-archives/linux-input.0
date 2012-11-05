From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] Input: nomadik-ske-keypad - start using the apb_pclk
Date: Mon, 5 Nov 2012 13:25:11 +0100
Message-ID: <CAPDyKFpjdVMCuBdN-O+xxK=Dko-GTEjF5AYOeEMgWghJfB8EsA@mail.gmail.com>
References: <1351779602-13818-1-git-send-email-ulf.hansson@stericsson.com>
	<1351779602-13818-3-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdbZB4nhFQtLH-GxBSK99RFk7yhSYMhO5keVjyugrqr7JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:62016 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752874Ab2KEMZM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Nov 2012 07:25:12 -0500
Received: by mail-wi0-f172.google.com with SMTP id hq12so3090183wib.1
        for <linux-input@vger.kernel.org>; Mon, 05 Nov 2012 04:25:11 -0800 (PST)
In-Reply-To: <CACRpkdbZB4nhFQtLH-GxBSK99RFk7yhSYMhO5keVjyugrqr7JA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

On 4 November 2012 19:12, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Nov 1, 2012 at 3:20 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Previously this clock was handled internally by the clockdriver,
>> but now this is separate clk. So we need take care of it.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> So this is a silicon block clock and falls into the category of things
> we've been discussing...
>
> If I understand correctly, the only "real" solution is to
> implement the PM domains and have these enable the clocks.

Agree.

Although, since the pm_domain not yet exist, this as a way forward for
now - to fix what is broken.
When the pm_domain is in place and when we decide to fold in the clock
handling in there, we can move it.

>
> An alternative may be to move this driver over to the AMBA bus,
> because I think this device actually has primecell registers.
> Then the bus will take care of the pclk for starters.

You are definitely right, this driver can be converted into using the AMBA bus.
Although, do you think that should be done _instead_ of going ahead
with this patch or do you want that to be handled as a next and a
separate step?

Kind regards
Ulf Hansson
