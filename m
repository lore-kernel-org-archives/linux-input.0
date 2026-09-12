Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628C38F92D
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 03:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789183283; cv=none; b=VmGYeiwXZGu8OHuhXiokzVbrtZzVMjgoCC8Qr3NnWG75x7yv8sNrwMgapLnDd1jQQzQ+M9mWeKe79UdxvDLvRZfF4DRg3i/CJ3VFZ3OOfHA9e1zuuwoFfF/rjpZm9n2DvwfOAW1fQVy4f3P0C08bzlMYfUcALRrWNLa7pyj9FMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789183283; c=relaxed/simple;
	bh=nwm02eVKjxtPnFMWrasstgM7fy66ZYcFFhmNFkf/Sc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D2xPhhdj23TSIWSK2lqhQxDNibUEtJtJyRWTPPQ9MaTuheRSwCEnJN3wCz/OI8dMs1DZmn16gmvPx5D58P01CTiEt+CnfvcKCHQps1Gt6VdEhaolta0CZ2RD7rgGh0YTXlHrX8KRTOBI9HRg6X8Ar56Amxv5kflP/vCKACVAoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwxG/Tqd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwxG/Tqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5411F000FF;
	Sat, 12 Sep 2026 03:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789183281;
	bh=qZP1Jm5FQXnLpjpnBkmB2aTYnsff+nu7xMOWWm9HPpY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mwxG/Tqdllc/ajm2qi8sZ+1D6NRyJB4G++8xOkTkkULb/W1AJVO+IUEN3InjM+lQC
	 8KFU6IZxPqjadWijXuqTlYN3Ruhk/oe+mXLDqDJp1csTnqxti3xAvtLBMMyF4LluKA
	 usd2IkqQqHbAfKy2OUO8ChKrLtXeXERMtCJqUvOWFfQIMUqPA1kcgKNhLCy43eP0Bb
	 zTXVSmO2JmJmJybMecpUlvaVF3MaRRCghACurOWrePGrtUd7rfyx5M+8Xt49QDSAMU
	 0TFYNGCUSEQY1b2Do0nCSIHLVicbPEI7Id1W3lb+jMXF/MTm7SGKWwBzHZf/eWQZrU
	 ZMXI8hB/t2JSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/12] Input: xbox_gip - Add security implementation
 from xone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912030426.2997003-8-vi@endrift.com>
References: <20260912030426.2997003-1-vi@endrift.com>
 <20260912030426.2997003-8-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 03:21:20 +0000
Message-Id: <20260912032121.0F5411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Use-After-Free during device disconnect due to asynchronous cancel=
lation of security workqueues.
- [High] Dynamic `INIT_WORK()` calls in `gip_security_start_handshake()` ca=
n corrupt workqueue state if re-entered.
- [High] Data race on shared security state (`transcript`, `random_client`,=
 `pubkey_client`) due to lack of synchronization.
- [High] Heap variables embedded directly in a dynamically allocated struct=
 are passed to scatterlists, risking DMA memory corruption.
- [Medium] Transcript hash incorrectly includes the message trailer, causin=
g a protocol mismatch.
- [Medium] Sensitive session key is left on the kernel stack without explic=
it zeroization.

Pre-existing issues:
- [High] Index typo in `gip_disconnect()` causes out_fragments delayed work=
s to not be cancelled, leading to a Use-After-Free.
--

commit 90b08fdfc4b71ac21c6c33cfb71aa69cf4b03d4c
Author: Vicki Pfau <vi@endrift.com>

Input: xbox_gip - Add security implementation from xone

This patch imports and adapts the security message implementation from the
out-of-tree xone driver. This message is necessary for most controllers
that use wireless dongles.

> diff --git a/drivers/input/joystick/gip/gip-core.c b/drivers/input/joysti=
ck/gip/gip-core.c
> index 1bfb559f5f7a2..ec21740bba50c 100644
> --- a/drivers/input/joystick/gip/gip-core.c
> +++ b/drivers/input/joystick/gip/gip-core.c

[ ... ]

This is a pre-existing issue, but I noticed a potential use-after-free bug
in the disconnect flow.

Looking at gip_disconnect() in drivers/input/joystick/gip/gip-core.c:

	mutex_lock(&gip->attachment_lock);
	for (i =3D 0; i < MAX_ATTACHMENTS; i++) {
		struct gip_attachment *attachment =3D gip->attachments[i];

		if (!attachment)
			continue;

		for (j =3D 0; j < MAX_OUT_FRAGMENTS; j++)
			cancel_delayed_work_sync(&attachment->out_fragments[i].timeout);
		devm_kfree(to_gip_device(attachment), attachment->uniq);
		devm_kfree(to_gip_device(attachment), attachment);
		gip->attachments[i] =3D NULL;
	}
	mutex_unlock(&gip->attachment_lock);

[Severity: High]
Does this code use the outer loop index `i` (attachment index) instead of t=
he
inner loop index `j` (fragment index)?

If `i` is used, timeouts for fragments other than the one at index `i` are
never cancelled. The function then proceeds to free the `attachment` struct=
ure.
If any of the un-cancelled delayed works execute later, they will access the
freed `attachment`, leading to a use-after-free.

> diff --git a/drivers/input/joystick/gip/gip-security.c b/drivers/input/jo=
ystick/gip/gip-security.c
> new file mode 100644
> index 0000000000000..1850850b60e67
> --- /dev/null
> +++ b/drivers/input/joystick/gip/gip-security.c
> @@ -0,0 +1,810 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

[ ... ]

> +static int gip_security_ecdh_get_secret(struct crypto_kpp *tfm, u8 *pubk=
ey,
> +	int pubkey_len, u8 *secret, int secret_len)
> +{
> +	struct kpp_request *req;
> +	struct scatterlist src, dest;
> +	DECLARE_CRYPTO_WAIT(wait);
> +	int err;
> +
> +	req =3D kpp_request_alloc(tfm, GFP_KERNEL);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	sg_init_one(&src, pubkey, pubkey_len);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Can passing these embedded, unaligned struct fields directly to
`sg_init_one()` cause DMA memory corruption?

The fields `security->pubkey_client2` and `security->pms` are embedded dire=
ctly
inside `struct gip_security`, which itself is embedded in
`struct gip_attachment`. If the underlying crypto backend uses hardware DMA,
the DMA transfer will share a cacheline with adjacent fields in the
`gip_attachment` structure. A simultaneous CPU access to these adjacent fie=
lds
while the DMA is ongoing can corrupt either the DMA payload or the adjacent
struct fields.

[ ... ]

> +static void gip_security_complete_handshake(struct work_struct *work)
> +{
> +	struct gip_security *security =3D container_of(work, typeof(*security),=
 work_complete);
> +	struct gip_attachment *attachment =3D container_of(security, struct gip=
_attachment, security);
> +	struct gip_security_header_control hdr =3D {
> +		.context =3D GIP_SECURITY_CTX_CONTROL,
> +		.control =3D GIP_SECURITY_CTRL_COMPLETE,
> +	};
> +	u8 random[GIP_SECURITY_RANDOM_LEN * 2];
> +	u8 key[GIP_SECURITY_SESSION_KEY_LEN];
> +	int err;
> +
> +	guard(mutex)(&attachment->lock);
> +	if (security->status !=3D GIP_SECURITY_SENT)
> +		return;
> +
> +	memcpy(random, security->random_host, sizeof(security->random_host));
> +	memcpy(random + sizeof(security->random_host), security->random_client,
> +		sizeof(security->random_client));
> +
> +	gip_security_compute_prf(
> +		"EXPORTER DAWN data channel session key for controller",
> +		security->master_secret, sizeof(security->master_secret),
> +		random, sizeof(random), key, sizeof(key));
> +
> +	gip_dbg(security, "%s: key=3D%*phD\n", __func__, (int)sizeof(key), key);
> +
> +	err =3D gip_send_system_message(attachment, GIP_CMD_SECURITY,
> +		0, &hdr, sizeof(hdr));
> +	if (err) {
> +		gip_err(security, "%s: send complete failed: %d\n", __func__, err);
> +		return;
> +	}
> +
> +	security->status =3D GIP_SECURITY_DONE;
> +}
    ^^^

[Severity: Medium]
Should `memzero_explicit()` be used to wipe the sensitive session key
material from the stack?

The symmetric session key `key` and the pre-master secret/random data `rand=
om`
are generated into local stack arrays. After sending the completion message,
the function returns without zeroing out this sensitive cryptographic mater=
ial,
which could be exposed if a subsequent kernel vulnerability allows reading
uninitialized stack memory.

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
> +	if (security->status !=3D GIP_SECURITY_SENT) {
> +		gip_err(security, "%s: security message received when none expected: 0=
x%02x\n",
> +			__func__, handshake->command);
> +		return -EPROTO;
> +	}
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
> +	if (num_bytes < sizeof(*hdr) || handshake->command !=3D hdr->data.comma=
nd) {
> +		/* reset transcript hash and restart handshake */
> +		gip_dbg(security, "%s: protocol upgrade\n", __func__);
> +		sha256_init(&security->transcript);
> +		return gip_security2_send_hello(security);
> +	}
> +
> +	err =3D gip_security_dispatch_message(security, hdr->data.command,
> +		bytes + sizeof(*hdr), num_bytes - sizeof(*hdr));
> +	if (err)
> +		return err;
> +
> +	sha256_update(&security->transcript, bytes + sizeof(hdr->handshake),
> +		num_bytes - sizeof(hdr->handshake));
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Is there a data race on the shared security state (`transcript`,
`random_client`, `pubkey_client`) due to lack of synchronization?

Incoming messages are processed by `gip_receive_work`, which calls
`gip_security_handle_message()` without acquiring `attachment->lock`.
This function modifies shared state such as `security->transcript` and
`security->pubkey_client`.

Concurrently, asynchronous work items (like `gip_security_exchange_rsa`)
acquire `attachment->lock` and call `gip_security_send_message()`, which al=
so
updates the `transcript` hash. Since one side does not hold the lock, these
threads can race and corrupt the internal state of the SHA256 context or
copy torn data.

[Severity: Medium]
Does this transcript hash incorrectly include the message trailer?

The transcript hash is updated using `num_bytes - sizeof(hdr->handshake)`.
If the received packet includes the 8-byte trailer, `num_bytes` encompasses=
 it,
and the trailer gets hashed. However, the sender (`gip_security_send_messag=
e()`)
specifically excludes the trailer from the hash. This discrepancy causes a
transcript mismatch during the `Finished` step.

> +
> +	return 0;
> +}
> +
> +void gip_security_release(struct gip_security *security)
> +{
> +	if (security->status < GIP_SECURITY_SENT)
> +		return;
> +
> +	cancel_work(&security->work_exchange_rsa);
> +	cancel_work(&security->work_exchange_ecdh);
> +	cancel_work(&security->work_complete);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Is it safe to use the non-blocking `cancel_work()` instead of
`cancel_work_sync()` here?

During device disconnect, `gip_disconnect()` calls `gip_shutdown()` which c=
alls
`gip_security_release()`. This uses the non-blocking `cancel_work()` to can=
cel
the security work items.

`gip_disconnect()` then explicitly frees the `attachment` structure using
`devm_kfree()`. If a security work item is actively executing on another CP=
U,
it will continue running and attempt to acquire the freed `attachment->lock=
` or
access other freed fields (such as inside `gip_security_exchange_rsa()`),
resulting in a use-after-free.

> +
> +	memzero_explicit(&security->transcript, sizeof(security->transcript));
> +	memzero_explicit(&security->pms, sizeof(security->pms));
> +	memzero_explicit(&security->master_secret, sizeof(security->master_secr=
et));
> +
> +	security->status =3D GIP_SECURITY_PENDING;
> +}
> +
> +int gip_security_start_handshake(struct gip_security *security)
> +{
> +	int err;
> +
> +	sha256_init(&security->transcript);
> +
> +	INIT_WORK(&security->work_exchange_rsa, gip_security_exchange_rsa);
> +	INIT_WORK(&security->work_exchange_ecdh, gip_security2_exchange_ecdh);
> +	INIT_WORK(&security->work_complete, gip_security_complete_handshake);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^

[Severity: High]
Can dynamically re-initializing these work items corrupt the workqueue state
if they are re-entered?

`INIT_WORK()` is dynamically invoked every time `gip_security_start_handsha=
ke()`
runs. If the handshake fails or is reset (e.g., via `HELLO_DEVICE`),
`gip_security_release()` cancels the work asynchronously.

A subsequent `STATUS_DEVICE` message will call `gip_security_start_handshak=
e()`
again. If the previous work item is still executing (because `cancel_work()=
` is
asynchronous), calling `INIT_WORK()` will overwrite its internal
`work_data_bits` and list pointers, leading to workqueue corruption.

> +
> +	err =3D gip_security_send_hello(security);
> +	if (err < 0)
> +		return err;
> +
> +	security->status =3D GIP_SECURITY_SENT;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912030426.2997=
003-1-vi@endrift.com?part=3D7
