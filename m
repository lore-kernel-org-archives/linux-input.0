From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: Add a detailed multi-touch finger data report
 protocol
Date: Tue, 11 Nov 2008 12:19:26 +0100
Message-ID: <49196A3E.3050201@euromail.se>
References: <49142351.9080805@euromail.se> <20081111042009.GC6776@dingo.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:43699 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754767AbYKKLTl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Nov 2008 06:19:41 -0500
In-Reply-To: <20081111042009.GC6776@dingo.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Peter Hutterer wrote:

[...]

> is there hardware that can do finger identification? (i.e. thumb vs. index
> finger)? Should we accommodate for this?

I believe we should start with events that fit the general idea of
detailed finger information, and which can be produced by at least one
existing kernel driver, so that we can test it immediately. I believe
the proposed set pretty much covers it. I would love to be wrong. :-)

Regarding identification, one of the harder problems involved in
making use of finger data is that of matching an anonymous finger at a
certain position to an identified finger, tagged with a number.  This
is very important in order to know if the fingers moved, which finger
did the tapping, how much rotation was made, etc. Generally, this is
the (euclidian) bipartite matching problem, and is one of the major
computations a multi-touch X driver needs to perform. I can imagine
such identification features eventually ending up on a chip. Maybe
someone more knowledgeable in hardware can give us a hint.

