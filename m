Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5134538C42D
	for <linux-input@vger.kernel.org>; Wed, 27 May 2026 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779924869; cv=none; b=coXX4RxpomFMo9iaP3OFECTnYXPEkTlpagGpuMCiP1M9JG0+R3IcCt57EcNwY6hMAk25K+l+YFuxzpKdweIwbmNS1Puw7g6bkh9nC8G+hkyfb/LOIE7DKj76iBMwtXA5zIgfxAVXr2LzJUf1ZpfCMbm75vyVYlTkbc9dN2/XPGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779924869; c=relaxed/simple;
	bh=Ko6dFDxGgOD8j8STrEHtbfRrGSGM0Dm20e+de5CsjK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HgcVP9cLwT0hvTq+u+tL10/pPoEjewY5c0e9NtBwwz8iAHj7Q+JJE1YBqtrB6YgTFmct4r43aTOIuUtDY7SvQnTnEppjdAe8pvKpKQeWGZCnHzPpB9U3ZyFtoOveLDHocASc7Ygpm6qmGWNR7rfMgHltuSQpzyzw1oc103f9GCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHV83bjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHV83bjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33301F000E9;
	Wed, 27 May 2026 23:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779924868;
	bh=p9ccS3yBC6l+2C+rRl01RqmFxlW86CDVNWGmWWDZNcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iHV83bjxQFaODjd8t/S16RL2jH9CtwLmTWnr+3MHWZJZjv0syK/farP3YcDkz8Glu
	 ftiONPFooKvI5uZkQ5x0PcUTw6c9vigHh8dQV75Pp3jLHGdGe7+uB/ysoRSWamuI0q
	 M9K012F8+VJPsCS2akclsyZzQ9+i/vzTyc7S3qY2B/SWq90ialOE1dmrNlhis1mWmh
	 2mzNH890WOXUlA3LD//4ZA2DbZOR3SK74Q+HywmApBAXryrPdFV4KVb9ogFg+O56ob
	 sRh+lN+wp2/bXMtHfEEFDim17TpeFPtn+/demDDvPfkgoQ01J14UD0WYU8XPaN6gYv
	 60sMpTejawhcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260527222122.10620-3-derekjohn.clark@gmail.com>
References: <20260527222122.10620-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 23:34:27 +0000
Message-Id: <20260527233427.D33301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unhandled timeouts and spurious ACKs cause the READ_PROFILE state =
machine to desynchronize, causing legitimate reads to fail.
- [High] `claw_profile_event` unconditionally clears `profile_pending` afte=
r temporarily dropping the `profile_lock`, potentially overwriting concurre=
nt state changes.
- [High] Fire-and-forget commands with `timeout =3D 0` generate unhandled g=
eneric ACKs that can spoof and prematurely complete unrelated blocking comm=
ands.
- [Low] The declaration of `struct claw_profile_report;` inside `struct cla=
w_mkey_report` does not declare a member, causing build failures.
--

commit fdbd312ad4eb08333f93148ebf26e4c750ccb799
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add M-key mapping attributes

This patch adds sysfs attributes that allow remapping the M-keys on MSI Claw
devices when in macro mode. The mapping supports up to 5 values for the M1
and M2 buttons.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 3a176f44f2c43..f099d6cb7ea8d 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> +struct claw_profile_report {
> +	u8 profile;
> +	__be16 read_addr;
> +} __packed;
> +
> +struct claw_mkey_report {
> +	struct claw_profile_report;

[Severity: Low]
Will this compile correctly?

In standard C11 and GCC (without -fms-extensions), declaring a struct tag
without a declarator inside a struct definition only declares the tag in th=
at
scope, rather than creating an anonymous embedded struct member.

This means struct claw_mkey_report won't have a member named read_addr, whi=
ch
would cause mkeys->read_addr to produce a compilation error later.

> +	u8 padding_0;
> +	u8 padding_1;
> +	u8 padding_2;
> +	u8 codes[5];
> +} __packed;

[ ... ]

> +static int claw_profile_event(struct claw_drvdata *drvdata, struct claw_=
command_report *cmd_rep)
> +{
> +	enum claw_profile_ack_pending profile;
> +	struct claw_mkey_report *mkeys;
> +	u8 *codes, key;
> +	int i;
> +
> +	scoped_guard(spinlock, &drvdata->profile_lock)
> +		profile =3D drvdata->profile_pending;
> +
> +	switch (profile) {
> +	case CLAW_M1_PENDING:
> +	case CLAW_M2_PENDING:
> +		key =3D (profile =3D=3D CLAW_M1_PENDING) ? CLAW_KEY_M1 : CLAW_KEY_M2;
> +		mkeys =3D (struct claw_mkey_report *)cmd_rep->data;
> +		if (be16_to_cpu(mkeys->read_addr) !=3D drvdata->bmap_addr[key])
> +			return -EINVAL;
> +		codes =3D (profile =3D=3D CLAW_M1_PENDING) ? drvdata->m1_codes : drvda=
ta->m2_codes;
> +		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
> +			codes[i] =3D (mkeys->codes[i]);
> +		break;
> +	default:
> +		dev_dbg(&drvdata->hdev->dev,
> +			"Got profile event without changes pending from command: %x\n",
> +			cmd_rep->cmd);
> +		return -EINVAL;
> +	}
> +	scoped_guard(spinlock, &drvdata->profile_lock)
> +		drvdata->profile_pending =3D CLAW_NO_PENDING;

[Severity: High]
Is it safe to unconditionally clear profile_pending here after dropping and
reacquiring the lock?

If a timeout occurred in claw_mkey_show() for M1 just before this function
drops the lock, the M1 thread would release profile_mutex. A concurrent
thread could then enter claw_mkey_show() for M2 and set profile_pending to
CLAW_M2_PENDING.

When this function reacquires the lock, it would unconditionally overwrite
the state set by the concurrent thread, which could cause the M2 command to
fail when its own ACK arrives.

> +
> +	return 0;
> +}

[ ... ]

> +set_buttons:
> +	scoped_guard(mutex, &drvdata->rom_mutex) {
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DA=
TA,
> +					    (u8 *)&report, sizeof(report), 25);
> +		if (ret)
> +			return ret;
> +		/* MCU will not send ACK until the USB transaction completes. ACK is s=
ent
> +		 * immediately after and will hit the stale state machine, before the =
next
> +		 * command re-arms the state machine. Timeout 0 ensures no deadlock wa=
iting
> +		 * for ACK that ill never come.
> +		 */
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NUL=
L, 0, 0);

[Severity: High]
Does sending CLAW_COMMAND_TYPE_SYNC_TO_ROM with timeout 0 cause issues with
subsequent commands?

Because timeout is 0, the driver does not wait for the generic ACK that the
MCU will eventually send. This means the ACK will be left lingering and will
be processed asynchronously by claw_raw_event.

If another thread later sends a command that waits for a generic ACK (such
as CLAW_COMMAND_TYPE_WRITE_PROFILE_DATA), could it falsely complete early
by consuming the lingering ACK before the MCU has actually finished process=
ing
its request?

> +	}
> +
> +	return ret;
> +}
> +
> +static int claw_mkey_show(struct device *dev, char *buf, enum claw_key_i=
ndex m_key)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	struct claw_mkey_report report =3D { {0x01, cpu_to_be16(drvdata->bmap_a=
ddr[m_key])}, 0x07 };
> +	int i, ret, count =3D 0;
> +	const char *name;
> +	u8 *codes;
> +
> +	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
> +		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context=
 */
> +		if (!smp_load_acquire(&drvdata->gp_registered))
> +			return -ENODEV;
> +	}
> +
> +	codes =3D (m_key =3D=3D CLAW_KEY_M1) ? drvdata->m1_codes : drvdata->m2_=
codes;
> +
> +	guard(mutex)(&drvdata->profile_mutex);
> +	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> +		drvdata->profile_pending =3D (m_key =3D=3D CLAW_KEY_M1) ? CLAW_M1_PEND=
ING
> +								  : CLAW_M2_PENDING;
> +
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE,
> +				    (u8 *)&report, sizeof(report), 25);
> +	if (ret)
> +		return ret;

[Severity: High]
If claw_hw_output_report times out and returns early, doesn't it leave
drvdata->profile_pending set?

If another thread then initiates a READ_PROFILE for the other M-key (e.g., =
M2),
it will overwrite profile_pending. When the late ACK from the timed-out M1
command eventually arrives, claw_profile_event() will read CLAW_M2_PENDING
and compare the ACK's address (which is for M1) against M2's expected addre=
ss.
This would return -EINVAL and falsely complete the active M2 command with an
error.

> +
> +	for (i =3D 0; i < CLAW_KEYS_MAX; i++) {
> +		name =3D mkey_mapping_code_to_name(codes[i]);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527222122.1062=
0-1-derekjohn.clark@gmail.com?part=3D2
