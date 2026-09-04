Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4C4CC286
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533874; cv=none; b=uripfxHsJY1m64ACrp4loIIOAwUHYx06SbCzI8CR3UCb8XZvSMkcLvYR24HsTm4s2fjf6gcaGCniU/2hihZxtZKtfjHAySNALCnburBigmCV7NOhtTwsFmN0gWzF9JLi46gGLEsjIG70kThKyOrYGp0eP+i19ecRtRAMX9TCE1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533874; c=relaxed/simple;
	bh=k2CtgMW+COB12lgJ22F6Erzpzx3e4w6lpW1tIE0gAqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UqAifNZ5vqO6m4fdQJnHuUqMIb5+cQBumPUgPbDPt3cdLiTRHfttybR94htVbN2tz8ElHRibzXqEbYBvcqPgQa9ma5OPQaTFE0rDSvSLmB8eAV6q8MaDQOliyNDx+ygiFXGLRTME7RIVF5Qwz8PYOxFIqtJ0IKVxslD3vELO40U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UepDogJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UepDogJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259581F00A3D;
	Fri,  4 Sep 2026 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788533873;
	bh=QqpKogcU7FK9XmaWrd0UHJOHVUzJ6uQkyAwHN4KNskg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UepDogJE4Tzo1O50S+NVM/KhaXRY289GFNOjeoRJFXWbqlI/zRKOZj1HEd42aTvtK
	 rXrgIkmA8Cg/cGajV/9RwsUSgIaOxTqE1g8nrOsNnLT9Bxl0zITrcr8vNuc8v9c1bx
	 429goQmnEHW+SR0M4PCljHmxH4NAdM0WNiDdt1+Gn7bvKMAO7MuuYwnvdQ/2NjyrII
	 0ogSoYbbjjliFP/X7+5Gg8iejrngOI6ehkvheOF+R8LyXF4jccAdpAyn4SJnqP31VS
	 om2KwFdrikGtgomYX8rDewlnUx6/ISTnV1d0uNyd46K6vQd6+QMqbngzZ51e3/3mqY
	 B/GkHEwxC73yQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 1/2] HID: topping-m62: driver for the M62's
 vendor controls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Gavrilov" <mikhail.v.gavrilov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260904144300.529289-2-mikhail.v.gavrilov@gmail.com>
References: <20260904141158.33398-1-mikhail.v.gavrilov@gmail.com>
 <20260904144300.529289-1-mikhail.v.gavrilov@gmail.com>
 <20260904144300.529289-2-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 14:57:52 +0000
Message-Id: <20260904145753.259581F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Lockless access to newly initialized ALSA controls (m62->kctl) wit=
hout memory barriers causing a data race.
- [Low] Mixing goto-based error handling with scope-based cleanup helpers (=
`scoped_guard`) in the same function.
--

commit 0bcb87ac2e7106ce707298feca287dd58398496f
Author: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

HID: topping-m62: driver for the M62's vendor controls

This commit adds a driver for the Topping M62 USB audio interface to expose
vendor controls (such as analogue input gains, output volumes, and output
source selectors) through a HID-class interface. It registers a component
that interacts with the snd-usb-audio driver to add the controls to the
master sound card.

> diff --git a/drivers/hid/hid-topping-m62.c b/drivers/hid/hid-topping-m62.c
> new file mode 100644
> index 0000000000000..3c1b8e7626f69
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
Can this lockless read of m62->kctl[idx] race with the initialization
in topping_add_kctl()?

Because hid_device_io_start() is called in topping_probe() before the
component binds, USB interrupts can arrive while topping_bind() is running.

In topping_bind(), m62->card is set early under a lock:

        scoped_guard(spinlock_irqsave, &m62->lock)
                m62->card =3D card;

This exposes it to the interrupt handler. When topping_bind() subsequently
allocates controls, it publishes them to m62->kctl locklessly in
topping_add_kctl():

        m62->kctl[slot] =3D kctl;

Without memory barriers or lock synchronization here, could the CPU reorder
the initialization, causing this interrupt handler to observe a non-NULL
pointer but crash or misbehave when snd_ctl_notify() dereferences it?

> +
> +	return 0;
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

[Severity: Low]
This is a stylistic issue, but does this function mix goto-based error
handling with scope-based cleanup helpers?

According to the kernel's cleanup subsystem guidelines, functions should not
mix goto labels (like err_drop) with scope-based cleanups (like
scoped_guard). This is to prevent confusing ownership semantics and fragile
cleanup paths. Should this function be converted entirely to scope-based
cleanups or revert to traditional locking?

> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904144300.5292=
89-1-mikhail.v.gavrilov@gmail.com?part=3D1
