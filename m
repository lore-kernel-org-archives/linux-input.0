Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA9A1A6838
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803131; cv=none; b=sHUay+DxbmQYYgI6rhEWoAwZDFycZ4wgK/MxNgozPDxj7e673g53YUrcIR8A0fGa9HhXOLbEjiMCwNMEZEXdcA3cCwokTv6si3hI2Bk1s9pUxetr59rzLO7VAsCuOlOHfyeMCMAR5FHsDowlx2JH1GP8QDi+TJM8ZqBY2WHizyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803131; c=relaxed/simple;
	bh=da/CQSiOstM603Kd1t7Yxa5OcSdTPW0Eyeth7DVuPeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YU4l3D6BX20+mTpbOFs/vzWVgtkwnx2rhkhYmq2zb+XQLOaHhavQlfIkyL/aq8eV4NM/musJOuJh3Ft4rQAeQRcvMLpiwGhNONwEcjDxokdoSSlO6tmufjlwGE1kseznYCkDdk/w0FRIAyxBv5jCxXunnv3GvzuxGxJ4wkVBgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVQ1MJod; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVQ1MJod"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E23C1F000E9;
	Tue, 30 Jun 2026 07:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782803130;
	bh=EX/Dz5qm6QB4XsVTbjIbKq+YlUAyroxcFIBluRnqB6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NVQ1MJod0gurHcedLiigOTqt+TmHQwMymys+LnriEZ1rijkl0PFw68GToW9V8XpR2
	 knkpYgE2Cimgojc9CkAKPy5panxDgdkOewUF6V5yIMaUHMNsd7gQYi6rS6SXHJ8pfP
	 SjonRYTwBqD1nR3jZ+hFFO5gXg4z2e4RgT8fjdsFqZdISMlS/YikXk5qHZRzGsljsz
	 TCHz7b/FjQJqzixsBPJ3acf8MFzExYT/poKJahdA7pkNxRIQQ3ZihTr4kSWb4t0Bmk
	 QZdfEDZWxzLrnRczLn5RXuxRvQuJ1OXaPeIAw9gPzeaz0p/ISouoURRTqnuUIp8Uh6
	 eB4KB1qsqxdIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: rmi: check report length before trimming sentinel
 bytes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <2026063007016439.1-ccfa108-0006-HID-rmi-check-report-length-pengpeng@iscas.ac.cn>
References: <2026063007016439.1-ccfa108-0006-HID-rmi-check-report-length-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 07:05:30 +0000
Message-Id: <20260630070530.8E23C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `rmi_hid_write_block` writes data into a dynamically allocated hea=
p buffer `data->writeReport` without verifying that the requested transfer =
length fits within the allocation.
- [High] `rmi_hid_read_block` trusts an attacker-controlled length field fr=
om the device report to read from the dynamically allocated `data->readRepo=
rt` buffer, leading to an out-of-bounds read of kernel memory.
--

commit 5629c16e6055ea1ed7974ee398f60300987bc662
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

HID: rmi: check report length before trimming sentinel bytes

rmi_check_sanity() trims trailing 0xff sentinel bytes, but its loop
reads data[valid_size - 1] before checking that valid_size is non-zero.

Reverse the condition so the length is proved before the last byte is
inspected.

> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> index d4af17fdba467..2bd781f1e0f53 100644
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -365,7 +365,7 @@ static int rmi_check_sanity(struct hid_device *hdev, =
u8 *data, int size)
>  	 * such reports here.
>  	 */
> =20
> -	while ((data[valid_size - 1] =3D=3D 0xff) && valid_size > 0)
> +	while (valid_size > 0 && data[valid_size - 1] =3D=3D 0xff)
>  		valid_size--;
> =20
>  	return valid_size;

[Severity: High]
This is a pre-existing issue, but does this code overflow the dynamically
allocated data->writeReport buffer?

drivers/hid/hid-rmi.c:rmi_hid_write_block() {
    ...
	data->writeReport[2] =3D addr & 0xFF;
	data->writeReport[3] =3D (addr >> 8) & 0xFF;
	memcpy(&data->writeReport[4], buf, len);
    ...
}

A malicious HID device can present a small output_report_size in its HID
descriptor, which determines the size of the data->writeReport allocation.

By sending parameters that cause the RMI core to perform a large block writ=
e,
can the device force rmi_hid_write_block() to process a len that vastly
exceeds the allocated buffer size?

[Severity: High]
This isn't a bug introduced by this patch, but could this memcpy() result in
an out-of-bounds read from the data->readReport buffer?

drivers/hid/hid-rmi.c:rmi_hid_read_block() {
    ...
			read_input_count =3D data->readReport[1];
			memcpy(buf + bytes_read, &data->readReport[2],
				min(read_input_count, bytes_needed));
    ...
}

The function reads read_input_count directly from the incoming HID report
without validating it against the size of the data->readReport allocation
(data->input_report_size).

Could a malicious device specify a small input_report_size in its HID
descriptor but send a large read_input_count byte in the report, causing
the memcpy() to over-read the kernel heap?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026063007016439.1-=
ccfa108-0006-HID-rmi-check-report-length-pengpeng@iscas.ac.cn?part=3D1
