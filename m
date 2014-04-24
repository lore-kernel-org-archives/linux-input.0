From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209 support to
	various boards
Date: Thu, 24 Apr 2014 17:35:23 +0100
Message-ID: <20140424163523.GB25663@opensource.wolfsonmicro.com>
References: <1397209093-10077-8-git-send-email-carlo@caione.org> <20140411122901.GE28800@sirena.org.uk> <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com> <20140411161813.GF28800@sirena.org.uk> <CAOQ7t2YO_MjUZkkoEe1Grft+fVttWoOro85Sru2P3LXbx8Kjbg@mail.gmail.com> <20140418151551.GZ12304@sirena.org.uk> <20140423202546.GA3890@nuc.fastwebnet.it> <20140424133036.GY12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140424133036.GY12304@sirena.org.uk>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Carlo Caione <carlo@caione.org>, boris.brezillon@free-electrons.com, sameo@linux.intel.com, linux-doc@vger.kernel.org, emilio@elopez.com.ar, dmitry.torokhov@gmail.com, wens@csie.org, lgirdwood@gmail.com, hdegoede@redhat.com, linux-sunxi@googlegroups.com, linux-input@vger.kernel.org, maxime.ripard@free-electrons.com, lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Thu, Apr 24, 2014 at 02:30:36PM +0100, Mark Brown wrote:
> On Wed, Apr 23, 2014 at 10:25:46PM +0200, Carlo Caione wrote:
> 
> > I'm having a really hard time with this problem, so any hint is welcome
> > :) The small modification I'm using on top of the patches in this series
> > is here: http://bpaste.net/show/228330/
> 
> > Unfortunately as I said I got this when booting:
> > http://bpaste.net/show/nUhUTzELT32v9HNPathL/
> 
> Huh, actually the arizona drivers do show this (it was being masked in
> my logs by another unrelated bug).  I guess the Wolfson guys aren't
> working with upstream much (though Charles did write the orignal code
> here...).

I run upstream fairly regularly here (although mostly on Arndale
rather than Speyside). On closer inspection of my kernel log
don't seem to have anything related to it, which is odd.

> The issue is the MFD core, it shouldn't be using managed allocations
> here - the error reported by the assert is entirely correct.  If the
> CODEC driver is bound and unbound it'll not be possible to reload it
> as things stand.  
> 
> Your driver is correct but the implementation needs to be fixed -
> possibly with an API change on free since at the minute the cells to be
> freed don't get passed back into the MFD core when deallocating.

This does indeed look broken, I will have a look and think about it.
Unfortunately I am travelling most of next week, so if I don't
manage to get something out over the weekend there may be a slight
delay on me getting a fix out.

Thanks,
Charles
