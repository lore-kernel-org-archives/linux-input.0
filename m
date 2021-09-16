Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2756C433F5
	for <linux-input@archiver.kernel.org>; Thu, 16 Sep 2021 23:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9935E611CA
	for <linux-input@archiver.kernel.org>; Thu, 16 Sep 2021 23:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241771AbhIPXPz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 16 Sep 2021 19:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241579AbhIPXPm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 16 Sep 2021 19:15:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D16AC0613E6
        for <linux-input@vger.kernel.org>; Thu, 16 Sep 2021 16:14:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b15so6405167lfe.7
        for <linux-input@vger.kernel.org>; Thu, 16 Sep 2021 16:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrcdelOr0WDXzRa5Y7OBaRiBU0y/+ZlZLM33ZPs8vYs=;
        b=iU4vcZDyoCAphSARnfycvWMqTrHc2rzhCDb0Pr1Wuacuy9hIfi//TKLJHV4hpvG9xN
         8YromWACsO4lIz139i9WAL+nGsdqINh5YubAixsY5zR/Qwm2bMuGCxSDTd0FB//LYGfy
         Ti/D03sib1ESRbbU5ieJxEVS1e4m04GD0XzEK2EZwpbnuTkbnN0UQmsio2VIbMfOPy+Q
         JX24yhBAr1ALi9v9JkSMCHxBpEXLfmIGNa3u5FCEmZgUs+P0p3DCTjLHMz96p3sGfY6E
         o0ln0LASjnvynbewm7vWvvcVMOnQic4aXdISnNfOFYBPQuvXrz73UpsB6ZvuEd5fypHF
         Im3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrcdelOr0WDXzRa5Y7OBaRiBU0y/+ZlZLM33ZPs8vYs=;
        b=CeDKjaNE7BEbCDFGyu7+E9nGEns6yLRKxeSybwjhmByWaHsiqO5UAWRed3TjbWRWVj
         DwxNLXcPG1pe8B5jaLYSy/kzIZSiqCsr92hgtq6CvYLmSTH39as7dWTidFaqIte041Zv
         ONEOEoxyD3fOiznJN550E84oit4wDnEQpovHvUYqpTi5rmUjOvr3/CQTuwEbMyUOEID2
         Yu4OFaCcaCMYAhXptHE63pHnqevqX1utBahjlczOKMsDsmqT8cOPmo59Uy7B5nMAkf9q
         TDeUbWYewuk/1Sg1yqDUasyhY+PJ88yeEo/67jxzKFQRno1NxxiBdjRjFQaQz9D9w+/m
         iqpQ==
X-Gm-Message-State: AOAM533KxwPd9TI1sT1qUNguwESEwTyuANzdiaygRW4+1pWJSm1dD65s
        pPgjeUM8vBESYiSDYoik7k/BdLDwIiL8xB+NbWn3P6b3TiA=
X-Google-Smtp-Source: ABdhPJzwbZEA1GFpHfRXhROOMPeztRMj2ogG7poMlWUbaf87IciI7tizAqxFw3yb62QG0Um5dT1pKjWdwExRCh/h4fU=
X-Received: by 2002:a19:f249:: with SMTP id d9mr5904640lfk.229.1631834049644;
 Thu, 16 Sep 2021 16:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210818152743.163929-1-tobias.junghans@inhub.de> <20210818152743.163929-2-tobias.junghans@inhub.de>
In-Reply-To: <20210818152743.163929-2-tobias.junghans@inhub.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Sep 2021 01:13:58 +0200
Message-ID: <CACRpkdZSmiVPOY8==pAhnUnYUn5xv6Wf5-tKEEJrpcqPF47++w@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: mcp2221: configure GP pins for GPIO function
To:     Tobias Junghans <tobias.junghans@inhub.de>
Cc:     Linux Input <linux-input@vger.kernel.org>,
        Rishi Gupta <gupt21@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, Aug 18, 2021 at 5:28 PM Tobias Junghans
<tobias.junghans@inhub.de> wrote:

> Per default the GP pins of an MCP2221 are designated to a certain
> dedicated or alternate function. While it's possible to change these
> defaults by manually updating the internal flash, it's much more
> convenient and safe to configure the GP pins as GPIOs automatically
> at runtime whenever the corresponding GPIO line is requested. The
> previous setting is restored as soon as the GPIO line is freed again.
>
> Signed-off-by: Tobias Junghans <tobias.junghans@inhub.de>

My sympathies are usually on the side of users trying to make
use of their hardware and they should be able to.

For other wrong configured GPIO expanders such as FTDI
a publicly available firmware reflash tool exists, and if that does
not exist for this hardware, I think this approach is legitimate.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
