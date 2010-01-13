From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] TiVo USB IR Dongle support
Date: Tue, 12 Jan 2010 23:53:08 -0800
Message-ID: <20100113075308.GB3242@core.coreip.homeip.net>
References: <20091206214543.GA5290@acer.drzhang.net>
 <20091212190143.GA3591@acer.drzhang.net>
 <20091212233259.GB16760@core.coreip.homeip.net>
 <20091214220059.GA16776@drzhang.net>
 <20091214222843.GE2373@core.coreip.homeip.net>
 <20091216005357.GA23449@drzhang.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:57260 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499Ab0AMHxP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2010 02:53:15 -0500
Received: by pwj9 with SMTP id 9so2684290pwj.21
        for <linux-input@vger.kernel.org>; Tue, 12 Jan 2010 23:53:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091216005357.GA23449@drzhang.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chaogui Zhang <czhang@marywood.edu>
Cc: linux-input@vger.kernel.org

Hi Chaogui,

I was looking at the driver again and I have some concerns with the
foolowing fragment:

On Tue, Dec 15, 2009 at 07:53:57PM -0500, Chaogui Zhang wrote:
> +
> +	/* The lower 5 bits of the first byte of each packet indicates the size
> +	 * of the transferred buffer, not including the first byte itself.
> +	 */
> +
> +	length = (remote->in_buffer[0]) & 0x1f;
> +	for (i = 0; i <= length; i++)
> +		snprintf(codes + i * 3, 4, "%02x ", remote->in_buffer[i]);
> +
> +	/* 0x80 at the end of a regular packet or in a separate packet
> +	   indicates key release */
> +
> +	if (i < TIVOIR_RECV_SIZE && remote->in_buffer[i] == 0x80)
> +		snprintf(codes + i * 3, 4, "%02x ", remote->in_buffer[i]);
> +

So does this mean that 0x80 indicating release is not included in the
size of the received packet.

Thanks.

-- 
Dmitry
