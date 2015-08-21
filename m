From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/1] cap11xx: add runtime PM support
Date: Thu, 20 Aug 2015 17:37:43 -0700
Message-ID: <20150821003743.GA24710@localhost>
References: <1439947289-10750-1-git-send-email-mranostay@gmail.com>
 <1439947289-10750-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34848 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbbHUAhr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 20:37:47 -0400
Received: by pacdd16 with SMTP id dd16so30910891pac.2
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 17:37:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1439947289-10750-2-git-send-email-mranostay@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Matt,

On Tue, Aug 18, 2015 at 06:21:29PM -0700, Matt Ranostay wrote:
>  
> +static int cap11xx_i2c_remove(struct i2c_client *i2c_client)
> +{
> +	struct cap11xx_priv *priv = i2c_get_clientdata(i2c_client);
> +
> +	cap11xx_set_sleep(priv, true);
> +	pm_runtime_disable(&i2c_client->dev);
> +	pm_runtime_set_suspended(&i2c_client->dev);

As I mentioned in my previous review:

> This violates ordering: the leds and input device are still open and
> may get requests while you are putting the device to sleep.

Thanks.

-- 
Dmitry
