From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 3/4] input: Deprecate real timestamps beyond year 2106
Date: Fri, 28 Oct 2016 14:19:42 +0200
Message-ID: <3030448.PcHXLsYrel@wuerfel>
References: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com> <CABeXuvoo1N_1wuiWTns9eLvfVbgCa4YfLj6dRBHwFem6ZXSzfw@mail.gmail.com> <20161027231254.GA12312@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:54645 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755605AbcJ1MUG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Oct 2016 08:20:06 -0400
In-Reply-To: <20161027231254.GA12312@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.com>, Hans de Goede <hdegoede@redhat.com>

On Thursday, October 27, 2016 4:12:54 PM CEST Dmitry Torokhov wrote:
> On Thu, Oct 27, 2016 at 03:25:43PM -0700, Deepa Dinamani wrote:
> > > If users are forced to update to adapt to the new event format, should
> > > we consider more radical changes? For example, does it make sense to
> > > send timestamp on every event? Maybe we should only send it once per
> > > event packet (between EV_SYN/SYN_REPORT)? What granularity do we need?
> > > Is there anything else in current protocol that we'd like to change?
> > 
> > I did see the thread with Pingbo's patches where you had a similar comment.
> > 
> > I see my series as decoupling the kernel input event format from the
> > userspace format.
> > The formats also are really the same still.
> > Could this be considered the first step towards changing the protocol?
> 
> I really do not see the point. I think we agree that the current
> protocol is not working past 2038 and it does not seem we can fix it
> transparently for the user. So we need to define new protocol and let
> kernel and clients negotiate which one is used.

This work is not primarily about fixing the protocol to work beyond
2038 (although as a side-effect it will work until 2106). The
main intention here is to not break existing applications when
they get recompiled against a C library that defines time_t as
64-bit.

> I am not concerned about in-kernel representation much as it does not
> get stored anywhere so we can adjust it as needed without too much
> effort.
>
> > The protocol changes might need new interfaces to be defined between libraries.
> > And, could end up being a substantial change.
> > Would a step by step approach make sense?
> 
> It would depend largely on the scope.

I think we should do those two things completely independently.
We need to do something now to preserve the current interfaces
for the glibc changes that are coming soon [1], and Deepa's
patches do that (though I now realize the changelog doesn't
mention the requirement).

An overhaul of the input_event handling with a new modern
but incompatible format may or may not be a good idea, but
this should be decided independently.

	Arnd

[1] https://sourceware.org/glibc/wiki/Y2038ProofnessDesign
