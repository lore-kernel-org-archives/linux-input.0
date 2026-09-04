Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5E4C8FF7
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 14:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531682; cv=none; b=X3BAIiv4QOmEosLXuNXINOUl4T4zapySWagCNRCjGPX1PrJEoAkF/L0+9XUAhLZ1eQLLjAJ++H4q/Rju0EHKMNtRkCPMyx2ZymWP8C8qiFLVIyMC93sfe+8jutzphwj+jDqK5hiPQhpehyELRn8DITWc9idjG2lK4C3xVj38yfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531682; c=relaxed/simple;
	bh=/Cd6amBtNiHUGdtYKALKbijIOffdJk9R3O8eEiHQ+SM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VToswAzhjL24W0gyNbRf6HXXI806nwho3zhgxBS7pxyZX3SsHP1wd04mhTOPuQFAWwJp/NCM4RCePHiUOAe/JWMjME5jTEwogmv4Cy+xUapMjHXsrX2meatKf1btD3+9Bte9PBERbw2FKts6Sx50J1Y9pC7EMA8G+vWArSnA448=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxVGK+mJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxVGK+mJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2F31F00A3D;
	Fri,  4 Sep 2026 14:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788531681;
	bh=x4azLc3AjcGPDlfxtNwUZiny5SsaslratC90ok1OAhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BxVGK+mJ3Ncv/4H1J0iHjB4fYtYz/5p5z7FRoyXUpAnWI8UhqS8kj3P0JnmejtSSd
	 5VbJH+YSR9LjdUXVLba0nI+vUqDbl+ZtCYH4THHQ7oW0MQOdCZLVKIC7P7ztJzau7o
	 RwRrl0Uej0ZKyvSLLTgTvc7Yc8Jjag0ja8n950B1RPbXNywYtseQbOOqj9ESVA2qRu
	 rwmZpsz+IdvJ46wlh5PbwM5wx8JPo/LDUuVRdmRNcOX6pvNHGYRsd8Ownc/Xj9gShG
	 mjxNYubxMGT6ALt5j3SJWmw9QV79hQE0TBJe4lsyPZa15RjBK/9N5IH9/NwBjzhPyb
	 8dIPfCn1ctCCw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 1/2] HID: topping-m62: driver for the M62's
 vendor controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260904141158.33398-2-mikhail.v.gavrilov@gmail.com>
References: <20260904112610.3286659-1-mikhail.v.gavrilov@gmail.com>
 <20260904141158.33398-1-mikhail.v.gavrilov@gmail.com>
 <20260904141158.33398-2-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 14:21:20 +0000
Message-Id: <20260904142121.1D2F31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Use-After-Free in topping_bind error path when handling concurrent=
 USB events.
--

commit a582809964c0e1ad990a6ee419fbee8c5cf85dae
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

HID: topping-m62: driver for the M62's vendor controls

This commit adds a HID driver for the Topping M62 USB audio interface to
expose vendor-specific controls like analog input gains, output volumes,=20
and source selectors. These controls are exposed as ALSA mixer elements on
the sound card created by snd-usb-audio.

> diff --git a/drivers/hid/hid-topping-m62.c b/drivers/hid/hid-topping-m62.c
> new file mode 100644
> index 0000000000000..66c037e2b8688
> --- /dev/null
> +++ b/drivers/hid/hid-topping-m62.c
[ ... ]
> +static int topping_raw_event(struct hid_device *hdev,
> +			     struct hid_report *report, u8 *data, int size)
> +{
[ ... ]
> +	guard(spinlock_irqsave)(&m62->lock);
> +
> +	if (m62->val[idx] =3D=3D value)
> +		return 0;
> +	m62->val[idx] =3D value;
> +
> +	if (m62->card && m62->kctl[idx])
> +		snd_ctl_notify(m62->card, SNDRV_CTL_EVENT_MASK_VALUE,
> +			       &m62->kctl[idx]->id);

[Severity: High]
If an interrupt packet arrives while the controls are being freed, could
this lead to a use-after-free?

Since hid_device_io_start() was called earlier in probe, topping_raw_event()
can execute concurrently with the error path in topping_bind().

> +
> +	return 0;
> +}
[ ... ]
> +static void topping_drop_kctls(struct topping_m62 *m62, struct snd_card =
*card)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < TOPPING_NUM_KCTLS; i++) {
> +		snd_ctl_remove(card, m62->kctl[i]);
> +		m62->kctl[i] =3D NULL;
> +	}
> +}
[ ... ]
> +static int topping_bind(struct device *comp, struct device *master,
> +			void *master_data)
> +{
> +	struct hid_device *hdev =3D to_hid_device(comp);
> +	struct topping_m62 *m62 =3D hid_get_drvdata(hdev);
> +	struct snd_card *card =3D master_data;
> +	int i, err;
> +
> +	scoped_guard(spinlock_irqsave, &m62->lock)
> +		m62->card =3D card;
> +
> +	for (i =3D 0; i < TOPPING_NUM_CTLS; i++) {
> +		err =3D topping_add_kctl(m62, &topping_ctl,
> +				       topping_m62_ctls[i].name, i, i,
> +				       topping_m62_ctls[i].tlv);
> +		if (err < 0)
> +			goto err_drop;
> +	}
[ ... ]
> +err_drop:
> +	topping_drop_kctls(m62, card);
> +	scoped_guard(spinlock_irqsave, &m62->lock)
> +		m62->card =3D NULL;
> +	return err;
> +}

[Severity: High]
Could this error path allow the race described above?

If topping_add_kctl() fails, we jump to err_drop and call
topping_drop_kctls(). The controls are removed and freed via snd_ctl_remove=
()
without holding m62->lock.

Because m62->card is still non-NULL until after topping_drop_kctls() finish=
es,
a concurrent topping_raw_event() could take the lock, see m62->card is vali=
d,
and access the already-freed m62->kctl[idx]->id.

It looks like topping_unbind() avoids this exact issue by clearing m62->card
under the lock before removing the controls. Should err_drop follow the same
ordering to prevent the race?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904141158.3339=
8-1-mikhail.v.gavrilov@gmail.com?part=3D1
