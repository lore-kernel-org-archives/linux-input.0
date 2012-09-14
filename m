From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] Input: ab8500-ponkey: Make the distinction between
 DT and non-DT boots
Date: Fri, 14 Sep 2012 09:03:48 +0100
Message-ID: <20120914080347.GB3374@gmail.com>
References: <1344256323-10484-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdaKa=NAObnjJyifhxyqu3Hcgj7Fxqi=bdNFqbm7V_8cSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62583 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab2INIDx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 04:03:53 -0400
Received: by eekc1 with SMTP id c1so2342438eek.19
        for <linux-input@vger.kernel.org>; Fri, 14 Sep 2012 01:03:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACRpkdaKa=NAObnjJyifhxyqu3Hcgj7Fxqi=bdNFqbm7V_8cSw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: arnd@arndb.de, Dmitry Torokhov <dmitry.torokhov@gmail.com>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, linux-input@vger.kernel.org

On Thu, Sep 13, 2012 at 11:35:43AM +0200, Linus Walleij wrote:
> On Mon, Aug 6, 2012 at 2:32 PM, Lee Jones <lee.jones@linaro.org> wrot=
e:
>=20
> > If we're booting with Device Tree enabled, we want the IRQ numbers =
to
> > be taken and translated from the Device Tree binary. If not, they
> > should be taken from the resource allocation defined in the AB8500 =
MFD
> > core driver.
> >
> > Tested-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>=20
> Not having this patch in v3.6-rcN gives the following boot noise (and
> the key does not work):
>=20
> ------------[ cut here ]------------
> WARNING: at /home/elinwal/linux-stericsson/kernel/irq/irqdomain.c:137
> irq_domain_legacy_revmap+0x20/0x48()
> Modules linked in:
> [<c0014710>] (unwind_backtrace+0x0/0xf8) from [<c001d37c>]
> (warn_slowpath_common+0x4c/0x64)
> [<c001d37c>] (warn_slowpath_common+0x4c/0x64) from [<c001d3b0>]
> (warn_slowpath_null+0x1c/0x24)
> [<c001d3b0>] (warn_slowpath_null+0x1c/0x24) from [<c0064200>]
> (irq_domain_legacy_revmap+0x20/0x48)
> [<c0064200>] (irq_domain_legacy_revmap+0x20/0x48) from [<c02cea28>]
> (ab8500_ponkey_probe+0xd0/0x1f8)
> [<c02cea28>] (ab8500_ponkey_probe+0xd0/0x1f8) from [<c01a1e20>]
> (platform_drv_probe+0x14/0x18)
> [<c01a1e20>] (platform_drv_probe+0x14/0x18) from [<c01a0be4>]
> (driver_probe_device+0x78/0x208)
> [<c01a0be4>] (driver_probe_device+0x78/0x208) from [<c01a0e00>]
> (__driver_attach+0x8c/0x90)
> [<c01a0e00>] (__driver_attach+0x8c/0x90) from [<c019f514>]
> (bus_for_each_dev+0x50/0x7c)
> [<c019f514>] (bus_for_each_dev+0x50/0x7c) from [<c01a0424>]
> (bus_add_driver+0x170/0x23c)
> [<c01a0424>] (bus_add_driver+0x170/0x23c) from [<c01a12b4>]
> (driver_register+0x78/0x144)
> [<c01a12b4>] (driver_register+0x78/0x144) from [<c0008598>]
> (do_one_initcall+0x34/0x174)
> [<c0008598>] (do_one_initcall+0x34/0x174) from [<c03df8e8>]
> (kernel_init+0xfc/0x1bc)
> [<c03df8e8>] (kernel_init+0xfc/0x1bc) from [<c000f1d4>]
> (kernel_thread_exit+0x0/0x8)
> ---[ end trace d77aa0db848f0e28 ]---
> ab8500-core ab8500-core.0: Failed to request dbf IRQ#0: -22
> ab8500-poweron-key: probe of ab8500-poweron-key.0 failed with error -=
22
>=20
> So how do we proceed to not release v3.6 with this regression?
>=20
> Shall all of the MFD IRQdomain stuff be pulled into the -rc series?
>=20
> (Linux-next seems to be working, so the real fix is in there)

I haven't tested this, but I think this patch should be pulled out
of -next and pushed into the -rcs to fix the issue you see above.
The real fix along with the revert to this patch also resides in
-next and will be applied during the next merge window.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
