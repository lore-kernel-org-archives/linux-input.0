From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Fwd:  autosuspend for appletouch driver
Date: Thu, 27 Sep 2007 11:59:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0709271158410.7735-100000@iolanthe.rowland.org>
References: <200709270829.48079.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200709270829.48079.oliver@neukum.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Oliver Neukum <oliver@neukum.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-usb-devel@lists.sourceforge.net, Richard Guenther <rguenther@suse.de>, Matthew Garrett <mjg59@srcf.ucam.org>, Soeren Sonnenburg <kernel@nn7.de>, Thomas Rohwer <tr@tng.de>
List-Id: linux-input@vger.kernel.org

On Thu, 27 Sep 2007, Oliver Neukum wrote:

> @@ -528,12 +537,20 @@ exit:
>  static int atp_open(struct input_dev *input)
>  {
>  	struct atp *dev = input_get_drvdata(input);
> +	int rv = 0;
>  
> -	if (usb_submit_urb(dev->urb, GFP_ATOMIC))
> +	if (usb_autopm_get_interface(dev->intf) < 0)
>  		return -EIO;
> +	dev->intf->needs_remote_wakeup = 1;
> +	if (usb_submit_urb(dev->urb, GFP_KERNEL)) {
> +		rv = -EIO;
> +		dev->intf->needs_remote_wakeup = 0;
> +		goto err;
>  
>  	dev->open = 1;
> -	return 0;
> +err:
> +	usb_autopm_put_interface(dev->intf);
> +	return rv;
>  }
>  
>  static void atp_close(struct input_dev *input)
> @@ -543,6 +560,7 @@ static void atp_close(struct input_dev *
>  	usb_kill_urb(dev->urb);
>  	cancel_work_sync(&dev->work);
>  	dev->open = 0;
> +	dev->intf->needs_remote_wakeup = 0;
>  }

Doesn't atp_close() need to call usb_autopm_put_interface(), to balance 
the usb_autopm_get_interface() call in atp_open()?

Alan Stern
