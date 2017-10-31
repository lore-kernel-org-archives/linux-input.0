From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: st1232 - Remove obsolete platform device support
Date: Tue, 31 Oct 2017 10:01:19 -0700
Message-ID: <20171031170119.yz3trextrsdjb7ay@dtor-ws>
References: <1507801275-12668-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:44099 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753298AbdJaRBX (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 31 Oct 2017 13:01:23 -0400
Content-Disposition: inline
In-Reply-To: <1507801275-12668-1-git-send-email-geert+renesas@glider.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-input@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Thu, Oct 12, 2017 at 11:41:15AM +0200, Geert Uytterhoeven wrote:
> Commit 1fa59bda21c7fa36 ("ARM: shmobile: Remove legacy board code for
> Armadillo-800 EVA"), removed the last user of st1232_pdata and the
> "st1232-ts" platform device.  All remaining users use DT.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Sorry, this got stuck in gmail SPAM folder for some reason...

Applied, thank you.

...

> +	ts->reset_gpio = of_get_gpio(client->dev.of_node, 0);
>  	if (gpio_is_valid(ts->reset_gpio)) {
>  		error = devm_gpio_request(&client->dev, ts->reset_gpio, NULL);
>  		if (error) {

I wonder if we can convert it to gpiod API?

Thanks.

-- 
Dmitry
