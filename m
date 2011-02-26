From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] input: evdev: Add a read() callback
Date: Sat, 26 Feb 2011 09:45:08 +0000
Message-ID: <20110226094507.GA13253@opensource.wolfsonmicro.com>
References: <1298297930-3937-1-git-send-email-bgat@billgatliff.com>
 <20110222002315.GA18299@sirena.org.uk>
 <AANLkTik8d1KZd_qSr2tKrBHq2X-9agA1BG7guK1SqzAd@mail.gmail.com>
 <20110222043302.GD18299@sirena.org.uk>
 <AANLkTikWA3Vsa2O4_yi1L78_xX18_7WqVKqhTaD1-6Wm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47367 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751656Ab1BZJo5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Feb 2011 04:44:57 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikWA3Vsa2O4_yi1L78_xX18_7WqVKqhTaD1-6Wm@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org, linux-embedded@vger.kernel.org

On Fri, Feb 25, 2011 at 08:46:24PM -0600, Bill Gatliff wrote:
> On Mon, Feb 21, 2011 at 10:33 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:

> > But surely the most obvious solution here is to standardise a rate
> > control interface?

> Yes, and no.  A standardized rate control interface would deal with
> the rate control problem, but leave the synchronization problem
> unsolved.

The main source of the problem with delayed readings was that
applications weren't blocking waiting for events.  If applications block
waiting for events then the data will be delivered to them promptly.
For cases where multiple readings need to be synced IIO looks like the
way forward.

> > The problem you're trying to solve is also an issue for really common
> > and standard things like touchscreens and polled switches/keys (the
> > latter of which you mentioned in your mail) which are used by standard
> > applications.

> The existing "polled switch" implementation sets up a throttled
> polling loop in kernel code.  The "polled switch" that I was thinking
> of when I wrote the essay for the commit was "a switch that is polled
> each time read() gets called".  I should have been clearer--- and
> probably picked a different name.  :)

It's the same thing, though - I'd really expect it to be handled by the
same code in kernel.
