From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 07/18] Input: cap11xx - simplify function return logic
Date: Fri, 2 Oct 2015 20:17:41 +0200
Message-ID: <560ECA45.30700@osg.samsung.com>
References: <1443793229-22363-1-git-send-email-javier@osg.samsung.com>
 <1443793229-22363-8-git-send-email-javier@osg.samsung.com>
 <20151002180926.GH8437@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:47090 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbbJBSRt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Oct 2015 14:17:49 -0400
In-Reply-To: <20151002180926.GH8437@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Daniel Mack <linux@zonque.org>, linux-input@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

Hello Dmitry,

On 10/02/2015 08:09 PM, Dmitry Torokhov wrote:

[snip]

>>  
>> -	error = devm_request_threaded_irq(dev, irq, NULL, cap11xx_thread_func,
>> -					  IRQF_ONESHOT, dev_name(dev), priv);
>> -	if (error)
>> -		return error;
>> -
>> -	return 0;
>> +	return devm_request_threaded_irq(dev, irq, NULL, cap11xx_thread_func,
>> +					 IRQF_ONESHOT, dev_name(dev), priv);
>>  }
> 
> For cases where we have multiple of potentially failing actions:
> 
> 	error = action1();
> 	if (error)
> 		return error;
> 
> 	error = action2();
> 	if (error)
> 		return error;
> 
> 	error = action3();
> 	if (error)
> 		return error;
> 
> 	return 0;
> 
> I prefer not to compress the last action check to "return action3()".
> 

Fair enough, I don't mind if you drop those patches then.
Thanks a lot for your feedback.

> Thanks.
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
