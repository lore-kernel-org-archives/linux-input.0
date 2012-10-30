From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] input: qt1070: add pinctrl consumer
Date: Tue, 30 Oct 2012 22:37:46 +0100
Message-ID: <CACRpkdaTciRNsG8viz19FQajFExX+ApPNcnnVBneecSe_w-EsA@mail.gmail.com>
References: <20121023131627.GE18964@game.jcrosoft.org>
	<1350998942-713-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:60669 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934295Ab2J3Vhr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Oct 2012 17:37:47 -0400
Received: by mail-ea0-f174.google.com with SMTP id c13so301088eaa.19
        for <linux-input@vger.kernel.org>; Tue, 30 Oct 2012 14:37:46 -0700 (PDT)
In-Reply-To: <1350998942-713-1-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Tue, Oct 23, 2012 at 3:29 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:

> If no pinctrl available just report a warning as some architecture may not
> need to do anything.
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-input@vger.kernel.org

We're having a discussion on the level of where to impose pinctrl.

Jean-Christophe, could you please check the thread
"Input: omap4-keypad: Add pinctrl support"
and tell us what you think is the best approach?

Yours,
Linus Walleij
