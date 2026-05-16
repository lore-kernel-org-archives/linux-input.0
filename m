Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2734F5E0
	for <linux-input@vger.kernel.org>; Sat, 16 May 2026 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778909247; cv=none; b=WylC4WHY1YZUluYGSInS5Q7EyVv0BzMLOkWBS8DUptFXbPu7yNybIYl3x6HEaDb+bKiqibsHpczeOG1nfQrV1M4XLv4B/vW7hVvPvnI3kHEru2kPT662uFpVt2r6yDOQmvvCdSo/bmNeK47qbUKnP45a5gVMD4uAzXFbT/jM0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778909247; c=relaxed/simple;
	bh=rvtxh9fi6n3Bde7vWKdb6lMcKMCAjr3FCVJsZY08C38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fzP+tzdOungASYFrBC2P4Eaxq72vqMkoqPXWl8i6qdQAg8Y1VYzRlvy8lIN2bHBz7r48eHmK9RR83sRySTlxw9j3WxnA0MvOTwg6TtxPI106SUAr2oK8r4cib3SwggAtZB3YNubyp8tdCKzg8FdWdj9mnbp8jWSg0YzOhn+XFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTMsgrPu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTMsgrPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0B3C19425;
	Sat, 16 May 2026 05:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778909246;
	bh=rvtxh9fi6n3Bde7vWKdb6lMcKMCAjr3FCVJsZY08C38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BTMsgrPuNH3WKbakztp/RhiyCdgUl1RefHUX2D/qQO1bL5zblvKc7MvhbTbE1urYw
	 czYu202kJwKjNWlCs3Nsk31HIXAQjJbqm/4zhPxemGPv2WfYOxBLO6e02xHWfpHRUZ
	 wXdC1D7bX6fMzJ9QkKIAiAGn6Khrq9nBHkPRaUSk/iNzNK8ABnLMmW52aFKPfk7wes
	 K/yj//viSQ8HaJoYzAvIQAXRiHTnQLti5y++qk8jEtGsLANp+llIURNX12wjGqCczl
	 GYWpi9Iq2cedJFPlASxJFPFHw6Xe78+IHcWe5S23XvL7eotqLfqm9Gqqkri0N4kHvS
	 61EZUtH6AxLTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] HID: hid-msi: Add M-key mapping attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260516042841.500299-3-derekjohn.clark@gmail.com>
References: <20260516042841.500299-3-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 May 2026 05:27:25 +0000
Message-Id: <20260516052726.3F0B3C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect error check in `claw_buttons_store()` prevents hardware =
updates and violates sysfs contract.
- [High] Unsynchronized request tracking and short timeouts cause cross-tal=
k between sysfs reads and corrupt device state.
- [Medium] Writing an empty string silently fails to clear M-key mappings.
--

commit 437a6d2887a8ee961bc67ec5d675b041d9f3b7b4
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add M-key mapping attributes

This commit adds sysfs attributes to remap the M-keys (M1 and M2) on MSI
devices in macro mode. It introduces functionality to parse user input,
translate button names to codes, and synchronize these configurations
with the hardware.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 1bf1d6150f4fd..bc0169c992ae8 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> +static int claw_buttons_store(struct device *dev, const char *buf, u8 mk=
ey_idx)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	u8 data[] =3D { 0x01, (drvdata->bmap_addr[mkey_idx] >> 8) & 0xff,
> +		      drvdata->bmap_addr[mkey_idx] & 0xff, 0x07,
> +		      0x04, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff };
> +	char **raw_keys __free(argv) =3D NULL;
> +	size_t len =3D ARRAY_SIZE(data);
> +	int ret, key_count, i;
> +
> +	raw_keys =3D argv_split(GFP_KERNEL, buf, &key_count);
> +	if (!raw_keys)
> +		return -ENOMEM;
> +
> +	if (key_count > CLAW_KEYS_MAX)
> +		return -EINVAL;
> +
> +	if (key_count =3D=3D 0)
> +		return 0;

If a user attempts to clear the button mappings by writing an empty string,
key_count will be 0.=20

Doesn't this early return prevent sending the pre-initialized data array=20
(which is filled with 0xff to denote unmapped keys) to the hardware,=20
effectively leaving the previous mappings active?

> +
> +	for (i =3D 0; i < key_count; i++) {
> +		ret =3D button_mapping_name_to_code(raw_keys[i]);
> +		if (ret)
> +			return ret;

Does this correctly handle valid button codes?

button_mapping_name_to_code() returns a positive integer for valid codes=20
(e.g., 0x01 to 0xce). Since any positive value evaluates to true, won't
this immediately abort the loop, bypass the hardware write, and return a
positive integer up to the VFS layer?=20

Should this be checking if (ret < 0) instead?

> +
> +		data[6 + i] =3D ret;
> +	}
> +
> +	scoped_guard(mutex, &drvdata->rom_mutex) {
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_WRITE_PROFILE_DA=
TA,
> +					    data, len, 8);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_SYNC_TO_ROM, NUL=
L, 0, 8);
> +	}
> +
> +	return ret;
> +}
> +
> +static int claw_buttons_show(struct device *dev, char *buf, enum claw_ke=
y_index m_key)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	u8 data[] =3D { 0x01, (drvdata->bmap_addr[m_key] >> 8) & 0xff,
> +		      drvdata->bmap_addr[m_key] & 0xff, 0x07 };
> +	size_t len =3D ARRAY_SIZE(data);
> +	int i, ret, count =3D 0;
> +	const char *name;
> +	u8 *codes;
> +
> +	codes =3D (m_key =3D=3D CLAW_KEY_M1) ? drvdata->m1_codes : drvdata->m2_=
codes;
> +
> +	guard(mutex)(&drvdata->profile_mutex);
> +	drvdata->profile_pending =3D (m_key =3D=3D CLAW_KEY_M1) ? CLAW_M1_PENDI=
NG : CLAW_M2_PENDING;
> +
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, dat=
a, len, 8);

Is 8ms enough time for the device to respond reliably? On a system with=20
HZ=3D100, 8ms is less than 1 jiffy.

If this times out, profile_pending is reset to CLAW_NO_PENDING below and=20
the mutex is released when the function returns. If a delayed ACK from this=
=20
request arrives while a subsequent sysfs read for the other M-key is=20
pending, could claw_profile_event() mistakenly write the stale data into=20
the new request's buffer and prematurely complete it?

> +	if (ret) {
> +		drvdata->profile_pending =3D CLAW_NO_PENDING;
> +		return ret;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260516042841.5002=
99-1-derekjohn.clark@gmail.com?part=3D2
