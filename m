From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] touchscreen: elants: Use octal permissions
Date: Sun, 22 Jul 2018 11:39:58 +0200
Message-ID: <20180722093958.GB13612@kroah.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
 <20180721191029.25658-4-harshitjain6751@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180721191029.25658-4-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dev-harsh1998 <harshitjain6751@gmail.com>
Cc: trivial@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andi Shyti <andi@etezian.org>, Simon Budig <simon.budig@kernelconcepts.de>, Luca Ceresoli <luca@lucaceresoli.net>, Guenter Roeck <linux@roeck-us.net>, Joe Perches <joe@perches.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Jul 22, 2018 at 12:39:45AM +0530, dev-harsh1998 wrote:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +static DEVICE_ATTR(iap_mode, S_IRUGO, show_iap_mode, NULL);
> 
> WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
> +static DEVICE_ATTR(update_fw, S_IWUSR, NULL, write_update_fw)
> 
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> +		.dattr = __ATTR(_field, S_IRUGO,			\
> 
> Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>

You need to use your real name when creating Linux kernel patches.

thanks,

greg k-h
