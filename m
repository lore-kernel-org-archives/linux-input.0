From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Another HID problem this merge window..
Date: Sat, 27 Oct 2018 23:45:05 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810272338590.23511@cbobk.fhfr.pm>
References: <CAHk-=wiZ24JuVehJ5sEC0UG1Gk2nvB363wO02RRsR1oEht6R9Q@mail.gmail.com> <c6b7e5b26883c53db35454e9b0ffb44898517228.camel@perches.com> <CAHk-=wgTMd_orbgEmjtKdpPJdnFcho_-66_R3PBr7joxFOxqsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wgTMd_orbgEmjtKdpPJdnFcho_-66_R3PBr7joxFOxqsw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: joe@perches.com, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, 27 Oct 2018, Linus Torvalds wrote:

> I wonder if there is some truly old historical legacy there, ie the old 
> PC keyboard support would have been configurable out only for expert 
> users to avoid errors, and maybe the HID Kconfig file started getting 
> ideas from that...

This really goes waaay back to times when we extracted all the quirks from 
the generic driver (which became unmaintainable exactly because quirks 
being sprinkled left and right) into specialized drivers, but didn't want 
to cause too many user surprises that all of a sudden their configuration 
regressed when it comes to hardware support.

We've had exactly this discussion multiple times before, see for example

	https://lkml.org/lkml/2010/5/20/227

So I guess there is no need for replaying it, I think we're in complete 
agreement.

That being said, benff Kconfig setting definitely escaped attention. That 
should never ever have been set to default y, I take blame for not 
noticing that while applying the patch.

Thanks,

-- 
Jiri Kosina
SUSE Labs
