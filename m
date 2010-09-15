From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/2] input: add support for Nomadik SKE keypad
 controller
Date: Wed, 15 Sep 2010 00:52:59 -0700
Message-ID: <20100915075259.GA28348@core.coreip.homeip.net>
References: <1284535498-9954-1-git-send-email-sundar.iyer@stericsson.com>
 <4C9076BA.80106@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38756 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954Ab0IOHxG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 03:53:06 -0400
Received: by pvg2 with SMTP id 2so2638743pvg.19
        for <linux-input@vger.kernel.org>; Wed, 15 Sep 2010 00:53:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C9076BA.80106@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <tsoni@codeaurora.org>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>, linux-input@vger.kernel.org, Kwangwoo LEE <kwangwoo.lee@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>

On Wed, Sep 15, 2010 at 01:03:14PM +0530, Trilok Soni wrote:
> Hi Sundar,
> 
> On 9/15/2010 12:54 PM, Sundar Iyer wrote:
> > Add support for the keypad controller in the Scroll Key Encoder (SKE)
> > module on the Nomadik family and the DB8500 SoC.
> > 
> > Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> > Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
> > ---
> > Thanx a bunch to Dmitry for being such a nice and persistent help :)
> > 
> > v4:
> >  - IRQ handler is no longer threaded
> >  - incorporated Dmitry's comments to make sure multikey is working
> >  - assorted comments from Trilok
> >  - pin configuration mistake pointed out thanx to Kwangwoo LEE
> 
> Looks good to me. Thanks.
> 
> Acked-by: Trilok Soni <tsoni@codeaurora.org>
> 

Hmm, now how to merge it... namely the arch code... Should it come
through my tree or you guys want to merge it yourselves?

-- 
Dmitry
