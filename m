From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Implement driver for Topaz signature pads
Date: Fri, 5 May 2017 15:35:29 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705051532590.26873@cbobk.fhfr.pm>
References: <20170407221018.vvav4f46e5c6ojfh@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170407221018.vvav4f46e5c6ojfh@debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org, benjamin.tissoires@redhat.com, b.zolnierkie@samsung.com
List-Id: linux-input@vger.kernel.org

On Fri, 7 Apr 2017, Alyssa Rosenzweig wrote:

> diff --git a/drivers/hid/hid-topaz.c b/drivers/hid/hid-topaz.c
> new file mode 100644
> index 000000000000..92a8f34a367f
> --- /dev/null
> +++ b/drivers/hid/hid-topaz.c
[ ... snip ... ]
> +static int topaz_send(struct hid_device *dev, u8 *packet, size_t sz)
> +{
> +	int ret;
> +
> +	u8 *buf = kmemdup(packet, sz, GFP_KERNEL);
> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (!dev->ll_driver->output_report)
> +		return -ENODEV;

Memory pointed to by *buf is leaked here.

> +static int topazfb_probe(struct hid_device *dev)
> +{
> +	struct fb_info *info;
> +	struct topazfb_par *par;
> +
> +	info = framebuffer_alloc(sizeof(struct topazfb_par), NULL);
> +
> +	par = info->par;
> +	par->hid = dev;
> +
> +	info->fbops = &topazfb_ops;
> +	info->fix = topazfb_fix;
> +	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_IMAGEBLIT
> +				     | FBINFO_HWACCEL_FILLRECT;
> +
> +	/* this is only a pseudo frame buffer device */
> +	info->screen_base = NULL;
> +	info->screen_size = 0;
> +
> +	/* LBK766 is 320x240; other models may differ */
> +	info->var.xres = 320;
> +	info->var.yres = 240;
> +
> +	info->var.bits_per_pixel = 1;
> +	info->var.grayscale = 1;
> +	info->var.red.offset = 0;
> +	info->var.red.length = 1;
> +	info->var.green.offset = 0;
> +	info->var.green.length = 1;
> +	info->var.blue.offset = 0;
> +	info->var.blue.length = 1;
> +	info->var.transp.offset = 0;
> +	info->var.transp.length = 1;
> +
> +	if (register_framebuffer(info) < 0)
> +		return -EINVAL;

Another leak (*info) here?

[ ... snip ... ]
> +static const struct hid_device_id topaz_devices[] = {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPAZ, USB_DEVICE_ID_TOPAZ_LBK766) },
> +	{ }
> +};

You have to add this to hid_have_special_driver[] as well

Thanks,

-- 
Jiri Kosina
SUSE Labs
