From: Peter Rusko <rusko.peter@prolan.hu>
Subject: Re: [PATCH] matrix_keypad: convert to threaded IRQs
Date: Wed, 4 Apr 2012 09:40:46 +0200
Message-ID: <4F7BFAFE.4020809@prolan.hu>
References: <1333440600-4183-1-git-send-email-rusko.peter@prolan.hu> <20120403163706.GA24832@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fw2.prolan.hu ([193.68.50.107]:34006 "EHLO fw2.prolan.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab2DDHks (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Apr 2012 03:40:48 -0400
In-Reply-To: <20120403163706.GA24832@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yong Zhang <yong.zhang0@gmail.com>, w.sang@pengutronix.de, linux-input@vger.kernel.org

On 2012-04-03 18:37, Dmitry Torokhov wrote:
> On Tue, Apr 03, 2012 at 10:10:00AM +0200, Peter Rusko wrote:
>> Tested on Ka-Ro TX28 SOC
>
> Needs justification; plus this is not how debounce works - you need to
> postpone scan until IRQ line settles, not simply wait so many
> milliseconds.
What is the difference there? The previous driver has the same effect,
it used a delayed work to wait:

	if (unlikely(keypad->scan_pending || keypad->stopped))
		goto out;

	disable_row_irqs(keypad);
	keypad->scan_pending = true;
	schedule_delayed_work(&keypad->work,
		msecs_to_jiffies(keypad->pdata->debounce_ms));

Are you saying that I should reschedule the scan every time an interrupt
arrives (before the 'goto out' line) and decrease timeout?

>
> I think what you really need is request_any_context_irq().
In that case, I'll have to get back to delayed work.

Peter
