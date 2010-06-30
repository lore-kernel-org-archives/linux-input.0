From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Subject: usbtouchscreen - runtime PM patches testing [Was: [PATCH 1/2]
	Input: usbtouchscreen - add support for ET&T TC4UM touchscreen
	controller]
Date: Wed, 30 Jun 2010 09:16:35 +0200
Message-ID: <20100630071635.GJ15039@ibawizard.net>
References: <20100603075720.GQ26052@ibawizard.net> <1276242054-11127-1-git-send-email-ynezz@true.cz> <20100628091959.GH15039@ibawizard.net> <20100628164603.GC11670@core.coreip.homeip.net>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:44951 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab0F3HQj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 03:16:39 -0400
Content-Disposition: inline
In-Reply-To: <20100628164603.GC11670@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>, linux-input@vger.kernel.org, Oliver Neukum <oneukum@suse.de>

Dmitry Torokhov <dmitry.torokhov@gmail.com> [2010-06-28 09:46:03]:

> Applied to 'next' branch (for .36). But I was wondering - could you
> please try the runtime PM patches to usebtouchscreen posted by Oliver
> Neukum on the linux-input list? I'd really like to apply them but
> I'd like to have them tested first.

Thank you for applying my patches. Well, I've now only broken touchscreen,
which have only 4-wires or so working, but I think, that it should be enough
for PM testing. What kind of testing do you need, just few suspend & resume
cycles? CC-ing Oliver also.

-- ynezz
