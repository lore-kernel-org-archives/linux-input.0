From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH 4/4] Input-gameport: Replace some printk() calls by
 pr_info() in joydump_connect()
Date: Sat, 24 Sep 2016 18:32:29 +0200
Message-ID: <8164eb48-e3fa-fa9d-6351-f14b595a6dc3@users.sourceforge.net>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
 <f486d64d-0759-9cd6-1e4e-df723acb6fea@users.sourceforge.net>
 <1474733610.23838.2.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:50996 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757480AbcIXQcj (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 24 Sep 2016 12:32:39 -0400
In-Reply-To: <1474733610.23838.2.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

>> @@ -57,27 +57,29 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
>>>  	unsigned long flags;
>>>  	unsigned char u;
>>  
>>> -	printk(KERN_INFO "joydump: ,------------------ START ----------------.\n");
>>> -	printk(KERN_INFO "joydump: | Dumping: %30s |\n", gameport->phys);
>>> -	printk(KERN_INFO "joydump: | Speed: %28d kHz |\n", gameport->speed);
>>> +	pr_info(",------------------ START ----------------.\n"
>>> +		"| Dumping: %30s |\n"
>>> +		"| Speed: %28d kHz |\n",
>>> +		gameport->phys,
>>> +		gameport->speed);
> 
> Not the same output.

Should the desired output be the same when the relevant data are passed by a single function call
(instead of three as before)?

Regards,
Markus
