From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: Input-gameport: Replace some printk() calls by pr_info() in
 joydump_connect()
Date: Sat, 24 Sep 2016 21:50:54 +0200
Message-ID: <fd0413a5-d181-8ee1-37bb-f47cc8a7ac45@users.sourceforge.net>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
 <f486d64d-0759-9cd6-1e4e-df723acb6fea@users.sourceforge.net>
 <1474733610.23838.2.camel@perches.com>
 <8164eb48-e3fa-fa9d-6351-f14b595a6dc3@users.sourceforge.net>
 <1474735656.23838.6.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:64378 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965050AbcIXTvD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 24 Sep 2016 15:51:03 -0400
In-Reply-To: <1474735656.23838.6.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

>> Should the desired output be the same when the relevant data are passed by a single function call
>> (instead of three as before)?
> 
> Adding a singleton for a pr_fmt #define constant string and
> updating the printk subsystem to prepend that constant string
> to each use of a pr_<level> at runtime would be an improvement
> as it could reduce constant data used by the format strings.

Thanks for for this constructive feedback.


> That would be a _real_ improvement.

This sounds interesting for me too.


> Please try to implement something like that before submitting
> more of these incorrect patches.

Nice wish!

Did any other software developer try to implement such enhanced
logging functionality already?

Regards,
Markus
