From: Alexander Shiyan <shc_work@mail.ru>
Subject: Re: [PATCH v3 RESEND 1/3] input: mc13783: Prepare driver to support
 MC13892 and OF
Date: Sat, 17 Aug 2013 10:53:05 +0400
Message-ID: <20130817105305.5201c078d4f2cf52ffb172f8@mail.ru>
References: <1376718381-16924-1-git-send-email-shc_work@mail.ru>
	<20130817062012.GA26693@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp12.mail.ru ([94.100.176.89]:38956 "EHLO smtp12.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752Ab3HQGxL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 17 Aug 2013 02:53:11 -0400
In-Reply-To: <20130817062012.GA26693@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <kernel@pengutronix.de>

On Sat, 17 Aug 2013 08:20:12 +0200
Michael Grzeschik <mgr@pengutronix.de> wrote:

> On Sat, Aug 17, 2013 at 09:46:20AM +0400, Alexander Shiyan wrote:
> > This patch is a preparation mc13xxx powerbutton driver to support
> > MC13892 and support the probe through the DT.
> 
> As this patch already mention by itself, it's doing to much at once.
> And by looking at it, it realy does more than it tells here.
> 
> Can you rework that into seperate readable tasks. In this patch you
> nearly rewrite the whole file. That runs the review impossible.

All changes in this patch are addicted to each other, can not be divided.
As an alternative, I can do all as a new driver.
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
