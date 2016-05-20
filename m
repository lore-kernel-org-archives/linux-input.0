From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2 V3] dt: add Atmel Captouch bindings
Date: Fri, 20 May 2016 15:21:21 -0700
Message-ID: <20160520222121.GG14951@dtor-ws>
References: <1463432094-146726-1-git-send-email-grundler@chromium.org>
 <20160518164404.GA31862@rob-hp-laptop>
 <20160518215914.GA4081@dtor-ws>
 <CAL_Jsq+zBQ-Z3eEouQHxSiH9jxbTMYuGUurnXwiAoXijgC3MfA@mail.gmail.com>
 <20160520161603.GA14951@dtor-ws>
 <CAL_Jsq+dDLnQQOrsDqXfCbU1pBFjM2qQ98PDQjg3=49WTjawRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:32904 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbcETWVZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 May 2016 18:21:25 -0400
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+dDLnQQOrsDqXfCbU1pBFjM2qQ98PDQjg3=49WTjawRw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Grant Grundler <grundler@chromium.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Hung-yu Wu <hywu@google.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Grant Likely <grant.likely@linaro.org>

On Fri, May 20, 2016 at 05:12:55PM -0500, Rob Herring wrote:
> On Fri, May 20, 2016 at 11:16 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Fri, May 20, 2016 at 07:56:51AM -0500, Rob Herring wrote:
> >> On Wed, May 18, 2016 at 4:59 PM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > On Wed, May 18, 2016 at 11:44:04AM -0500, Rob Herring wrote:
> >> >> On Mon, May 16, 2016 at 01:54:53PM -0700, Grant Grundler wrote:
> >> >> > From: Daniel Hung-yu Wu <hywu@google.com>
> >> >> >
> >> >> > Add binding for Atmel Capacitive Touch Button device.
> >> >> >
> >> >> > Signed-off-by: Daniel Hung-yu Wu <hywu@google.com>
> >> >> > Signed-off-by: Grant Grundler <grundler@chromium.org>
> >> >> > ---
> >> >> >  .../devicetree/bindings/input/atmel,captouch.txt   | 36 ++++++++++++++++++++++
> >> >> >  1 file changed, 34 insertions(+)
> >> >> >  create mode 100644 Documentation/devicetree/bindings/input/atmel,captouch.txt
> >> >>
> >> >> Acked-by: Rob Herring <robh@kernel.org>
> >> >
> >> > Folded into the driver patch and applied.
> >>
> >> Folded why? Please don't do that. You should be committing what is
> >> posted as is for the most part. We specifically ask that binding
> >> changes are kept separate commits. It also messes up the ability to
> >
> > I know that you ask for binding docs to be posted separately (I guess
> > so that devicetree list is not overrun with driver code mails),
> 
> And because we're really only reviewing the binding, so putting my ack
> on the driver is not really correct.

If you'd like I can annotate your Acks to state that they are for
bindings only when I fold everything together.

> 
> > but
> > logically driver patch and binding doc patch are a single change and
> > should be committed together, so that when I am researching the history
> > I can easily see what was introduced and when. You do not require header
> > changes to be submitted separately form .c files, do you?
> 
> Yes, for include/dt-bindings we ask that they are part of the binding
> doc, not the driver even though both use it. You can also certainly
> have bindings without drivers though generally we require them. I
> would not if they had a driver in BSD or u-boot for example.

Would they be in linux kernel sources then? I can see rules changed if
ever DTS/bindings are split from kernel, but while they are kept
together I do not see why we'd want to keep commits separate.

> 
> You can already easily see when things are introduced because they
> will be next to each other in the git history.
> 
> >> correlate git commits to patchworks or mail searches.
> >
> > The fact that it was applied can be found in mail archives.
> 
> Yes, with extra effort reading the history you can, but not with a
> script. There's a patchwork script to add commit hashes to patchwork
> which works all based on the subject.

If you'd like I can teach my scripts to update patches in your patchwork
instance when I do folds.

> 
> Regardless of one commit or two, you simply shouldn't be changing what
> you commit. Either commit what was posted or require the author to
> combine things and repost. That's our job as patch monkeys.

Or I do a bit of work on my end (i.e. add a few "depends on" that were
missed in case I notice them) and not ask for yet another respin.

Thanks.

-- 
Dmitry
