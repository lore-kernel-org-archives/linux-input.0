Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86C1E7C23
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 03:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046323; cv=none; b=qqoX3oHfS7yo3JOwsyCIxljf2oozN6TjAGzXj5qgyvVn7sZdpb1lRuNbYLlYPLyVnZDztcQeanwIudYufnlxWE7WVOvF5uiaKD/5Ka+DgmcK8xHjGLJAwKlGamjzCWTAo9bJQkc40AyOzhbNuc15HktKqsNkA6kB83XhBIqquyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046323; c=relaxed/simple;
	bh=3i8heWWjN7z+N1gv2VvbSNwzvAF93d0Mfko5XUKTPnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SLTzAeQDChkIOUpGVZZNf9vApWiPnVddpZ+xz9AW0aSR/mZ4htJQD/tkB7dd43UngIu9TLCeiotJOWtwUHe0XYNu1xu92GXv9tbeRK9t6I9dN5XZVAX6mbSKaGJNajSXuz3RxNEbV6bd7Tpa//lyvllqvtE/u7beO9MNxMjSfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltuM16T4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltuM16T4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CAA1F000FF;
	Tue, 22 Sep 2026 03:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790046322;
	bh=ri/q5gf49svdVFFFtV7QchzC4IkHBwgcZAeFC443cVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ltuM16T4LBwhumISNXcgR3VdyiVByJRmA/O6fqt0bF5pyIloC3vSc2cJFm2PRJ921
	 jr2G5kEIn7uLwEqrf7TM4mtZGUOx4CGJtdtsbpLilE4rXKxgnBNFNobkF8eo5uu+pM
	 L0dUR0UvBR4YY+QOxk97ryZNeYE5vINh3swEtZfW3DS1ju5ht4FNTLlX9O2SlHF6hm
	 uYnWe1g55LNn0vsIjyrHQ9LA+noZplaiMyAR80Fv9gdyteFtNEiHkVGCXHERVqX0u3
	 FQ2Jbmp+G88ZhjLtfVepUNlyq2iBcRNOTw9DxJbB25bAD2mpf0OyxPzKt5v9q7d0u8
	 luPqha0Dpm0Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: Intel-thc-hid: Intel-quickspi: Use
 hid_safe_input_report()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Even Xu" <even.xu@intel.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260922025437.940072-3-even.xu@intel.com>
References: <20260922025437.940072-1-even.xu@intel.com>
 <20260922025437.940072-3-even.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 03:05:21 +0000
Message-Id: <20260922030521.C9CAA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: intel-thc-hid: heap OOB write and report rejection due to inc=
orrect buf_size
--

commit 89b3a4008ccfc5430514595b9a4bdb1131455535
Author: Even Xu <even.xu@intel.com>

    HID: Intel-thc-hid: Intel-quickspi: Use hid_safe_input_report()
   =20
    Replace the deprecated hid_input_report() with
    hid_safe_input_report(), which takes the allocated size of the input
    report buffer and allows hid-core to validate the reported data length
    against the actual buffer size.
   =20
    Track the allocated size of qsdev->input_buf in the new input_len
    field and pass it through quickspi_hid_send_report() to
    hid_safe_input_report() to prevent potential out-of-bounds reads.

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c=
 b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> index 847c5ec55569a..0df33c44fbffe 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
> @@ -240,7 +240,7 @@ void quickspi_handle_input_data(struct quickspi_devic=
e *qsdev, u32 buf_len)
>  		input_len =3D sizeof(body_hdr->content_id) + input_len;
>  		input_report =3D input_body->content - sizeof(body_hdr->content_id);
> =20
> -		ret =3D quickspi_hid_send_report(qsdev, input_report, input_len);
> +		ret =3D quickspi_hid_send_report(qsdev, input_report, qsdev->input_len=
, input_len);

[Severity: High]
Does passing qsdev->input_len as the buf_size here overstate the available
buffer space?

In quickspi_handle_input_data(), input_report is calculated as an offset in=
to
the allocated buffer:

    input_report =3D input_body->content - sizeof(body_hdr->content_id);

This offsets the pointer by 3 bytes into the qsdev->input_buf allocation.
However, qsdev->input_len represents the total allocation size, not the
remaining space from the input_report pointer.

When this overstated size reaches hid_safe_input_report(), if a short report
requires padding, hid_report_raw_event() in the HID core could write up to
3 bytes past the end of the qsdev->input_buf allocation via memset(), causi=
ng
a heap out-of-bounds write.

Additionally, if a maximum-sized report is received, the data length will
strictly exceed the stated buf_size, causing the HID core to falsely reject
the report with -EINVAL.

Should the buf_size passed to quickspi_hid_send_report() account for the
offset into the buffer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922025437.9400=
72-1-even.xu@intel.com?part=3D2
