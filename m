From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix - preliminary support for GT801-2+1
Date: Wed, 08 Apr 2015 16:25:10 +0200
Message-ID: <1428503110.28443.13.camel@hadess.net>
References: <1428181693-25362-1-git-send-email-plaes@plaes.org>
	 <1428181693-25362-2-git-send-email-plaes@plaes.org>
	 <1428249864.28443.4.camel@hadess.net> <20150405235608.GB5313@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:55602 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754498AbbDHO0K (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 10:26:10 -0400
In-Reply-To: <20150405235608.GB5313@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Priit Laes <plaes@plaes.org>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>

On Sun, 2015-04-05 at 16:56 -0700, Dmitry Torokhov wrote:
> On Sun, Apr 05, 2015 at 06:04:24PM +0200, Bastien Nocera wrote:
> > On Sun, 2015-04-05 at 00:08 +0300, Priit Laes wrote:
> > > This patch implements GT801x2 touchscreen support.
> > > Unfortunately, there is a big difference between GT801 and GT9xx 
> > > series
> > > chips, therefore some advice is needed on how to proceed.
> > > 
> > > Differences between GT801x2 and GT9xx series:
> > > 
> > > 1. I2C registers: 1 byte (GT801x2) vs 2 bytes (GT9xx)
> > > 2. Different configuration layout and version info
> > > 3. Different touch report protocol
> > 
> > That doesn't seem like an awful lot of differences. Approximately 
> > 80 
> > line changes for 500 lines of driver code. You could add an enum 
> > for 
> > the 8xx and 9xx types near the top, add that as driver data in the 
> > match arrays (both the ACPI and OF ones). Then have if statements 
> > choose the correct init, read and report functions.
> > 
> > I would think that that would grow the driver by a further 50 
> > lines, 
> > which would certainly be acceptable.
> > 
> > Don't forget to add your name to the copyright header mentioning 
> > you're the author for the 8xx support :)
> > 
> > > Signed-off-by: Priit Laes <plaes@plaes.org>
> > 
> > There's really no need to sign it off if you know it's not going 
> > to be 
> > accepted upstream ;)
> 
> Actually I think it is still useful: that means that somebody else 
> can
> use the patch as a base for their work without any concerns even if
> original author did not see it through upstream acceptance for some
> reason.


Right, fair enough.
