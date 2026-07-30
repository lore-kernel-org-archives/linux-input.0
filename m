Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F937EFEC
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416951; cv=none; b=OOc/TjOg84AzcKKbNcd/39G1h8Pnn2E7auIFcbsc277V7O6b2stMWDKs9kQHv35GG70u+JkXS5aoBnjfoqDDDD5ci5XbBLJZxykx15PQFo8DRPcu2D5ikKh3SC55KLaNQD1UGv3de1DEz+dsr7LaBUW3uNrqVh9ixDimVU8XBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416951; c=relaxed/simple;
	bh=2biCtU4I6hRn5v0ATd38ar6JajtoAPDhzgsMWxgHBqg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NZeyo5wcl96MFCF1I0tMuL0NY7e9J3w+SbCykLZOrtb8gA47vUKMrZ7B5REx98fRyuygdt95wl49EuWbJTWICkKmUHunwHDRYZH3VnYIknDd4/dsrsCR3K7ZTWvtYcWxq7MJxY9ICqnzftTDF1qwQKwxyYjsMPkI4wBOhDJRtQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ie0OB47z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie0OB47z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC42C1F000E9;
	Thu, 30 Jul 2026 13:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785416950;
	bh=8n+dilMPm6oacdBfQtNW1g1eeTMsdOxzn5uVREZ2DIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ie0OB47zbeg/uZyVQHdPCtoT/e2OMiO9GlKEvrQ5MsiZwsqi60g/9bxIYwO3XWBRW
	 opu/tw+nQAL/lJPlFj5Pzeyv9IVYkdhCtLnW3v7ebPpud48OBiJf7QR87+ah3gjruA
	 4bAdrPcj8MPFPjaS186xu7i0EOCEimH5SMVqm08o7UWflSSdHTw5D2RNLjplLYqYHA
	 fxi+war8awNs90RXh/4cUTTvi8trHSwyU0BkcB89rQSXQVdI3L65R4OB38TAAkQfoc
	 wQsDiv2W5QEUTEmpW1BcPJa9cT4EX1FQr4LwcIGVtrwahXTc9ewQS+MB3+CjLAc13e
	 2eoG34hw8n4GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] HID: intel-ish-hid: add full entry bounds check
 to report_list parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shen Yongchao" <grayhat@foxmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <tencent_7441292A34B9A7A3111C7679504B7407B808@qq.com>
References: <tencent_7441292A34B9A7A3111C7679504B7407B808@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:09:09 +0000
Message-Id: <20260730130909.AC42C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing check against MAX_HID_DEVICES allows out-of-bounds array i=
ndexing in client_data.
- [High] Reusing previously allocated heap memory without size checks on re=
dundant initialization responses causes heap buffer overflows.
- [High] Flawed bounds checking in HOSTIF_DM_ENUM_DEVICES allows out-of-bou=
nds reads across messages and beyond the receive buffer.
- [High] Missing cancellation of workqueues during device removal leads to =
Use-After-Free.
- [Medium] Missing minimum payload length checks allow reading past the end=
 of the packet buffer.
--

--- Patch [4]: [PATCH v2 4/4] HID: intel-ish-hid: add full entry bounds che=
ck to report_list parsing ---
commit ac6e6de794611e6aba0e28b1be2df9e2337fcb9e
Author: Shen Yongchao <grayhat@foxmail.com>

HID: intel-ish-hid: add full entry bounds check to report_list parsing

This commit adds a bounds check to ensure the full entry (report header plus
payload) fits within the message before processing it. It also updates the
report list and list end pointers to use the current message payload instead
of a stale variable.

> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/i=
ntel-ish-hid/ishtp-hid-client.c
> index efe5c5326de3b..0ac7be0c4adf5 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -282,9 +282,9 @@ static void process_recv(struct ishtp_cl *hid_ishtp_c=
l, void *recv_buf,
> =20
>  		case HOSTIF_PUBLISH_INPUT_REPORT_LIST:
>  			report_type =3D HID_INPUT_REPORT;
> -			reports_list =3D (struct report_list *)payload;
> +			reports_list =3D (struct report_list *)recv_msg->payload;
>  			pos =3D (u8 *)reports_list->reports;
> -			list_end =3D (u8 *)payload + payload_len;
> +			list_end =3D (u8 *)recv_msg->payload + payload_len;
> =20
>  			for (j =3D 0; j < reports_list->num_of_reports; j++) {

[Severity: Medium]
This isn't a bug introduced by this patch, but does this code read past the=
 end=20
of the packet buffer if the payload is truncated?

If the firmware sends a zero-length or truncated payload for
HOSTIF_PUBLISH_INPUT_REPORT_LIST, we access reports_list->num_of_reports
without verifying payload_len is at least sizeof(struct report_list).

I noticed a similar lack of minimum payload checks earlier in this function
when accessing *payload:

drivers/hid/intel-ish-hid/ishtp-hid-client.c:process_recv() {
    ...
    client_data->hid_dev_count =3D (unsigned int)*payload;
    ...
}

Can these accesses read from adjacent out-of-bounds memory when the message
sits exactly at the end of the receive buffer?

[ ... ]

[Severity: High]
This is a pre-existing issue, but I noticed a potential out-of-bounds array
access related to hid_dev_count when reviewing the rest of process_recv():

drivers/hid/intel-ish-hid/ishtp-hid-client.c:process_recv() {
    ...
    client_data->hid_dev_count =3D (unsigned int)*payload;
    ...
}

and later in ishtp_enum_enum_devices():

drivers/hid/intel-ish-hid/ishtp-hid-client.c:ishtp_enum_enum_devices() {
    ...
    client_data->num_hid_devices =3D client_data->hid_dev_count;
    ...
}

Could a firmware response provide a hid_dev_count up to 255, which is then
assigned to client_data->num_hid_devices without being bounded to
MAX_HID_DEVICES?

When this value is used as an index:

drivers/hid/intel-ish-hid/ishtp-hid-client.c:process_recv() {
    ...
    if (!client_data->hid_descr[curr_hid_dev])
    ...
}

Does this code allow out-of-bounds reads and writes to the hid_descr array?

[Severity: High]
This isn't a bug introduced by this patch, but does this memory allocation
pattern allow a heap buffer overflow if redundant initialization responses
are received?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:process_recv() {
    ...
    if (!client_data->hid_descr[curr_hid_dev])
        client_data->hid_descr[curr_hid_dev] =3D
        devm_kmalloc(cl_data_to_dev(client_data),
                     payload_len, GFP_KERNEL);

    if (client_data->hid_descr[curr_hid_dev]) {
        memcpy(client_data->hid_descr[curr_hid_dev],
               payload, payload_len);
    ...
}

If multiple HOSTIF_GET_HID_DESCRIPTOR responses arrive, the first one
allocates the buffer based on the initial payload_len. On subsequent respon=
ses,
the allocation check fails and skips reallocation, but the memcpy uses the =
new,
potentially much larger payload_len.

Can this corrupt adjacent heap memory?

[Severity: High]
This is a pre-existing issue, but the bounds check for device enumeration
seems to compare against the total buffer size incorrectly:

drivers/hid/intel-ish-hid/ishtp-hid-client.c:process_recv() {
    ...
    if (1 + sizeof(struct device_info) * i >=3D data_len)
        break;
    ...
    memcpy(client_data->hid_devices + i,
           dev_info,
           sizeof(struct device_info));
    ...
}

Since payload is an offset within the recv_buf (equal to
recv_buf + cur_pos + sizeof(header)), does this check allow the actual
accessed address to extend past the end of recv_buf by up to cur_pos +
sizeof(header) bytes?

Would this result in copying out-of-bounds heap memory into the newly
allocated hid_devices array?

[Severity: High]
This isn't a bug introduced by this patch, but I have a question about the
device removal lifecycle:

drivers/hid/intel-ish-hid/ishtp-hid-client.c:hid_ishtp_cl_remove() {
    ...
}

If hid_ishtp_cl_remove() returns without calling cancel_work_sync(), devres
will free the client_data memory.

If a background work item (like client_data->work or client_data->resume_wo=
rk)
is still pending or executing, will it dereference the freed client_data
structure and cause a use-after-free regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730115600.2181=
72-1-grayhat@foxmail.com?part=3D4
