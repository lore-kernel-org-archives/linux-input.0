From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] ad7877: keep dma rx buffers in seperate cache lines
Date: Mon, 10 May 2010 14:22:25 -0700
Message-ID: <20100510142225.4bf215ef.akpm@linux-foundation.org>
References: <1273487642-2169-1-git-send-email-os@emlix.com>
	<1273488154-2993-1-git-send-email-os@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48020 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752084Ab0EJVXQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 17:23:16 -0400
In-Reply-To: <1273488154-2993-1-git-send-email-os@emlix.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oskar Schirmer <os@emlix.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel =?ISO-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>, Oliver Schneidewind <osw@emlix.com>, Johannes Weiner <jw@emlix.com>

On Mon, 10 May 2010 12:42:34 +0200
"Oskar Schirmer" <os@emlix.com> wrote:

> With dma based spi transmission, data corruption
> is observed occasionally. With dma buffers located
> right next to msg and xfer fields, cache lines
> correctly flushed in preparation for dma usage
> may be polluted again when writing to fields
> in the same cache line.
> 
> Make sure cache fields used with dma do not
> share cache lines with fields changed during
> dma handling. As both fields are part of a
> struct that is allocated via kzalloc, thus
> cache aligned, moving the fields to the 1st
> position and insert padding for alignment
> does the job.

This sounds odd.  Doesn't it imply that some code somewhere is missing
some DMA synchronisation actions?

> 
> v2: add a comment to explain why alignment is needed
> 
> v3: fix the typo in comment and layout (- to end of line)
> 
> diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
> index 885354c..9ebb1b4 100644
> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -153,15 +153,29 @@ enum {
>   */
>  
>  struct ser_req {
> +	u16			sample;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	char			__padalign[L1_CACHE_BYTES - sizeof(u16)];

It would be better to use __cacheline_aligned, rather than open-coding
things in this manner.

