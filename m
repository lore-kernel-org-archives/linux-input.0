Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32BD3033FC
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778822767; cv=none; b=BAMCHoDnY4TbdTiN2GCJdK2uFf8BSrPrbucxDvHzr4tcT/37VV0ZLA8nMjjtBo06vseD+DPg1UGF/49nLq3Z3790cYOKkcP16k8tNcZ6rXVjJ/ovuYaO9N9IKzyi+OQ8IODbNqripSeFFVaLBMInXXZ4d/y63l1z8enEDYlF0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778822767; c=relaxed/simple;
	bh=MQg3n1QlX/iZHNhADCNkz8NfFjPtHCMHoqwG41+iQBM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tgyosHNU7qsQRpE5BANVddn3rUMb6G4cEtK/ttt1C3hRbC0vT4fImF3Ch7Uz5AzD/0ZPOQoanjuGMckjnJgoCl+qyGiWxyx9+DBo68KNNaw28/NvlIwIFhRDsJYkLEoHuLUCNJegZ2qNjqZg+FXGzmcUZA5C1zWF0CsVcE3hWnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY6mwt/Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY6mwt/Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52710C2BCB0;
	Fri, 15 May 2026 05:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778822766;
	bh=MQg3n1QlX/iZHNhADCNkz8NfFjPtHCMHoqwG41+iQBM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NY6mwt/ZvIEEo6RaxKX7/HHdAoAglNxUl0peMe+nfsHtSAdm+Ub8zhKtH5hdUZ2hy
	 LQNf6cQU2JgQUnOqDPHpkQg+PIwtDWFA1GoSV+0kxbquVyxNVEWChCft3qmypNOk71
	 M9K5AQcOO48/EAMLxOromV72TXnbYJldJOsv+rMMBEHPwLf0lywrz1AI7hjvvN0iCw
	 5NjS2Fv7qYHsst33jQ11THqfjsVDZVaZoMZwgzIjq5HzJ32OEECsmThW77+5VCVMuQ
	 hYOBXUNHiiLrIcQ7cPXsSYMpjnmEM03/BtCPxKN0Hni8DASX34yRvLhm1mejVZj1RS
	 CHxRjJBcLKRbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] HID: hid-msi: Add Rumble Intensity Attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260515033622.2095277-5-derekjohn.clark@gmail.com>
References: <20260515033622.2095277-5-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 05:26:05 +0000
Message-Id: <20260515052606.52710C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The asynchronous request state machine lacks sequence tracking and=
 proper synchronization, causing delayed USB events to misroute and corrupt=
 data for subsequent operations.
--

commit 95ec4f316951f2159554c90bdf669eb45a19e099
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add Rumble Intensity Attributes

This commit adds sysfs attributes to control the left and right rumble motor
intensity on MSI Claw devices. It implements store and show functions that
communicate with the device firmware and uses a state machine to handle the
asynchronous responses.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 06dc4290d2bb5..349a59f75e471 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -810,6 +826,126 @@ static ssize_t button_mapping_options_show(struct d=
evice *dev,
>  }
>  static DEVICE_ATTR_RO(button_mapping_options);
> =20

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
> +
> +	guard(mutex)(&drvdata->profile_mutex);
> +	drvdata->profile_pending =3D CLAW_RUMBLE_LEFT_PENDING;
> +	ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, dat=
a,
> +				    ARRAY_SIZE(data), 8);
> +	if (ret) {
> +		drvdata->profile_pending =3D CLAW_NO_PENDING;
> +		return ret;
> +	}

Is the state machine vulnerable to crossed data from delayed USB events?

If claw_hw_output_report() times out (using the 8ms timeout), this function
clears profile_pending and returns. If a subsequent read for the right
motor then sets profile_pending to CLAW_RUMBLE_RIGHT_PENDING, could a
delayed response from this left motor request arrive?

If so, claw_profile_event() would see CLAW_RUMBLE_RIGHT_PENDING,
incorrectly save the left rumble data into drvdata->rumble_intensity_right,
and clear the pending state. This would complete the right rumble request
with the left motor's data.

Similarly, could a stray ACK from a timed-out store operation prematurely
complete a show operation, exiting without clearing profile_pending and
permanently corrupting the state machine?

> +
> +	return sysfs_emit(buf, "%u\n", drvdata->rumble_intensity_left);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515033622.2095=
277-1-derekjohn.clark@gmail.com?part=3D4
