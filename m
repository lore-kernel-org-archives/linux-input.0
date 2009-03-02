From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND] Input: wm97xx: add BTN_TOUCH event to wm97xx to
	use it with Android
Date: Mon, 2 Mar 2009 14:28:39 +0000
Message-ID: <20090302142838.GA23342@rakim.wolfsonmicro.main>
References: <49ABE938.8040502@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58070 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751468AbZCBO2l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 09:28:41 -0500
Content-Disposition: inline
In-Reply-To: <49ABE938.8040502@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: dmitry.torokhov@gmail.com, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Mon, Mar 02, 2009 at 04:12:08PM +0200, Mike Rapoport wrote:
> Android expects BTN_TOUCH events when pen state changes. Add BTN_TOUCH
> event reporting to allow use of wm97xx touchscreen controller with
> Android devices.

> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'd still like to see more consistency over touchscreen drivers on this
one, BTW - if we're doing this it should be done for all touchscreen
drivers (either by updating the individual drivers or having the input
core do it).  This isn't the only touchscreen driver that doesn't do
BTN_TOUCH.
