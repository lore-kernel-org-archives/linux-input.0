From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 22/22] input: ads7846: introduce platform specific way
	to synchronize sampling
Date: Sat, 14 Mar 2009 12:55:11 +0000
Message-ID: <20090314125510.GA11560@sirena.org.uk>
References: <200903041959.n24JxDIQ028495@imap1.linux-foundation.org> <F71A24FDAED97E4CB6D3A8E8A97D5C544A38E1D6@SC-VEXCH1.marvell.com> <f17812d70903121950h768fb7d0t234e040f34656f0c@mail.gmail.com> <200903131809.40400.david-b@pacbell.net> <f17812d70903132041u5df5d6f7u9cc9577d2dc95a60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1093 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbZCNMze (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Mar 2009 08:55:34 -0400
Content-Disposition: inline
In-Reply-To: <f17812d70903132041u5df5d6f7u9cc9577d2dc95a60@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Eric Miao <ymiao3@marvell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sat, Mar 14, 2009 at 11:41:58AM +0800, Eric Miao wrote:
> On Sat, Mar 14, 2009 at 9:09 AM, David Brownell <david-b@pacbell.net>=
 wrote:

> > yeech! =A0It would be a Good Thing if someone were to split out the
> > sample filtering logic from this driver so it could be used with
> > other touchscreen drivers.

> Yes, sample filtering can actually be made input device wise.

> There are actually some user-land solution to this, e.g. tslib.
> Yet this sync issue seems annoyingly unavoidable even with
> a fine grained filter, or maybe I didn't try my best to tweak those
> filters to a maximum potential yet, and I gave up on that finally.

OpenMoko has a genericised in-kernel filter setup which they're
currently trying to get merged:

	http://wiki.openmoko.org/wiki/Touchscreen_Filters
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
