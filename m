From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Patch 08/10] input: Touchscreen driver for the PCAP
Date: Mon, 7 Jul 2008 16:13:29 -0400
Message-ID: <20080707161212.ZZRA012@mailhub.coreip.homeip.net>
References: <20080707184000.411913919@datenfreihafen.org> <20080707184131.286622542@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:32416 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622AbYGGUNe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jul 2008 16:13:34 -0400
Received: by yx-out-2324.google.com with SMTP id 8so504820yxm.1
        for <linux-input@vger.kernel.org>; Mon, 07 Jul 2008 13:13:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080707184131.286622542@datenfreihafen.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: stefan@datenfreihafen.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-input@vger.kernel.org, Daniel Ribeiro <wyrm@openezx.org>

Hi Stefan,

On Mon, Jul 07, 2008 at 08:40:08PM +0200, stefan@datenfreihafen.org wrote:
> +
> +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +	input_set_abs_params(input_dev, ABS_X, X_AXIS_MIN, X_AXIS_MAX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, Y_AXIS_MIN, Y_AXIS_MAX, 0, 0);
> +	input_set_abs_params(input_dev, ABS_PRESSURE, PRESSURE_MIN,
> +			     PRESSURE_MAX, 0, 0);
> +
> +	input_register_device(pcap_ts->input);

Please add error handling here, otherwise looks good.

Thanks.

-- 
Dmitry
