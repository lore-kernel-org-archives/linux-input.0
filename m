From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 1/1] input: ideapad_slidebar: new input driver
Date: Tue, 20 Aug 2013 12:45:27 -0700
Message-ID: <20130820194527.GA22595@core.coreip.homeip.net>
References: <520DCDA5.8090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32923 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab3HTTpc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Aug 2013 15:45:32 -0400
Content-Disposition: inline
In-Reply-To: <520DCDA5.8090001@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Moiseev <o2g.org.ru@gmail.com>
Cc: linux-input@vger.kernel.org, arnoques@gmail.com, russianneuromancer@ya.ru, ike.pan@canonical.com, linux-kernel@vger.kernel.org

Hi Andrey,

On Fri, Aug 16, 2013 at 10:58:45AM +0400, Andrey Moiseev wrote:
> v7: fixed things addressed by Dmitry Torokhov to v7 (quoted message goes below the patch)
> 

This looks almost perfect, I have just one question:

> +static bool slidebar_i8042_filter(unsigned char data, unsigned char str,
> +				struct serio *port)
> +{
> +	static bool extended = false;
> +
> +	/* Scancodes: e03b on move, e0bb on release */
> +	if (unlikely(data == 0xe0)) {
> +		extended = true;
> +		return false;
> +	} else if (unlikely(extended && (data == 0x3b))) {
> +		extended = false;
> +		input_report_key(slidebar_input_dev, BTN_TOUCH, 1);
> +		input_report_abs(slidebar_input_dev, ABS_X, slidebar_pos_get());
> +		input_sync(slidebar_input_dev);
> +		return false;
> +	} else if (unlikely(extended && (data == 0xbb))) {
> +		input_report_key(slidebar_input_dev, BTN_TOUCH, 0);
> +		input_sync(slidebar_input_dev);

Don't you need to reset 'extended" here as well?

-- 
Dmitry
