From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH] input/mc13783-ts: add pdata to set conversion delay
Date: Mon, 20 Feb 2012 12:13:26 +0100
Message-ID: <20120220111326.GR5387@sortiz-mobl>
References: <1326269903-22180-1-git-send-email-michael.thalmeier@hale.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21592 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752192Ab2BTLGQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Feb 2012 06:06:16 -0500
Content-Disposition: inline
In-Reply-To: <1326269903-22180-1-git-send-email-michael.thalmeier@hale.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, michael@thalmeier.at

Hi Michael,

On Wed, Jan 11, 2012 at 09:18:23AM +0100, Michael Thalmeier wrote:
> MC13783 can be programmed to wait some clock cycles between the touch screen
> polarization and the resistance conversion. This is needed to adjust for
> touchscreens with high capacitance between plates.
I applied (manually) this one to my for-next branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
