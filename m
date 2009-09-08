From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input driverfor button/scrollwhell/slider/touchpad
Date: Tue, 8 Sep 2009 14:48:34 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04B1115C@chinexm1.ad.analog.com>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com><1251777330-16994-2-git-send-email-21cnbao@gmail.com><1251777330-16994-3-git-send-email-21cnbao@gmail.com> <20090908070811.BE709526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:6399 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbZIHGsg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Sep 2009 02:48:36 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20090908070811.BE709526EC9@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Barry Song <21cnbao@gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, dbrownell@users.sourceforge.net, uclinux-dist-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

 

>-----Original Message-----
>From: uclinux-dist-devel-bounces@blackfin.uclinux.org 
>[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On 
>Behalf Of Dmitry Torokhov
>Sent: Tuesday, September 08, 2009 2:35 PM
>To: Barry Song
>Cc: spi-devel-general@lists.sourceforge.net; 
>dbrownell@users.sourceforge.net; 
>uclinux-dist-devel@blackfin.uclinux.org; linux-input@vger.kernel.org
>Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] add ad714x input 
>driverfor button/scrollwhell/slider/touchpad
>
>Hi,
>
>On Tue, Sep 01, 2009 at 11:55:30AM +0800, Barry Song wrote:
>> ad7142/ad7147 are Programmable Controllers for Capacitance 
>Touch Sensors.
>> The chips don't restrict the specific usage, and it can be 
>used as button/
>> slider/scrollwheel/touchpad etc. depending on the hardware 
>connection.
>> One special target board can include one or several these components.
>> 
>> The driver is independent of special boards. It gets the components
>> layout information from the platform_data, registers related devices,
>> fullfills the algorithms and state machines for these components and
>> report related input events to up level.
>> 
>
>There were already quite a few comments, I will just add:
>
>> +			if (h_state) {
>> +				slider_cal_sensor_val(ad714x, idx);
>> +				slider_cal_highest_stage(ad714x, idx);
>> +				slider_cal_abs_pos(ad714x, idx);
>> +				slider_cal_flt_pos(ad714x, idx);
>> +
>> +				input_report_abs(sw->input, 
>ABS_X, sw->flt_pos);
>> +				input_report_abs(sw->input, 
>ABS_PRESSURE, 1);
>
>The driver does not seem to report true pressure so please don't fake
>ABS_PRESSURE. You probably want to return BTN_TOUCH here,
Fixed
>
>Also, what about vertical sliders? I also wonder if slider 
Sliders are only single-dimensional. Is it necessary to report vertical
slider as ABS_Y and horizontal slider as ABS_X? 
>
>> +fail_irq:
>> +fail_alloc_reg:
>> +	for (i = 0; i < reg_idx; i++)
>> +		input_unregister_device(input[i]);
>> +	for (i = 0; i < alloc_idx; i++)
>> +		input_free_device(input[i]);
>
>No callls to input_free_device after input_unregister_device.
Fixed.
>
>-- 
>Dmitry
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel@blackfin.uclinux.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
