From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] ad7877: keep dma rx buffers in seperate cache lines
Date: Mon, 10 May 2010 23:20:15 -0400
Message-ID: <20100510232015.0a9f653a.akpm@linux-foundation.org>
References: <1273487642-2169-1-git-send-email-os@emlix.com>
	<1273488154-2993-1-git-send-email-os@emlix.com>
	<20100510142225.4bf215ef.akpm@linux-foundation.org>
	<20100511060547.GA9644@core.coreip.homeip.net>
	<AANLkTikA9s6lpO2uDuIup8BwGOYYHQ9yQxS36PBSIttX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikA9s6lpO2uDuIup8BwGOYYHQ9yQxS36PBSIttX@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Oskar Schirmer <os@emlix.com>, Michael Hennerich <Michael.Hennerich@analog.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel =?ISO-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>
List-Id: linux-input@vger.kernel.org

On Tue, 11 May 2010 02:11:41 -0400 Mike Frysinger <vapier.adi@gmail.com> wrote:

> > __ __ __ __unsigned __ __ __ __ __ __ __ __pending:1; __ __ __/* P: lock */
> > +
> > + __ __ __ /*
> > + __ __ __ __* DMA (thus cache coherency maintenance) requires the
> > + __ __ __ __* transfer buffers to live in their own cache lines.
> > + __ __ __ __*/
> > + __ __ __ u16 conversion_data[AD7877_NR_SENSE] ____cacheline_aligned;
> > __};

(^^stupid gmail)

> i'm not sure this is correct.  the cached_aligned attribute makes sure
> it starts on a cache boundary, but it doesnt make sure it pads out to
> one.  so it might work more of the time, but i dont think it's
> guaranteed.

yup.  You'd need to put something like

	int pad ____cacheline_aligned;

_after_ the trashable field.

Then look at the .s file and make sure it came out right ;)
