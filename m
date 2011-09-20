From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v2] Input: gpio_keys - Use of_property_read_u32
Date: Tue, 20 Sep 2011 14:54:25 +0200
Message-ID: <20110920125425.GQ11405@distanz.ch>
References: <1314775945-6822-1-git-send-email-tklauser@distanz.ch> <1316423391-20219-1-git-send-email-tklauser@distanz.ch> <20110920112627.41b180e05dc6717beee0f5e8@canb.auug.org.au> <20110920062604.GA26576@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from symlink.to.noone.org ([85.10.207.172]:48145 "EHLO sym.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946Ab1ITMy0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Sep 2011 08:54:26 -0400
Content-Disposition: inline
In-Reply-To: <20110920062604.GA26576@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-input@vger.kernel.org

Hi Dmitry

On 2011-09-20 at 08:26:04 +0200, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Tue, Sep 20, 2011 at 11:26:27AM +1000, Stephen Rothwell wrote:
> > On Mon, 19 Sep 2011 11:09:51 +0200 Tobias Klauser <tklauser@distanz.ch> wrote:
> > >
> > > Use the of_property_read_u32 helper function to retreive u32 values
> > > from the device tree. Also do not pass the len parameter to
> > > of_get_property if it isn't checked afterwards.
> > > 
> > > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > > ---
> > > v2: Fix build failure caused by a missing opening brace (reported by
> > >     Stephen Rothwell)
> > 
> > Sure, but it will still generate all the warnings I reported as "reg" is
> > the wrong type now.
> > 
> > drivers/input/keyboard/gpio_keys.c: In function 'gpio_keys_get_devtree_pdata':
> > drivers/input/keyboard/gpio_keys.c:500:3: warning: passing argument 3 of 'of_property_read_u32' from incompatible pointer type
> > include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type 'const u32 **'
> > drivers/input/keyboard/gpio_keys.c:504:19: warning: assignment makes integer from pointer without a cast
> > drivers/input/keyboard/gpio_keys.c:508:3: warning: passing argument 3 of 'of_property_read_u32' from incompatible pointer type
> > include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type 'const u32 **'
> > drivers/input/keyboard/gpio_keys.c:509:20: warning: assignment makes integer from pointer without a cast
> > drivers/input/keyboard/gpio_keys.c:515:3: warning: passing argument 3 of 'of_property_read_u32' from incompatible pointer type
> > include/linux/of.h:268:19: note: expected 'u32 *' but argument is of type 'const u32 **'
> > drivers/input/keyboard/gpio_keys.c:516:33: warning: assignment makes integer from pointer without a cast
> > 
> 
> I think the following shoudl fix it, I am going to fold it into original
> path.

Thanks a lot for fixing this and sorry for the messup.

Thanks
Tobias
