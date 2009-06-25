From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] tsc2007: make platform callbacks optional
Date: Thu, 25 Jun 2009 14:23:44 -0700
Message-ID: <20090625142344.d7c5b72d.akpm@linux-foundation.org>
References: <4A40C28E.1070109@mocean-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45956 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751684AbZFYVXu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2009 17:23:50 -0400
In-Reply-To: <4A40C28E.1070109@mocean-labs.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard =?ISO-8859-1?Q?R=F6jfors?= <richard.rojfors.ext@mocean-labs.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kwangwoo.lee@gmail.com, thierry.reding@avionic-design.de, soni.trilok@gmail.com

On Tue, 23 Jun 2009 13:54:54 +0200
Richard R__jfors <richard.rojfors.ext@mocean-labs.com> wrote:

> The platform callbacks are only called if supplied. Makes the driver
> to fallback on only pressure calculation to decide when the pen is up.
> 

Again, I don't understand the reason for the change from the above
description.

Is there some driver in the tree which does not implement
->get_pendown_state()?  If so, it will oops, won't it?  Which driver is
that?

Or is there some other driver which you're developing which does not
implement ->get_pendown_state()?

If the latter, why should the problem be solved in this way, rather
than implementing an empty ->get_pendown_state() within that driver?

etc.   More details, please.
