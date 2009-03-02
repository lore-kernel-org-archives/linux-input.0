From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND] Input: wm97xx: add BTN_TOUCH event to wm97xx to
	use it with Android
Date: Mon, 2 Mar 2009 16:21:51 +0000
Message-ID: <20090302162151.GA24717@rakim.wolfsonmicro.main>
References: <49ABE938.8040502@compulab.co.il> <20090302142838.GA23342@rakim.wolfsonmicro.main> <49AC0677.7040102@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:50592 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754280AbZCBQVy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Mar 2009 11:21:54 -0500
Content-Disposition: inline
In-Reply-To: <49AC0677.7040102@compulab.co.il>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: dmitry.torokhov@gmail.com, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

On Mon, Mar 02, 2009 at 06:16:55PM +0200, Mike Rapoport wrote:

> Most touchscreen drivers already have BTN_TOUCH event generation:

Hrm, I'd found some other hits but I could well have been working on a
platform tree with additional drivers merged at the time.

> If there no objection I can make a similar patch for mainstone-wm97xx.c and ucb1400_ts.c

No problem for me.  Please see the other two accelerated WM97xx drivers
I posted today too.
