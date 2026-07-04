Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5332F290A
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 06:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783145304; cv=none; b=l0jTAW5iaAKODrdQxFWS/wZmub77ejs40id6rMHihDM08m7yt3SCCoQooc2+c/Uuxw4Q1BnqI6csLkXa59R+ZRJgXOoYEBmyXgjiHGWQszSlyZRH0TDEJkMpOAO7oziAF0SmDmPwWlP76wxC+TzhTN0Eou2nbEyCgSAyw+zyZpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783145304; c=relaxed/simple;
	bh=87NbvxK6gKYSrG3jSO8iIAR+MHd83MYrO/LIBYt6ojo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p2jjKEG5X9NI1jaX1ttD7ZAkQDyRXS+Hn6X6SuCLAq1iSlzzVbit7aqdU8oYOYB27QF7pmlv0XK0gwEMcmBq6oP5POcImkbGXRq/5PlGOaWIsTyuIZESn3RvCNe5X7vIx7HF92CEg1sP9O0nS3cDDZHiTFV1LckYJzBn+OA6hdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCYN4gQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCYN4gQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676351F000E9;
	Sat,  4 Jul 2026 06:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783145302;
	bh=+1F1/RsDtEvD4HbKiSm4D6qhh5IVXE8kD79bbuelk9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FCYN4gQaJOe9Wi4lEM6mtLwdnCB+0UsmBhQFLkzSGr81EmhoJ58G1KV/it0g8pJQ2
	 3rdvDzSjXhyPmeUMB8Xmt1u0jL/189s/62aDk/2b0pjPiBr/59+6Hjjc35IzgKeT+2
	 sM1oj9Tcao3pac1lD+NhSVMM0o9O/OxsTx83IrTCyLaPoZCh5x7CRiKjxcUyayHHXS
	 cM+FdsODd8mBBT2h8eVkXbzB65gurm5tFS+GCrta9vjqMcvirwboLCPU1frV/jsB0r
	 4xEXt+NNLXWvFQzSVcQIcgO0CZSmDonYuj5ZCfGhX3C2eu5vEBEyojcWiWXjUok0dJ
	 bvdCLaT5HIOTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] Input: mms114 - fix Y-resolution configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260704060115.353049-3-dmitry.torokhov@gmail.com>
References: <20260704060115.353049-1-dmitry.torokhov@gmail.com>
 <20260704060115.353049-3-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 06:08:21 +0000
Message-Id: <20260704060822.676351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe DMA buffer allocation on the stack for I2C transfers.
--

commit b2ece0d05aab20ebd4014035e04b87c4d9127c9f
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Input: mms114 - fix Y-resolution configuration

This commit fixes a copy-paste error in mms114_setup_regs() where
props->max_x was being used instead of props->max_y to configure the
lower bits of the Y resolution.

> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscre=
en/mms114.c
> index 84afdadb3bccc..27911a9f4e9eb 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -408,7 +408,7 @@ static int mms114_setup_regs(struct mms114_data *data)
>  	if (error < 0)
>  		return error;
> =20
> -	val =3D props->max_x & 0xff;
> +	val =3D props->max_y & 0xff;
>  	error =3D mms114_write_reg(data, MMS114_Y_RESOLUTION, val);

[Severity: High]
This is a pre-existing issue, but since mms114_write_reg() is called here,
is it safe for the driver to use stack-allocated buffers for I2C transfers?

Looking at mms114_write_reg():

static int mms114_write_reg(struct mms114_data *data, u8 reg, u8 val)
{
        struct i2c_client *client =3D data->client;
        u8 buf[2];
        ...
        buf[0] =3D reg;
        buf[1] =3D val;

        error =3D i2c_master_send(client, buf, 2);

If the underlying I2C adapter uses DMA for transfers and CONFIG_VMAP_STACK =
is
enabled, passing a stack-allocated buffer to i2c_master_send() can cause me=
mory
corruption or kernel panics because stack memory is not DMA-safe.

A similar pattern appears in __mms114_read_reg() and mms114_interrupt():

static int __mms114_read_reg(struct mms114_data *data, unsigned int reg, ..=
.)
{
        ...
        u8 buf =3D reg;
        ...
        xfer[0].buf =3D &buf;
        ...
        error =3D i2c_transfer(client->adapter, xfer, 2);

and in mms114_interrupt(), a large array is allocated on the stack and pass=
ed
down through __mms114_read_reg():

        struct mms114_touch touch[MMS114_MAX_TOUCH];
        ...
        error =3D __mms114_read_reg(data, MMS114_INFORMATION,
                                  MMS114_MAX_TOUCH * sizeof(struct mms114_t=
ouch),
                                  (u8 *)touch);

Could these stack-allocated buffers lead to instability on DMA-capable I2C
controllers? Should these buffers be moved to the mms114_data struct so they
are dynamically allocated on the heap?

>  	if (error < 0)
>  		return error;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704060115.3530=
49-1-dmitry.torokhov@gmail.com?part=3D3
