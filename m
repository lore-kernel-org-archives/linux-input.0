From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH v5] Fix the resolution issue in ChromeOS
Date: Mon, 1 Jun 2015 20:18:29 +0200
Message-ID: <20150601181829.GB4469@bugger.home>
References: <1432873649-32484-1-git-send-email-hn.chen@weidahitech.com>
 <CAH6sp9Ny3onDBaGEGUUGUMioG4OAiwy5RxantCjEqrYy-Qdcsw@mail.gmail.com>
 <1A63A1423E772B419A9D2E882CBCF6C401F3DB61@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34559 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbbFASRy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jun 2015 14:17:54 -0400
Content-Disposition: inline
In-Reply-To: <1A63A1423E772B419A9D2E882CBCF6C401F3DB61@mail>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hn Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Jun 02, 2015 at 12:39:13AM +0800, Hn Chen wrote:
> Hi, Klaver,
> 
> Sorry for replying late and thanks for your opinion !
> 
> About the patch descrition, I will follow your suggestion and 

Ok. More on this is in Documentation/SubmittingPatches.

> maybe add more commemts between codes to be easy to read.

Only where really necessary. If you do, explain _why_ you do stuff,
rather than how. The how is already in the code. If how isn't clear
enough, clear up the code instead.

> >Are these (and other) delay times based on datasheet values?
> The time consuming is about the computing power of WDT87xx's controller.
> The value is from the algorithm/firmware engineer of wdt87xx.
> They think it is reasonable value to wait the controller to finish the computing.

Alright, I was just wondering. Seems like a waste to be waiting for
something that's already finished ;-). There's of course a risk that
times may fluctuate between firmware versions. Did you take that into
account in the code? Or is there a hard maximum time for these
operations defined for the firmware?

> For the rest parts, I'll just follow your opinion to modify them.
> 
> Best Regards,
> hn.chen
> 

Thanks,
Frans
