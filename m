From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC v2 0/10] hid-multitouch: a first step towards multitouch
 unification
Date: Thu, 6 Jan 2011 18:28:45 +0100
Message-ID: <20110106172845.GE1790@polaris.bitmath.org>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
 <20110105174927.GB2146@polaris.bitmath.org>
 <AANLkTikCqufvOgYqqBZLjfmtSdsgyQV4L2HyvEP07+vf@mail.gmail.com>
 <alpine.LNX.2.00.1101061610270.26685@pobox.suse.cz>
 <20110106160418.GA1790@polaris.bitmath.org>
 <AANLkTik9qHn4u_U6FGKR0A4AOyPoYPkXM7rTMxVjiXgk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik9qHn4u_U6FGKR0A4AOyPoYPkXM7rTMxVjiXgk@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jan 06, 2011 at 05:08:39PM +0100, Benjamin Tissoires wrote:
> On Thu, Jan 6, 2011 at 5:04 PM, Henrik Rydberg <rydberg@euromail.se> wrote:
> >> > The point is that currently we have users that want to have a proper
> >> > support for their device (PixCir, Cypress TrueTouch and GeneralTouch),
> >> > and it's a shame to ask them to wait for 3 more months.
> >
> > That is understandable, but for the future, please bear in mind that
> > submitting patches in the merge window is the worst possible time
> > within that three-month period.
> >
> >> > Maybe a solution would be to make what we can here during this merge
> >> > window to add support for at least the new devices. Then, in 2.6.39
> >> > and above, we could still migrate other devices, and eventually modify
> >> > some lines in the code.
> >> >
> >> > Jiri, Dmitry, what do you think?
> >>
> >> I still have to go through the patchset, my backlog has grown very badly
> >> recently, sorry.
> >>
> >> In case the patchset doesn't impose danger of regressions for already
> >> existing devices, we could merge this new 'unified' driver only for newly
> >> supported devices, and finish the unification in 2.6.39.
> >
> > Sounds reasonable.
> 
> Thanks Henrik and Jiri.
> 
> Do you want me to send a new patchset with only the new devices?

Yes, please do. Thanks again for doing this, it is going to be
great. I sent comments for the main driver, and will hold off the rest
for the next round, then.

Cheers,
Henrik
