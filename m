From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/mfd/ucb1400: move static function from header to
	its user
Date: Sun, 11 Jan 2009 23:47:38 -0800
Message-ID: <20090111234716.ZZRA012@mailhub.coreip.homeip.net>
References: <20090108110757.GB24243@www.tglx.de> <200901081323.55398.marek.vasut@gmail.com> <4965F2A9.3060208@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:23616 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbZALHsS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 02:48:18 -0500
Received: by qw-out-2122.google.com with SMTP id 3so9561733qwe.37
        for <linux-input@vger.kernel.org>; Sun, 11 Jan 2009 23:48:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4965F2A9.3060208@linutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-input@vger.kernel.org

On Thu, Jan 08, 2009 at 01:33:45PM +0100, Sebastian Andrzej Siewior wrote:
> Marek Vasut wrote:
>> On Thursday 08 of January 2009 12:07:57 Sebastian Andrzej Siewior wrote:
>>> it's a little too large for static line and just static is somehow ....
>>>
>>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>> ---
>>> The only user I've seen is ts driver.
>>
>> NAK, this is used by the battery as well (which is not merged yet, see 
>> ARM linux mailing list for it)
>
> It is not merged :) And this also in .v28.
> Would you prefer me to move this function into the core instead ?
>

Yes, core seems to be more appropriate.

Thanks.

-- 
Dmitry
