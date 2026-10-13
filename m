Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0134F47A87C
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864058; cv=none; b=u+JbrWI4ZL3D6Mu9yfdiHpOIFWk72L+38vNEjLEcvnuycB47KQFHROCwFRukC7jZr5owf7F2XZql1rQsqAbF7gsypVlzAUgYk5yjujH8hbhAOnbKEchRkuGhJC6+jedj8dCcstcy1Wb+57Y6I/ToRyserbPxMMOt6V2aGHbHf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864058; c=relaxed/simple;
	bh=EwKs/JuPJJ69FLFuQQctNlgP4tL2Okx5Qv8KKW68+vo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HOmYXtBNXs+hRdWOo7ENuJBq/hntvfj7JSt2SWqA1rT4BeCExCIn2Ok1sKui2tr5oIBt+lgK9QEMI6TAJF3fkerbZJZdTjdzwNJ5zHuN/PJTM5O7bI3fJi+LJLz9dxUNggU1hJgX6PR4kfbInXjEQNM1Qhc+t19XyxQ0l/wOX08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/uG9OSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/uG9OSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0471F000FF;
	Tue, 13 Oct 2026 04:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791864056;
	bh=PfNLdNL9jG6RsZLoupw3LxthDI9uhPGvONkt5/VL7UM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S/uG9OSQRwWG/m/h/0xsqpQHki+mg9C3MmUsJfECn9Xxmx9JCLC/LG1uYuZSHxkwo
	 Cq9LL3EDM5NRXn4bDWuA1JIlau90Qj0I/pvsl4Ti9rLGce6tCbmkQSynATLTLdpVZU
	 SURgfXdJwXQnROIcuCoEKs+sGa0aZLeoz+t3z8e9yUi0hSKjWxpry1q62rOPYrps6s
	 ukcwq7TAVRBGgzGr4bF4s2vHbFKttoxCtX/GMb+ry+pdybr9l5KNXtbSI8g/F7R5OW
	 2fkQjPWJTFG5wsF6W08krw0voOEVpiHCe45kD+92lYaILpyFsnkhk6sly8vaDWf/o2
	 Jk7+GXFdJOHwQ==
Message-ID: <sashiko-outbox-168952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] HID: core: Fix GET_REPORT input processing for
 unnumbered reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261012-hid-core-report-validation-v1-2-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
 <20261012-hid-core-report-validation-v1-2-e0dd5cb60b2e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 04:00:55 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: core: uhid unnumbered GET_REPORT payload truncation
--

commit c28ca1033fab3989e7f3d67f52364f0621a32b6d
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

HID: core: Fix GET_REPORT input processing for unnumbered reports

This commit offsets the buffer and deducts the dummy report ID from the len=
gth
when forwarding unnumbered reports to the input layer in __hid_request.

> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index ec7c2860c93ef..a33e864a25f92 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2033,8 +2033,13 @@ int __hid_request(struct hid_device *hid, struct h=
id_report *report,
>  		return ret;
>  	}
> =20
> -	if (reqtype =3D=3D HID_REQ_GET_REPORT)
> -		hid_input_report(hid, report->type, buf, ret, 0);
> +	if (reqtype =3D=3D HID_REQ_GET_REPORT) {
> +		if (report->id =3D=3D 0)
> +			ret--;
> +
> +		if (ret > 0)
> +			hid_input_report(hid, report->type, data_buf, ret, 0);

[Severity: High]
Does this unconditional stripping of the first byte truncate the payload for
unnumbered reports on uhid devices?

The commit message notes that low-level transport drivers store a dummy
report ID of 0 for unnumbered reports. While true for drivers like usbhid
and i2c-hid, uhid handles this differently.

According to the uhid ABI, userspace replies to UHID_GET_REPORT via
UHID_GET_REPORT_REPLY and places the exact raw payload in req->data without
a dummy report ID.

In drivers/hid/uhid.c:uhid_hid_get_report(), the payload is copied exactly
as provided by userspace:

	ret =3D min3(count, (size_t)req->size, (size_t)UHID_DATA_MAX);
	memcpy(buf, req->data, ret);

Since uhid does not prepend a dummy 0 byte, decrementing ret and passing
data_buf (which was advanced by one earlier in __hid_request) to
hid_input_report() appears to strip the first byte of the actual payload,
corrupting the data.

> +	}
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-hid-core-r=
eport-validation-v1-0-e0dd5cb60b2e@gmail.com?part=3D2
