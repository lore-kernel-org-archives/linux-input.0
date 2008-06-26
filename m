From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch]reliably killing urbs in yealink driver
Date: Thu, 26 Jun 2008 10:26:34 -0400
Message-ID: <20080626142633.GA16831@anvil.corenet.prv>
References: <200806261344.32326.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.189]:22816 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbYFZO0n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Jun 2008 10:26:43 -0400
Received: by rn-out-0910.google.com with SMTP id k40so62822rnd.17
        for <linux-input@vger.kernel.org>; Thu, 26 Jun 2008 07:26:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200806261344.32326.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Alfred E. Heggestad" <aeh@db.org>, Jiri Kosina <jkosina@suse.cz>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Henk.Vergonet@gmail.com

Hi Oliver,

On Thu, Jun 26, 2008 at 01:44:30PM +0200, Oliver Neukum wrote:
> @@ -809,8 +831,7 @@ static int usb_cleanup(struct yealink_de
>  	if (yld == NULL)
>  		return err;
>  
> -	usb_kill_urb(yld->urb_irq);	/* parameter validation in core/urb */
> -	usb_kill_urb(yld->urb_ctl);	/* parameter validation in core/urb */
> +	stop_traffic(yld);

stop_traffic is unneeded here since input core guarantees that close is
called when you unregister and opened device. Do you have the hardware
to test? If not I will fold stop_traffic back into yealink_close
locally.

-- 
Dmitry
