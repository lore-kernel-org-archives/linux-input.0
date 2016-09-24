From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] Input-gameport: Replace some printk() calls by
 pr_info() in joydump_connect()
Date: Sat, 24 Sep 2016 09:39:12 -0700
Message-ID: <20160924163912.GA40187@dtor-ws>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
 <f486d64d-0759-9cd6-1e4e-df723acb6fea@users.sourceforge.net>
 <1474733610.23838.2.camel@perches.com>
 <8164eb48-e3fa-fa9d-6351-f14b595a6dc3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8164eb48-e3fa-fa9d-6351-f14b595a6dc3@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Joe Perches <joe@perches.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 24, 2016 at 06:32:29PM +0200, SF Markus Elfring wrote:
> >> @@ -57,27 +57,29 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
> >>>  	unsigned long flags;
> >>>  	unsigned char u;
> >>  
> >>> -	printk(KERN_INFO "joydump: ,------------------ START ----------------.\n");
> >>> -	printk(KERN_INFO "joydump: | Dumping: %30s |\n", gameport->phys);
> >>> -	printk(KERN_INFO "joydump: | Speed: %28d kHz |\n", gameport->speed);
> >>> +	pr_info(",------------------ START ----------------.\n"
> >>> +		"| Dumping: %30s |\n"
> >>> +		"| Speed: %28d kHz |\n",
> >>> +		gameport->phys,
> >>> +		gameport->speed);
> > 
> > Not the same output.
> 
> Should the desired output be the same when the relevant data are passed by a single function call
> (instead of three as before)?

The desired output should not be broken in conversion, which you did. Do
you know how syslog works and why the transformation is not correct.

I am also curious as to why you are patching joydump? Are you working on
extending it?

Thanks.

-- 
Dmitry
