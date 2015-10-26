From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v9 0/9] Goodix touchscreen enhancements
Date: Mon, 26 Oct 2015 19:40:20 +0100
Message-ID: <1445884820.31107.8.camel@hadess.net>
References: <1444663477-30062-1-git-send-email-irina.tirdea@intel.com>
	 <1445871989.31107.4.camel@hadess.net>
	 <20151026182112.GA1800@excalibur.cnev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43691 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbJZSk1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2015 14:40:27 -0400
In-Reply-To: <20151026182112.GA1800@excalibur.cnev.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karsten Merker <merker@debian.org>, Irina Tirdea <irina.tirdea@intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Octavian Purdila <octavian.purdila@intel.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

On Mon, 2015-10-26 at 19:21 +0100, Karsten Merker wrote:
> On Mon, Oct 26, 2015 at 04:06:29PM +0100, Bastien Nocera wrote:
> > On Mon, 2015-10-12 at 18:24 +0300, Irina Tirdea wrote:
> 
> > > v9 only adds GPIOLIB dependency in Kconfig for patch 2:
> > > "Input: goodix - reset device at init". There are no other code
> > > changes from v8.
> > > 
> > > Thanks for testing these changes, Bastien and Aleksei!
> > > 
> > > Karsten, there is no need to rebase your series on top of v9.
> > 
> > Are we waiting on anything else before merging this? I'd like it to
> > be
> > scheduled to be merged so I can start focusing on the subsequent
> > and
> > dependent patches for that same driver.
> 
> Hello,
> 
> AFAICS there is one open point (cf. 
> http://www.spinics.net/lists/linux-input/msg41567.html) which
> Irina wanted to address in a v10 of the patchset (cf. 
> http://www.spinics.net/lists/linux-input/msg41642.html).
> 
> Irina, how are your plans regarding the v10? It would be really
> nice if the patches could go into kernel 4.4, but the merge
> window opens on the coming weekend, so there is not much time
> left.
> 
> Bastien, did you have time to look at v3 of the axis
> swapping/inversion set?
> (http://www.spinics.net/lists/linux-input/msg41628.html)
> You had acked v2, but I had to do some small changes to address
> Irina's review comments after you had acked it, so I didn't want
> to carry your "acked-by" on to v3 without an ok from you.

I was waiting on at least Irina's patches being merged before testing
your patches again. I have limited time to do testing on this (I have
plenty more hardware that's sitting unloved here), and wanted to
minimise the amount of time I'd spend testing it.
