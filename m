Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0232032D
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781331853; cv=none; b=Ae/+owv1U0BSpRUSFq6LhL1M5Kp+oLWNMW9P0US6MFxOfYlT/ExsaUrdZbLReKIihtzJgzL6WTC/C7bIPRRz6/r7lbK7dybYUe/1e26BdY6TgB2I5GONJdsT9FI/3Z8E5iz1bOKF/L+VStC/1vAbp2Ba8xmOYa9jKWVgltfrYJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781331853; c=relaxed/simple;
	bh=W1lmBxnbobJWrP8T97EYrqFmPbi35lprIWALlsMvHpA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lTMVhM2WfU6j1lfLRE/vVv99ttoWDxW+Jk3f+i9nw5wvF+SrCBm5V9Rd1JoLfhewp2bzUr8utwq51iYrvzov9cinu9H0Uuoj3Ds9LxuW1I0QaIIHlFqNKRUW4P7U7tQGa7mLtQAJ5E5mHpkMzXUv53jrIPmoUN9255Ac1Tldt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9hMOTbA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9hMOTbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBF71F000E9;
	Sat, 13 Jun 2026 06:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781331852;
	bh=Uoll3pvWqjCJp0I6g6zT1MpxkS6rqUakVEEuyuLTq7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l9hMOTbAeHXwj8QWY2ZeRMwgFx/dK9mgSl1WocN61ETHtEezPpkmlaSoFEx8EqWUc
	 B0R0E0M6GdcnDMFSLe3Cyymou6axYOhVBjY8VTwDsrGC9Eop38p/NDdmJqqJZRcVul
	 M0L4httYbt/3iIblUfD46tRWgebG4+c37r/S1X17SB3FM5fBX9oKl2EsXRPXDnaQvE
	 27ZiJK26t25PrSTPaDXFtzekZbTsWcCg1M3+VufaEEeNY7jdS04f77Q8tI0a1e4bDV
	 juckTZvZz/sciJ+Oqz5Sy2gUATSw9TuJ9G0trO3MqSqvMMKQeoKyusn7b4czpp1Pji
	 7/bR1d+CkVrRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: cyapa - bound the SMBus block reads to the
 caller buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260613-b4-disp-8e550272-v1-1-9658cf8292c2@proton.me>
References: <20260613-b4-disp-8e550272-v1-1-9658cf8292c2@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 06:24:11 +0000
Message-Id: <20260613062412.0CBF71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] cyapa_smbus_read_block masks short reads by unconditionally return=
ing the expected length, causing callers to process and leak uninitialized =
stack memory.
- [High] Explicit `input_unregister_device()` on a `devm` allocated input d=
evice causes double-unregistration and memory leak.
--

commit 3fd76440d016e0f73dbb99ea7474006c10fb3123
Author: Bryam Vargas <hexlabsecurity@proton.me>

Input: cyapa - bound the SMBus block reads to the caller buffer

This commit prevents a potential buffer overflow in the cyapa driver's
SMBus block read path. It introduces a local buffer to ensure that the
number of bytes copied back does not exceed the size of the destination
buffer provided by the caller.

> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa=
_gen3.c
> index fc3fb954523b7..832775bb71825 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c

[ ... ]

> @@ -247,27 +247,37 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa,=
 u8 cmd, size_t len,
>  	ssize_t ret;
>  	u8 index;
>  	u8 smbus_cmd;
> -	u8 *buf;
> +	u8 buf[I2C_SMBUS_BLOCK_MAX];
>  	struct i2c_client *client =3D cyapa->client;
> =20
>  	if (!(SMBUS_BYTE_BLOCK_CMD_MASK & cmd))
>  		return -EINVAL;
> =20
> +	/*
> +	 * i2c_smbus_read_block_data() copies the device-reported block count
> +	 * (up to I2C_SMBUS_BLOCK_MAX) into its buffer and has no way to know
> +	 * its size, so read into a local buffer and copy back at most the
> +	 * expected number of bytes - never past the caller's buffer.
> +	 */
>  	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
>  		/* read specific block registers command. */
>  		smbus_cmd =3D SMBUS_ENCODE_RW(cmd, SMBUS_READ);
> -		ret =3D i2c_smbus_read_block_data(client, smbus_cmd, values);
> +		ret =3D i2c_smbus_read_block_data(client, smbus_cmd, buf);
> +		if (ret > 0)
> +			memcpy(values, buf, min_t(size_t, ret, len));
>  		goto out;
>  	}
> =20
>  	ret =3D 0;
>  	for (index =3D 0; index * I2C_SMBUS_BLOCK_MAX < len; index++) {
> +		size_t offset =3D index * I2C_SMBUS_BLOCK_MAX;
> +
>  		smbus_cmd =3D SMBUS_ENCODE_IDX(cmd, index);
>  		smbus_cmd =3D SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
> -		buf =3D values + I2C_SMBUS_BLOCK_MAX * index;
>  		ret =3D i2c_smbus_read_block_data(client, smbus_cmd, buf);
>  		if (ret < 0)
>  			goto out;
> +		memcpy(values + offset, buf, min_t(size_t, ret, len - offset));
>  	}
> =20
>  out:

[Severity: High]
This isn't a bug introduced by this patch, but does returning len in
cyapa_smbus_read_block() mask a short read if ret < len?

The function returns the requested length even if fewer bytes were read:

cyapa_smbus_read_block() {
    ...
out:
	return ret > 0 ? len : ret;
}

Callers seem to assume their buffers are fully populated if the return value
matches the requested length. For instance, in cyapa_gen3_get_query_data():

	u8 query_data[QUERY_DATA_SIZE];
	int ret;

	if (cyapa->state !=3D CYAPA_STATE_OP)
		return -EBUSY;

	ret =3D cyapa_read_block(cyapa, CYAPA_CMD_GROUP_QUERY, query_data);
	if (ret !=3D QUERY_DATA_SIZE)
		return (ret < 0) ? ret : -EIO;

	memcpy(&cyapa->product_id[0], &query_data[0], 5);

Could this lead to processing uninitialized stack memory and exposing it
to userspace if the read is short?


[Severity: High]
This is also a pre-existing issue, but does calling input_unregister_device=
()
on a devm-allocated device in cyapa_update_fw_store() cause a double-free or
resource leak?

Looking at cyapa_update_fw_store() in drivers/input/mouse/cyapa.c:

	if (cyapa->input) {
		/* ... */
		input_unregister_device(cyapa->input);
		cyapa->input =3D NULL;
	}

Since the device was originally allocated with devm_input_allocate_device()
in cyapa_create_input_dev(), manually unregistering it leaves the devres
cleanup action still queued.

Could the devres action trigger a double-unregistration when the device
unbinds, and does allocating a new device via cyapa_reinitialize() during
each firmware update leak the old devres actions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613-b4-disp-8e=
550272-v1-1-9658cf8292c2@proton.me?part=3D1
