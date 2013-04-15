From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/2] input: st1232: Add reset pin handling
Date: Mon, 15 Apr 2013 10:48:03 -0700
Message-ID: <20130415174803.GA13157@core.coreip.homeip.net>
References: <1365630083-9758-1-git-send-email-hechtb+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1365630083-9758-1-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-input@vger.kernel.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 10, 2013 at 11:41:22PM +0200, Bastian Hecht wrote:
> We add the possiblity to hand over a GPIO number for the reset pin.
> This way we can remove existing board code that takes care of it and
> group this information properly in the platform data or in the device
> tree confguration.
> 
> The implementation is analogous to the cy8ctmg110 driver, thanks.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
> v3:
> - Based on Laurent Pinchart's patch:
>   input: st1232: Convert to devm_* infrastructure
> 
> - use gpio_valid()
> 
> - reorder probing for reset_gpio data

Applied both (but moved the file to include/linux/platform_data/).

Thanks.

-- 
Dmitry
