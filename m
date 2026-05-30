Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1F7E0FF
	for <linux-input@vger.kernel.org>; Sat, 30 May 2026 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780120405; cv=none; b=tSLoowoQW0iSMgRH+W2pZreWtO/vDXSPHHPGHKyz5bmBZsEQoDitM3HL4SPh0srUahR1iNw9BIawzz6xWaTdsf2Cj21+9VjHTkNI5myfIGJy3MtIu3a6wyt5g066SWtnLjO6QMjWBWNBFXAsqTZh3PwxD73jbr4f52EkvT9uG3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780120405; c=relaxed/simple;
	bh=ZiCy0EGdTVySLSPVS8xt31XGhQt7VNVSuuBVRIYf7XQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Poc4RLHl0U0nAbYqRh7gGVPxVKgWncfbndFUWbyDYHCdNHnG9mULBHFiEt4x/Bs+87FABp1wLti7BSFFcIwL/ZdkY4r9a9+Ir78+N4ze2BhaXxbw+DM665xi3b2WhiZwMOWlauwiX2E6Z/4i647FgJTpjiuUsVj4Rc254/d+2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcKz8y3F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcKz8y3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5BA1F00893;
	Sat, 30 May 2026 05:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780120403;
	bh=61sShHrM8yglzxVusG0TtAp3odO6VfjDR5Ves0stwIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcKz8y3FuPQNJ1/Gd14UDlbrBxz0R/R4qhrSZPpInv8oTQsZOAtRaBYlpI2BsjUIQ
	 i1P/rD9Vdg2TtHcRo3twSIFRSFsabPgzX5M4yhJg2P3v1zd7kLYwkyEwQHJ8EIYtJY
	 eI9p64jWNJiIF5DR7O3aBYF7NlUW5Dex6zRtC8t+L2OML0a1y35P9nOAiaftiDmEx1
	 evuZoK83yf6XXnXfSq0fdd+AZzQ0hZzv+7YXNv/R2zDoU+Wh7aL6RGC6UI2AZKhAVC
	 7zJGHVoeN8GRQOqtbo9MuDrD7DvCW33EedbGLTEB5nhz67RontzZXfC7pvBoSlRrxv
	 yMGhKXV+DtcAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: ims-pcu - only expose sysfs attributes on
 control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <ahp23lj4_vXIeUBl@google.com>
References: <ahp23lj4_vXIeUBl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 05:53:23 +0000
Message-Id: <20260530055323.6F5BA1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Low] The `ims_pcu_ofn_is_attr_visible()` function introduced in the patc=
h returns `0` when `intf !=3D pcu->ctrl_intf` for the `ofn` attribute group=
. Because `ofn` is a named attribute group, returning `0` suppresses the in=
dividual files but still creates an empty 'ofn' directory on the data inter=
face.

Pre-existing issues:
- [High] The `buttons->input` pointer is assigned after `input_register_dev=
ice()`, and there is no memory barrier before setting `pcu->setup_complete =
=3D true`. On weakly ordered architectures, the CPU can reorder these store=
s, leading to a NULL pointer dereference in the interrupt handler (`ims_pcu=
_handle_response`) if an event arrives and observes `setup_complete =3D=3D =
true` before `buttons->input` is initialized.
- [High] The driver claims the secondary data interface (`pcu->data_intf`) =
in `ims_pcu_probe` but fails to release it in `ims_pcu_disconnect` when unb=
inding the control interface. The data interface remains bound with its `in=
tfdata` pointing to the freed `pcu` structure. Subsequent sysfs accesses on=
 the data interface will dereference this freed pointer, resulting in a use=
-after-free (UAF).
- [High] A malicious USB device can provide an incorrect master interface n=
umber in the CDC Union descriptor. `ims_pcu_parse_cdc_data()` uses this to =
set `pcu->ctrl_intf` and assigns `intfdata` to it. If this differs from the=
 interface currently being probed, the probed interface will have `NULL` dr=
iver data. When the sysfs core subsequently calls `ims_pcu_is_attr_visible(=
)`, `usb_get_intfdata()` returns `NULL`, causing a NULL pointer dereference=
 when accessing `pcu->ctrl_intf`.
- [High] The sysfs attribute store function `ims_pcu_reset_device` calls `i=
ms_pcu_execute_command()` without acquiring `pcu->cmd_mutex`. This allows c=
oncurrent sysfs operations (e.g., setting backlight brightness or updating =
firmware) to interleave their command preparations, causing data corruption=
 in the shared `pcu->urb_out_buf` and race conditions on the `pcu->cmd_done=
` completion structure.
- [High] In `ims_pcu_buffers_free()`, the input URB DMA buffer (`pcu->urb_i=
n_buf`) is incorrectly freed using `pcu->max_out_size` instead of the `pcu-=
>max_in_size` used during allocation.
--

commit e7e143a0135bed02c30cf00e17a9a25adf1ab6c4
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Input: ims-pcu - only expose sysfs attributes on control interface

When the driver was converted to use the driver core to instantiate device
attributes, they started appearing on all interfaces bound to the driver.
This patch updates the is_visible callbacks to verify that the interface
being accessed is indeed the control interface.

> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index 4c022a36dbe84..7c76bc82ab703 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -1249,6 +1249,9 @@ static umode_t ims_pcu_is_attr_visible(struct kobje=
ct *kobj,
>  	struct ims_pcu *pcu =3D usb_get_intfdata(intf);
>  	umode_t mode =3D attr->mode;
> =20
> +	if (intf !=3D pcu->ctrl_intf)
> +		return 0;

[Severity: High]
This isn't a bug introduced by this patch, but could pcu be NULL here?

If a malicious USB device provides an incorrect master interface number in =
the
CDC Union descriptor, ims_pcu_parse_cdc_data() might set pcu->ctrl_intf to
a different interface than the one being probed. When the sysfs core
subsequently calls ims_pcu_is_attr_visible(), usb_get_intfdata() would
return NULL, leading to a NULL pointer dereference when accessing
pcu->ctrl_intf.

[ ... ]

> @@ -1488,6 +1491,9 @@ static umode_t ims_pcu_ofn_is_attr_visible(struct k=
object *kobj,
>  	struct ims_pcu *pcu =3D usb_get_intfdata(intf);
>  	umode_t mode =3D attr->mode;
> =20
> +	if (intf !=3D pcu->ctrl_intf)
> +		return 0;

[Severity: Low]
Since ofn is a named attribute group, does returning 0 here suppress the
individual files but still leave an empty ofn directory on the data interfa=
ce?

According to sysfs guidelines, should this return SYSFS_GROUP_INVISIBLE
instead to fully suppress the group directory?


I also noticed a few pre-existing issues in the surrounding code:

drivers/input/misc/ims-pcu.c:ims_pcu_init_application_mode() {
        ...
        if (info->has_gamepad) {
                error =3D ims_pcu_setup_gamepad(pcu);
                if (error)
                        goto err_destroy_buttons;
        }

        pcu->setup_complete =3D true;

        return 0;
}

[Severity: High]
This is a pre-existing issue, but should there be a memory barrier before
setting pcu->setup_complete =3D true?

On weakly ordered architectures, could the CPU reorder these stores? If an
event arrives and ims_pcu_handle_response() observes setup_complete =3D=3D =
true
before buttons->input is fully initialized, it might lead to a NULL pointer
dereference in the interrupt handler.

drivers/input/misc/ims-pcu.c:ims_pcu_disconnect() {
        ...
        /*
         * See if we are dealing with control or data interface. The cleanup
         * happens when we unbind primary (control) interface.
         */
        if (alt->desc.bInterfaceClass !=3D USB_CLASS_COMM)
                return;

        ims_pcu_stop_io(pcu);
        ...
        ims_pcu_buffers_free(pcu);
        kfree(pcu);
}

[Severity: High]
This isn't a bug introduced by this patch, but does this fail to release the
claimed data interface?

If the driver claims the secondary data interface (pcu->data_intf) in
ims_pcu_probe(), failing to release it via usb_driver_release_interface()
when unbinding the control interface results in an asymmetric teardown.
The data interface remains bound with its intfdata pointing to the freed
pcu structure, and reading its sysfs attributes could trigger a use-after-f=
ree.

drivers/input/misc/ims-pcu.c:ims_pcu_reset_device() {
        ...
        dev_info(pcu->dev, "Attempting to reset device\n");

        error =3D ims_pcu_execute_command(pcu, PCU_RESET, &reset_byte, 1);
        if (error) {
        ...
}

[Severity: High]
This is a pre-existing issue, but shouldn't ims_pcu_reset_device() acquire
pcu->cmd_mutex before calling ims_pcu_execute_command()?

Without acquiring the lock, concurrent sysfs operations (e.g., setting
backlight brightness or updating firmware) could interleave their command
preparations. This could cause data corruption in the shared
pcu->urb_out_buf and race conditions on the pcu->cmd_done completion
structure.

drivers/input/misc/ims-pcu.c:ims_pcu_buffers_free() {
        ...
        usb_kill_urb(pcu->urb_in);
        usb_free_urb(pcu->urb_in);

        usb_free_coherent(pcu->udev, pcu->max_out_size,
                          pcu->urb_in_buf, pcu->read_dma);
        ...
}

[Severity: High]
This isn't a bug introduced by this patch, but is pcu->urb_in_buf being fre=
ed
with the wrong size?

It appears the input URB DMA buffer is incorrectly freed using
pcu->max_out_size instead of the pcu->max_in_size that was used during
allocation. Depending on the DMA allocator, this could lead to memory
corruption or leaks.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ahp23lj4_vXIeUBl@go=
ogle.com?part=3D1
