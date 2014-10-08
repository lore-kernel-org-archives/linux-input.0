From: Richard Leitner <me@g0hl1n.net>
Subject: Re: [PATCH] input: avoid negative input device numbers
Date: Wed, 8 Oct 2014 23:49:27 +0200
Message-ID: <20141008234927.5c4b8492@frodo>
References: <20141008224245.601a1339@frodo>
	<20141008212538.GB15198@dtor-ws>
	<20141008213051.GD15198@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141008213051.GD15198@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, richard.leitner@skidata.com
List-Id: linux-input@vger.kernel.org

On Wed, 8 Oct 2014 14:30:51 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Wed, Oct 08, 2014 at 02:25:38PM -0700, Dmitry Torokhov wrote:
> > On Wed, Oct 08, 2014 at 10:42:45PM +0200, Richard Leitner wrote:
> > > From: Richard Leitner <richard.leitner@skidata.com>
> > > 
> > > Fix the format string for input device name generation to avoid
> > > negative device numbers when the id exceeds the maximum signed
> > > integer value.
> > 
> > Well, it is going to take us a while to get there :)
> > 
> > Applied, thank you.
> 
> By the way, we have similar issue in serio and gameport code, mind
> sending fixes for them as well?
> 
I'll send a patch for the serio in a few minutes.

The gameport code looks fine to me:

536		dev_set_name(&gameport->dev, "gameport%lu",
537				(unsigned long)atomic_inc_return(&gameport_no) - 1);

regards,
richard
