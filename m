From: Daniel Mack <daniel@caiaq.de>
Subject: Re: ABS_MAX incrementation?
Date: Tue, 4 May 2010 09:18:55 +0200
Message-ID: <20100504071855.GN30801@buzzloop.caiaq.de>
References: <20100419171412.GH30801@buzzloop.caiaq.de>
 <20100419174924.GB22295@core.coreip.homeip.net>
 <20100419180606.GI30801@buzzloop.caiaq.de>
 <20100421062929.GH4364@core.coreip.homeip.net>
 <20100502121331.GH30801@buzzloop.caiaq.de>
 <20100504065832.GC17482@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:50844 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab0EDHTA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 May 2010 03:19:00 -0400
Content-Disposition: inline
In-Reply-To: <20100504065832.GC17482@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Mon, May 03, 2010 at 11:58:32PM -0700, Dmitry Torokhov wrote:
> On Sun, May 02, 2010 at 02:13:31PM +0200, Daniel Mack wrote:
> > Hmm, maybe I could also help with that. Could you outline where this
> > should go? I guess a linked list is not very suitable as it doesn't
> > allow instant access of specific members. So we need a fixed-size bitmap
> > to indicate active members at least?
> 
> I was just thinking about having drivers taht emit absolute events
> allocate abs data (value, min, max, resolution) separately from
> allocating a device (or maybe have additional input_abs_device_alloc
> helper). Someting very simple.

So that would buy us less memory footprint by saving 4 integers for 1
pointer. However, we would still need to store an array of pointers
which has ABS_MAX entries.

I'm hessitating as I would like to see ABS_MAX being quite large.
I'm planning to write a driver with > 100 absolute axis soon.

Also, that approach wouldn't be able to be descriptive about what the
axis in fact represent, and especially for such a high number, that
would be more than just a nice-to-have :)

As I say, I'd be willing to help with this hack up a clean solution
which also teaches the user space interface new fancy features. I would
just need some idea what's a proper way to go.

Thanks,
Daniel
