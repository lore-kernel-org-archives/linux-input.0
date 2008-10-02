From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Input: add mmio xi driver
Date: Wed, 1 Oct 2008 23:12:16 -0700
Message-ID: <20081001231216.68c7328d.akpm@linux-foundation.org>
References: <20080925232237.GA22938@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47777 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753983AbYJBGMd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Oct 2008 02:12:33 -0400
In-Reply-To: <20080925232237.GA22938@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, phil@hannent.co.uk, mwilder@cs.nmsu.edu

> On Thu, 25 Sep 2008 16:22:37 -0700 Greg KH <gregkh@suse.de> wrote:
> 
> From: Greg Kroah-Hartman <gregkh@suse.de>

Is this true?

> This patch adds the Mimio Xi interactive whiteboard driver to the tree.
> 
> It was originally written by mwilder@cs.nmsu.edu, but cleaned up and
> forward ported by me to the latest kernel version.

Oh.  Tricky.
 
>
> ...
>
> +#define isvalidtxsize(n)	((n) > 0 && (n) <= MIMIO_MAXPAYLOAD)

grumble.

- should be written in C

- buggy when passed expresion-with-side-effects.

>
> ...
>
> +static DECLARE_MUTEX(disconnect_sem);

ooh, a semaphore - I remember them.

checkpatch used to warn about newly-added semaphores but a) it broke and
b) this patch doesn't seem to have met checkpatch.

>
> ...
>
> +static int mimio_greet(struct mimio *mimio)
> +{
> +	const struct grtpkt {
> +		int nbytes;
> +		unsigned delay;
> +		char data[8];
> +	} grtpkts[] = {
> +		{ 3, 0, { 0x11, 0x55, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00 } },
> +		{ 5, 0, { 0x53, 0x55, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00 } },
> +		{ 5, 0, { 0x43, 0x55, 0x00, 0x00, 0x16, 0x00, 0x00, 0x00 } },
> +		{ 5, 0, { 0x33, 0x55, 0x00, 0x00, 0x66, 0x00, 0x00, 0x00 } },
> +		{ 5, 0, { 0x13, 0x00, 0x5e, 0x02, 0x4f, 0x00, 0x00, 0x00 } },
> +		{ 5, 0, { 0x13, 0x00, 0x04, 0x03, 0x14, 0x00, 0x00, 0x00 } },
> +		{ 5, 2, { 0x13, 0x00, 0x00, 0x04, 0x17, 0x00, 0x00, 0x00 } },
> +		{ 5, 0, { 0x13, 0x00, 0x0d, 0x08, 0x16, 0x00, 0x00, 0x00 } },
> +		{ 5, 0, { 0x13, 0x00, 0x4d, 0x01, 0x5f, 0x00, 0x00, 0x00 } },
> +		{ 3, 0, { 0xf1, 0x55, 0xa4, 0x00, 0x00, 0x00, 0x00, 0x00 } },
> +		{ 7, 2, { 0x52, 0x55, 0x00, 0x07, 0x31, 0x55, 0x64, 0x00 } },
> +		{ 0, 0, { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 } },
> +	};

I believe that gcc does the right thing here, but an explict `static' would set
minds at ease.


