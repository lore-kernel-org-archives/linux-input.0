From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/2] ads7846: Make buffers in ads7846_read12_ser and ads7845_read12_ser
 DMA save
Date: Wed, 04 May 2011 16:55:04 +0100
Message-ID: <4DC176D8.70900@cam.ac.uk>
References: <544AC56F16B56944AEC3BD4E3D5917713AAF0732D8@LIMKCMBX1.ad.analog.com> <1304522525-27351-1-git-send-email-alexander.stein@systec-electronic.com> <4DC175A4.6060401@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:55035 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115Ab1EDPwm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2011 11:52:42 -0400
In-Reply-To: <4DC175A4.6060401@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Michael Hennerich <Michael.Hennerich@analog.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Anatolij Gustschin <agust@denx.de>

On 05/04/11 16:49, Jonathan Cameron wrote:
> On 05/04/11 16:22, Alexander Stein wrote:
>> req.sample needs its own cacheline otherwise accessing req.msg fetches
>> it in again.
>> Put req onto stack as it doesn't need to be DMA save.
>> req.sample is kzalloced itself for DMA access.
>> req.command doesn't need own cache line because it will only be written to
>> memory on dma_map_single. req.scratch is unsed at all.
>>
>> Note: This effect doesn't occur if the underlying SPI driver doesn't use
>> DMA at all.
>>
> How about using ____cacheline_aligned having moved 'sample' to the end of the
> structure?
> 
> e.g.
> 
> ...
> struct spi_transfer xfer[6];
> __be16  sample ____cacheline_aligned;
> }
hmm. I should probably have glanced further up the thread. Michael beat me to it
with the same suggestion!
