From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC v2 0/10] hid-multitouch: a first step towards multitouch
 unification
Date: Thu, 6 Jan 2011 17:04:18 +0100
Message-ID: <20110106160418.GA1790@polaris.bitmath.org>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
 <20110105174927.GB2146@polaris.bitmath.org>
 <AANLkTikCqufvOgYqqBZLjfmtSdsgyQV4L2HyvEP07+vf@mail.gmail.com>
 <alpine.LNX.2.00.1101061610270.26685@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1101061610270.26685@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>, Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> > The point is that currently we have users that want to have a proper
> > support for their device (PixCir, Cypress TrueTouch and GeneralTouch),
> > and it's a shame to ask them to wait for 3 more months.

That is understandable, but for the future, please bear in mind that
submitting patches in the merge window is the worst possible time
within that three-month period.

> > Maybe a solution would be to make what we can here during this merge
> > window to add support for at least the new devices. Then, in 2.6.39
> > and above, we could still migrate other devices, and eventually modify
> > some lines in the code.
> > 
> > Jiri, Dmitry, what do you think?
> 
> I still have to go through the patchset, my backlog has grown very badly 
> recently, sorry.
> 
> In case the patchset doesn't impose danger of regressions for already 
> existing devices, we could merge this new 'unified' driver only for newly 
> supported devices, and finish the unification in 2.6.39.

Sounds reasonable.

Thanks,
Henrik
