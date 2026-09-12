Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499294BEE5E
	for <linux-input@vger.kernel.org>; Sat, 12 Sep 2026 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789173402; cv=none; b=FS70LF6aALlQLcI/trySAA3e64f8VUA7ctKknj/RdEOXV5YQlib1Ej4NKi2RmTTU9Wwns6gGQfS5tIgrUetAUMFwGTfq0NKF0xRYk8fAjEWHpaW4nKPHP2prKDsSMv3DUQUNucGjXwZzbUaQLu5E+IFEmxiUBj4Zjowu7dD/WFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789173402; c=relaxed/simple;
	bh=e3FLLs6MRT50CUOUrfPMwBJZAIlf1BR1XQG2dLIXWus=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y9VITHFC1YRsRiG8hyNKtIQLyxITu2ShKrQLJgZV2f+9qF1/YtrORmVV3RNHqpRhUEAeXH7vk+LjT2P9LAfT1J3fYXivhvQS/mDMqBH8Z/+nzsJzc56ai2EHgjmoqnhb+0NSR5uv0DZoGUgsYG46MToTdiZMtDzIrtNtEXV5QuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ8Tj71M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ8Tj71M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899361F000FF;
	Sat, 12 Sep 2026 00:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789173400;
	bh=+U3mQt0czw7uoYrssJOlg9TcjcrOpgCPe6FLHmxYKTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJ8Tj71M+NJnNfTgeiQRt84TQPrK60No5jK1HyrIf3FVt9m0eZFRZ70qtOPwHtDcp
	 NDbeTfJX9kCKHXw3fIkqMXtFAFcIEg2lgzWOQRR7lVNRdRSLQniySKas3QRGxlbsaq
	 p8i3qNXS273YMMEvkQPnfLRWyl6L3pDO/W1UGXHQjCfarC4bl/zg++KFozVr68S1Xz
	 sQzQmr+NRMv3HfLHMrpEMP0+uTdXXKWg7cMOf/xWoAGPg1BeAYGLciC+qbCvgqdDUz
	 b6PN9f+gWpjbnSyLmxDPJOWSstqdx1jwr+EkFMonV3DKbunhV1/CcWDvznEiPqLCfq
	 cnRAjkK9ckcZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quicki2c: Fix the return
 value in quicki2c_dev_init() kernel-doc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260912002143.35091-1-kmehltretter@gmail.com>
References: <20260912002143.35091-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 00:36:40 +0000
Message-Id: <20260912003640.899361F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Transport drivers use hid_input_report() instead of the safer hid_=
safe_input_report() when feeding data from interrupts.
--

commit e849f07638d5d777d058d1762033819d3087f020
Author: Karl Mehltretter <kmehltretter@gmail.com>

HID: intel-thc-hid: intel-quicki2c: Fix the return value in quicki2c_dev_in=
it() kernel-doc

This commit corrects the kernel-doc for quicki2c_dev_init() to accurately
reflect that it returns an ERR_PTR() on failure instead of NULL.

> diff --git a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c b/dr=
ivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> index 0d2ad7bc3648a..aa601ef613c91 100644
> --- a/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c
> +++ b/drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but does this code in quicki2c_hid_send_repor=
t()
bypass the HID core's bounds checks?

drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-hid.c:quicki2c_hid_send_r=
eport() {
    ...
    ret =3D hid_input_report(qcdev->hid_dev, HID_INPUT_REPORT, data, data_l=
en, 1);
    ...
}

If a malicious or malfunctioning device sends an interrupt with a spoofed
length larger than the allocated buffer, the hardware could send an inflated
length over DMA. When this is passed as data_len to hid_input_report(), whi=
ch
does not know the actual allocated size of the buffer, could it blindly read
data_len bytes and cause an out-of-bounds read in the HID core?

Should this transport driver use hid_safe_input_report() instead when feedi=
ng
data from interrupts to prevent local memory disclosure or a kernel oops?

This same pattern also appears to exist in the QuickSPI driver:

drivers/hid/intel-thc-hid/intel-quickspi/quickspi-hid.c:quickspi_hid_send_r=
eport() {
    ...
    ret =3D hid_input_report(qsdev->hid_dev, HID_INPUT_REPORT, data, data_l=
en, 1);
    ...
}

Should both of these transport drivers be updated to use the safer
hid_safe_input_report() API?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912002143.3509=
1-1-kmehltretter@gmail.com?part=3D1
