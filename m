From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] Input: tsc2005 - Add support for tsc2004
Date: Fri, 30 Oct 2015 13:59:13 +0100
Message-ID: <4699994.s366ePcOrS@wuerfel>
References: <201510280724.dKfeR76E%fengguang.wu@intel.com> <20151028054829.GA13066@deathstar> <20151028061258.GD16963@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:55485 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758433AbbJ3M72 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Oct 2015 08:59:28 -0400
In-Reply-To: <20151028061258.GD16963@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Welling <mwelling@ieee.org>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tuesday 27 October 2015 23:12:58 Dmitry Torokhov wrote:
> > Yes it does.
> > 
> > I have been told that using wildcard names is bad in other subsystems.
> > Perhaps tsc200x-core.c should be called something else because it has
> > nothing to do with the tsc2007 but it is covered by the wildcard.
> > 
> > You you think this is a big deal?
> 
> No I do not.

To clarify: using wildcards in DT bindings is bad, because that is
the only way to clearly identify small differences between related
devices there. In file names or identifiers in the kernel, there is
no problem.

	Arnd
