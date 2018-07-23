From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] touchscreen: elants: Use octal permissions
Date: Mon, 23 Jul 2018 15:32:00 +0200
Message-ID: <20180723133200.GA1167@kroah.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
 <20180723131954.30739-4-harshitjain6751@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180723131954.30739-4-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dev-harsh1998 <harshitjain6751@gmail.com>
Cc: trivial@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Luca Ceresoli <luca@lucaceresoli.net>, Joe Perches <joe@perches.com>, Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jul 23, 2018 at 06:49:20PM +0530, dev-harsh1998 wrote:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);
> 
> WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> +static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw)
> 
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +		.dattr = __ATTR(_field, S_IRUGO,			\
> 
> Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>

This name doesn't match up with the From: line above :(

Please fix up and try again.

thanks,

greg k-h
