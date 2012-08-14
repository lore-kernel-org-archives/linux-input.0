From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Date: Tue, 14 Aug 2012 08:30:44 +0200
Message-ID: <20120814083044.78b401d2@pluto.restena.lu>
References: <20120730213656.0a9f6d30@neptune.home>
	<20120809200947.2194e89f@neptune.home>
	<20120813232708.GF25632@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:57495 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab2HNGar convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Aug 2012 02:30:47 -0400
In-Reply-To: <20120813232708.GF25632@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-fbdev@vger.kernel.org

Hello Tejun,

[Tejun: sorry for duplicate, did hit "reply" instead of "reply to all"]

On Mon, 13 Aug 2012 16:27:08 Tejun Heo <tj@kernel.org> wrote:
> On Thu, Aug 09, 2012 at 08:09:47PM +0200, Bruno Pr=C3=A9mont wrote:
> > As you are working on workqueues and related code, could you have a=
 look
> > at my usage of them in combination with db_defio?
> >=20
> > The delayed memory corruptions or system reboots after unbinding/un=
plugging
> > the PicoLCD seem very much related to workqueue used to handle the =
deferred
> > IO to framebuffer.
> >=20
> > I think things don't get cleaned-up as they should though I'm not s=
ure
> > where the trouble lies.
> >=20
> > For ease of reading, I'm inlineing below the framebuffer related co=
de of
> > PicoLCD (for complete driver after this patch series apply the whol=
e series
> > on top of 3.5 https://lkml.org/lkml/2012/7/30/375 )
> ...
> > void picolcd_exit_framebuffer(struct picolcd_data *data)
> > {
> > 	struct fb_info *info =3D data->fb_info;
> > 	u8 *fb_vbitmap =3D data->fb_vbitmap;
> >=20
> > 	if (!info)
> > 		return;
> >=20
> > 	device_remove_file(&data->hdev->dev, &dev_attr_fb_update_rate);
> > 	info->par =3D NULL;
> > 	unregister_framebuffer(info);
> > 	data->fb_vbitmap =3D NULL;
> > 	data->fb_bitmap  =3D NULL;
> > 	data->fb_bpp     =3D 0;
> > 	data->fb_info    =3D NULL;
> > 	kfree(fb_vbitmap);
> > }
>=20
> I'm kinda shooting in the dark but who flushes / cancels
> fb_info->deferred_work?

fb_deferred_io_cleanup() does so and is called by destroy fbops
(when last reference to fb_info is returned):


static void picolcd_fb_destroy(struct fb_info *info)
{
	/* make sure no work is deferred */
	fb_deferred_io_cleanup(info);

	vfree((u8 *)info->fix.smem_start);
	framebuffer_release(info);
	printk(KERN_DEBUG "picolcd_fb_destroy(%p)\n", info);
}


=3D=3D=3D=3D=3D drivers/video/fb_defio.c =3D=3D=3D=3D=3D
void fb_deferred_io_cleanup(struct fb_info *info)
{
        struct fb_deferred_io *fbdefio =3D info->fbdefio;
        struct page *page;
        int i;

        BUG_ON(!fbdefio);
        cancel_delayed_work_sync(&info->deferred_work);

        /* clear out the mapping that we setup */
        for (i =3D 0 ; i < info->fix.smem_len; i +=3D PAGE_SIZE) {
                page =3D fb_deferred_io_page(info, i);
                page->mapping =3D NULL;
        }

        info->fbops->fb_mmap =3D NULL;
        mutex_destroy(&fbdefio->lock);
}



Thanks,
Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
