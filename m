From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: Input-gameport: Replace some printk() calls by pr_info() in
 joydump_connect()
Date: Sat, 24 Sep 2016 19:20:48 +0200
Message-ID: <69699b11-88fb-93ea-24a2-9ff697b5f439@users.sourceforge.net>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
 <f486d64d-0759-9cd6-1e4e-df723acb6fea@users.sourceforge.net>
 <1474733610.23838.2.camel@perches.com>
 <8164eb48-e3fa-fa9d-6351-f14b595a6dc3@users.sourceforge.net>
 <20160924163912.GA40187@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:49923 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755556AbcIXRU7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 24 Sep 2016 13:20:59 -0400
In-Reply-To: <20160924163912.GA40187@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joe Perches <joe@perches.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

> The desired output should not be broken in conversion, which you did.

I dared to change another source code place a bit too much perhaps.


> Do you know how syslog works and why the transformation is not correct.

I imagine that there are chances to improve the software situation a bit more,
aren't there?


> I am also curious as to why you are patching joydump?

The discussed function implementation contains update candidates.

One of them was detected by the execution of a script for the semantic patch
language (Coccinelle software).
I identified further update possibilities after the opportunity for using
the function "kmalloc_array" also in this software module.


> Are you working on extending it?

I attempted just another software refactoring.

Regards,
Markus
