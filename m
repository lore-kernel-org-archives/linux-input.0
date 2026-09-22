Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C739CCF8
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046227; cv=none; b=H0msX89W+h71pDndNlrIhLwCk84CCK8LFRJmQQkgcqW4WYiO03LNB7Nq1V66pVN68Tg9YP/Vyvl/UppvN7t22O/fI5ZuGlLIy9ShJYbMVw3Q8a95ICYBvFB7MV6aV6VZVyJJRL4o+9AWic280uCuj29ejHXupxaUwTjD/BuFwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046227; c=relaxed/simple;
	bh=ZhC1m+Y56LEiRxhgCDK9geiJ9rgBL6Fiqh9dbqCC52Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ozprAk2SaNElcgrT1GzkOzNS28ldjJWrkNYMVzl85uZG1wdgOFR0KbBeQqm64heMV5ab0B0VXmVo2AEKdBB4CKoHpC0ctmIAYFb4nCqXyf+kK5GBO8OdGwAchIYvYUVTQ+c4M+CQ1XCX4+tsezmXALl2/6jN5zY6rs2zXpUQl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOcVATIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOcVATIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531FE1F000FF;
	Tue, 22 Sep 2026 03:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790046225;
	bh=ai/Yy0ik9sUldVN+0/jBMuLZBT+wK0fh06V6FEnduBE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kOcVATIub8wHnqXLj/ezHIaS/3ihGr2pXpdjwjCelCJL6znPZH6GyQtxmb5V4PL+m
	 Lq4fS0VequD1NCtDiyn6gTPj7/ze3s5S0965pdUUiYG5H3JsW0Z+jROZMFsWDcciSq
	 +grF7U/thdMSrMetkBFrdpOLo2VfSVeqfnQvUENhaKgTZoH+YVfFf/Yxevkc7mwmlR
	 NkT0xQOwybDt3drNoGYlGkXCBrJOERm9TOqMqBJKXqdqKNcN20RFSQbF2XsCWSvi/W
	 XFmsAXDF7OT149mLsiqyTKL9z5HjlHji2jitUy/5TbxIjTidWsMBxUM4aJdpuMpDt4
	 m5Wjh10IJgTEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: Intel-thc-hid: Intel-quicki2c: Use
 hid_safe_input_report()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260922025437.940072-2-even.xu@intel.com>
References: <20260922025437.940072-1-even.xu@intel.com>
 <20260922025437.940072-2-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 03:03:44 +0000
Message-Id: <20260922030345.531FE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: intel-quicki2c: OOB memory access due to unadjusted buffer si=
ze in hid_safe_input_report()
--

commit fd2fb2220e67b32415f7045570713d7e64755020
Author: Even Xu <even.xu@intel.com>

HID: Intel-thc-hid: Intel-quicki2c: Use hid_safe_input_report()

This commit replaces the deprecated hid_input_report() with
hid_safe_input_report(). It tracks the allocated size of the input buffer a=
nd
passes it along to allow hid-core to validate the reported data length agai=
nst
the actual buffer size.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 0d2ad7bc3648a..6cf19dac8e181 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> @@ -315,7 +315,7 @@ static int handle_input_report(struct quicki2c_device=
 *qcdev)
>  		if (qcdev->state !=3D QUICKI2C_ENABLED)
>  			continue;
> =20
> -		quicki2c_hid_send_report(qcdev, pkt->data,
> +		quicki2c_hid_send_report(qcdev, pkt->data, qcdev->input_len,
>  					 HIDI2C_DATA_LEN(le16_to_cpu(pkt->len)));

[Severity: High]
Does this code pass the unadjusted buffer size when pkt->data is offset by 2
bytes from the start of the buffer?

The buffer qcdev->input_buf is dynamically allocated to qcdev->input_len
bytes.

Since pkt is mapped to qcdev->input_buf, pkt->data is offset by
HIDI2C_LENGTH_LEN (2 bytes) from the start of the allocation.

Passing the full qcdev->input_len overstates the remaining capacity for
pkt->data by 2 bytes.

[ ... ]

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
> index 8075992e8732e..1a220a50d934c 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c
[ ... ]
> @@ -157,16 +157,18 @@ void quicki2c_hid_remove(struct quicki2c_device *qc=
dev)
>   *
>   * @qcdev: point to quicki2c device
>   * @data: point to input report data buffer
> + * @buf_size: the allocated size of the input report data buffer
>   * @data_len: the length of input report data
>   *
>   * Return: 0 on success, non zero on error.
>   */
>  int quicki2c_hid_send_report(struct quicki2c_device *qcdev,
> -			     void *data, size_t data_len)
> +			     void *data, size_t buf_size, size_t data_len)
>  {
>  	int ret;
> =20
> -	ret =3D hid_input_report(qcdev->hid_dev, HID_INPUT_REPORT, data, data_l=
en, 1);
> +	ret =3D hid_safe_input_report(qcdev->hid_dev, HID_INPUT_REPORT, data,
> +				    buf_size, data_len, 1);

[Severity: High]
Can passing this unadjusted buf_size to hid_safe_input_report() lead to an
out-of-bounds access?

If a device sends a pkt->len such that HIDI2C_DATA_LEN(pkt->len) equals
qcdev->input_len, hid_safe_input_report() will trust the data length since =
it
does not exceed the provided buf_size.

This would neutralize the core's bounds checks, allowing the core to read or
zero-pad 2 bytes past the end of the qcdev->input_buf allocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922025437.9400=
72-1-even.xu@intel.com?part=3D1
