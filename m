From: Daniel Mack <daniel-rDUAYElUppE@public.gmane.org>
Subject: Re: [PATCH 2/4] isl29020: ambient light sensor
Date: Thu, 15 Apr 2010 08:20:23 +0200
Message-ID: <20100415062023.GG30801@buzzloop.caiaq.de>
References: <20100414124913.23181.75903.stgit@localhost.localdomain>
 <20100414125147.23181.5817.stgit@localhost.localdomain>
 <20100414224542.GX30807@buzzloop.caiaq.de>
 <20100414233554.3f020155@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20100414233554.3f020155-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 14, 2010 at 11:35:54PM +0100, Alan Cox wrote:
> > Would it be possible to make the existing driver for the ISL29003
> > support the ISL29020 as well?
> 
> I dug the manuals out for these to take a look - the answer is they are
> quite different chips. 

Hmm, sad :(

However, the driver should be applied to the ALS tree after all, unless
Jonathan plans to drop the whole thing, which I doubt.

Thanks,
Daniel
