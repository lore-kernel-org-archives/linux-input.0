Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C533033E8
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 07:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784361257; cv=none; b=tN/1cQ8I0f3SsSmIZ9qZPjRN3249LZe6WXB3ksIa1kHtJY90v1Bjtuymp8luM/LntnwFdLIC49K8/UVs6eQQl/vHUOML8iAsI5Hy8PqjRdeX8/bD2PhIvPIvKtgu8MiM98Zj76x3yVIM7PGrtTQ1n0PXwniKIb8oG6FyX/7sFVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784361257; c=relaxed/simple;
	bh=FVsfcd6HCCP7nrC2kuY1LUxaMKDYstqPHjwK1K+Hjks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PDPdchhG7wyZ9Wi9NVbVAk2ElBg19FQaCgGjsMXDFO6AXDUwNrfWgnWOq42iXkBiZ1GiVMgTP1nZvDM0pC6mL2eC4ngy6o8cKEv7KhcIInMmrwTUj8ft404sKkoVEoRJqUMq3ixsbSnG5QIA661IGiDV5STRpA3a3n1ob7xxa2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qrplixsg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qrplixsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACAA1F000E9;
	Sat, 18 Jul 2026 07:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784361256;
	bh=gaexjysXs7eAt3mAIXgIdksNaXHbn8GADV/MGpD51ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QrplixsgwI96ZOOFrU6KuwegJuiD4umzdli+joDCtLJyoxRBOKSHwok+PeQV9rL4b
	 MBwzhBFnVOLFIcrAZvaDQ/5fzHC0AaqWyp1kl9z9PKo0j2EA4t3I4geacglCY3E9wf
	 3zOUOjoTyRx4WYJmukuoGiJiNBipSNo/E5R7eKm8cYZ8MBcLDoaK7/WhpOAY3XNpgw
	 Dcw4rV6hD91xL6YW/eI99gcsfG46gp5YnAguClNwEhS3s+8GaiiQivT7wp9rr7AXQO
	 dFN2RK1my3Czoc9lIlrJdNlWjw1fwuX/rmjLiXDvZULOMMAy9uBLay1AaBacACkTXt
	 iT52RShrvKaVA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: cs40l50-vibra - validate custom data from user
 space
Reply-To: sashiko-reviews@lists.linux.dev
To: "HyeongJun An" <sammiee5311@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260718074032.1864861-1-sammiee5311@gmail.com>
References: <20260718074032.1864861-1-sammiee5311@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 07:54:15 +0000
Message-Id: <20260718075416.2ACAA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Updating an existing OWT effect leaks DSP memory and desynchronize=
s indices.
- [High] Out-of-bounds slab read in cs40l50_upload_owt due to passing byte =
count instead of element count to regmap_bulk_write.
- [High] The driver allocates devm resources against the parent device rath=
er than its own child device, leaking resources across unbind cycles.
- [High] Local DoS via unbounded synchronous sleeping in ordered workqueue =
during playback.
- [Medium] Unhandled odd custom_len values lead to truncated OWT data lengt=
hs.
- [Medium] Memory structures are permanently leaked if hardware cannot be r=
esumed during worker execution.
--

--- Patch [1]: [PATCH] Input: cs40l50-vibra - validate custom data from use=
r space ---
commit a72a6893fcb7d7f39ce7369bea556bb585afa8b7
Author: HyeongJun An <sammiee5311@gmail.com>

Input: cs40l50-vibra - validate custom data from user space

This commit adds validation for custom data lengths to prevent zero or one-=
byte
allocations. It also updates the bank value to a 32-bit unsigned integer to
avoid bypassing upper bounds checks with negative values.

> diff --git a/drivers/input/misc/cs40l50-vibra.c b/drivers/input/misc/cs40=
l50-vibra.c
> index 996d6c38cca43..7ef4534fea2fb 100644
> --- a/drivers/input/misc/cs40l50-vibra.c
> +++ b/drivers/input/misc/cs40l50-vibra.c
[ ... ]
> @@ -326,6 +326,12 @@ static int cs40l50_add(struct input_dev *dev, struct=
 ff_effect *effect,
>  		return -EINVAL;
>  	}
> =20
> +	if (periodic->custom_len < CS40L50_OWT_CUSTOM_DATA_SIZE) {

[Severity: Medium]
This is a pre-existing issue, but would this check ensure `custom_len` is e=
ven?

Since `custom_len` represents the number of 16-bit words, an odd value resu=
lts
in a byte length that is not a multiple of 4. Later in `cs40l50_upload_owt(=
)`:

cs40l50_upload_owt() {
    ...
    header.data_words =3D len / sizeof(u32);
    ...
}

Could this integer division truncate the unaligned payload length before it=
 is
sent to the DSP?

> +		dev_err(vib->dev, "Invalid custom data length (%u)\n",
> +			periodic->custom_len);
> +		return -EINVAL;
> +	}
> +
>  	work_data.custom_data =3D memdup_array_user(effect->u.periodic.custom_d=
ata,

[Severity: High]
This is a pre-existing issue, but is it possible that updating an existing =
OWT
effect leaks DSP memory and desynchronizes indices?

When an existing OWT effect is updated, it seems `cs40l50_add_worker()` pus=
hes
a new waveform to the DSP without deleting the old one:

cs40l50_add_worker() {
    ...
    effect =3D cs40l50_find_effect(work_data->effect->id, &vib->effect_head=
);
    ...
}

Might this leak DSP memory until it permanently errors with `-ENOSPC`?

Additionally, `cs40l50_effect_index_set()` computes the new index by counti=
ng
OWT elements in `vib->effect_head`:

cs40l50_effect_index_set() {
    ...
    list_for_each_entry(owt_effect, &vib->effect_head, list)
        if (owt_effect->type =3D=3D CS40L50_WVFRM_BANK_OWT)
            effect->index++;
    ...
}

Since `CS40L50_EFFECTS_MAX` is 1, this count is always 1 during an update.
However, the DSP increments its internal index for each push. Will this cau=
se
the software index to permanently desynchronize from the DSP after multiple
updates, resulting in the wrong effect being played?

[Severity: High]
This is a pre-existing issue, but could there be an out-of-bounds read in
`cs40l50_upload_owt()`?

cs40l50_upload_owt() {
    ...
    error =3D regmap_bulk_write(vib->regmap, vib->dsp.owt_base_reg +
                              (offset * sizeof(u32)), new_owt_effect_data,
                              sizeof(header) + len);
    ...
}

It appears `sizeof(header) + len` is passed as the `val_count` argument to
`regmap_bulk_write()`. Since the device's regmap configuration sets
`val_bits =3D 32`, `regmap_bulk_write()` interprets `val_count` as the numb=
er of
elements, not bytes.

Would this multiply the count by 4, reading 4x the allocated bytes from
`new_owt_effect_data` and sending arbitrary kernel memory to the DSP?

[Severity: Medium]
This is a pre-existing issue, but are memory structures leaked if the hardw=
are
cannot be resumed?

In `cs40l50_stop_worker()`:

cs40l50_stop_worker() {
    ...
    if (pm_runtime_resume_and_get(vib->dev) < 0)
        return;
    ...
}

Would this early return bypass the `kfree(work_data)` call, leaking the
dynamically allocated work structure?

Similarly, in `cs40l50_erase_worker()`:

cs40l50_erase_worker() {
    ...
    error =3D pm_runtime_resume_and_get(vib->dev);
    if (error)
        goto err_exit;
    ...
}

Can this failure path skip removing the effect from `vib->effect_head` and
`kfree(erase_effect)`, leaving the effect state permanently stranded?

[Severity: High]
This is a pre-existing issue, but are devm resources allocated against the =
wrong
device?

cs40l50_vibra_probe() {
    ...
    vib =3D devm_kzalloc(pdev->dev.parent, sizeof(*vib), GFP_KERNEL);
    ...
}

Because `devm_kzalloc()`, `devm_input_allocate_device()`, and
`devm_add_action_or_reset()` are bound to `pdev->dev.parent` (the parent MFD
device), will these resources be leaked across unbind cycles when the child
driver is unbound via sysfs?

[Severity: High]
This is a pre-existing issue, but could there be an unbounded synchronous s=
leep
in the workqueue during playback?

When a playback event is triggered, `work_data->count` comes from the
user-controlled event `value`:

cs40l50_start_worker() {
    ...
    while (--work_data->count >=3D 0) {
        vib->dsp.write(vib->dev, vib->regmap, start_effect->index);
        usleep_range(work_data->effect->replay.length,
                     work_data->effect->replay.length + 100);
    }
    ...
}

Could a user pass `count =3D 0x7FFFFFFF`, causing the worker to sleep for u=
p to
4.4 years?

Since `vib->vib_wq` is an ordered workqueue, would this completely block all
other work items?

If another process attempts to add, erase, or close the device descriptor, =
it
will call `flush_work()`:

cs40l50_add() {
    ...
    flush_work(&work_data.work);
    ...
}

Will this cause the process to hang in `TASK_UNINTERRUPTIBLE` indefinitely =
if
the workqueue is blocked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718074032.1864=
861-1-sammiee5311@gmail.com?part=3D1
