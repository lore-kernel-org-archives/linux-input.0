From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: h3600_ts_input - bugfix for
 request_irq()/free_irq() parameters
Date: Sun, 1 May 2011 09:50:58 -0700
Message-ID: <20110501165058.GA23240@core.coreip.homeip.net>
References: <1302698231.3002.4.camel@phoenix>
 <20110428162620.GA9529@core.coreip.homeip.net>
 <BANLkTi=BpdfE+VmBZuzaodNiE9JUhARbfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62485 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209Ab1EAQ7Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 May 2011 12:59:16 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=BpdfE+VmBZuzaodNiE9JUhARbfg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, May 02, 2011 at 12:23:43AM +0800, Axel Lin wrote:
> Hi Dmitry,
> 
> 2011/4/29 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > On Wed, Apr 13, 2011 at 08:37:11PM +0800, Axel Lin wrote:
> >> The dev field of h3600_dev is a pointer, thus use ts->dev instead of &ts->dev
> >> as the dev_id argument while calling request_irq()/free_irq().
> >
> > dev_id does not need to have specific type, it is just a cookie so as
> > long as it's value is unique we are OK. &ts->dev works as well as
> > ts->dev.
> 
> Then you might want to apply below patch:
> http://www.spinics.net/lists/linux-input/msg15042.html
> 
> My original intension was to fix the irq driver data mismatch.
> 

Ah, I see. Then I'll apply it but with teh above as commit message.

-- 
Dmitry
