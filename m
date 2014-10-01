From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: cp2112: remove use of gpiochip_remove() retval
Date: Wed, 1 Oct 2014 10:01:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1410011000450.26311@pobox.suse.cz>
References: <1412087049-4368-1-git-send-email-pramod.gurav@smartplayin.com> <alpine.LNX.2.00.1410010917000.26311@pobox.suse.cz> <542BACB3.3010203@smartplayin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <542BACB3.3010203@smartplayin.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 1 Oct 2014, Pramod Gurav wrote:

> >> > Cc: Linus Walleij <linus.walleij@linaro.org>
> >> > Cc: Alexandre Courbot <gnurou@gmail.com>
> >> > Cc: Jiri Kosina <jkosina@suse.cz>
> >> > Cc: linux-input@vger.kernel.org 
> >> > Cc: linux-gpio@vger.kernel.org
> >> > 
> >> > Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> > I guess this depends on some other patch that hasn't gone to Linus yet, 
> > right? As Linus' tree currently has this prototype:
> > 
> > 	int gpiochip_remove(struct gpio_chip *chip)
> 
> Yes. It is yet to make it to linus's tree. But the change is there in
> linux-next master branch.

Alright. It probably makes most sense to take this patch together with the 
prototype change in one pile (i.e. not through my tree).

For that purpose

	Acked-by: Jiri Kosina <jkosina@suse.cz>

-- 
Jiri Kosina
SUSE Labs
