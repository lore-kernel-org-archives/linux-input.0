Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAFC18DB01
	for <linux-input@vger.kernel.org>; Tue, 19 May 2026 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150122; cv=none; b=Yg2KVIV9lgAy+oa/RGWhmdfUPTCfZbcC0/cPOS5g75q+CpTX641p3Gj1qnatZedAKE8ye7b5kn3AphcJe4Ybtw4yWrJ3lpnYrDDxpnH/G4Cwub9fznoqErh144Q4o1LDEbUXMt70rhBiJDT7lKEB8s6yocvkuODM14LmeQAbnaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150122; c=relaxed/simple;
	bh=XRErfUocbX/cU5GG+Tg0hvLMpPHVMbE5TcxFaCmGeP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MPGwftf60UlsE2BADgBSyzFIlPQFgFyBTpdfUCyzhuKhL6eKbd/7jnw2OO4YT0Y49aPwjqo7i7eO2dBGkx/4Atcq0adkNmpFgDcEXQOvm1uN6OzDErgJcfgbfB10I00Ll9WyHGtl32i/LhmyoJ9jotWu3JP/GL0OKhE9W0if4B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uW1PEzoa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uW1PEzoa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBC5C2BCB7;
	Tue, 19 May 2026 00:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779150122;
	bh=XRErfUocbX/cU5GG+Tg0hvLMpPHVMbE5TcxFaCmGeP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uW1PEzoaneSWhv+IBDOLJSJckRiLm11cH59xZPg0eLDi05DOvyxGiIRrvLVLBxtXC
	 bTEHltV2AicSCLhPZiAbgapH5L3XxApMlpWQu1a8TpzrxZ2c5SOPisc84TSTjfNVMr
	 X23KOtjHqgj4AXAz3vlmC7S82R3tJCNvDpNn7pZztrH3aIjh7i0cknJP2yv8WgFHkb
	 Bkfw/Ck24IOFKIvQeCwBP8rrbuUxj9xFvYbSpVAjvq2YDZJu3I21Q6vHZXumV/jzaH
	 AoihuWAdrWZNmqf7dFAVAfbOumcKLjB19gYVWg5HOxNJtlDloDY5wnTMjuQznnkWGR
	 n4z3qAxsF88jQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260518222935.1802071-5-derekjohn.clark@gmail.com>
References: <20260518222935.1802071-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 00:22:01 +0000
Message-Id: <20260519002201.EDBC5C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] State machine desynchronization and data race on `profile_pending`=
 leads to corrupted rumble intensity reads.
--

commit 85612b755f6822082f71e029c33a01200dc4046f
Author: Derek J. Clark <derekjohn.clark@gmail.com>

    HID: hid-msi: Add Rumble Intensity Attributes
   =20
    Adds intensity adjustment for the left and right rumble motors.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 4d267b896da72..339f256b60dbe 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -882,6 +901,142 @@ static ssize_t button_mapping_options_show(struct d=
evice *dev,
>  }
>  static DEVICE_ATTR_RO(button_mapping_options);

[ ... ]

> +static ssize_t rumble_intensity_left_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	u8 data[4] =3D { 0x01, (rumble_addr[0] >> 8) & 0xff, rumble_addr[0] & 0=
xff, 0x01 };
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	int ret;
> +	u8 val;
> +
> +	if (!drvdata->gamepad_registered)
> +		return -ENODEV;
> +
> +	guard(mutex)(&drvdata->profile_mutex);
> +	drvdata->profile_pending =3D CLAW_RUMBLE_LEFT_PENDING;
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, dat=
a,
> +				    ARRAY_SIZE(data), 25);
> +	if (ret) {
> +		drvdata->profile_pending =3D CLAW_NO_PENDING;
> +		return ret;
> +	}

Can the profile_pending state become desynchronized if a hardware read times
out?

If claw_hw_output_report() times out, it sets
drvdata->profile_pending =3D CLAW_NO_PENDING and returns.

If a subsequent call to rumble_intensity_right_show() sets
drvdata->profile_pending =3D CLAW_RUMBLE_RIGHT_PENDING, and then the delayed
hardware ACK from the first left request arrives, claw_profile_event() will
misattribute the response.

It will read the left motor's intensity into drvdata->rumble_intensity_righ=
t,
corrupting the state:

	case CLAW_RUMBLE_RIGHT_PENDING:
		scoped_guard(spinlock_irqsave, &drvdata->rumble_lock)
			drvdata->rumble_intensity_right =3D cmd_rep->data[4];

Additionally, claw_profile_event() clears
drvdata->profile_pending =3D CLAW_NO_PENDING locklessly at the end, which
could race with other process contexts accessing it under profile_mutex.

Should claw_profile_event() validate the memory address in the response pay=
load
to ensure it belongs to the pending request, and synchronize accesses to
profile_pending?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518222935.1802=
071-1-derekjohn.clark@gmail.com?part=3D4
