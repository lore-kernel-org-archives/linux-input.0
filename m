Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232217;
	b=pjAzJ47FAru5zq3UyEaiDDOpfMFPA5OJOIrchMAo/mw26nsxhAl9LwOAhdyShM5TIrI5
	 57RBggr+ArgmGY5XgSYlBidPO7XenagddKIiQa38wiwLjLcvNEPRe3Xim3Mo+D2ecwrDc
	 5yv88ZeNtTqkujcoRmKc4kZeZ4EfTtzN5LOzdvDZQAkjV4wmOrPp9BHkM5hL0ZQHDA0Fk
	 o7/M3vBQl88lxqeq1VJagthzMDY9EFEdSW1Lsz1+5LtjnH5LU+M9RA5UXOkzzW2Ny78f/
	 AbOhNiA/mN2M+VVLR5/qV3+wyoqvIa7jcSFKfyi8FgPw4QTKb5Rdbw7KBHiQI/vUscw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232217;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=sV80kwdjYfS3SgzsxQOfUc8arMNq3DrwT8oNR3+rv4o=;
	b=KKUppfiu6LohyOAgwtb2Z1qDQhtPRa5lqemSI4bOMqaovN3nxz1SM7QpBcvUDN/3jf3f
	 z1u6omYqyCxCLugthnSctHPZv4h0lRlsSHkV/WRbthOQcb1u1tCoA6kusCa4OqYl5X1FH
	 QxAW1at6jqoDuKPhRgTG842DQL7kPdHfPL1Xwkiar0o5AepV6arRV3AB8x2Bg47ZNvA45
	 q+Dk2Xux3GNuYnZpfneEFAQT7SdB9HGpTnOuKSqa1G/+s5lm/ae/S2Du1uR19zK+/Mcjw
	 AQATnqe8m1SNx7pxxZUmlfAm81f8n3ILQV+0a0tm/16utYBDYK+M6m8ALcZrSqDCakg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZqsuVHYQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D4606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZqsuVHYQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EF61F0089F;
	Mon,  9 Nov 2026 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232216;
	bh=sV80kwdjYfS3SgzsxQOfUc8arMNq3DrwT8oNR3+rv4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZqsuVHYQruPTDnvL/wRyoETvkHM/FjQjo/k60IgXH2INXxwz0f/edt7RAZVVC/diR
	 yPm1+5/aUVAkDvROkoAX+W42dH3ZTMETovsLXmXseNK6vszF5BjGbBHHYRlfIWbfuR
	 vZZx+b0d8MeeMs7MESuTe4lCyFqcn69b+vpzunM7nIiCDFD3bDinLCObUezDJV8tj1
	 sL2Xfc/jXKHUJEtxt28Qhu5RmCa2DXSClOYml3qUUEPlcAlbHJgvNxwaBaStFjkth5
	 095h5uECfNEloj81nJ/g5HmBBNAOtf7FdA9LuvewiFvP31eSkkNf4WO/X1bLVww5s9
	 F1sAoZVW8XFtw==
Message-ID: <bd9e3544-b818-4b12-8c81-16563c5c84c5@kernel.org>
Date: Mon, 9 Nov 2026 14:50:14 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] HID: lg-g15: Add G15 LCD framebuffer support
To: Benjamin Valentin <benpicco@googlemail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org
References: <20261108173920.424072-1-benpicco@googlemail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20261108173920.424072-1-benpicco@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8-Nov-26 18:39, Benjamin Valentin wrote:
> Add support for the LCD display on the G15 and G15 v2 to the driver.
> Those keyboards have a 160x43 monochrome display, hid-lg-g15 already
> binds the device.
> 
> All protocol knowledge was lifted from g15daemon, a userspace utility
> written for this keyboard long time ago. [0]
> 
> To test it I had Copliot port the g15stats util to use a framebuffer
> device instead of directly talking to the USB device [1] and also
> ran samples/auxdisplay.
> 
> [0] https://sourceforge.net/projects/g15daemon/
> [1] https://github.com/benpicco/g15stats-auxdisplay
> 
> Assisted-by: Copilot with GPT-6.1 Terra
> Signed-off-by: Benjamin Valentin <benpicco@googlemail.com>

Someone else also just submitted almost the same patch, please see my
reaction to that patch:

https://lore.kernel.org/linux-input/f6f843ea-1ab2-45fc-b844-7fbb646c686e@kernel.org/

and please reply in that email thread.

Regards,

Hans



> ---
>  drivers/hid/Kconfig      |  12 ++
>  drivers/hid/hid-lg-g15.c | 319 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 329 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 2481bc01c435..d7a7e2708308 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -674,6 +674,18 @@ config HID_LOGITECH
>  	help
>  	Support for Logitech devices that are not fully compliant with HID standard.
>  
> +config HID_LOGITECH_G15_LCD
> +	bool "Framebuffer support for Logitech G15 LCD" if EXPERT
> +	default !EXPERT
> +	depends on HID_LOGITECH
> +	depends on HID_LOGITECH=FB || FB=y
> +	select FB_SYSMEM_HELPERS_DEFERRED
> +	help
> +	  Say Y here to expose the 160x43 monochrome LCD on Logitech G15
> +	  keyboards through a framebuffer device. This supports the original
> +	  G15 and G15 v2 models. The display updates when its framebuffer
> +	  changes. If unsure, say Y.
> +
>  config HID_LOGITECH_DJ
>  	tristate "Logitech receivers full support"
>  	depends on USB_HID
> diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> index 02ef3e2094b4..ca1f3280c05a 100644
> --- a/drivers/hid/hid-lg-g15.c
> +++ b/drivers/hid/hid-lg-g15.c
> @@ -5,15 +5,25 @@
>   *  Copyright (c) 2019 Hans de Goede <hdegoede@redhat.com>
>   */
>  
> +#include <linux/bits.h>
>  #include <linux/device.h>
> +#include <linux/fb.h>
>  #include <linux/hid.h>
> +#include <linux/jiffies.h>
>  #include <linux/leds.h>
>  #include <linux/led-class-multicolor.h>
> +#include <linux/math.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
> +#include <linux/pm.h>
>  #include <linux/random.h>
>  #include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
>  #include <linux/usb.h>
> +#include <linux/vmalloc.h>
>  #include <linux/wait.h>
> +#include <linux/workqueue.h>
>  #include <dt-bindings/leds/common.h>
>  
>  #include "hid-ids.h"
> @@ -79,6 +89,19 @@ struct lg_g15_led {
>  	u8 red, green, blue;
>  };
>  
> +#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
> +struct lg_g15_fb {
> +	struct usb_device *usb;
> +	struct fb_info *info;
> +	struct fb_deferred_io defio;
> +	struct mutex lock; /* Serializes USB I/O and disconnect. */
> +	u8 *report;
> +	unsigned int pipe;
> +	bool disconnected;
> +	bool suspended;
> +};
> +#endif
> +
>  struct lg_g15_data {
>  	/* Must be first for proper dma alignment */
>  	u8 transfer_buf[LG_G15_TRANSFER_BUF_SIZE];
> @@ -88,12 +111,285 @@ struct lg_g15_data {
>  	struct input_dev *input;
>  	struct input_dev *input_js; /* Separate joystick device for G13. */
>  	struct hid_device *hdev;
> +#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
> +	struct lg_g15_fb *fb;
> +#endif
>  	enum lg_g15_model model;
>  	struct lg_g15_led leds[LG_G15_LED_MAX];
>  	bool game_mode_enabled;
>  	bool backlight_disabled;	/* true == HW backlight toggled *OFF* */
>  };
>  
> +#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
> +#define LG_G15_LCD_WIDTH		160
> +#define LG_G15_LCD_HEIGHT		43
> +#define LG_G15_LCD_STRIDE		(LG_G15_LCD_WIDTH / 8)
> +#define LG_G15_LCD_FB_SIZE		(LG_G15_LCD_STRIDE * LG_G15_LCD_HEIGHT)
> +#define LG_G15_LCD_HEADER_SIZE		32
> +#define LG_G15_LCD_PAGES		DIV_ROUND_UP(LG_G15_LCD_HEIGHT, 8)
> +#define LG_G15_LCD_REPORT_SIZE		(LG_G15_LCD_HEADER_SIZE + \
> +					 LG_G15_LCD_WIDTH * LG_G15_LCD_PAGES)
> +#define LG_G15_LCD_REFRESH_DELAY	msecs_to_jiffies(50)
> +#define LG_G15_LCD_USB_TIMEOUT		1000
> +
> +static void lg_g15_pack_report(u8 *report, const u8 *pixels)
> +{
> +	unsigned int page, x, bit, y;
> +	u8 value, mask;
> +
> +	memset(report, 0, LG_G15_LCD_HEADER_SIZE);
> +	report[0] = 0x03;
> +	report += LG_G15_LCD_HEADER_SIZE;
> +
> +	/*
> +	 * The LCD consumes vertical, LSB-at-the-top groups of eight pixels.
> +	 * Its pixel polarity is opposite to FB_VISUAL_MONO10.
> +	 */
> +	for (page = 0; page < LG_G15_LCD_PAGES; page++) {
> +		for (x = 0; x < LG_G15_LCD_WIDTH; x++) {
> +			mask = BIT(7 - x % 8);
> +			value = 0;
> +			for (bit = 0; bit < 8; bit++) {
> +				y = page * 8 + bit;
> +				if (y >= LG_G15_LCD_HEIGHT)
> +					break;
> +				if (!(pixels[y * LG_G15_LCD_STRIDE + x / 8] & mask))
> +					value |= BIT(bit);
> +			}
> +			*report++ = value;
> +		}
> +	}
> +}
> +
> +static void lg_g15_fb_deferred_io(struct fb_info *info,
> +				  struct list_head *pagelist)
> +{
> +	struct lg_g15_fb *fb = info->par;
> +	int actual, ret;
> +
> +	mutex_lock(&fb->lock);
> +
> +	if (fb->disconnected || fb->suspended)
> +		goto out;
> +
> +	lg_g15_pack_report(fb->report, fb->info->screen_buffer);
> +
> +	ret = usb_interrupt_msg(fb->usb, fb->pipe, fb->report,
> +				LG_G15_LCD_REPORT_SIZE, &actual,
> +				LG_G15_LCD_USB_TIMEOUT);
> +
> +	if (!ret && actual != LG_G15_LCD_REPORT_SIZE)
> +		ret = -EIO;
> +	if (ret)
> +		dev_err_ratelimited(&fb->usb->dev,
> +				    "LCD update failed: %d\n", ret);
> +out:
> +	mutex_unlock(&fb->lock);
> +}
> +
> +static void lg_g15_fb_damage(struct fb_info *info, off_t offset, size_t len)
> +{
> +	schedule_delayed_work(&info->deferred_work, LG_G15_LCD_REFRESH_DELAY);
> +}
> +
> +static void lg_g15_fb_damage_area(struct fb_info *info, u32 x, u32 y,
> +				  u32 width, u32 height)
> +{
> +	schedule_delayed_work(&info->deferred_work, LG_G15_LCD_REFRESH_DELAY);
> +}
> +
> +FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(lg_g15_fb,
> +				   lg_g15_fb_damage,
> +				   lg_g15_fb_damage_area)
> +
> +static int lg_g15_fb_open(struct fb_info *info, int user)
> +{
> +	struct lg_g15_fb *fb = info->par;
> +	int ret;
> +
> +	mutex_lock(&fb->lock);
> +	ret = fb->disconnected ? -ENODEV : 0;
> +	mutex_unlock(&fb->lock);
> +	return ret;
> +}
> +
> +static int lg_g15_fb_check_var(struct fb_var_screeninfo *var,
> +			       struct fb_info *info)
> +{
> +	if (var->xres != LG_G15_LCD_WIDTH ||
> +	    var->yres != LG_G15_LCD_HEIGHT ||
> +	    var->xres_virtual != LG_G15_LCD_WIDTH ||
> +	    var->yres_virtual != LG_G15_LCD_HEIGHT ||
> +	    var->bits_per_pixel != 1 || var->xoffset || var->yoffset ||
> +	    var->nonstd || var->rotate)
> +		return -EINVAL;
> +
> +	*var = info->var;
> +	return 0;
> +}
> +
> +static void lg_g15_fb_destroy(struct fb_info *info)
> +{
> +	struct lg_g15_fb *fb = info->par;
> +
> +	fb_deferred_io_cleanup(info);
> +	vfree(info->screen_buffer);
> +	kfree(fb->report);
> +	usb_put_dev(fb->usb);
> +	framebuffer_release(info);
> +}
> +
> +static const struct fb_ops lg_g15_fb_ops = {
> +	.owner = THIS_MODULE,
> +	.fb_open = lg_g15_fb_open,
> +	.fb_check_var = lg_g15_fb_check_var,
> +	.fb_destroy = lg_g15_fb_destroy,
> +	FB_DEFAULT_DEFERRED_OPS(lg_g15_fb),
> +};
> +
> +static const struct fb_fix_screeninfo lg_g15_fb_fix = {
> +	.id = "g15",
> +	.type = FB_TYPE_PACKED_PIXELS,
> +	.visual = FB_VISUAL_MONO10,
> +	.line_length = LG_G15_LCD_STRIDE,
> +	.smem_len = LG_G15_LCD_FB_SIZE,
> +	.accel = FB_ACCEL_NONE,
> +};
> +
> +static const struct fb_var_screeninfo lg_g15_fb_var = {
> +	.xres = LG_G15_LCD_WIDTH,
> +	.yres = LG_G15_LCD_HEIGHT,
> +	.xres_virtual = LG_G15_LCD_WIDTH,
> +	.yres_virtual = LG_G15_LCD_HEIGHT,
> +	.bits_per_pixel = 1,
> +	.red = {
> +		.length = 1,
> +	},
> +	.green = {
> +		.length = 1,
> +	},
> +	.blue = {
> +		.length = 1,
> +	},
> +	.width = 90,
> +	.height = 23,
> +};
> +
> +static int lg_g15_fb_init(struct hid_device *hdev, struct lg_g15_data *g15)
> +{
> +	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> +	struct usb_host_interface *alt = intf->cur_altsetting;
> +	struct usb_endpoint_descriptor *out;
> +	struct fb_info *info;
> +	struct lg_g15_fb *fb;
> +	int ret;
> +
> +	ret = usb_find_int_out_endpoint(alt, &out);
> +	if (ret)
> +		return ret;
> +
> +	info = framebuffer_alloc(sizeof(*fb), &hdev->dev);
> +	if (!info)
> +		return -ENOMEM;
> +	fb = info->par;
> +	fb->info = info;
> +	fb->usb = usb_get_dev(interface_to_usbdev(intf));
> +	fb->pipe = usb_sndintpipe(fb->usb, out->bEndpointAddress);
> +	mutex_init(&fb->lock);
> +
> +	fb->report = kmalloc(LG_G15_LCD_REPORT_SIZE, GFP_KERNEL);
> +	if (!fb->report) {
> +		ret = -ENOMEM;
> +		goto err_usb;
> +	}
> +	info->screen_buffer = vzalloc(PAGE_ALIGN(LG_G15_LCD_FB_SIZE));
> +	if (!info->screen_buffer) {
> +		ret = -ENOMEM;
> +		goto err_report;
> +	}
> +
> +	info->fbops = &lg_g15_fb_ops;
> +	info->fix = lg_g15_fb_fix;
> +	info->var = lg_g15_fb_var;
> +	info->flags = FBINFO_VIRTFB;
> +	info->screen_size = LG_G15_LCD_FB_SIZE;
> +	fb->defio.delay = LG_G15_LCD_REFRESH_DELAY;
> +	fb->defio.deferred_io = lg_g15_fb_deferred_io;
> +	info->fbdefio = &fb->defio;
> +	ret = fb_deferred_io_init(info);
> +	if (ret)
> +		goto err_buffer;
> +
> +	ret = register_framebuffer(info);
> +	if (ret)
> +		goto err_defio;
> +
> +	g15->fb = fb;
> +	hid_info(hdev, "fb%d: G15 LCD, %dx%d monochrome\n",
> +		 info->node, LG_G15_LCD_WIDTH, LG_G15_LCD_HEIGHT);
> +	return 0;
> +
> +err_defio:
> +	fb_deferred_io_cleanup(info);
> +err_buffer:
> +	vfree(info->screen_buffer);
> +err_report:
> +	kfree(fb->report);
> +err_usb:
> +	usb_put_dev(fb->usb);
> +	framebuffer_release(info);
> +	return ret;
> +}
> +
> +static void lg_g15_fb_remove(struct lg_g15_data *g15)
> +{
> +	struct lg_g15_fb *fb = g15->fb;
> +	struct fb_info *info;
> +
> +	if (!fb)
> +		return;
> +
> +	info = fb->info;
> +	mutex_lock(&fb->lock);
> +	fb->disconnected = true;
> +	mutex_unlock(&fb->lock);
> +	flush_delayed_work(&info->deferred_work);
> +	unregister_framebuffer(info);
> +}
> +
> +static int lg_g15_suspend(struct hid_device *hdev, pm_message_t message)
> +{
> +	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
> +	struct lg_g15_fb *fb;
> +
> +	if (!g15 || !g15->fb)
> +		return 0;
> +
> +	fb = g15->fb;
> +	mutex_lock(&fb->lock);
> +	fb->suspended = true;
> +	mutex_unlock(&fb->lock);
> +	flush_delayed_work(&fb->info->deferred_work);
> +	return 0;
> +}
> +
> +static int lg_g15_resume(struct hid_device *hdev)
> +{
> +	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
> +	struct lg_g15_fb *fb;
> +
> +	if (!g15 || !g15->fb)
> +		return 0;
> +
> +	fb = g15->fb;
> +	mutex_lock(&fb->lock);
> +	fb->suspended = false;
> +	mutex_unlock(&fb->lock);
> +	schedule_delayed_work(&fb->info->deferred_work, 0);
> +	return 0;
> +}
> +#endif
> +
>  /********* G13 LED functions ***********/
>  /*
>   * G13 retains no state across power cycles, and always powers up with the backlight on,
> @@ -1333,6 +1629,15 @@ static int lg_g15_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  			goto error_hw_stop;
>  	}
>  
> +#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
> +	if (hdev->product == USB_DEVICE_ID_LOGITECH_G15_LCD ||
> +	    hdev->product == USB_DEVICE_ID_LOGITECH_G15_V2_LCD) {
> +		ret = lg_g15_fb_init(hdev, g15);
> +		if (ret)
> +			hid_err(hdev, "Failed to initialize LCD framebuffer: %d\n", ret);
> +	}
> +#endif
> +
>  	return 0;
>  
>  error_hw_stop:
> @@ -1377,15 +1682,20 @@ MODULE_DEVICE_TABLE(hid, lg_g15_devices);
>  static void lg_g15_remove(struct hid_device *hdev)
>  {
>  	struct lg_g15_data *g15 = hid_get_drvdata(hdev);
> +	if (!g15)
> +		goto out;
>  
> +#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
> +	lg_g15_fb_remove(g15);
> +#endif
>  	/*
>  	 * g15->work is only initialized for the models that schedule it
>  	 * (G15, G15 v2, G510). The G13 and Z-10 leave it zeroed, so only
>  	 * cancel it when it was set up.
>  	 */
> -	if (g15 && g15->work.func)
> +	if (g15->work.func)
>  		cancel_work_sync(&g15->work);
> -
> +out:
>  	hid_hw_stop(hdev);
>  }
>  
> @@ -1395,6 +1705,11 @@ static struct hid_driver lg_g15_driver = {
>  	.raw_event		= lg_g15_raw_event,
>  	.probe			= lg_g15_probe,
>  	.remove			= lg_g15_remove,
> +#if IS_ENABLED(CONFIG_HID_LOGITECH_G15_LCD)
> +	.suspend		= pm_ptr(lg_g15_suspend),
> +	.resume			= pm_ptr(lg_g15_resume),
> +	.reset_resume		= pm_ptr(lg_g15_resume),
> +#endif
>  };
>  module_hid_driver(lg_g15_driver);
>  

