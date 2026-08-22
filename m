Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543F2E266C
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787366148; cv=none; b=s6UlqdUCjf1u/+95NgRqYJQ1TC7f0KwYjbRhURX7beOyUQqmabE1YPlsY+YhC2jfDFNKkn1imLYholAoE4DoY5yCwQLvBqAK6lLHIgzY5sbssBCbt46qq4rybdVt8NEgt4elb9d5Mx650nxC1CSb5boL7x9rmNNuXfW2qIYvrck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787366148; c=relaxed/simple;
	bh=7Yu24hR/bcx5wt43iBkxsLixWRQyemefabC4izBlmhI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lb6mUKPlrt8qxpkKQB+SaNYcWr7eVOPjzSbD3X8iA3j4eVfVlINDnMus2P4CHWiX49lcA+Cu5N42G2cu9+EINodbMA65zFgkKtjeGybXvFYLNH+C5W+PpLxHDNAMlM0GfOEPRwPPnnf1F7FnSGUU4fElilSM0GfiOSVnCC06SaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfG4o0sa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfG4o0sa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C911F000E9;
	Sat, 22 Aug 2026 02:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787366147;
	bh=UF8rF7qhYRGwBEEINylE7qqGOY4s58XGy0o94a54Dq4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KfG4o0saqO5yZunkQDZkTLEBJZJ+37ViDH6lMyzp6xjobxpOQl1WwHHZ4qvMF8D01
	 EibeFStv/sgFPHwoRpPvW8VdBTUedsYFQoBOryMgjbrLNjToCny215RHQBRI7I0HlV
	 qMGopViKIkjT+JlXClWkbxfjdZxoeiGt3LAdvM5LAIsZ8YAAOR5CC+LwdslDMnRCzE
	 qUqIGQ94FS+UOIyToAsH93bFWXPSF6z7dRYHqbejMFhWrRjd44G/jY0lnGVXN0yGqH
	 EnPQLqYWlQM8/Wf6QDxMlxwiYoJyChS5xrINxGBiWsupKMYT2KXmGrF1t2gj78uJyR
	 rqOe4opW2Tj5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/12] Input: xbox_gip - Add security implementation
 from xone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822021140.1149546-8-vi@endrift.com>
References: <20260822021140.1149546-1-vi@endrift.com>
 <20260822021140.1149546-8-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 02:35:46 +0000
Message-Id: <20260822023546.C1C911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Receiving a GIP_CMD_SECURITY message before the handshake is e=
xplicitly started causes a NULL pointer dereference.
- [High] Concurrent unprotected calls to crypto_shash_update corrupt the cr=
yptographic transcript.
- [High] Missing NULL check for the state buffer allocation in gip_security=
_get_transcript leads to a NULL pointer dereference.
- [High] Allocating the transcript state buffer using crypto_shash_descsize=
 instead of crypto_shash_statesize causes a heap buffer overflow.
- [High] Unchecked return values in gip_security_compute_prf lead to an inf=
ormation leak of kernel stack memory.
- [Medium] Missing cancellation of pending workers during protocol upgrade.
- [Medium] Unchecked return value of crypto_shash_tfm_digest() in gip_secur=
ity_compute_ecdh.
- [Medium] The ECDH shared secret is freed without being securely zeroized.
--

--- Patch [7]: [PATCH v4 07/12] Input: xbox_gip - Add security implementati=
on from xone ---
commit 5605e9d7634da03b416418354e348fe0ff787ead
Author: Vicki Pfau <vi@endrift.com>
Subject: Input: xbox_gip - Add security implementation from xone

This patch imports and adapts the security message implementation from the
out-of-tree xone driver. It adds a security message driver for Xbox One and
Series controllers, establishing handshakes needed for wireless dongles.

> diff --git a/drivers/input/joystick/gip/gip-security.c b/drivers/input/jo=
ystick/gip/gip-security.c
> new file mode 100644
> index 0000000000000..71da0833980ac
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-security.c
[ ... ]
> +static int gip_security_get_transcript(struct shash_desc *desc, void *tr=
anscript)
> +{
> +	void *state =3D kzalloc(crypto_shash_descsize(desc->tfm), GFP_KERNEL);

[Severity: High]
Does this allocate the wrong size? The crypto_shash_export function expects
a buffer sized by crypto_shash_statesize, not crypto_shash_descsize. Since
the state size can be strictly larger than the descriptor size for certain
algorithms, this could cause a heap buffer overflow.

[Severity: High]
Is it possible for kzalloc to fail here? The return value is passed directly
to crypto_shash_export without a null check, which would cause a null point=
er
dereference under memory pressure.

> +	int err;
> +
> +	err =3D crypto_shash_export(desc, state);
[ ... ]
> +static int gip_security_compute_prf(struct shash_desc *desc, const char =
*label,
> +	u8 *key, int key_len, u8 *seed, int seed_len, u8 *out, int out_len)
> +{
> +	u8 hash[SHA256_DIGEST_SIZE], hash_out[SHA256_DIGEST_SIZE];
> +	int err;
> +
> +	err =3D crypto_shash_setkey(desc->tfm, key, key_len);
> +	if (err)
> +		return err;
> +
> +	crypto_shash_init(desc);
> +	crypto_shash_update(desc, label, strlen(label));
> +	crypto_shash_update(desc, seed, seed_len);
> +	crypto_shash_final(desc, hash);
> +
> +	while (out_len > 0) {
> +		crypto_shash_init(desc);
> +		crypto_shash_update(desc, hash, sizeof(hash));
> +		crypto_shash_update(desc, label, strlen(label));
> +		crypto_shash_update(desc, seed, seed_len);
> +		crypto_shash_final(desc, hash_out);
> +
> +		memcpy(out, hash_out, min_t(int, out_len, sizeof(hash)));

[Severity: High]
Should we check the return values of the crypto operations inside this loop?
If crypto_shash_init, crypto_shash_update, or crypto_shash_final fail, the
hash_out buffer will retain its uninitialized kernel stack data. This data =
is
then copied into the output buffer and eventually sent over USB, leading to=
 an
information leak.

> +		out +=3D sizeof(hash);
> +		out_len -=3D sizeof(hash);
> +
> +		crypto_shash_digest(desc, hash, sizeof(hash), hash);
> +	}
> +
> +	return 0;
> +}
[ ... ]
> +static int gip_security_compute_ecdh(u8 *pubkey_in, u8 *pubkey_out, int =
pubkey_len, u8 *secret_hash)
> +{
> +	struct crypto_kpp *tfm_ecdh;
> +	struct crypto_shash *tfm_sha;
> +	u8 *secret;
> +	int err;
[ ... ]
> +	err =3D gip_security_ecdh_get_pubkey(tfm_ecdh, pubkey_out, pubkey_len);
> +	if (err)
> +		goto err_free_sha;
> +
> +	err =3D gip_security_ecdh_get_secret(tfm_ecdh, pubkey_in, pubkey_len,
> +		secret, GIP_SECURITY_ECDH_SECRET_LEN);
> +	if (err)
> +		goto err_free_sha;
> +
> +	crypto_shash_tfm_digest(tfm_sha, secret, GIP_SECURITY_ECDH_SECRET_LEN, =
secret_hash);

[Severity: Medium]
Could this leave secret_hash uninitialized if the digest fails? The return
value is ignored, which means the caller might silently proceed to compute =
the
master secret using uninitialized stack memory.

> +
> +err_free_sha:
> +	crypto_free_shash(tfm_sha);
> +err_free_ecdh:
> +	crypto_free_kpp(tfm_ecdh);
> +err_free_secret:
> +	kfree(secret);

[Severity: Medium]
Since the secret buffer holds raw cryptographic key material, should this u=
se
kfree_sensitive instead of kfree to prevent sensitive data from lingering in
the slab allocator?

> +
> +	return err;
> +}
> +
> +static int gip_security_send_message(struct gip_security *security,
> +	enum gip_security_command_handshake cmd, void *message, u16 len)
> +{
> +	struct gip_attachment *attachment =3D container_of(security, struct gip=
_attachment, security);
> +	struct gip_security_header_full *hdr =3D message;
> +	u16 data_len =3D len - sizeof(hdr->handshake) - GIP_SECURITY_TRAILER_LE=
N;
> +
> +	hdr->handshake.context =3D GIP_SECURITY_CTX_HANDSHAKE;
> +	hdr->handshake.options =3D GIP_SECURITY_OPT_ACKNOWLEDGE | GIP_SECURITY_=
OPT_FROM_HOST;
> +	hdr->handshake.command =3D cmd;
> +	hdr->handshake.length =3D cpu_to_be16(data_len);
> +
> +	hdr->data.command =3D cmd;
> +	hdr->data.version =3D cmd >=3D GIP_SECURITY2_CMD_HOST_HELLO ? 0x02 : 0x=
01;
> +	hdr->data.length =3D cpu_to_be16(data_len - sizeof(hdr->data));
> +
> +	security->last_sent_command =3D cmd;
> +	crypto_shash_update(security->shash_transcript, message + sizeof(hdr->h=
andshake), data_len);

[Severity: High]
Can this code execute concurrently with the message handler? The
gip_security_send_message function is called from asynchronous workers, whi=
le
gip_security_handle_message can also update the same shash_transcript
descriptor. Since shash_desc is not thread-safe, concurrent modifications
could corrupt the cryptographic transcript.

> +
> +	return gip_send_system_message(attachment, GIP_CMD_SECURITY, GIP_FLAG_A=
CME, message, len);
> +}
[ ... ]
> +int gip_security_handle_message(struct gip_security *security, const voi=
d *bytes, int num_bytes)
> +{
> +	const struct gip_security_header_handshake *handshake =3D bytes;
> +	const struct gip_security_header_full *hdr;
> +	int err;
> +
> +	if (num_bytes < sizeof(*handshake))
> +		return -EINVAL;
> +
> +	if (handshake->error)
> +		return -EPROTO;
> +
> +	if (handshake->options & GIP_SECURITY_OPT_ACKNOWLEDGE) {
> +		if (handshake->command =3D=3D 0x01)
> +			return gip_security_handle_acknowledge(security);
> +
> +		gip_err(security, "%s: handshake failed: 0x%02x\n",
> +			__func__, handshake->command);
> +		return -EPROTO;
> +	}
> +
> +	if (num_bytes < sizeof(*hdr))
> +		return -EINVAL;
> +
> +	hdr =3D bytes;
> +	/* client uses v2 */
> +	if (handshake->command !=3D hdr->data.command) {
> +		/* reset transcript hash and restart handshake */
> +		gip_dbg(security, "%s: protocol upgrade\n", __func__);
> +		crypto_shash_init(security->shash_transcript);

[Severity: Critical]
If an attacker-controlled USB device sends a security packet before the
handshake is explicitly started, could security->shash_transcript be a null
pointer here and cause a dereference? The cryptographic descriptors are
initialized lazily in gip_security_start_handshake, so early packets routed
to this handler might trigger a crash.

[Severity: Medium]
If we restart the handshake here, do we need to cancel any previously
scheduled v1 workers? If a v1 worker like work_exchange_rsa is pending, it
could execute concurrently, modify the state, and corrupt the new v2 handsh=
ake.

> +		return gip_security2_send_hello(security);
> +	}
> +
> +	err =3D gip_security_dispatch_message(security, hdr->data.command,
> +		bytes + sizeof(*hdr), num_bytes - sizeof(*hdr));
> +	if (err)
> +		return err;
> +
> +	return crypto_shash_update(security->shash_transcript,
> +		bytes + sizeof(hdr->handshake),
> +		num_bytes - sizeof(hdr->handshake));

[Severity: Critical]
Similar to the issue above, could security->shash_transcript be a null poin=
ter
here if a packet is received before the handshake was explicitly started,
resulting in a null pointer dereference in crypto_shash_update?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822021140.1149=
546-1-vi@endrift.com?part=3D7
