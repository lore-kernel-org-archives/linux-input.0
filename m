Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81238AC80
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518381; cv=none; b=SigByZGvVpNvAFPpTqpyglEHbmrT0S04A2XUatKerbvyWKmux81pduEQ3m5R0T7osw+mX/0/VNq2oyVnxEWkabrGLiygoqokOPEd8+qNpjZQdSJP7W3d5a/tqwFbIYC7CKGQeN+2qfrJEt0sFcDOmpUcvHolj0kGF0kw4N9Vpro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518381; c=relaxed/simple;
	bh=6CgCkGFTuSLHHIGC/yHd8rcZ+6ZqCtdJMUkoISn/6mI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SE65x+nmi5a3NE7DIDohf/B+nThAjv/2PQE0LX1zNCbdlZ0LIenc26Wjkcus/+jAFX0JXAKXlGp01CnAySZgwIO/N+xlTDUxSgh5z7RdW6S0ZkGBfVtiQQJbe97O9lXsiy4k0pdJP2osQZK0saH5ctSOhnZ9JCicY2CQQ8gZS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Evi53KGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Evi53KGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC0F1F000E9;
	Mon, 20 Jul 2026 03:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784518378;
	bh=e/EGyu4i3uQ2CgnsT2F11rFr4ZB3+99/Hydx+Fsd2UM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Evi53KGLKss/JTCgc4zTuN8oNiM73UC21VPzHOfLdjWZdzPOEo41bBTJh+XdOULkO
	 BFo7IQkOMyPMHfCc1CRwZgurZlIbVdhB0ADuXlvPrpBcrhzXaS3+NHca3ihS7VnqPL
	 P4y+UqJDKPgTB4Hrl/OVFgVSoqpr4Ektt7g2bGXZ5iaA29KXBdmYnT5FKxTIW08USu
	 BtQrqQgkZMIR7kYupebUB3kyUCBVmDazVHMCVs2Lu7gwYZhbNyKz/CzAH2oVNKV7Un
	 BRpBZXStRFTk9aAy0O9w9WhH4LFXoJ0GnBiR0/TsgngjTvmZex9ng6YAyt0TPVUCqm
	 CI0EJQ3PmMYVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720031549.2272658-3-derekjohn.clark@gmail.com>
References: <20260720031549.2272658-1-derekjohn.clark@gmail.com>
 <20260720031549.2272658-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 03:32:58 +0000
Message-Id: <20260720033258.9DC0F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Race condition in `claw_profile_event` causes stale data to be ret=
urned for profile reads.
- [Low] Compilation error due to invalid C syntax for embedded tagged struc=
t.
- [Low] Subsystem guide violation: Mixing `goto`-based cleanup labels with =
`__free()` automated cleanup.

Pre-existing issues:
- [High] Generic ACK responses improperly complete commands waiting for spe=
cific data payloads.
- [High] Gamepad sysfs attributes are permanently hidden and never created.
--

--- Patch [2]: [PATCH v13 2/4] HID: hid-msi: Add M-key mapping attributes -=
--
commit 4c48f895b57157a8a075f47f1218b8052e864f1b
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add M-key mapping attributes
   =20
This patch adds attributes that allow for remapping the M-keys on MSI
devices when in macro mode. It routes mapped buttons to appropriate event
devices for gamepad, keyboard, or mouse events.

Link: https://patch.msgid.link/20260529072111.7565-3-derekjohn.clark@gmail.=
com

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 6687e4579faa1..023d63cee6b06 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
> @@ -255,6 +255,15 @@ struct claw_command_report {
>  	u8 data[59];
>  } __packed;
> =20
> +struct claw_profile_report {
> +	u8 profile;
> +	__be16 read_addr;
> +} __packed;
> +
> +struct claw_mkey_report {
> +	struct claw_profile_report;
> +	u8 padding_0;

[Severity: Low]
Will this compile successfully, or does this introduce a regression?
Standard C11 only permits anonymous structs if they do not have a tag. Using
a tagged struct (like struct claw_profile_report;) without a field name acts
as a forward declaration.

This makes padding_0 the first member, causing the initialization in
claw_mkey_store() to fail, and attempts to access mkeys->read_addr in
claw_profile_event() will fail with a missing member error.

[ ... ]
> +static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_=
command_report *cmd_rep)
> +{
> +	enum claw_profile_ack_pending profile;
> +	struct claw_mkey_report *mkeys;
> +	u8 *codes, key;
> +	int i;
> +
> +	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> +		profile =3D drvdata->profile_pending;
> +
> +	switch (profile) {
> +	case CLAW_M1_PENDING:
[ ... ]
> +	default:
> +		dev_dbg(&drvdata->hdev->dev,
> +			"Got profile event without changes pending from command: %x\n",
> +			cmd_rep->cmd);
> +		return -EINVAL;
> +	}
> +	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> +		drvdata->profile_pending =3D CLAW_NO_PENDING;
> +
> +	return 0;
> +}

[Severity: High]
Is there a race condition here that introduces a regression where stale
data is returned?

The lock is dropped after reading profile_pending, opening a race window
where another thread could update it. When this thread resumes and
unconditionally writes CLAW_NO_PENDING, it could destroy pending profile
requests initiated during the race window.

For example, if Thread 1 times out leaving CLAW_M1_PENDING, and Thread 2
sets CLAW_M2_PENDING, a delayed hardware response for M1 could cause this
function to overwrite Thread 2's state with CLAW_NO_PENDING. This would
cause Thread 2 to return unmodified M2 data.

[ ... ]
>  static int claw_raw_event(struct claw_drvdata *drvdata, struct hid_repor=
t *report,
>  			  u8 *data, int size)
>  {
[ ... ]
>  	case CLAW_COMMAND_TYPE_ACK:
>  		if (drvdata->orphan_ack_pending) {
>  			drvdata->orphan_ack_pending =3D false;
>  			complete(&drvdata->orphan_ack_complete);
>  			break;
>  		}
> =20
>  		if (drvdata->waiting_cmd =3D=3D CLAW_COMMAND_TYPE_NONE) {
>  			dev_warn(&drvdata->hdev->dev, "Got unexpected ACK from MCU, ignoring\=
n");
>  			break;
>  		}
> =20
>  		drvdata->cmd_status =3D 0;
>  		complete(&drvdata->send_cmd_complete);

[Severity: High]
This is a pre-existing issue, but do generic ACKs improperly complete
commands waiting for specific data payloads?

If a previous command (like SYNC_TO_ROM with a timeout of 0) takes longer
than the timeout to send its ACK, the orphan_ack_pending flag might clear
before the generic ACK arrives.=20

When the delayed generic ACK finally arrives while waiting_cmd is set for
a new command (like READ_PROFILE), this branch skips the orphan check and
unconditionally triggers complete(&drvdata->send_cmd_complete). This
prematurely completes the new command's wait, potentially returning stale
or uninitialized data.

[ ... ]
> static int __claw_hw_output_report(struct hid_device *hdev, u8 index, u8 =
*data,
>                                    size_t len, unsigned int timeout)
> {
>         unsigned char *dmabuf __free(kfree) =3D NULL;
[ ... ]
> err:
>         scoped_guard(spinlock_irqsave, &drvdata->cmd_lock) {
>                 drvdata->waiting_cmd =3D CLAW_COMMAND_TYPE_NONE;
>                 drvdata->orphan_ack_pending =3D false;
>         }
>         return ret;
> }

[Severity: Low]
This is a pre-existing issue, but does this function mix goto-based cleanup
labels with __free() automated cleanup?

The function declares unsigned char *dmabuf __free(kfree) =3D NULL; but also
utilizes a goto err; label for state cleanup. The cleanup and guard
subsystem guidelines state that functions should either convert all
resources to scope-based cleanup or convert none of them.

[ ... ]
>  static umode_t claw_gamepad_attr_is_visible(struct kobject *kobj, struct=
 attribute *attr,
>  					    int n)
>  {
>  	struct hid_device *hdev =3D to_hid_device(kobj_to_dev(kobj));
>  	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
>=20
>  	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
>  		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context=
 */
>  		if (!smp_load_acquire(&drvdata->gp_registered))
>  			return 0;
>  	}

[Severity: High]
This is a pre-existing issue, but are the gamepad sysfs attributes ever
created and made visible?

In cfg_setup_fn(), device_add_group() is called before gp_registered is
set to true. During sysfs group creation, this callback evaluates
!smp_load_acquire(&drvdata->gp_registered) and returns 0.

Because it returns 0 during creation, the files are never created. Even
though gp_registered is set to true immediately afterward, the attributes
will remain permanently hidden since sysfs_update_group is not called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720031549.2272=
658-1-derekjohn.clark@gmail.com?part=3D2
