From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] ads7846: Make buffers in ads7846_read12_ser and
 ads7845_read12_ser DMA save
Date: Wed, 4 May 2011 18:31:40 -0700
Message-ID: <20110505013140.GA28813@core.coreip.homeip.net>
References: <544AC56F16B56944AEC3BD4E3D5917713AAF0732D8@LIMKCMBX1.ad.analog.com>
 <1304522525-27351-1-git-send-email-alexander.stein@systec-electronic.com>
 <4DC175A4.6060401@cam.ac.uk>
 <201105041755.24184.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59828 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab1EEBbs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2011 21:31:48 -0400
Received: by pwi15 with SMTP id 15so770734pwi.19
        for <linux-input@vger.kernel.org>; Wed, 04 May 2011 18:31:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201105041755.24184.alexander.stein@systec-electronic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Michael Hennerich <Michael.Hennerich@analog.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Anatolij Gustschin <agust@denx.de>

On Wed, May 04, 2011 at 05:55:23PM +0200, Alexander Stein wrote:
> Hello,
> 
> Am Mittwoch, 4. Mai 2011, 17:49:56 schrieb Jonathan Cameron:
> > On 05/04/11 16:22, Alexander Stein wrote:
> > > req.sample needs its own cacheline otherwise accessing req.msg fetches
> > > it in again.
> > > Put req onto stack as it doesn't need to be DMA save.
> > > req.sample is kzalloced itself for DMA access.
> > > req.command doesn't need own cache line because it will only be written
> > > to memory on dma_map_single. req.scratch is unsed at all.
> > > 
> > > Note: This effect doesn't occur if the underlying SPI driver doesn't use
> > > DMA at all.
> > 
> > How about using ____cacheline_aligned having moved 'sample' to the end of
> > the structure?
> > 
> > e.g.
> > 
> > ...
> > struct spi_transfer xfer[6];
> > __be16  sample ____cacheline_aligned;
> > }
> > 
> > Rather smaller patch when you get down to it.
> 
> Mh, I didn't know I had to reorder the struct elements to use 
> ____cacheline_aligned. I originally had a solution in mind with a smaller 
> memory footprint in mind, but rethinking about it, this might be negligible if 
> there is one at all.
> So, if ____cacheline_aligned is the more sane approach I'll resend a patch 
> using it.
> 

Yes, please, as ____cacheline_aligned introduces the least amount of the
churn (and I like it better than separately doing kmalloc anyway) and I
should be able to get it in .39.

Thanks.

-- 
Dmitry
