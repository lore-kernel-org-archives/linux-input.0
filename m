Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7A33260B
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789380289; cv=none; b=dEheIVmko8++jiJIhviddc6pvFQlxIhHvtDBSDgQSWUCt7FsPqSBvdXZLS0M1Ql/9TgwheHXfVbMJEEjLOm3bTRVNjkI+b0+xaBTWqXdBy+DvZIWGgENIBEwoS93Vy1qVtSc6+xztz3TXLOoH5QdgsWm5jrB3Hq0pRF2qUwd2Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789380289; c=relaxed/simple;
	bh=jxlh2jI5yO3mk9LDzbkxjgpbAMqNLdYW9q7sYziuRtw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fGUe1vPsXCpZ2ML9gMC8u8wXWYMcy3zPEb/u/6InjOp522UuozCbBFvEO8MQZSQVMekUklxeoAjBM5qhzFbpFepd36UegnBd7SKSVK2dAKe8e5XdR5EZcNsSBxQemqVoKnRTJPqGUMjG0WmIpVp3hyuYYqoiR6SmsQjylsJBABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A25zI2XQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A25zI2XQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2956F1F000FF;
	Mon, 14 Sep 2026 10:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789380288;
	bh=gGqA1yGyWJVN2L7/Wxe9tzDRp74JCgAXU0s/Bp5G/HM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A25zI2XQ9CqosF77ixlt8AH5adm0uOGPTt7UCKBWtTKopUTZt3dxbQ7tBPACijCb4
	 eMCFJ+MQJlBbBkuSa8JdMsKwNY7KEPNOfuN7Kx9Eq9Xvtqr4Qg7k+5Zqso6uuIOCsU
	 3LEh8zyMQooZ85mhxf32yZhKIIm3hvIsgCnIRN7sM7ElQ5AAh5Petdz6S3MrrRT87V
	 UbjV5Y1Uph532xXmdeV85NjiQUwRDxtyj3VGqUOqIom/j5ObbDzDosV3JXVzKh8yfz
	 m3uGhD2FuCub9nMDbPdH2vkcgbc65XbtQzqdJICotSxQsmRwls/r14Ch1XJEozAJOH
	 rPK3rPj66FL+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: amd_sfh: Validate PCI BAR size before mapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Slawomir Stepien" <sst@poczta.fm>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260914095007.205287-1-sst@poczta.fm>
References: <20260914095007.205287-1-sst@poczta.fm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 10:04:47 +0000
Message-Id: <20260914100448.2956F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race on `cli_data->cur_hid_dev` in `amd_sfh_set_report()` can=
 lead to wrong completion flags being set, causing legitimate HID requests =
to time out.
--

commit eb712409bb933989aa1a882596c6ff02ffcdb00c
Author: Slawomir Stepien <sst@poczta.fm>
Subject: HID: amd_sfh: Validate PCI BAR size before mapping

This patch validates that the PCI BAR 2 size is at least 128KB before
attempting to map it. This prevents an out-of-bounds memory access and page
fault during the probe function if the driver is bound to a device with a
smaller BAR size.

Link: https://syzkaller.appspot.com/bug?extid=3D4eadd4dfe9e66522bae8
Link: https://syzkaller.appspot.com/ai_job?id=3D3bc1c45c-548f-4ab5-8243-d2c=
8ec321d6c

> diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh=
-hid/amd_sfh_pcie.c
> index eda26a094d3f1..061a63519d441 100644
> --- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
> +++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
[ ... ]
> @@ -497,6 +497,16 @@ static int amd_mp2_pci_probe(struct pci_dev *pdev, c=
onst struct pci_device_id *i
>  	if (rc)
>  		return rc;
> =20
> +	if (!(pci_resource_flags(pdev, 2) & IORESOURCE_MEM)) {
> +		dev_err(&pdev->dev, "BAR 2 is not IORESOURCE_MEM\n");
> +		return -ENODEV;
> +	}
> +
> +	if (pci_resource_len(pdev, 2) < AMD_SFH_MIN_BAR_SIZE) {
> +		dev_err(&pdev->dev, "BAR 2 is too small\n");
> +		return -EINVAL;
> +	}
> +
>  	rc =3D pcim_iomap_regions(pdev, BIT(2), DRIVER_NAME);
>  	if (rc)
>  		return rc;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible to have a data
race on cli_data->cur_hid_dev here in the amd_sfh driver?

Looking at drivers/hid/amd-sfh-hid/amd_sfh_client.c:amd_sfh_set_report(),
the shared global state is modified without acquiring the mp2->lock mutex:

amd_sfh_set_report() {
    ...
    cli_data->cur_hid_dev =3D i;
    break;
    ...
}

Could this lead to wrong completion flags being set in amdtp_hid_wakeup()?

amdtp_hid_wakeup() {
    ...
    cli_data->request_done[cli_data->cur_hid_dev] =3D true;
    ...
}

If Process A triggers HID_REQ_GET_REPORT on one HID device, it queues work =
to
amd_sfh_work(). Concurrently, if Process B triggers HID_REQ_SET_REPORT via
ioctl on a different HID device on the same AMD SFH PCI controller,
amd_sfh_set_report() modifies cli_data->cur_hid_dev without lock protection.

Would this cause amdtp_hid_wakeup() to read the racy cur_hid_dev value, wri=
te
to the wrong request_done index, and wake up the wrong waitqueue, causing
legitimate HID requests to time out?

This seems reachable by local users capable of sending HID raw requests (e.=
g.,
via /dev/hidrawX), which in many desktop configurations is accessible to the
logged-in user.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914095007.2052=
87-1-sst@poczta.fm?part=3D1
