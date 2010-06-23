From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Add an entry for the input MT protocol
Date: Wed, 23 Jun 2010 15:27:52 -0700
Message-ID: <1277332072.31591.92.camel@Joe-Laptop.home>
References: <1277330664-13884-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.perches.com ([173.55.12.10]:1260 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939Ab0FWW1z (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jun 2010 18:27:55 -0400
In-Reply-To: <1277330664-13884-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Thu, 2010-06-24 at 00:04 +0200, Henrik Rydberg wrote:
> This patch adds a maintainer for the input multitouch (MT) protocol,
> such that get_maintainer.pl selects it whenever an MT event is present
> in the patch.

> +MULTITOUCH INPUT MT PROTOCOL
> +M:	Henrik Rydberg <rydberg@euromail.se>
> +L:	linux-input@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/input/multi-touch-protocol.txt
> +K:	ABS_MT

That doesn't seem to match anything other than multitouch
stuff, but it's probably best to specify the pattern as
much as possible.

If you didn't know, K: entries can be entered as perl regex,
so maybe something like:

K:	\b(ABS|SYN)_MT_


