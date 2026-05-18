Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F01378821
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121571; cv=none; b=cocQ7l1nNukaVWNMfCyhMRR0lN0Cczw2zNUDbOEvo/Qu1ejFKDe/1h9D+0XCuGSLOhnQOgByU7JPu8ejml0hgO2htFiGYDvtXfKw38O3V0r+OgEOFhws5Dahg1nuInmnPnmaQhTXFG+yfY3rVSddOvOn5/H2SSfywLMTReJc4Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121571; c=relaxed/simple;
	bh=w25w+W7nL3j94VZ1koTn7G3mtKQJAALt9hMDbckkktE=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ctcGqVJuKxxanJOBvv5PN2WV6ID7TnthAX4dytjtV09sdyE1cKjDYuC7+0/72ECAxq9ssnRsZQC5ahD7siNh3EV64sIFG1ThlO3oIayvGV//aP2A6HxJ8GSrHRwKikom/kSE5IDx/k3myOQxs6qF0WeQMYTDly1gw8NaQW31vLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7orMhQI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7orMhQI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F57C2BCB7;
	Mon, 18 May 2026 16:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121571;
	bh=w25w+W7nL3j94VZ1koTn7G3mtKQJAALt9hMDbckkktE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date:From;
	b=O7orMhQIDL6lYMk+EvLTMRFthca/spwjbW+itop3SKefuIlJ/ECp1L+BFQmeOjx2c
	 8FLYDPtWGrUWr+MnL0EyMhN/ikfrX/bcbFJAfzKks37v3Y+SEQ9Ac8aggK1Vhx273s
	 nSc0hazHhxCpOMTxoE+VAKmLI/vStNn922iVGbPOEtnH5347u2jhsNeT6TvC8u1Hu0
	 Vie8KkLPQ/jfAOvMqxrgqc/vMavWh6ITYWMJyFo7VGnMU+erZUdIhO2kVKdIuHPa7A
	 gJdb1fokjwNHc1/IQkIz9/JK4HOgO3TOcQwhWBK8rYaTIbOhjrDWYDeKhjwjLf5Ir1
	 zWW/8EVc3ApKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] HID: hid-tmff: use
 'hid_device_id::driver_data_ptr'
Reply-To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260518-mod-devicetable-hid_device_id-v1-10-a08e3989c283@thegoodpenguin.co.uk>
References: <20260518-mod-devicetable-hid_device_id-v1-10-a08e3989c283@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:26:10 +0000
Message-Id: <20260518162611.56F57C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Potential NULL pointer dereference in `tmff_init()` when dynamical=
ly binding devices via sysfs `new_id`.
--

commit 773ba3555b1e1205e4c7dd4ff010a1b6be4f15fa
Author: Pawel Zalewski (The Capable Hub) <pzalewski@thegoodpenguin.co.uk>

HID: hid-tmff: use 'hid_device_id::driver_data_ptr'

This commit updates the Thrustmaster HID driver to use the driver_data_ptr
field in the hid_device_id structure. It removes unsigned long and void
pointer casts to improve readability.

> diff --git a/drivers/hid/hid-tmff.c b/drivers/hid/hid-tmff.c
> index 423f395d01ac5..0d7e73fba0fa3 100644
> --- a/drivers/hid/hid-tmff.c
> +++ b/drivers/hid/hid-tmff.c
[ ... ]
> @@ -226,7 +226,7 @@ static int tm_probe(struct hid_device *hdev, const st=
ruct hid_device_id *id)
>  		goto err;
>  	}
> =20
> -	tmff_init(hdev, (void *)id->driver_data);
> +	tmff_init(hdev, id->driver_data_ptr);

If a new device ID is dynamically added to the HID driver via the sysfs
new_id interface without explicitly providing driver_data, does
id->driver_data_ptr default to NULL?

If id->driver_data_ptr is NULL, and the dynamically bound device contains
a THRUSTMASTER_USAGE_FF usage in its HID report descriptor, can this lead
to a NULL pointer dereference in tmff_init()?

Looking at tmff_init(), it appears to unconditionally dereference the
ff_bits pointer in this situation:

    for (i =3D 0; ff_bits[i] >=3D 0; i++)

Could this regression allow a standard administrative sysfs action to crash
the system? While the missing NULL check might predate these changes,
modifying the pointer extraction here seems like a good time to address it.

> =20
>  	return 0;
>  err:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-mod-device=
table-hid_device_id-v1-0-a08e3989c283@thegoodpenguin.co.uk?part=3D10
