From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] Input: omap4-keypad - don't leak in
 omap4_keypad_probe()
Date: Wed, 8 Aug 2012 21:57:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208082156100.10061@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1208072014140.3227@swampdragon.chaosbits.net> <CAK9yfHxS=VvZ8Cuhd4LAUG+JnOK0g6=xCEoX45mtuVwj-+8D_g@mail.gmail.com> <alpine.LNX.2.00.1208082135410.10061@swampdragon.chaosbits.net> <1545778.bUhk8oTdlK@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1010ds2-suoe.0.fullrate.dk ([90.184.90.115]:15105 "EHLO
	swampdragon.chaosbits.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753315Ab2HHT5M (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Aug 2012 15:57:12 -0400
In-Reply-To: <1545778.bUhk8oTdlK@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, Sourav Poddar <sourav.poddar@ti.com>, Felipe Balbi <balbi@ti.com>, JJ Ding <dgdunix@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Abraham Arce <x0066660@ti.com>, Syed Rafiuddin <rafiuddin.syed@ti.com>

On Wed, 8 Aug 2012, Dmitry Torokhov wrote:

> On Wednesday, August 08, 2012 09:36:51 PM Jesper Juhl wrote:
> > On Wed, 8 Aug 2012, Sachin Kamat wrote:
> > > On 7 August 2012 23:46, Jesper Juhl <jj@chaosbits.net> wrote:
> > > > If omap4_keypad_parse_dt() does not return 0 (zero) in
> > > > omap4_keypad_probe() we will leak the memory we allocated for
> > > > 'keypad_data' with kzalloc() when we return and the variable goes out
> > > > of scope.
> > > 
> > > How about using devm_kzalloc() instead which will take care of freeing
> > > the memory on detach?
> > 
> > Perhaps. I'm not (yet) familiar with how that function works, so I had
> > not considered it. I'll look into it.
> 
> Actually please not yet - I guess at some point I'll have to add devm_*
> variants for input_device_* operations but for now I prefer not to mix
> the 2 styles of managing resources.
> 
> BTW, I think I need to redo a few patches so I plan on folding this fix
> into the original change.
> 
Ok. I'll just leave this alone for now then and let you do whatever you 
feel is best :-) .

-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.

