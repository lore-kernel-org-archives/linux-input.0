Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219717;
	b=AO/WRU2zRxgL9gMfMHKRE1/J0mmdjeyP97TOzKhgBaJ/jvhNMqPZHsXINMwrX83ARP+x
	 DdRi0oRF5kK4e0QcJkQjqFV0WvXO0HoSGbvacU77mtCnsYp4K0JxRvXQRqm2IFqrBXe4o
	 +icxa243AN95+lCB2s42riuUvPxMqLhef6r/jup31gAjMTLqDERNBRm2goYcbPnKgDRLC
	 CRYy5pwE3tjSgE+VRJjdP+UaUkJ9ME0Yd5diqfuvW/x9+OzFdmXVvBWPw+RSaEbvb5HS/
	 nDqiHgsM1QByf9az3V3jEKEu0t0X2qLczk3ipX+kDWPp4Ug3CBD5m6NXgBZ2SwNlZkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219717;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gnb38iMioXTRRyDwu6iJ5hQqDf5xtzZnOv0zmRB8KY8=;
	b=5No6J6rIGBdRed2sCgv/UIUcwrsJQuwlS+hTQ3N4tX1sq65YzhhwdyKDHvyClQog3pDR
	 KI/EqPDs5ytH/y3VWyrZRgZk/gIdsf0HSbPeRT9RbqPJYh1jilfIuffSuPgZLjA0X8/uL
	 KeZoU9oYR7zViTMmUQMDjY+1KD97B6x4hFNBfNu6hqdj/bYUi+b2xPIvgdatok57uPo1k
	 SvS/RX/pNVbGM7MVyNMaP0SGX7P6sk9sbok1iq1LsDSmbT9SGzy/Igj6dO3JCwjMjFAQK
	 gOw8lCLzWbgq4gxPg44R864f+KHbkVy/KVUp9bRUn2N27epzCSUxzMuybDPfO59q+IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjoCQ9bx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0597606A326
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjoCQ9bx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECD71F0089F;
	Mon,  9 Nov 2026 10:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794219716;
	bh=gnb38iMioXTRRyDwu6iJ5hQqDf5xtzZnOv0zmRB8KY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DjoCQ9bxGTD3207koxcXQ4kPID1oeUh7FVOAaYdh8Tj+twph9PJForArgFkUjH4Uz
	 KeJbjZvc0RGgODlU0EzLxeZZahy8l3NNUglGCkAWHaRM8muctdUGd1xdzUHhJ+rqID
	 YI5EODl8m/nap/pYVVigAKIm4jdBziRXZmlCBWXdN7AGVeqQNuLGQdS+l/V/62cnAo
	 IBHPCX+TiBOql7qo0KkIcof7O3MB+rrfUh7xlXNUA41tMtpJCfGP8M/XRy2KBe9O7r
	 Bqv0nPjO0rlERiZrrsZf2qpw5BZjlXZEIeSXJnHC5mquYgP02og5XeP3pBy2k46eg/
	 uRDeXJDf5EzFw==
Message-ID: <sashiko-outbox-204805@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] HID: lg-g15: add LCD pixel-content framebuffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Torstein Eide" <torsteine+linux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109094426.1432465-3-torsteine+linux@gmail.com>
References: <20261109094426.1432465-1-torsteine+linux@gmail.com>
 <20261109094426.1432465-3-torsteine+linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:21:55 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] HID: lg-g15: reversed 1bpp pixel bit order in
  lg_g15_fb_pack()
- [Low] HID: lg-g15: no-op lg_g15_fb_blank() breaks fbcon blanking and
  blank state
- [Low] HID: lg-g15: race and missed redraw onpar->sent in
  lg_g15_fb_redraw()
--

commit bcb1dfda67b01b4a6f0c45e68ab96dc227cf9166
Author: Torstein Eide <torsteine+linux@gmail.com>

HID: lg-g15: add LCD pixel-content framebuffer

This commit adds a 160x43 1bpp fbdev framebuffer using deferred I/O for
the GamePanel LCD on Logitech G15 and G15 v2 keyboards.

> diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> index 50abe6c58b10b..35d183787383a 100644
> --- a/drivers/hid/hid-lg-g15.c
> +++ b/drivers/hid/hid-lg-g15.c

[ ... ]

> @@ -1051,6 +1081,270 @@ static void lg_g15_setup_led_rgb(struct lg_g15_da=
ta *g15, int index)
>  	gled->mcdev.subled_info =3D subled_info;
>  }
> =20
> +/********* G15 LCD framebuffer *********/
> +
> +#ifdef CONFIG_HID_LOGITECH_G15_FB

[ ... ]

> +static const struct fb_var_screeninfo lg_g15_fb_var =3D {
> +	.xres		=3D LG_G15_LCD_WIDTH,
> +	.yres		=3D LG_G15_LCD_HEIGHT,
> +	.xres_virtual	=3D LG_G15_LCD_WIDTH,
> +	.yres_virtual	=3D LG_G15_LCD_HEIGHT,
> +	.bits_per_pixel	=3D 1,
> +	.red		=3D { 0, 1, 0 },
> +	.green		=3D { 0, 1, 0 },
> +	.blue		=3D { 0, 1, 0 },
> +	.vmode		=3D FB_VMODE_NONINTERLACED,
> +};
> +
> +/*
> + * Packs pixels column-major (8 vertically-stacked source rows per
> + * destination byte), not the row-major layout the linear fb buffer hold=
s.
> + *
> + * fb is LG_G15_LCD_WIRE_SIZE bytes (padded, not just LG_G15_LCD_FB_SIZE=
) -
> + * the last of the six 8-row groups only has 3 real pixel-rows (43 isn't=
 a
> + * multiple of 8), and this reads past the logical frame into that paddi=
ng
> + * for the other 5.
> + */
> +static void lg_g15_fb_pack(u8 *wire, const u8 *fb)
> +{
> +	unsigned int output_offset =3D LG_G15_LCD_WIRE_OFFSET;
> +	unsigned int base_offset =3D 0;
> +	unsigned int row, col;
> +	unsigned int height_in_bytes =3D DIV_ROUND_UP(LG_G15_LCD_HEIGHT, 8);
> +
> +	for (row =3D 0; row < height_in_bytes; row++) {
> +		for (col =3D 0; col < LG_G15_LCD_WIDTH; col++) {
> +			unsigned int bit =3D col % 8;
> +			unsigned int sub;
> +			u8 packed =3D 0;
> +
> +			for (sub =3D 0; sub < 8; sub++) {
> +				unsigned int pixel_offset =3D
> +					base_offset + sub * LG_G15_LCD_ROW_BYTES;
> +
> +				packed |=3D ((fb[pixel_offset] << bit) & 0x80) >> (7 - sub);
> +			}

[Severity: Medium]
Does lg_g15_fb_pack() extract bits from each source byte in reversed
horizontal order compared to standard 1bpp fbdev drawing helpers?

On little-endian architectures, sys_imageblit(), sys_fillrect(), and
sys_copyarea() (wired in via FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS without
FB_NONSTD_REV_PIX_IN_B) place the leftmost pixel of each 8-pixel group
(col % 8 =3D=3D 0) in bit 0 (0x01) and col % 8 =3D=3D 7 in bit 7 (0x80).
Shifting fb[pixel_offset] left by bit and masking with 0x80 reads bit 7
for col % 8 =3D=3D 0 and bit 0 for col % 8 =3D=3D 7, horizontally mirroring=
 every
8-pixel byte group when rendering via fbcon or the sys_* drawing ops.
Extracting ((fb[pixel_offset] >> bit) & 1) << sub would match standard
1bpp ordering.

> +
> +			wire[output_offset] =3D packed;
> +			output_offset++;
> +			if (bit =3D=3D 7)
> +				base_offset++;
> +		}
> +		base_offset +=3D LG_G15_LCD_WIDTH - LG_G15_LCD_ROW_BYTES;
> +	}
> +}
> +
> +/*
> + * Deferred IO callback, runs when userspace dirtied the framebuffer (th=
rough
> + * mmap, write() or the drawing ops). Writes made while a frame is being=
 sent
> + * re-arm the deferred work, so no update is lost.
> + */
> +static void lg_g15_fb_deferred_io(struct fb_info *info, struct list_head=
 *pagereflist)
> +{
> +	struct lg_g15_fb_par *par =3D info->par;
> +	struct lg_g15_data *g15;
> +	u8 *wire;
> +	int ret;
> +
> +	mutex_lock(&par->lock);
> +
> +	g15 =3D par->g15;
> +	if (!g15)
> +		goto out;
> +
> +	wire =3D g15->fbdev.wire;
> +	memset(wire, 0, LG_G15_LCD_WIRE_OFFSET);
> +	lg_g15_fb_pack(wire, (const u8 *)info->screen_buffer);
> +	wire[0] =3D LG_G15_LCD_OUTPUT_REPORT;
> +
> +	ret =3D hid_hw_output_report(g15->hdev, wire, LG_G15_LCD_WIRE_SIZE);
> +	if (ret < 0)
> +		hid_err_ratelimited(g15->hdev, "Error writing LCD framebuffer: %d\n", =
ret);
> +	else
> +		par->sent =3D true;
> +
> +out:
> +	mutex_unlock(&par->lock);
> +}
> +
> +static void lg_g15_fb_damage_range(struct fb_info *info, off_t off, size=
_t len)
> +{
> +	schedule_delayed_work(&info->deferred_work, info->fbdefio->delay);
> +}
> +
> +static void lg_g15_fb_damage_area(struct fb_info *info, u32 x, u32 y,
> +				  u32 width, u32 height)
> +{
> +	schedule_delayed_work(&info->deferred_work, info->fbdefio->delay);
> +}
> +
> +FB_GEN_DEFAULT_DEFERRED_SYSMEM_OPS(lg_g15_fb,
> +				   lg_g15_fb_damage_range,
> +				   lg_g15_fb_damage_area)
> +
> +static int lg_g15_fb_blank(int blank, struct fb_info *info)
> +{
> +	return 0;
> +}
> +
> +static void lg_g15_fb_destroy(struct fb_info *info)
> +{
> +	struct lg_g15_fb_par *par =3D info->par;
> +
> +	fb_deferred_io_cleanup(info);
> +	mutex_destroy(&par->lock);
> +	vfree(info->screen_buffer);
> +	framebuffer_release(info);
> +}
> +
> +static const struct fb_ops lg_g15_fb_ops =3D {
> +	.owner		=3D THIS_MODULE,
> +	FB_DEFAULT_DEFERRED_OPS(lg_g15_fb),
> +	.fb_destroy	=3D lg_g15_fb_destroy,
> +	.fb_blank	=3D lg_g15_fb_blank,
> +};

[Severity: Low]
Does providing a no-op lg_g15_fb_blank() that returns 0 prevent fbcon
from blanking the display?

When fb_ops->fb_blank is populated, do_register_framebuffer() initializes
info->blank to FB_BLANK_POWERDOWN, and fbcon_blank() only falls back to
clearing the screen in software via fbcon_generic_blank() when fb_blank()
returns non-zero.  In addition, because info->bl_dev and info->lcd_dev
are NULL, returning 0 from fb_blank() causes fb_bl_notify_blank(),
fb_lcd_notify_blank(), and fb_ledtrig_backlight_notify_blank() to
broadcast blank events to unrelated backlight and LCD devices on the
system.  Omitting .fb_blank from lg_g15_fb_ops avoids these side effects.

[ ... ]

> +/* The LCD loses its pixel content across a USB reset or power loss */
> +static void lg_g15_fb_redraw(struct lg_g15_data *g15)
> +{
> +	struct fb_info *info =3D g15->fbdev.info;
> +	struct lg_g15_fb_par *par;
> +
> +	if (!info)
> +		return;
> +
> +	par =3D info->par;
> +	if (par->sent)
> +		schedule_delayed_work(&info->deferred_work, 0);
> +}

[Severity: Low]
Can lg_g15_fb_redraw() miss redrawing the initial frame across suspend and
resume?

In lg_g15_fb_deferred_io(), par->sent is only set when
hid_hw_output_report() succeeds.  If the first frame's deferred I/O work
runs while the USB device is suspended, fb_deferred_io_work consumes the
dirty state and hid_hw_output_report() fails with -EHOSTUNREACH, leaving
par->sent false so lg_g15_fb_redraw() skips rescheduling the update on
resume.

Also, lg_g15_fb_redraw() reads par->sent without holding par->lock:

kworker                             CPU1
lg_g15_fb_deferred_io()
  mutex_lock(&par->lock)
  hid_hw_output_report(...)
                                    lg_g15_resume()
                                      lg_g15_fb_redraw()
                                        if (par->sent)  <-- reads false
  par->sent =3D true
  mutex_unlock(&par->lock)

Setting par->sent =3D true before hid_hw_output_report() in
lg_g15_fb_deferred_io() and taking par->lock in lg_g15_fb_redraw() would
ensure the frame is re-sent after resume.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109094426.1432=
465-1-torsteine+linux@gmail.com?part=3D2
