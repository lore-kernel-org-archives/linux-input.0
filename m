From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 02/06] input/rmi4: Core files
Date: Sat, 17 Nov 2012 13:54:15 -0800
Message-ID: <20121117215415.GA5624@kroah.com>
References: <1353124734-16803-1-git-send-email-cheiny@synaptics.com>
 <1353124734-16803-3-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353124734-16803-3-git-send-email-cheiny@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Allie Xiong <axiong@synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Alexandra Chin <alexandra.chin@tw.synaptics.com>, Joerie de Gram <j.de.gram@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 16, 2012 at 07:58:50PM -0800, Christopher Heiny wrote:
> +static void release_rmidev_device(struct device *dev)
> +{
> +	device_unregister(dev);
> +}

You just leaked memory here, right?

Also, you already unregistered the device, otherwise this function would
have never been called, so you just ended up in a loop?

Have you ever tried removing a device?  Are you sure it's working
properly?

> +EXPORT_SYMBOL(rmi_register_phys_device);

Just curious, but why not EXPORT_SYMBOL_GPL() on all of these new
symbols you are creating?

thanks,

greg k-h
