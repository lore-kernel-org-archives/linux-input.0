From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Date: Mon, 13 Aug 2012 16:27:08 -0700
Message-ID: <20120813232708.GF25632@google.com>
References: <20120730213656.0a9f6d30@neptune.home>
 <20120809200947.2194e89f@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61438 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab2HMX1O (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Aug 2012 19:27:14 -0400
Content-Disposition: inline
In-Reply-To: <20120809200947.2194e89f@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-fbdev@vger.kernel.org

Hello,

On Thu, Aug 09, 2012 at 08:09:47PM +0200, Bruno Pr=E9mont wrote:
> As you are working on workqueues and related code, could you have a l=
ook
> at my usage of them in combination with db_defio?
>=20
> The delayed memory corruptions or system reboots after unbinding/unpl=
ugging
> the PicoLCD seem very much related to workqueue used to handle the de=
ferred
> IO to framebuffer.
>=20
> I think things don't get cleaned-up as they should though I'm not sur=
e
> where the trouble lies.
>=20
> For ease of reading, I'm inlineing below the framebuffer related code=
 of
> PicoLCD (for complete driver after this patch series apply the whole =
series
> on top of 3.5 https://lkml.org/lkml/2012/7/30/375 )
=2E..
> void picolcd_exit_framebuffer(struct picolcd_data *data)
> {
> 	struct fb_info *info =3D data->fb_info;
> 	u8 *fb_vbitmap =3D data->fb_vbitmap;
>=20
> 	if (!info)
> 		return;
>=20
> 	device_remove_file(&data->hdev->dev, &dev_attr_fb_update_rate);
> 	info->par =3D NULL;
> 	unregister_framebuffer(info);
> 	data->fb_vbitmap =3D NULL;
> 	data->fb_bitmap  =3D NULL;
> 	data->fb_bpp     =3D 0;
> 	data->fb_info    =3D NULL;
> 	kfree(fb_vbitmap);
> }

I'm kinda shooting in the dark but who flushes / cancels
fb_info->deferred_work?

Thanks.

--=20
tejun
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
