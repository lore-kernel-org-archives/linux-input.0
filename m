From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH 4/4] Input-gameport: Replace some printk() calls by
 pr_info() in joydump_connect()
Date: Sat, 24 Sep 2016 18:41:37 +0200
Message-ID: <031de9c0-2e54-a6e4-3b61-73ce523bb769@users.sourceforge.net>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
 <f486d64d-0759-9cd6-1e4e-df723acb6fea@users.sourceforge.net>
 <1474733610.23838.2.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <1474733610.23838.2.camel@perches.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

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

Do you insist that each line from a multi-line text that is passed by such a single logging call
contains the same module prefix?

Regards,
Markus
