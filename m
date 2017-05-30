From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v3] input: keyboard: Add D-Link DIR-685 touchkeys
 driver
Date: Tue, 30 May 2017 09:40:21 -0700
Message-ID: <20170530164021.GB12922@dtor-ws>
References: <20170530120918.27357-1-linus.walleij@linaro.org>
 <20170530120918.27357-2-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35670 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdE3QkZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 May 2017 12:40:25 -0400
Received: by mail-it0-f53.google.com with SMTP id c15so44947382ith.0
        for <linux-input@vger.kernel.org>; Tue, 30 May 2017 09:40:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170530120918.27357-2-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org

Hi Linus,

On Tue, May 30, 2017 at 02:09:18PM +0200, Linus Walleij wrote:
> +	/*
> +	 * This key appears in the vendor driver, but I have
> +	 * not been able to provoke it.
> +	 */
> +	tk->codes[6] = KEY_O;

If there is no way to make the device produce this key, should we mark
is as KEY_RESERVED? KEY_O would not be suitable in any case, we'd need
to find more suitable keycode for whatever function is has.

If it is OK I can make the change locally.

Thanks.

-- 
Dmitry
