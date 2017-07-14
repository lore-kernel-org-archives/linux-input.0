From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 2/2] skip all blobs that are not touches
Date: Fri, 14 Jul 2017 18:24:06 +1000
Message-ID: <20170714082406.GA29703@jelly>
References: <1499626491-22592-1-git-send-email-floe@butterbrot.org>
 <1499626491-22592-2-git-send-email-floe@butterbrot.org>
 <20170709214105.GE21945@dtor-ws>
 <ebe3ea9a-d79c-8fbc-db96-adb878a53848@butterbrot.org>
 <20170710181120.GC23984@dtor-ws>
 <alpine.DEB.2.10.1707140951540.18874@butterbrot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:29020 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdGNIYF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Jul 2017 04:24:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1707140951540.18874@butterbrot>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Martin Kaltenbrunner <modin@yuri.at>

On Fri, Jul 14, 2017 at 09:54:03AM +0200, Florian Echtler wrote:
> On Mon, 10 Jul 2017, Dmitry Torokhov wrote:
> > On Mon, Jul 10, 2017 at 09:11:53AM +0200, Florian Echtler wrote:
> > > 
> > > Related question: we first attempted to label non-touch objects as MT_TOOL_PALM,
> > > but it looks like userspace (Xorg in particular) doesn't actually distinguish
> > > between MT_TOOL_* types; is that correct?
> > 
> > It really should, but I think Peter never got around implementing this.
> > 
> > Also, I think it is a good idea to set touch major to max in this case.
> > I believe that that will help clients that do no understand MT_TOOL_PALM
> > to still do palm rejection.
> > 
> > Peter?
> 
> Would you consider merging v2 of the patch regardless of the Xorg situation?
> Right now, it's a useful bugfix in any case, and we can deal with how to
> represent blobs/palms/tokens later on.

sorry about the delay, bit chaotic here. libinput 1.8 was released a week or
so ago and it supports MT_TOOL_PALM, so consider userspace ready for that. I
also have patches to use major/minor for palm detection where appropriate
which will hit git master (my) tonight.

That's the libinput situation sorted I think, don't expect synaptics to
catch up with that though (unless someone ends up writing the patches).

Cheers,
   Peter
