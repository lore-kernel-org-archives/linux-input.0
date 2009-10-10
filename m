From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH] input: New driver for Altera PS/2 controller
Date: Sat, 10 Oct 2009 18:24:16 +0800
Message-ID: <4AD060D0.7090502@wytron.com.tw>
References: <1254985152-32407-1-git-send-email-thomas@wytron.com.tw> <20091010045603.GA9914@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from msr12.hinet.net ([168.95.4.112]:62859 "EHLO msr12.hinet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbZJJKWw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Oct 2009 06:22:52 -0400
In-Reply-To: <20091010045603.GA9914@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Nios2 development list <nios2-dev@sopc.et.ntust.edu.tw>, linux-kernel@vger.kernel.org

On 10/10/2009 12:56 PM, Dmitry Torokhov wrote:
> Hi Thomas,
>
> On Thu, Oct 08, 2009 at 02:59:12PM +0800, Thomas Chou wrote:
>    
>> This patch adds a new SERIO driver to support the Altera University
>> Program PS/2 controller.
>>
>>      
> Thank you for the patch, it looks like it is reasonable written although
> it should do request_mem_region for the IO memory region it tries to
> remap and also IO addresses should not be cast to unsigned int but
> rather 'void __iomem *'. I also don;t see the reason for it to depend on
> EMBEDDED since the things that depend on EMBEDDED are usually features
> that are used almost by everyone and only in case of embedded arch you
> may want to turn them off to save some memory.
>
> I also prefer even static functions to have the driver name as their
> prefix - this way if I see a backtrace I know exactly which module is
> involved.
>
> I made a small patch on top of yours, please give it a try and if it did
> not break anything then I will fold it all together and queue for
> 2.6.33.
>
> Thanks!
>
>    
Hi Dmitry,

Thank you very much for your help. I have tested the updated driver with 
PS/2 keyboard and mouse on boards. They all worked well.

Cheers,
Thomas


