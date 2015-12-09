From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 154/182] hid: cp2112: use gpiochip data pointer
Date: Wed, 9 Dec 2015 18:41:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512091841210.9922@cbobk.fhfr.pm>
References: <1449668658-5642-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60604 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbbLIRlm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Dec 2015 12:41:42 -0500
In-Reply-To: <1449668658-5642-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, linux-input@vger.kernel.org

On Wed, 9 Dec 2015, Linus Walleij wrote:

> This makes the driver use the data pointer added to the gpio_chip
> to store a pointer to the state container instead of relying on
> container_of().
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Jiri Kosina <jkosina@suse.cz>

-- 
Jiri Kosina
SUSE Labs

