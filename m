From: =?ISO-8859-1?Q?Richard_R=F6jfors?=
	<richard.rojfors.ext@mocean-labs.com>
Subject: Re: [PATCH 2/2] tsc2007: make platform callbacks optional
Date: Thu, 09 Jul 2009 18:03:35 +0200
Message-ID: <4A5614D7.8050107@mocean-labs.com>
References: <4A40C28E.1070109@mocean-labs.com> <20090625142344.d7c5b72d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from av7-1-sn3.vrr.skanova.net ([81.228.9.181]:52707 "EHLO
	av7-1-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759877AbZGIQDn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2009 12:03:43 -0400
In-Reply-To: <20090625142344.d7c5b72d.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kwangwoo.lee@gmail.com, thierry.reding@avionic-design.de, soni.trilok@gmail.com

On 6/25/09 11:23 PM, Andrew Morton wrote:
> On Tue, 23 Jun 2009 13:54:54 +0200
> Richard R__jfors<richard.rojfors.ext@mocean-labs.com>  wrote:
>
>> The platform callbacks are only called if supplied. Makes the driver
>> to fallback on only pressure calculation to decide when the pen is up.
>>
>
> Again, I don't understand the reason for the change from the above
> description.
>
> Is there some driver in the tree which does not implement
> ->get_pendown_state()?  If so, it will oops, won't it?  Which driver is
> that?
>
> Or is there some other driver which you're developing which does not
> implement ->get_pendown_state()?
>
> If the latter, why should the problem be solved in this way, rather
> than implementing an empty ->get_pendown_state() within that driver?

On the board I'm currently writing drivers for we don't have any chance 
of getting the pendown state, we have to trust the touch controller, 
(which is not very accurate in all cases).

So we can not implement a dummy function, because there is no dummy 
default value to return. In that case the function must also do I2C 
calls to the touch controller, which is the responsibility of this driver.

--Richard
