From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/2] ads7846: Make buffers in ads7846_read12_ser and ads7845_read12_ser
 DMA save
Date: Wed, 04 May 2011 17:07:01 +0100
Message-ID: <4DC179A5.2080109@cam.ac.uk>
References: <544AC56F16B56944AEC3BD4E3D5917713AAF0732D8@LIMKCMBX1.ad.analog.com> <1304522525-27351-1-git-send-email-alexander.stein@systec-electronic.com> <4DC175A4.6060401@cam.ac.uk> <201105041755.24184.alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:53358 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab1EDQEj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2011 12:04:39 -0400
In-Reply-To: <201105041755.24184.alexander.stein@systec-electronic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anatolij Gustschin <agust@denx.de>

On 05/04/11 16:55, Alexander Stein wrote:
> Hello,
> 
> Am Mittwoch, 4. Mai 2011, 17:49:56 schrieb Jonathan Cameron:
>> On 05/04/11 16:22, Alexander Stein wrote:
>>> req.sample needs its own cacheline otherwise accessing req.msg fetches
>>> it in again.
>>> Put req onto stack as it doesn't need to be DMA save.
>>> req.sample is kzalloced itself for DMA access.
>>> req.command doesn't need own cache line because it will only be written
>>> to memory on dma_map_single. req.scratch is unsed at all.
>>>
>>> Note: This effect doesn't occur if the underlying SPI driver doesn't use
>>> DMA at all.
>>
>> How about using ____cacheline_aligned having moved 'sample' to the end of
>> the structure?
>>
>> e.g.
>>
>> ...
>> struct spi_transfer xfer[6];
>> __be16  sample ____cacheline_aligned;
>> }
>>
>> Rather smaller patch when you get down to it.
> 
> Mh, I didn't know I had to reorder the struct elements to use 
> ____cacheline_aligned. I originally had a solution in mind with a smaller 
> memory footprint in mind, but rethinking about it, this might be negligible if 
> there is one at all.
> So, if ____cacheline_aligned is the more sane approach I'll resend a patch 
> using it.
It simply enforces that element being aligned. Thus if there is anything after it
you may well have things in the same cacheline.  Obviously you could use
align the following element to ensure its on the next cache line, but thats
silly when you can just reorder to make sure nothing is there. All mallocs
are guaranteed to get a whole number of cachelines. (would be really fiddly
otherwise!)  Footprint wise, it should be pretty trivial.
