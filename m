From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH v2 1/2] Input: Add DaVinci DM365 Keypad support
Date: Thu, 17 Sep 2009 13:27:16 -0600
Message-ID: <4AB28D94.2090401@ridgerun.com>
References: <1252951959-31015-1-git-send-email-miguel.aguilar@ridgerun.com>	<200909141145.48252.david-b@pacbell.net> <4AB276BF.9000807@ridgerun.com> <4AB2795D.2060900@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.navvo.net ([74.208.67.6]:44714 "EHLO mail.navvo.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbZIQT1W (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Sep 2009 15:27:22 -0400
In-Reply-To: <4AB2795D.2060900@ru.mvista.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: David Brownell <david-b@pacbell.net>, davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, linux-input@vger.kernel.org, santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com

Sergei,

Thanks for your response.

I have another question: When should I use dev_err and dev_dbg in a probe 
function, for reporting the errors (-ENOMEM, -ENODEV, -ENOMEM, etc)?

Thanks,

Miguel Aguilar
Sergei Shtylyov wrote:
> Hello.
> 
> Miguel Aguilar wrote:
> 
>> David,
> 
>    Though I'm not David, I'll reply... :-)
> 
>> What are the proper error codes when platform_get_resource,
> 
>    -ENODEV.
> 
>> request_mem_region
> 
>    -EBUSY.
> 
>> and ioremap functions fail?.
> 
>    -ENOMEM.
> 
> WBR, Sergei



