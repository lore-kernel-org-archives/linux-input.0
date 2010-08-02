From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH 09/13] IR: add helper function for hardware with small
 o/b buffer.
Date: Mon, 2 Aug 2010 11:54:05 -0400
Message-ID: <20100802155405.GD2296@redhat.com>
References: <1280588366-26101-1-git-send-email-maximlevitsky@gmail.com>
 <1280588366-26101-10-git-send-email-maximlevitsky@gmail.com>
 <1280715061.19666.47.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-media-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1280715061.19666.47.camel@localhost>
Sender: linux-media-owner@vger.kernel.org
To: Andy Walls <awalls@md.metrocast.net>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, lirc-list@lists.sourceforge.net, Jarod Wilson <jarod@wilsonet.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Mauro Carvalho Chehab <mchehab@redhat.com>, Christoph Bartelmus <lirc@bartelmus.de>
List-Id: linux-input@vger.kernel.org

On Sun, Aug 01, 2010 at 10:11:01PM -0400, Andy Walls wrote:
> On Sat, 2010-07-31 at 17:59 +0300, Maxim Levitsky wrote:
...
> >  struct ir_input_dev {
> > @@ -69,9 +81,10 @@ struct ir_input_dev {
> >  	char				*driver_name;	/* Name of the driver module */
> >  	struct ir_scancode_table	rc_tab;		/* scan/key table */
> >  	unsigned long			devno;		/* device number */
> > -	const struct ir_dev_props	*props;		/* Device properties */
> > +	struct ir_dev_props		*props;		/* Device properties */
> 
> So I don't think the struct ir_dev_props structure is the right place to
> be storing current operating parameters. IMO, operating parameters
> stored in the ir_dev_props are "too far" from the lower level driver,
> and are essentially mirroring what the low level driver should be
> tracking internally as it's own state anyway.
> 
> 
> So in summary, I think we need to keep the opertions in struct
> ir_dev_props simple using ,get_parameters() and .set_parameters() to
> contol the lower level driver and to fetch, retrieve, and store
> parameters.

Yeah, I neglected to consider this change the first pass through an
earlier revision. Making props modifiable on the fly does feel like we're
mixing up hardware features with hardware state, and perhaps the
on-the-fly-modifiable state bits should be stored somewhere else.

-- 
Jarod Wilson
jarod@redhat.com
