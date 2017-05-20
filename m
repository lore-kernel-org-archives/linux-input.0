From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v2] input: keyboard: Add D-Link DIR-685 touchkeys
 driver
Date: Sat, 20 May 2017 10:26:48 -0700
Message-ID: <20170520172648.GA38800@dtor-ws>
References: <20170520165746.13356-1-linus.walleij@linaro.org>
 <20170520165746.13356-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:33242 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752301AbdETR0v (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 20 May 2017 13:26:51 -0400
Received: by mail-pg0-f46.google.com with SMTP id u187so51058932pgb.0
        for <linux-input@vger.kernel.org>; Sat, 20 May 2017 10:26:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170520165746.13356-2-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org

Hi Linus,

On Sat, May 20, 2017 at 06:57:46PM +0200, Linus Walleij wrote:
> +	tk->codes[0] = KEY_UP;
> +	tk->codes[1] = KEY_DOWN;
> +	tk->codes[2] = KEY_LEFT;
> +	tk->codes[3] = KEY_RIGHT;
> +	tk->codes[4] = KEY_ENTER;
> +	tk->codes[5] = KEY_W;
> +	tk->codes[6] = KEY_O;

Why 'W' and 'O'? I do not think the router software expects users to
"type" these letters? Could it have something to do with WPS and maybe
something else?

Thanks.

-- 
Dmitry
