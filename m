From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] input: touchscreen: silead_gsl1680: Document
 firmware-name, fix implementation
Date: Fri, 2 Sep 2016 09:39:48 -0500
Message-ID: <20160902143948.GA6214@rob-hp-laptop>
References: <20160829192937.32129-1-hdegoede@redhat.com>
 <20160829192937.32129-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160829192937.32129-2-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 29, 2016 at 09:29:36PM +0200, Hans de Goede wrote:
> The driver has supported touchscreen-fw-name to specify the firmware to
> load since it has been merged, but this was omitted from the dt-binding
> documentation.
> 
> During review of adding touchscreen-fw-name to the binding documentation
> it was brought up that there is a standard property name called
> "firmware-name" for this, which should be used.
> 
> Since there are no users of touchscreen-fw-name yet, this commit
> adds documentation of "firmware-name" to the dt-binding documentation
> and switches the driver over to use this.
> 
> This commit also makes the driver add a "silead/" prefix to the
> firmware name from dt before calling request_firmware. That the
> firmware files are stored under /lib/firmware/silead under Linux
> is an implementation detail and does not belong in devicetree.
> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt         | 1 +
>  drivers/input/touchscreen/silead.c                                   | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
