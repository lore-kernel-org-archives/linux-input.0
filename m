From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/3] Input: sysrq - drop tty argument from sysrq ops
 handlers
Date: Wed, 4 Aug 2010 10:09:26 +0100
Message-ID: <20100804100926.3f24f5e5@lxorguk.ukuu.org.uk>
References: <20100804075602.30647.91462.stgit@localhost.localdomain>
	<20100804075900.30647.46910.stgit@localhost.localdomain>
	<1280910830.1902.144.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40119 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757151Ab0HDI4i (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Aug 2010 04:56:38 -0400
In-Reply-To: <1280910830.1902.144.camel@pasglop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>, David Miller <davem@davemloft.net>, Fenghua Yu <fenghua.yu@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Jason Wessel <jason.wessel@windriver.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>

> I have a patch to drop the lock in serial_core.h, I'll post that
> tomorrow hopefully, just checking if there's any objection there ? The

Fundamentally - no. However the impact it has on a lot of the drivers
will be significant and you'll be submitting a huge patch pile to fix up
all the locking assumptions (for one it means port->tty might change
across any call that ends up in sysrq)

> serial drivers might need to be audited a bit to make sure they cope
> with the lock being dropped and re-acquired around the sysrq call.

Architecturally I think it would make more sense to add a new sysrq
helper which merely sets a flag, and check that flag at the end of the IRQ
when dropping the lock anyway.

Otherwise it'll be a huge amount of work to even build test all those
consoles.

Alan
