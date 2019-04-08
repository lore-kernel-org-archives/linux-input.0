From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 4/6] MIPS: SGI-IP27: fix readb/writeb addressing
Date: Mon, 8 Apr 2019 16:58:34 +0200
Message-ID: <20190408145834.GO7480@piout.net>
References: <20190408142100.27618-1-tbogendoerfer@suse.de>
 <20190408142100.27618-5-tbogendoerfer@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190408142100.27618-5-tbogendoerfer@suse.de>
Sender: netdev-owner@vger.kernel.org
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Alessandro Zummo <a.zummo@towertech.it>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org, linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 08/04/2019 16:20:56+0200, Thomas Bogendoerfer wrote:
> diff --git a/drivers/rtc/rtc-m48t35.c b/drivers/rtc/rtc-m48t35.c
> index 0cf6507de3c7..05f0d91366af 100644
> --- a/drivers/rtc/rtc-m48t35.c
> +++ b/drivers/rtc/rtc-m48t35.c
> @@ -24,6 +24,16 @@
>  
>  struct m48t35_rtc {
>  	u8	pad[0x7ff8];    /* starts at 0x7ff8 */
> +#ifdef CONFIG_SGI_IP27
> +	u8	hour;
> +	u8	min;
> +	u8	sec;
> +	u8	control;
> +	u8	year;
> +	u8	month;
> +	u8	date;
> +	u8	day;
> +#else

I'm not sure why the RTC driver has to know about that. Shouldn't your
accessors be fixing that?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
