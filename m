From: Sundar R IYER <sundar.iyer@stericsson.com>
Subject: Re: [PATCH] input: add support for Nomadik SKE keypad controller
Date: Tue, 24 Aug 2010 12:50:30 +0530
Message-ID: <20100824072029.GC15203@bnru01.bnr.st.com>
References: <1282554245-3633-1-git-send-email-sundar.iyer@stericsson.com>
 <0680EC522D0CC943BC586913CF3768C003B39A3BA1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:36537 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751692Ab0HXHUx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Aug 2010 03:20:53 -0400
Content-Disposition: inline
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003B39A3BA1@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Linus WALLEIJ <linus.walleij@stericsson.com>

Hello Shubhra,

On Tue, Aug 24, 2010 at 08:37:16 +0200, Datta, Shubhrajyoti wrote:
> > + * ske_keypad_chip_init : init keypad controller configuration
> > + *
> > + * Enable Multi key press detection, auto scan mode
> > + */
> May consider making it an init function as called only at probe?

Okay. will do so.

> > +
> Nitpick : Bonus space

Sure.

> > +out_unregisterinput:
> > +     input_unregister_device(input);
> > +     input = NULL;
> > +     clk_disable(keypad->clk);
> > +out_freeinput:
> Unregister and then free you may want to have a relook.
> > +     input_free_device(input);

Hmm. Is there something wrong here? input_free_device() is being
called with a NULL after input_unregister_device(), which is okay.

> > +out_freekeypad:
> > +     kfree(keypad);
> > +out_freeclk:
> Kfree keypad and then access keypad->clk ?
> 
> > +     clk_put(keypad->clk);

Oops. It ought to be only clk.

> > +     clk_disable(keypad->clk);
> > +     clk_put(keypad->clk);
> What is the cpu you tested on? Just curious not a comment.

I have tested it on the U8500 platform.

Thanx for the review; I will re-post with the changes.

Regards,
Sundar

