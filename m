From: "Marc Zyngier" <maz@misterjones.org>
Subject: Re: Using PXA arm board with MAX7319 GPIO expander input
Date: Mon, 8 Feb 2010 12:32:38 -0000 (GMT)
Message-ID: <6a1db73cb6c89001764393acd766f2ba.squirrel@www.loen.fr>
References: <bf0eec9a1002072144n461e5894m8993bfd4e8f49e9b@mail.gmail.com>
    <f17812d71002072202x2fb620c3hf4c3bbf6dc78aa78@mail.gmail.com>
    <bf0eec9a1002072302w1e81cc6bkd994c3efaab4d51d@mail.gmail.com>
    <bf0eec9a1002080308v77c9c026j302767e41cd660f2@mail.gmail.com>
    <20100208113306.GN9007@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from inca-roads.misterjones.org ([213.251.177.50]:49513 "EHLO
	inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751364Ab0BHMcm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Feb 2010 07:32:42 -0500
In-Reply-To: <20100208113306.GN9007@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Jebediah Huang <jebediah.huang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

> I just saw that there is indeed no support for irq line handling in this
> driver. In order to use these lines as input for something like the
> gpio_keys driver, support for that should be added. I never used this
> driver and can't say whether it is under active development.

It should be rather easy to introduce something similar to what I did for
the pca953x driver (http://patchwork.kernel.org/patch/77418/)

MAX732x seems a lot saner than PCA953x, as it has at least a hardware
interrupt mask...

        M.
-- 
And if you don't know where you're going, any road will take you there...


