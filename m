From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] input/mfd/ucb1400: move static function from header to
 its user
Date: Thu, 08 Jan 2009 13:33:45 +0100
Message-ID: <4965F2A9.3060208@linutronix.de>
References: <20090108110757.GB24243@www.tglx.de> <200901081323.55398.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:56289 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732AbZAHMdu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Jan 2009 07:33:50 -0500
In-Reply-To: <200901081323.55398.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org

Marek Vasut wrote:
> On Thursday 08 of January 2009 12:07:57 Sebastian Andrzej Siewior wrote:
>> it's a little too large for static line and just static is somehow ....
>>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>> The only user I've seen is ts driver.
> 
> NAK, this is used by the battery as well (which is not merged yet, see ARM 
> linux mailing list for it)

It is not merged :) And this also in .v28.
Would you prefer me to move this function into the core instead ?

Sebastian

