From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: evdev - Flush queues during EVIOCGKEY-like
 ioctls
Date: Wed, 27 Mar 2013 22:06:35 -0700
Message-ID: <20130328050635.GA2812@core.coreip.homeip.net>
References: <1364431764-31378-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:49891 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab3C1FGh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Mar 2013 01:06:37 -0400
Received: by mail-pb0-f54.google.com with SMTP id rq13so1587338pbb.13
        for <linux-input@vger.kernel.org>; Wed, 27 Mar 2013 22:06:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364431764-31378-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Mar 28, 2013 at 01:49:24AM +0100, David Herrmann wrote:
> +	spin_lock_irq(&dev->event_lock);
> +	spin_lock(&client->buffer_lock);
> +
> +	ret = bits_to_user(bits, max, size, p, compat);

This copies data to userspace and thus may sleep. You can not hold spinlocks
here.

I think you need to collect the data, flush the events and then try
copying the data out. If we fail on copying data out - too bad. Maybe we
can stuff SYN_DROPPED in the queue, but it is not really necessary.

Thanks.

-- 
Dmitry
