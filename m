From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/4] input: misc: introduce Atmel PTC driver
Date: Mon, 3 Apr 2017 17:58:40 +0200
Message-ID: <20170403155840.vln4wg56iunrmdcw@piout.net>
References: <20170331152250.12758-1-ludovic.desroches@microchip.com>
 <20170331152250.12758-2-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170331152250.12758-2-ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 31/03/2017 at 17:22:47 +0200, Ludovic Desroches wrote:
> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

I think you probably want to switch to your microchip email.

Also, this requires a proper commit message.

> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> +struct atmel_ptc {
> +	void __iomem		*ppp_regs;
> +	void __iomem		*firmware;
> +	int			irq;
> +	uint8_t			imr;
> +	volatile struct atmel_qtm_mailbox __iomem	*qtm_mb;
> +	struct clk		*clk_per;
> +	struct clk		*clk_int_osc;
> +	struct clk		*clk_slow;
> +	struct device		*dev;
> +	struct completion	ppp_ack;
> +	unsigned int		button_keycode[ATMEL_PTC_MAX_NODES];
> +	struct input_dev	*buttons_input;
> +	struct input_dev	*scroller_input[ATMEL_PTC_MAX_SCROLLERS];
> +	bool			buttons_registered;
> +	bool			scroller_registered[ATMEL_PTC_MAX_SCROLLERS];
> +	uint32_t		button_event[ATMEL_PTC_MAX_NODES/32];
> +	uint32_t		button_state[ATMEL_PTC_MAX_NODES/32];
> +	uint32_t		scroller_event;
> +	uint32_t		scroller_state;

You should use u8, u16 and u32 instead of uint8_t, uint16_t and
uint32_t.

> diff --git a/include/uapi/linux/atmel_ptc.h b/include/uapi/linux/atmel_ptc.h
> new file mode 100644
> index 0000000..d15c4df
> --- /dev/null
> +++ b/include/uapi/linux/atmel_ptc.h


Is there any sample application showing how to configure the PTC?


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
