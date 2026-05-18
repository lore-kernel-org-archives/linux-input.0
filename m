Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86FE3F54DF;
	Mon, 18 May 2026 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103035; cv=none; b=fCcbjNibB5p2X9SbQ6Ktb/+oXu+QiWOmc0suf3DRlEBLrFQY9rR5FbkFIGEupHWauLbpgk0s/xziNO4Jh6wUZVurCSAHwV9gpDW3X9zqdVLgnz51cmQ9/bIIfMLW9AnEDHNG5T8cBhkXID/P1kTFbyHN49Ks2h64QzL+gZW2HII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103035; c=relaxed/simple;
	bh=yQaPRqjhEAvNS2XqtXLbW3dhlWBkhQA+KcaHB3/iEPg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CL+MW4NlERTJ7jvTRRODVhJYqCF80aSgaQX0mfIE6kTkCLz+oXE5vqkA8r7LG6UVrqhj+mJ7eFDid9XUXsLvl2rhWOOpJBh5x0+asxqsQkludOjeRIdyumPpvbnXgmy2aCn373EC1sRJD8763AGxgv+nk8z4V/rIrtc5kKVXcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdqyWq1b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdqyWq1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEF9C2BCB7;
	Mon, 18 May 2026 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779103033;
	bh=yQaPRqjhEAvNS2XqtXLbW3dhlWBkhQA+KcaHB3/iEPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JdqyWq1bNypXzLceBdYuWNvvYCPDNI1V4u8FgI2YnmZJQpLZNRJTaeeQD/opGv6Ra
	 9/JnVC+WdBnHKVvhPh0ju36cEUuMZ1qTj7mnA3k2NY2/pgDtH3Ud9ovQUW9cSTIwA9
	 ckgap2v1O1CsyUq3SVqWlVeHoH8JbxwLlWS1NcebSgQC1VoZSwMsrT6tWKCgOJQ27R
	 B4a5bbuXRlglfmas7VN63MGHocv+b2pz3lqoN8mmp5+RPO2sMNk2ujUzX5hc+0G8Ux
	 x167OTvHOb3N1bW5M20TVrbrLb9CuxJADynRRWQooaWwyTnKjCHxhiSZ1WFx+nLbl/
	 CRzbaMG6X+HYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org
In-Reply-To: <20260518095907.36158-4-clamor95@gmail.com>
References: <20260518095907.36158-4-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 11:17:12 +0000
Message-Id: <20260518111712.BDEF9C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Sleeping in atomic context due to synchronous I2C transfer in seri=
o->write callback.
- [High] Off-by-one error in packet length calculation causes a buffer over=
-read and breaks keycode remapping.
- [Medium] In-place modification of a shared notifier data buffer.
--

commit 3c9b2bf0acd20a594f17d65b0d6fd9762329b3bc
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

input: serio: Add driver for ASUS Transformer dock keyboard and touchpad

This commit adds a serio input driver for the ASUS Transformer dock keyboard
and touchpad. It registers serio ports that act as a bridge over I2C and
remaps specific keycodes according to their position.

> diff --git a/drivers/input/serio/asus-transformer-ec-kbc.c b/drivers/inpu=
t/serio/asus-transformer-ec-kbc.c
> new file mode 100644
> index 0000000000000..c9707c7fbede5
> --- /dev/null
> +++ b/drivers/input/serio/asus-transformer-ec-kbc.c

[ ... ]

> +static int asus_ec_kbc_notify(struct notifier_block *nb,
> +			      unsigned long action, void *data_)
> +{
> +	struct asus_ec_kbc_data *priv =3D container_of(nb, struct asus_ec_kbc_d=
ata, nb);
> +	unsigned int port_idx, n;
> +	u8 *data =3D data_;
> +
> +	if (action & (ASUSEC_SMI_MASK | ASUSEC_SCI_MASK))
> +		return NOTIFY_DONE;
> +	else if (action & ASUSEC_AUX_MASK)
> +		port_idx =3D 1;
> +	else if (action & (ASUSEC_KBC_MASK | ASUSEC_KEY_MASK))
> +		port_idx =3D 0;
> +	else
> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * The data[0] is the length of the packet including itself. It has to
> +	 * be at least 2 bytes (length + 1 data byte) and must not exceed
> +	 * the EC buffer size.
> +	 */
> +	if (data[0] < 2 || data[0] > DOCKRAM_ENTRY_BUFSIZE)
> +		return NOTIFY_BAD;
> +
> +	n =3D data[0] - 1;
> +	data +=3D 2;

Is the payload length calculation off by one?

The comment states data[0] is the length of the packet including itself.
The code then skips two bytes (data +=3D 2), which suggests the payload
starts at offset 2. If the payload length is data[0] - 2, will setting
n =3D data[0] - 1 cause the loop at the end of the function to read one byte
past the actual payload and inject garbage data into the serio port?

If an external device sends a packet with data[0] =3D=3D DOCKRAM_ENTRY_BUFS=
IZE,
could this off-by-one error cause an out-of-bounds read past the end of
the EC buffer array?

Additionally, will this artificially inflated n cause the exact-length
validation in the key remapping logic (if (n =3D=3D 2 ...) and if (n =3D=3D=
 3 ...))
to always fail for valid payload sequences, breaking the layout translation?

> +
> +	if (port_idx =3D=3D 0) {
> +		/*
> +		 * Remap keyboard key codes to match AT layout:
> +		 * SEARCH: RIGHT-META [E0 27] -> LEFT-ALT   [11]
> +		 * MENU:   COMPOSE    [E0 2F] -> RIGHT-META [E0 27]
> +		 */
> +		if ((n =3D=3D 2 || (n =3D=3D 3 && data[1] =3D=3D 0xF0)) && data[0] =3D=
=3D 0xE0) {
> +			u8 *keycode =3D &data[n - 1];
> +
> +			switch (*keycode) {
> +			case 0x27:
> +				*keycode =3D 0x11;

Is it safe to modify the data_ buffer in place?

Since data_ is passed to this function via the notifier chain, it points to=
 a
shared event buffer that is broadcast to all registered listeners. Will
modifying this payload permanently corrupt the event data for any downstream
notifiers that might inspect the packet subsequently?

> +				++data;
> +				--n;
> +				break;
> +			case 0x2F:
> +				*keycode =3D 0x27;
> +				break;
> +			}
> +		}
> +	}
> +
> +	while (n--)
> +		serio_interrupt(priv->sdev[port_idx], *data++, 0);
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int asus_ec_serio_write(struct serio *port, unsigned char data)
> +{
> +	struct asus_ec_kbc_data *priv =3D port->port_data;
> +
> +	return i2c_smbus_write_word_data(priv->parent, ASUSEC_WRITE_BUF,
> +					 (data << 8) | port->id.extra);

Can this sleep while in an atomic context?

i2c_smbus_write_word_data() performs a synchronous I2C transaction which
acquires mutexes and can sleep. However, serio->write callbacks can be
invoked from atomic contexts.

For example, asus_ec_kbc_notify() calls serio_interrupt() which acquires a
spinlock and disables interrupts:

serio_interrupt()
  spin_lock_irqsave(&serio->lock, flags);
  serio->drv->interrupt()
    serio_write()
      asus_ec_serio_write()
        i2c_smbus_write_word_data()

Will this trigger a scheduling-while-atomic panic if the input driver issues
a command back to the port while the spinlock is held?

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518095907.3615=
8-1-clamor95@gmail.com?part=3D3
