From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] Input: bcm5974 - Fix USB autosuspend
Date: Mon, 12 Dec 2011 10:02:52 +0100
Message-ID: <201112121002.53004.oneukum@suse.de>
References: <1323680764-2155-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33660 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105Ab1LLJB0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Dec 2011 04:01:26 -0500
In-Reply-To: <1323680764-2155-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg@redhat.com>

Am Montag, 12. Dezember 2011, 10:06:04 schrieb Henrik Rydberg:
> @@ -895,6 +857,10 @@ static int bcm5974_probe(struct usb_interface *iface,
>         /* save our data pointer in this interface device */
>         usb_set_intfdata(iface, dev);
>  
> +       error = bcm5974_start_traffic(dev);
> +       if (error)
> +               goto err_free_buffer;
> +
>         return 0;
>  
>  err_free_buffer:
> -- 

Why do you want to start traffic before open() in probe() ?
It doesn't make sense to ask a device to deliver data nobody
wants.

	Regards
		Oliver
