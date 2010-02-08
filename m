From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Using PXA arm board with MAX7319 GPIO expander input
Date: Mon, 8 Feb 2010 14:04:48 +0100
Message-ID: <20100208130448.GD28972@buzzloop.caiaq.de>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
 <f17812d71002072202x2fb620c3hf4c3bbf6dc78aa78@mail.gmail.com>
 <bf0eec9a1002072302w1e81cc6bkd994c3efaab4d51d@mail.gmail.com>
 <bf0eec9a1002080308v77c9c026j302767e41cd660f2@mail.gmail.com>
 <20100208113306.GN9007@buzzloop.caiaq.de>
 <6a1db73cb6c89001764393acd766f2ba.squirrel@www.loen.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:57737 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab0BHNE4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 08:04:56 -0500
Content-Disposition: inline
In-Reply-To: <6a1db73cb6c89001764393acd766f2ba.squirrel@www.loen.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marc Zyngier <maz@misterjones.org>
Cc: Jebediah Huang <jebediah.huang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Mon, Feb 08, 2010 at 12:32:38PM -0000, Marc Zyngier wrote:
> > I just saw that there is indeed no support for irq line handling in this
> > driver. In order to use these lines as input for something like the
> > gpio_keys driver, support for that should be added. I never used this
> > driver and can't say whether it is under active development.
> 
> It should be rather easy to introduce something similar to what I did for
> the pca953x driver (http://patchwork.kernel.org/patch/77418/)
> 
> MAX732x seems a lot saner than PCA953x, as it has at least a hardware
> interrupt mask...

Is anyone with access to such hardware able to implement this?

Daniel
