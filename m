From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 4/4] Input-gameport: Replace some printk() calls by
 pr_info() in joydump_connect()
Date: Sat, 24 Sep 2016 09:47:36 -0700
Message-ID: <1474735656.23838.6.camel@perches.com>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
         <f486d64d-0759-9cd6-1e4e-df723acb6fea@users.sourceforge.net>
         <1474733610.23838.2.camel@perches.com>
         <8164eb48-e3fa-fa9d-6351-f14b595a6dc3@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:52785 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757348AbcIXQrp (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 24 Sep 2016 12:47:45 -0400
In-Reply-To: <8164eb48-e3fa-fa9d-6351-f14b595a6dc3@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Sat, 2016-09-24 at 18:32 +0200, SF Markus Elfring wrote:
> > > @@ -57,27 +57,29 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
> > >  	unsigned long flags;
> > >  	unsigned char u;
> > 
> >  
> > > -	printk(KERN_INFO "joydump: ,------------------ START ----------------.\n");
> > > -	printk(KERN_INFO "joydump: | Dumping: %30s |\n", gameport->phys);
> > > -	printk(KERN_INFO "joydump: | Speed: %28d kHz |\n", gameport->speed);
> > > +	pr_info(",------------------ START ----------------.\n"
> > > +		"| Dumping: %30s |\n"
> > > +		"| Speed: %28d kHz |\n",
> > > +		gameport->phys,
> > > +		gameport->speed);
> 
> 
> > Not the same output.
> 
> 
> Should the desired output be the same when the relevant data are passed by a single function call
> (instead of three as before)?

Adding a singleton for a pr_fmt #define constant string and
updating the printk subsystem to prepend that constant string
to each use of a pr_<level> at runtime would be an improvement
as it could reduce constant data used by the format strings.

That would be a _real_ improvement.

Please try to implement something like that before submitting
more of these incorrect patches.

