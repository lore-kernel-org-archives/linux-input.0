Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACDC38D
	for <linux-input@vger.kernel.org>; Sat, 27 Jun 2026 22:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782601070; cv=none; b=CbxnfZzDyzNFT3iHovbSXzIdZf6l4adYsYI/v0q28QlQajs3D6FkTaBaNmstDCv1bJjil2islaucN3RxUcz5nFG5zSLqZI7rMsEuVOnWFsY06LlOJXq5IyVfEC++FqlowfMwbQk+2zLTAVzPWVzcBgZwPDoM/cBVJM66ywab5R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782601070; c=relaxed/simple;
	bh=W4NxCOKjyxMn06TeiWpoRlZ1eS8hI77iGRHDZKtjmb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pOTfP99dviACsPKYqlxdE0OQifgTeRGM+YKNWYmJHNNp8+6d1IVUsY4i2+4kE5FgQUlYS+tzX0fgqd/A4tzgCIpfNJIUEtEs/jOLG0ts8pGWTS/F95D/qzchESuBkwaLi5Mh7xCfYZ1kUrpC85ECw8KW2v+Mbov1JPKDVDNeGgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuPTCrCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuPTCrCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058711F000E9;
	Sat, 27 Jun 2026 22:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782601069;
	bh=q6+NZVWzkicoxeeaML+Dw9BqTEtHWmpV/oWgNkkcRuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TuPTCrCw7W5B+oZlT+HudVBv0m+yeLLm2NGeHD9Ilb2kbwPLhOl9TI/7nW2/7Ny3k
	 jczcVQqUjLGbbaUxEDAoEFvzVATSerIa7y3y4HDk6vxYYwipJUAFCE1ue0KPlgRsk4
	 0Dy+6YRYXzRQDqpceY5aD5pGZpnQIKDUe3w0YftMrdG++WRRWxwutc08gq9Que9UI0
	 AN0dVF3ExPVi0ondKOPoJFU9V6YN9jO1BdnZQPsviodrKGMnxJmMJ04dd5z/TGfbh/
	 j6ETCTl5BebIIq6CvGKucyV9c0CHJ8ER/StEPf7N/too0FrYblzYMxqRSnVSkZV6fM
	 +ck8yoHuxab4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: ignore post-init ENUM_DEVICES from
 firmware
Reply-To: sashiko-reviews@lists.linux.dev
To: Wahid7852 <wahidzk0091@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260627224753.35075-1-wahidzk0091@gmail.com>
References: <20260627224753.35075-1-wahidzk0091@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 22:57:48 +0000
Message-Id: <20260627225749.058711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Duplicate firmware responses during initialization (ENUM_DEVIC=
ES, GET_HID_DESCRIPTOR, GET_REPORT_DESCRIPTOR) cause heap buffer overflows.
- [High] Missing payload length validation and flawed bounds checks in HOST=
IF_DM_ENUM_DEVICES parsing lead to out-of-bounds memory reads.
- [High] Unscaled pointer arithmetic and integer underflow in HOSTIF_PUBLIS=
H_INPUT_REPORT_LIST lead to massive out-of-bounds memory accesses.
--

commit 44b4c0eea0f41216fd9e39bd67a4356eeadc37c7
Author: Wahid <wahidzk0091@gmail.com>

HID: intel-ish-hid: ignore post-init ENUM_DEVICES from firmware

This commit splits the guard condition for HOSTIF_DM_ENUM_DEVICES messages
to safely discard valid ENUM_DEVICES messages that arrive after
initialization is complete. This prevents unnecessary ISH soft-resets
caused by periodic firmware announcements.

> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/i=
ntel-ish-hid/ishtp-hid-client.c
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -113,8 +113,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_c=
l, void *recv_buf,
> =20
>  		switch (recv_msg->hdr.command & CMD_MASK) {
>  		case HOSTIF_DM_ENUM_DEVICES:
> -			if ((!(recv_msg->hdr.command & ~CMD_MASK) ||
> -					client_data->init_done)) {
> +			if (!(recv_msg->hdr.command & ~CMD_MASK)) {
>  				++client_data->bad_recv_cnt;
>  				report_bad_packet(hid_ishtp_cl, recv_msg,
>  						  cur_pos,
> @@ -122,6 +121,8 @@ static void process_recv(struct ishtp_cl *hid_ishtp_c=
l, void *recv_buf,
>  				ish_hw_reset(ishtp_get_ishtp_device(hid_ishtp_cl));
>  				break;
>  			}
> +			if (client_data->init_done)
> +				break;
>  			client_data->hid_dev_count =3D (unsigned int)*payload;

[Severity: High]
This is a pre-existing issue, but does this code read out-of-bounds memory
if the payload length is zero?

If a HOSTIF_DM_ENUM_DEVICES message is received with a zero-length payload,
*payload is dereferenced here without validation.

Furthermore, in the loop that follows:

process_recv() {
    ...
    for (i =3D 0; i < client_data->hid_dev_count; ++i) {
        ...
        if (1 + sizeof(struct device_info) * i >=3D data_len)
            break;
           =20
        dev_info =3D (struct device_info *)(payload + 1 +
            sizeof(struct device_info) * i);
           =20
        if (client_data->hid_devices)
            memcpy(client_data->hid_devices + i, dev_info,
                   sizeof(struct device_info));
    ...
}

The bounds check compares the relative payload offset against the absolute
buffer size (data_len) instead of the payload size. This allows the offset
to read out-of-bounds memory, which is then copied into the persistent
device information cache, leaking the contents.

>  			if (!client_data->hid_devices)
>  				client_data->hid_devices =3D devm_kcalloc(

[Severity: Critical]
This is a pre-existing issue, but can duplicate firmware responses cause a
heap buffer overflow here?

If multiple HOSTIF_DM_ENUM_DEVICES or GET_HID_DESCRIPTOR messages arrive
back-to-back before init_done becomes true, this allocation is incorrectly
skipped because the pointer is already non-NULL.

The memory is then copied into the existing buffer based on a potentially
larger, unvalidated hid_dev_count or payload_len:

process_recv() {
    ...
    memcpy(client_data->hid_devices + i, dev_info,
           sizeof(struct device_info));
    ...
    memcpy(client_data->hid_descr[curr_hid_dev], payload, payload_len);
    ...
}

This could cause memory to be copied into the original buffer without
reallocation, causing a heap buffer overflow.

[ ... ]

[Severity: High]
This is a pre-existing issue, but is there an integer underflow and pointer
arithmetic issue when parsing HOSTIF_PUBLISH_INPUT_REPORT_LIST?

Looking further down in process_recv():

process_recv() {
    ...
    case HOSTIF_PUBLISH_INPUT_REPORT_LIST:
        ...
        payload_len =3D report_len - sizeof(struct hostif_msg_hdr);
        ...
        report +=3D sizeof(*report) + payload_len;
    ...
}

If the firmware-controlled report_len is less than 6
(sizeof(struct hostif_msg_hdr)), payload_len underflows.

Additionally, because report is a typed pointer (struct report *), this
addition is implicitly scaled by sizeof(struct report) (8 bytes), advancing
the pointer out of bounds by a factor of 8.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627224753.3507=
5-1-wahidzk0091@gmail.com?part=3D1
