From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
Date: Mon, 6 Aug 2012 17:02:26 +0100
Message-ID: <20120806160226.GF29272@sirena.org.uk>
References: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
 <20120806081915.GA4518@core.coreip.homeip.net>
 <20120806153750.GI10524@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:36167 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756618Ab2HFQC3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Aug 2012 12:02:29 -0400
Content-Disposition: inline
In-Reply-To: <20120806153750.GI10524@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linux-arm-kernel@lists.infradead.org

On Mon, Aug 06, 2012 at 04:37:52PM +0100, Lee Jones wrote:
> On Mon, Aug 06, 2012 at 01:19:15AM -0700, Dmitry Torokhov wrote:

> > > +	ponkey->irq_dbf = (np) ? ab8500_irq_get_virq(ab8500, irq_dbf) : irq_dbf;
> > > +	ponkey->irq_dbr = (np) ? ab8500_irq_get_virq(ab8500, irq_dbr) : irq_dbr;

> > Why this isn't done inside ab8500_irq_get_virq()?

> There's no reason why it can't be.

> My first version of the patch did just that in fact.

> Would that be your preference?

Restating my comment elsewhere...  why do we even need to do this in
_get_virq() - I'd *really* expect this to be handled by the irq domain
code.
