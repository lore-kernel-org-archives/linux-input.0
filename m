From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID: picolcd: Prevent NULL pointer dereference on _remove()
Date: Mon, 2 Sep 2013 13:37:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309021337170.3796@pobox.suse.cz>
References: <20130831140748.3353e7bc@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48018 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756086Ab3IBLhc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Sep 2013 07:37:32 -0400
In-Reply-To: <20130831140748.3353e7bc@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org

On Sat, 31 Aug 2013, Bruno Pr=C3=A9mont wrote:

> When picolcd is switched into bootloader mode (for FW flashing) make
> sure not to try to dereference NULL-pointers of feature-devices durin=
g
> unplug/unbind.
>=20
> This fixes following BUG:
>   BUG: unable to handle kernel NULL pointer dereference at 00000298
>   IP: [<f811f56b>] picolcd_exit_framebuffer+0x1b/0x80 [hid_picolcd]
>   *pde =3D 00000000
>   Oops: 0000 [#1]
>   Modules linked in: hid_picolcd syscopyarea sysfillrect sysimgblt fb=
_sys_fops
>   CPU: 0 PID: 15 Comm: khubd Not tainted 3.11.0-rc7-00002-g50d62d4 #2
>   EIP: 0060:[<f811f56b>] EFLAGS: 00010292 CPU: 0
>   EIP is at picolcd_exit_framebuffer+0x1b/0x80 [hid_picolcd]
>   Call Trace:
>    [<f811d1ab>] picolcd_remove+0xcb/0x120 [hid_picolcd]
>    [<c1469b09>] hid_device_remove+0x59/0xc0
>    [<c13464ca>] __device_release_driver+0x5a/0xb0
>    [<c134653f>] device_release_driver+0x1f/0x30
>    [<c134603d>] bus_remove_device+0x9d/0xd0
>    [<c13439a5>] device_del+0xd5/0x150
>    [<c14696a4>] hid_destroy_device+0x24/0x60
>    [<c1474cbb>] usbhid_disconnect+0x1b/0x40
>    ...
>=20
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> Cc: stable@kernel.org
> ---
>  drivers/hid/hid-picolcd_cir.c | 3 ++-
>  drivers/hid/hid-picolcd_fb.c  | 6 +++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)

Applied, thanks Bruno.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
