From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] input: dynamically allocate ABS information
Date: Thu, 12 Aug 2010 20:35:28 -0700
Message-ID: <20100813033528.GD2661@core.coreip.homeip.net>
References: <1274289757-2723-1-git-send-email-daniel@caiaq.de>
 <1274289757-2723-5-git-send-email-daniel@caiaq.de>
 <20100524160805.GO30801@buzzloop.caiaq.de>
 <20100524161527.GC3182@core.coreip.homeip.net>
 <20100616083903.GU17833@buzzloop.caiaq.de>
 <20100721083048.GA21558@core.coreip.homeip.net>
 <20100721083150.GB21558@core.coreip.homeip.net>
 <20100811070238.GF10432@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:55929 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab0HMDfe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Aug 2010 23:35:34 -0400
Content-Disposition: inline
In-Reply-To: <20100811070238.GF10432@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Aug 11, 2010 at 09:02:38AM +0200, Daniel Mack wrote:
> Hi Dmitry,
> 
> On Wed, Jul 21, 2010 at 01:31:50AM -0700, Dmitry Torokhov wrote:
> > Input: switch to input_abs_*() access functions
> > 
> > From: Daniel Mack <daniel@caiaq.de>
> > 
> > Change all call sites in drivers/input to not access the ABS axis
> > information directly anymore. Make them use the access helpers instead.
> > 
> > Also use input_set_abs_params() when possible.
> > Did some code refactoring as I was on it.
> > 
> > Signed-off-by: Daniel Mack <daniel@caiaq.de>
> > Cc: Dmitry Torokhov <dtor@mail.ru>
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> 
> Hmm, there are three locations where some mysterious 'XX' characters
> were introduced.
> 

Gah, it is all my fault, I was marking stuff that I want to review but
missed these 2 drivers.

I sent it on to Linus, hopefully he'll apply it.

-- 
Dmitry
