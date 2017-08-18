From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Date: Fri, 18 Aug 2017 13:08:34 +1000
Message-ID: <20170818030834.GA1144@jelly>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
 <5528ad84-9b42-8826-abb1-1aef06876284@bitmath.org>
 <CAKdAkRRRo-Xz5O7+gVQcAH5=PnEgwhDx4eYvyBZe7Qbves21kg@mail.gmail.com>
 <c1a6ca9c-5f4d-cc9e-fc36-71d7d6aff640@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:15671 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753932AbdHRDKu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 23:10:50 -0400
Content-Disposition: inline
In-Reply-To: <c1a6ca9c-5f4d-cc9e-fc36-71d7d6aff640@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, Dennis Kempin <denniskempin@google.com>, Andrew de los Reyes <adlr@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>

sorry, was at a conference/travelling and I'm slowly catching up.

On Fri, Aug 11, 2017 at 10:29:07AM +0200, Henrik Rydberg wrote:
> Hi Dmitry,
> 
> > The meaning of confidence is literally "contact is too large to be a
> > finger", so it is not touch state, but really tool identity. We do
> > allow tool identity to change over time.
> What I am arguing is rather that since "palm" is a property, just like
> contact size, there should be no need to confuse that property with the
> touch state, which is, as you state, what happens in userland when the tool
> type is modified. Using a different event for the palm property ought to
> remove that confusion.

whether it's a property or a tool type is up for interpretation, imo neither
is right or wrong. It's common enough that the tool type changes after touch
down but it's equally common for the tool type to be set at start.

> > The additional state is simply because we have never updated the tool
> > type on release events and userspace is not expecting it and is likely
> > to ignore any data in the slot that is accompanied with
> > ABS_TRACKING_ID == -1. So we synthesize an extra event to have
> > distinct tool change and release.
> 
> We update all other properties of a contact freely at release, so
> logically there is no good reason to treat palm, the binary version of max
> contact size, differently.

note that palm does not indicate max contact size, it's merely a magic
property at which point the contact is not considered a normal finger
anymore. It may be size related, but it's certainly doesn't imply that it's
the maximum touch size and I expect this to be even less true of devices in
the future.
 
> > Mostly because with BTN_TOOL_PALM we are not able to decide which
> > contact is turning into palm. Also, other drivers (RMI) use
> > MT_TOOL_PALM and I would like to report palm state in unified way.
> Precedent certainly matters, but in this case, I think the modification
> promises problems down the road. I would rather suggest to add a new binary
> palm property, with the precise meaning "contact size = max contact size",
> and take it from there. I dont mind writing a patch for it if you agree.

the closest interpretation would be "contact size/shape/location indicates
that it is not a finger". I don't think you can easily narrow this down
further, mostly because it's often driven by the firmware and who knows what
that does.

I can live with an extra property as well as long as it's per-touch, but I
don't have any problems with MT_TOOL_PALM.

Cheers,
   Peter
