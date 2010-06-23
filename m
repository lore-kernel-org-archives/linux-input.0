From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] MAINTAINERS: Add an entry for the input MT protocol
Date: Thu, 24 Jun 2010 00:31:37 +0200
Message-ID: <4C228B49.5000408@euromail.se>
References: <1277330664-13884-1-git-send-email-rydberg@euromail.se> <1277332072.31591.92.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:33637 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753658Ab0FWWcR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jun 2010 18:32:17 -0400
In-Reply-To: <1277332072.31591.92.camel@Joe-Laptop.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Joe Perches wrote:
> On Thu, 2010-06-24 at 00:04 +0200, Henrik Rydberg wrote:
>> This patch adds a maintainer for the input multitouch (MT) protocol,
>> such that get_maintainer.pl selects it whenever an MT event is present
>> in the patch.
> 
>> +MULTITOUCH INPUT MT PROTOCOL
>> +M:	Henrik Rydberg <rydberg@euromail.se>
>> +L:	linux-input@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/input/multi-touch-protocol.txt
>> +K:	ABS_MT
> 
> That doesn't seem to match anything other than multitouch
> stuff, but it's probably best to specify the pattern as
> much as possible.
> 
> If you didn't know, K: entries can be entered as perl regex,
> so maybe something like:
> 
> K:	\b(ABS|SYN)_MT_
> 

Thanks for the info. However, since every application using the MT protocol by
necessity uses at least one event called ABS_MT*, it should be fine as is,
shouldn't it?

Henrik

