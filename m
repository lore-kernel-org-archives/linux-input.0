From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: sony: disable descriptor fixup for FutureMax Dance
 Mat
Date: Mon, 25 Jul 2016 11:14:04 +0200
Message-ID: <20160725091404.GD19383@mail.corp.redhat.com>
References: <20160717172533.8777-1-mikko.perttunen@kapsi.fi>
 <20160718142837.GK4663@mail.corp.redhat.com>
 <78cafd15-850f-3110-f63e-bb41f6b69c5c@kapsi.fi>
 <20160721183439.3edddbc6312555afda517f8c@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47842 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751805AbcGYJOK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jul 2016 05:14:10 -0400
Content-Disposition: inline
In-Reply-To: <20160721183439.3edddbc6312555afda517f8c@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>

On Jul 21 2016 or thereabouts, Antonio Ospite wrote:
> On Tue, 19 Jul 2016 09:08:27 +0300
> Mikko Perttunen <mikko.perttunen@kapsi.fi> wrote:
> 
> > On 07/18/16 17:28, Benjamin Tissoires wrote:
> [...]
> > >
> > > Also, I think it would be better to have a check on the existing report
> > > descriptor instead of blindly fixing it. Other drivers make sure they
> > > are fixing the correct region before overriding it, but I think using a
> > > md5sum might be just easier (though that's not required for your patch I
> > > think).
> > 
> > I agree. In fact, the mat used to work back in 3.15 when the driver did 
> > some rudimentary checks before overwriting the descriptor. In any case, 
> > it would be difficult for me to add the checks since the mat is the only 
> > piece of hardware I own that is handled by this driver.
> > 
> 
> The fact that the report gets fixed up unconditionally is from
> commit c607fb8 (HID: sony: Always override the Sixaxis descriptor).
> 
> The rationale behind this change was that compatible devices are
> supposed to send exactly the same _raw_ data as the original ones, so
> overriding the _whole_ descriptor unconditionally should keep them
> working.
> 
> I would be interesting to understand why some (supposedly) compatible
> devices break, maybe they rely on the fact that the PS3 would use the
> original report?

[just speculating]
I would be *really* surprised if the Sony software were to overwrite the
report descriptor of their own sony controllers. My guess is that their
HID stack or their Playstation driver is compatible with the original
report descriptors and so they can handle the differences between
original and weirdo controllers.

> 
> BTW I'd slightly prefer the current way of having a straight path for
> the common case (original and actually compatible devices) and handle
> the exceptions explicitly using quirks, but I am open to changes and I
> can test patches with some original controllers if needed.

Would the v2 of Mikko's patch be OK with you?

Cheers,
Benjamin

> 
> Ciao ciao,
>    Antonio
> 
> -- 
> Antonio Ospite
> http://ao2.it
> 
> A: Because it messes up the order in which people normally read text.
>    See http://en.wikipedia.org/wiki/Posting_style
> Q: Why is top-posting such a bad thing?
