From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH v5 8/8] Loongson: YeeLoong: add hotkey driver
Date: Mon, 30 Nov 2009 13:18:15 +0800
Message-ID: <1259558295.5516.5.camel@falcon.domain.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
	 <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:55906 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbZK3FSh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 00:18:37 -0500
Received: by pxi26 with SMTP id 26so2303816pxi.21
        for <linux-input@vger.kernel.org>; Sun, 29 Nov 2009 21:18:43 -0800 (PST)
In-Reply-To: <739db9c7b5bab429d0df5a7c68f301aa12f1402d.1259414649.git.wuzhangjin@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com, linux-input@vger.kernel.org

On Sat, 2009-11-28 at 21:44 +0800, Wu Zhangjin wrote:
[...]
> +
> +static int camera_handler(int status)
> +{
> +	int value;
> +	static int camera_status;
> +
> +	status = !!status;
> +	camera_status = ec_read(REG_CAMERA_STATUS);
> +	if (status != camera_status) {
> +		value = ec_read(REG_CAMERA_CONTROL);
> +		ec_write(REG_CAMERA_CONTROL, value | (1 << 1));
> +	}
> +	return ec_read(REG_CAMERA_STATUS);
> +}

The above stuff is very awful, the camera event work as a switch, so
this is enough:

static int camera_handler(int status)
{
	int value;

	value = ec_read(REG_CAMERA_CONTROL);
	ec_write(REG_CAMERA_CONTROL, value | (1 << 1));

	return status;
}

[...]
> +/*
> + * SCI(system control interrupt) main interrupt routine
> + *
> + * We will do the query and get event number together so the interrupt routine
> + * should be longer than 120us now at least 3ms elpase for it.
> + */
> +static irqreturn_t sci_irq_handler(int irq, void *dev_id)
> +{
> +	int ret;
> +
> +	if (SCI_IRQ_NUM != irq)
> +		return IRQ_NONE;
> +
> +	/* Query the event number */
> +	ret = ec_query_event_num();
> +	if (ret < 0)
> +		return IRQ_NONE;
> +
> +	event = ec_get_event_num();
> +	if (event < 0)
> +		return IRQ_NONE;
> +
> +	if ((event != 0x00) && (event != 0xff)) {

It's better to use somethig else:

if (event >= EVENT_START && event <= EVENT_END) {
....

Best Regards,
	Wu Zhangjin

