From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] add ad714x input driver for
	button/scrollwhell/slider/touchpad
Date: Mon, 7 Sep 2009 23:34:48 -0700
Message-ID: <20090908070811.BE709526EC9@mailhub.coreip.homeip.net>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com> <1251777330-16994-2-git-send-email-21cnbao@gmail.com> <1251777330-16994-3-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.211.173]:55612 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbZIHGev (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2009 02:34:51 -0400
Received: by ywh3 with SMTP id 3so4556656ywh.22
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2009 23:34:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1251777330-16994-3-git-send-email-21cnbao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: dbrownell@users.sourceforge.net, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

Hi,

On Tue, Sep 01, 2009 at 11:55:30AM +0800, Barry Song wrote:
> ad7142/ad7147 are Programmable Controllers for Capacitance Touch Sensors.
> The chips don't restrict the specific usage, and it can be used as button/
> slider/scrollwheel/touchpad etc. depending on the hardware connection.
> One special target board can include one or several these components.
> 
> The driver is independent of special boards. It gets the components
> layout information from the platform_data, registers related devices,
> fullfills the algorithms and state machines for these components and
> report related input events to up level.
> 

There were already quite a few comments, I will just add:

> +			if (h_state) {
> +				slider_cal_sensor_val(ad714x, idx);
> +				slider_cal_highest_stage(ad714x, idx);
> +				slider_cal_abs_pos(ad714x, idx);
> +				slider_cal_flt_pos(ad714x, idx);
> +
> +				input_report_abs(sw->input, ABS_X, sw->flt_pos);
> +				input_report_abs(sw->input, ABS_PRESSURE, 1);

The driver does not seem to report true pressure so please don't fake
ABS_PRESSURE. You probably want to return BTN_TOUCH here,

Also, what about vertical sliders? I also wonder if slider 

> +fail_irq:
> +fail_alloc_reg:
> +	for (i = 0; i < reg_idx; i++)
> +		input_unregister_device(input[i]);
> +	for (i = 0; i < alloc_idx; i++)
> +		input_free_device(input[i]);

No callls to input_free_device after input_unregister_device.

-- 
Dmitry
