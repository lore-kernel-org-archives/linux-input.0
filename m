From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2] Input: gpio_keys - Use of_property_read_u32
Date: Tue, 20 Sep 2011 08:25:24 +0200
Message-ID: <20110920062524.GN11405@distanz.ch>
References: <1314775945-6822-1-git-send-email-tklauser@distanz.ch> <1316423391-20219-1-git-send-email-tklauser@distanz.ch> <20110920112627.41b180e05dc6717beee0f5e8@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from symlink.to.noone.org ([85.10.207.172]:43561 "EHLO sym.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127Ab1ITGZZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 02:25:25 -0400
Content-Disposition: inline
In-Reply-To: <20110920112627.41b180e05dc6717beee0f5e8@canb.auug.org.au>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Stephen

Sorry for the messup!

On 2011-09-20 at 03:26:27 +0200, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Mon, 19 Sep 2011 11:09:51 +0200 Tobias Klauser <tklauser@distanz.ch> wrote:
> >
> > Use the of_property_read_u32 helper function to retreive u32 values
> > from the device tree. Also do not pass the len parameter to
> > of_get_property if it isn't checked afterwards.
> > 
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> > v2: Fix build failure caused by a missing opening brace (reported by
> >     Stephen Rothwell)
> 
> Sure, but it will still generate all the warnings I reported as "reg" is
> the wrong type now.
> 
> drivers/input/keyboard/gpio_keys.c: In function 'gpio_keys_get_devtree_pdata':
> drivers/input/keyboard/gpio_keys.c:500:3: warning: passing argument 3 of 'of_property_read_u32' from incompatible pointer type
> include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type 'const u32 **'
> drivers/input/keyboard/gpio_keys.c:504:19: warning: assignment makes integer from pointer without a cast
> drivers/input/keyboard/gpio_keys.c:508:3: warning: passing argument 3 of 'of_property_read_u32' from incompatible pointer type
> include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type 'const u32 **'
> drivers/input/keyboard/gpio_keys.c:509:20: warning: assignment makes integer from pointer without a cast
> drivers/input/keyboard/gpio_keys.c:515:3: warning: passing argument 3 of 'of_property_read_u32' from incompatible pointer type
> include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type 'const u32 **'
> drivers/input/keyboard/gpio_keys.c:516:33: warning: assignment makes integer from pointer without a cast

Stupid me was compiling iwht the wrong .config (which hasn't CONFIG_OF
set) all the time, that's why I never noticed any of the
errors/warnings in the part I actually changed.

Sorry, I'll send another patch, hopefully the final one.

Thanks a lot for your help
Tobias
