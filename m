From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] Input: wm97xx: add BTN_TOUCH event to wm97xx to use it
 with Android
Date: Tue, 17 Feb 2009 13:42:19 +0200
Message-ID: <499AA29B.8090803@compulab.co.il>
References: <1234863813-12211-1-git-send-email-mike@compulab.co.il> <20090217100246.GB16303@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cathcart.site5.com ([74.54.107.137]:55801 "EHLO
	cathcart.site5.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbZBQLmX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Feb 2009 06:42:23 -0500
In-Reply-To: <20090217100246.GB16303@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@slimlogic.co.uk, linux-input@vger.kernel.org

Mark Brown wrote:
> On Tue, Feb 17, 2009 at 11:43:33AM +0200, Mike Rapoport wrote:
>> Please CC me, I'm not subscribed to linux-input
> 
>> Android expects BTN_TOUCH events when pen state changes. Add BTN_TOUCH
>> event reporting to allow use of wm97xx touchscreen controller wiht
>> Android devices.
> 
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> 
> Hrm.  While this is obviously fine from a code point of view it seems
> like it'd be better to synthesise the BTN_TOUCH events in the input core
> if we want to do this - that way all drivers will behave consistently.
> 

The difficulty here is to find out when BTN_TOUCH should be generated and what
should be its value. As far as I can see from different drivers, there's no
one-to-one correspondence between ABS_PRESSURE and BTN_TOUCH. For instance,
drivers/input/mouse/synaptics.c has

	if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
	if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);

	if (hw.z > 0) {
		input_report_abs(dev, ABS_X, hw.x);
		input_report_abs(dev, ABS_Y, YMAX_NOMINAL + YMIN_NOMINAL - hw.y);
	}
	input_report_abs(dev, ABS_PRESSURE, hw.z);

-- 
Sincerely yours,
Mike.

