From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 05/19] input: ti_am335x_tsc: Add variance filters
Date: Tue, 4 Jun 2013 18:54:17 +0200
Message-ID: <20130604165417.GK1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-6-git-send-email-bigeasy@linutronix.de>
 <20130604164345.GB26400@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56866 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756055Ab3FDQyS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Jun 2013 12:54:18 -0400
Content-Disposition: inline
In-Reply-To: <20130604164345.GB26400@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>, Felipe Balbi <balbi@ti.com>, "Patil, Rachna" <rachna@ti.com>

* Dmitry Torokhov | 2013-06-04 09:43:49 [-0700]:

>Hi,
Hi Dmitry,

>On Mon, May 27, 2013 at 09:11:52PM +0200, Sebastian Andrzej Siewior wrote:
>> From: "Patil, Rachna" <rachna@ti.com>
>> 
>> Only fine tuning variance present in tslib utility
>> does not help in removing all the wanted ADC noise.
>> 
>> This logic of filtering is necessary to get this
>> touchscreen to work finely.
>
>So why do not we enhancing tslib so that it is useful for more
>touchscreen?

I am reworking the series and dropped this patch. I think it got added
because the driver currently mixes up sometimes some of the Y & Z
coordinates. So I check how it behaves and if required I try to push to
tslib if still required. I doubt someone is using this directly on the
eventX node.

>FWIW I have been asking this question from the very beginning of this
>driver being submitted.

I'm sorry. I'm currently trying to get the three pieces of the driver
(mfd, touch, iio) into shape. If there is anything please let me know.

Sebastian
