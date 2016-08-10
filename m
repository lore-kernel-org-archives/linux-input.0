From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt: bindings: Remove focaltech,ft6236 binding
Date: Wed, 10 Aug 2016 15:17:07 -0500
Message-ID: <20160810201707.GA23642@rob-hp-laptop>
References: <1470677879-5907-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1470677879-5907-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Mon, Aug 08, 2016 at 07:37:59PM +0200, Hans de Goede wrote:
> The focaltech ft6236 are i2c protocol compatible with other chips supported
> by the edt,ft5x06 driver. The duplicate ft6236 driver has already been
> removed from the kernel.
> 
> This commit removes the duplicate binding to match, adding its compatible
> string to the edt,ft5x06 binding.
> 
> This commit also adds the standard touchscreen properties as optional
> properties to the edt,ft5x06 binding, these were documented in the
> focaltech,ft6236 binding but missing from the edt,ft5x06 doc.
> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |  8 +++++
>  .../input/touchscreen/focaltech-ft6236.txt         | 35 ----------------------
>  2 files changed, 8 insertions(+), 35 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6236.txt

The subject is a bit misleading, but:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
