From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: ad7879: split bus logic out
Date: Tue, 19 Jan 2010 00:26:52 -0800
Message-ID: <20100119082652.GA19338@core.coreip.homeip.net>
References: <1263742686-22305-1-git-send-email-vapier@gentoo.org>
 <1263876764-6464-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:44567 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab0ASI06 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2010 03:26:58 -0500
Received: by pwj9 with SMTP id 9so2250979pwj.21
        for <linux-input@vger.kernel.org>; Tue, 19 Jan 2010 00:26:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1263876764-6464-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

Hi Mike,

On Mon, Jan 18, 2010 at 11:52:44PM -0500, Mike Frysinger wrote:
> The ad7879 driver is using the old bus method of only supporting one at a
> time (I2C or SPI).  So refactor it like the other input drivers that
> support multiple busses simultaneously.
> 

Nice patch, thank you. A couple of suggestions though:

> -
>  struct ad7879 {
> -	bus_device		*bus;
> +	struct ad7879_bus_ops	bops;

Could you change it to 'const struct ad7879_bus_ops *bops;' and add a
separate pointer to private transport data so that bus ops are truly
shared between instances (if any).

>  	struct input_dev	*input;
>  	struct work_struct	work;
>  	struct timer_list	timer;

Also I dont see the reason for having the following typedefs:

> +
> +typedef int (ad7879_read_t) (void *bus_data, u8 reg);
> +typedef int (ad7879_multi_read_t) (void *bus_data, u8 first_reg, u8 count, u16 *buf);
> +typedef int (ad7879_write_t) (void *bus_data, u8 reg, u16 val);
> +
> +struct ad7879_bus_ops {
> +	void *bus_data;
> +	int irq;
> +	ad7879_read_t *read;
> +	ad7879_multi_read_t *multi_read;
> +	ad7879_write_t *write;
> +};
> +
> +int ad7879_disable(struct device *dev);
> +int ad7879_enable(struct device *dev);
> +int ad7879_probe(struct device *dev, struct ad7879_bus_ops *bops, u8 devid, u16 bustype);
> +int ad7879_remove(struct device *dev);

Hmm, I liked when these accepted "struct ad7879" better.

Thanks.

-- 
Dmitry
