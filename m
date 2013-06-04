From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 12/19] iio & mfd & input: ti_tscadc: Match mfd sub
 devices to regmap interface
Date: Tue, 4 Jun 2013 13:05:32 +0200
Message-ID: <20130604110532.GJ1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-13-git-send-email-bigeasy@linutronix.de>
 <51AB84F5.2030405@kernel.org>
 <20130604102318.GC1151@linutronix.de>
 <F58DCC19-20B7-4385-B323-C1A2E5F22641@antoniou-consulting.com>
 <20130604105210.GI1151@linutronix.de>
 <4AA621AD-5273-444C-875C-05486CC810A8@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55130 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab3FDLFh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Jun 2013 07:05:37 -0400
Content-Disposition: inline
In-Reply-To: <4AA621AD-5273-444C-875C-05486CC810A8@antoniou-consulting.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Felipe Balbi <balbi@ti.com>

* Pantelis Antoniou | 2013-06-04 13:54:48 [+0300]:

>What make you think I am the original author?
Nothing, you just made _this_ patch.

>I just fixed whatever I had to fix to get it working.
Fair enough.

>Namely that the multi function device was using regmap in one place and
>not in another, which had the nice effect of the regmap cache getting out of sync.

Yeah, that is a pain. Currently I think why we do need regmap at all
here and I think about getting rid of it. Most of the values read here
need no caching at all.

>Regards
>
>-- Pantelis

Sebastian
