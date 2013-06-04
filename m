From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 05/19] input: ti_am335x_tsc: Add variance filters
Date: Tue, 4 Jun 2013 09:43:49 -0700
Message-ID: <20130604164345.GB26400@core.coreip.homeip.net>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-6-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64898 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab3FDQn6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Jun 2013 12:43:58 -0400
Content-Disposition: inline
In-Reply-To: <1369681926-22185-6-git-send-email-bigeasy@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>, Felipe Balbi <balbi@ti.com>, "Patil, Rachna" <rachna@ti.com>

Hi,

On Mon, May 27, 2013 at 09:11:52PM +0200, Sebastian Andrzej Siewior wrote:
> From: "Patil, Rachna" <rachna@ti.com>
> 
> Only fine tuning variance present in tslib utility
> does not help in removing all the wanted ADC noise.
> 
> This logic of filtering is necessary to get this
> touchscreen to work finely.

So why do not we enhancing tslib so that it is useful for more
touchscreen?

FWIW I have been asking this question from the very beginning of this
driver being submitted.

-- 
Dmitry
