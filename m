From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH 0/5] WM97xx updates
Date: Wed, 04 Mar 2009 12:29:03 +0100
Message-ID: <49AE65FF.2060309@atmel.com>
References: <20090303182402.GA29542@rakim.wolfsonmicro.main> <20090304091538.GD7394@dtor-d630.eng.vmware.com> <49AE492F.6020006@atmel.com> <20090304105358.GA32107@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay.atmel.no ([80.232.32.139]:56381 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903AbZCDL3W (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2009 06:29:22 -0500
In-Reply-To: <20090304105358.GA32107@rakim.wolfsonmicro.main>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>

Mark Brown wrote:
> On Wed, Mar 04, 2009 at 10:26:07AM +0100, Hans-Christian Egtvedt wrote:
> 
>> The only thing catched by review was a leaking irq line, do you plan to  
>> fixup that Mark?
> 
> Jiri also had some further comments from the initial posting (mail
> attached).  I can probably try to fix up most things blind but I'll need
> to at least set up an at32 toolchain to build test.  The workqueue thing
> might be better to test on hardware, though, just in case there's some
> noticable performance impact.  I wouldn't expect so but it'd be safer.
> 

I'll see what I can manage to squeeze in of testing, there is always the 
in-between-time.

What is this patch based against? Linus tree, master branch?

-- 
Best regards,
Hans-Christian Egtvedt
