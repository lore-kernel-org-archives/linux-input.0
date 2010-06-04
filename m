From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] input: evdev: Convert to dynamic event buffer (rev3)
Date: Thu, 3 Jun 2010 23:37:34 -0700
Message-ID: <20100604063734.GD21239@core.coreip.homeip.net>
References: <1275552062-8153-1-git-send-email-rydberg@euromail.se>
 <1275552062-8153-2-git-send-email-rydberg@euromail.se>
 <1275552062-8153-3-git-send-email-rydberg@euromail.se>
 <1275552062-8153-4-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:41771 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab0FDGhk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Jun 2010 02:37:40 -0400
Content-Disposition: inline
In-Reply-To: <1275552062-8153-4-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>, Benjamin Tissoires <tissoire@cena.fr>, Rafi Rubin <rafi@seas.upenn.edu>

On Thu, Jun 03, 2010 at 10:01:01AM +0200, Henrik Rydberg wrote:
>  
> +	evdev->bufsize = evdev_compute_buffer_size(dev);
> +	evdev->buffer = kzalloc(evdev->bufsize * sizeof(struct input_event),
> +				GFP_KERNEL);

kcalloc().

> +	if (!evdev->buffer) {
> +		error = -ENOMEM;
> +		goto err_free_evdev;
> +	}
> +
>  	error = input_register_handle(&evdev->handle);
>  	if (error)
>  		goto err_free_evdev;

-- 
Dmitry
