From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] Input: wm97xx: add BTN_TOUCH event to wm97xx to use it
 with Android
Date: Wed, 18 Feb 2009 09:29:41 +0200
Message-ID: <499BB8E5.9050801@compulab.co.il>
References: <1234863813-12211-1-git-send-email-mike@compulab.co.il> <20090217100246.GB16303@rakim.wolfsonmicro.main> <499AA29B.8090803@compulab.co.il> <20090217133028.GD16303@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cathcart.site5.com ([74.54.107.137]:48559 "EHLO
	cathcart.site5.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbZBRH3x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2009 02:29:53 -0500
In-Reply-To: <20090217133028.GD16303@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@slimlogic.co.uk, linux-input@vger.kernel.org



Mark Brown wrote:
> On Tue, Feb 17, 2009 at 01:42:19PM +0200, Mike Rapoport wrote:
> 
>> The difficulty here is to find out when BTN_TOUCH should be generated and what
>> should be its value. As far as I can see from different drivers, there's no
>> one-to-one correspondence between ABS_PRESSURE and BTN_TOUCH. For instance,
>> drivers/input/mouse/synaptics.c has
> 
> As a default it should be fine to check for zero/non-zero.  Anything
> that wants to override the behaviour could supply their own BTN_TOUCH.
> Another option would be to change Android user space to support pressure
> only touchscreens.

Android uses test_bit(BTN_TOUCH) to detect a touchscreen. So, adding generated
BTN_TOUCH event in the input core without changing the input_dev->keybit won't
help. And if we force BTN_TOUCH set in the input core there would be no way to
differentiate between devices that supply their own BTN_TOUCH and devices that
don't.
Apparently the most correct way would be to change Android touchscreen detection
and BTN_TOUCH/ABS_PRESSURE handling. But until it's done I'd prefer wm97xx to
report BTN_TOUCH :)

> Like I say, I'm fine with the patch itself so it's got my ack - it just
> feels like it fixes the problem at the wrong level.   From that PoV
> consider it to have
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 

-- 
Sincerely yours,
Mike.

