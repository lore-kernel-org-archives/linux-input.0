From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ims-pcu - fix error unwinding path in application
 mode
Date: Fri, 3 Jan 2014 21:29:33 -0800
Message-ID: <20140104052933.GA32576@core.coreip.homeip.net>
References: <20140104050058.GA20652@core.coreip.homeip.net>
 <CAHQ1cqGZT7TOCX+5yPhWt1MpsSbAfbr07SProgSxrn7RO=7aig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:57259 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbaADF3g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jan 2014 00:29:36 -0500
Content-Disposition: inline
In-Reply-To: <CAHQ1cqGZT7TOCX+5yPhWt1MpsSbAfbr07SProgSxrn7RO=7aig@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-input@vger.kernel.org, Chris Healy <chealy@imsco-us.com>, linux-kernel@vger.kernel.org

On Fri, Jan 03, 2014 at 09:13:10PM -0800, Andrey Smirnov wrote:
> Dmitry,
> 
> Do you want this patch to go separatly or do you want me to bundle it
> with my other changes(probably the first one)?

I'll apply it separately.

> Also, offtopic, do you want me to backport this changes to 2.6 kernel
> that IMS uses or would you do it?

It should apply as is, no backport needed as far as I can tell.

-- 
Dmitry
