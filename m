Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23383C1F3A
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 13:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416898; cv=none; b=Zw0VG9vvbGDX02fFTf9CjxSzEofreSq2VDztTX3fZYIpqaZtsYmGrvzT0UGTioQ4qwAlhddm71+Q/V2THOogX/TNeRprx0ZAOxPZd0cpSoONd6Z4VnAMMAGgrpbHyeBJ0GZtsTm3eBMypUTMEe9PTJG9JjBIviDKw8D+ilcWFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416898; c=relaxed/simple;
	bh=/dTcwoQdqMLnCCTMcMj4lrQeEY7npB7+bzUCydrrCPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fATKxeHDIofFmud8AZ8kzGzGTA0rTTKoDiw2rUY8v0SwyjlSz5vRKpL939ivAk9EimqSS+k0iGy7Dl4lor3Ub7OXNQ50kJy6wHDHg83KoWjMcJ8uOT8K5q18ovfJ+qMJ460BpECburEj4wtZOBd73vHIaSRqxy8ACqC2I1TQYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR2PJoku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR2PJoku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0781F000E9;
	Thu, 30 Jul 2026 13:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785416897;
	bh=zlffWPbB1WRltO4yiALthC7uxBd9A9CKmfmARWkHagw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JR2PJokuMNw92D4inf1Jzi+Eo1yDg1Ki0Dv3xRIXkvRVDdh8QUTUmfBf9FVRcbrSh
	 MSzu6c1QznCboTPq5Qa3kvH32IY1aQX9Uu7hrATjNL502i7XaEFJJtyL9f1ZIe8CrR
	 GVzR48hA+jsngCBxtkjsrUGPKhAnbthVrj04gGaWiUibRZwanhokCLlwRe1IoIHeYW
	 H9M/RBQyrVUSsjAS0kogO9A6XE8SSCJXs099yTlBKqnt4XE87r1CN/y3KgRIZnZ91M
	 2yG2HkxxblMhYiPvdL3GGust+b08wXeXk9w6+LTBYEJjlNU+4cjHGoqz08Zj0PM9kv
	 u8ZgsEiHfuP0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] HID: intel-ish-hid: bound report_list iteration
 to message size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shen Yongchao" <grayhat@foxmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <tencent_9DD5BCA4258383AEA05715975CA7D16C0E07@qq.com>
References: <tencent_9DD5BCA4258383AEA05715975CA7D16C0E07@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:08:16 +0000
Message-Id: <20260730130817.4F0781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Outer loop variables used for message parsing are clobbered in=
side the inner sub-report processing loop, permanently desynchronizing the =
outer ISHTP message parser.
- [High] Processing duplicate initialization responses (e.g., HOSTIF_GET_HI=
D_DESCRIPTOR) before `init_done` is set leads to a heap buffer overflow.
- [High] In the HOSTIF_DM_ENUM_DEVICES case, the driver suffers from out-of=
-bounds reads because it improperly uses `data_len` instead of `payload_len=
` for loop boundaries.
--

--- Patch [2]: [PATCH v2 2/4] HID: intel-ish-hid: bound report_list iterati=
on to message size ---
commit d383335a5cf9c011bbef2b75bc812227c6cc17cc
Author: Shen Yongchao <grayhat@foxmail.com>

HID: intel-ish-hid: bound report_list iteration to message size

The commit introduces bounds checking in the ISH HID client's report parsing
loop. It ensures the iteration does not proceed past the message buffer by
calculating a list_end pointer and verifying the next report falls within t=
he
valid payload.

> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/i=
ntel-ish-hid/ishtp-hid-client.c
> index ba52e185ce051..6609130ce63e1 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -75,6 +75,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_cl,=
 void *recv_buf,
>  	struct report_list *reports_list;
>  	struct report *report;
>  	u8 *pos;
> +	u8 *list_end;
>  	size_t report_len;
>  	struct ishtp_cl_data *client_data =3D ishtp_get_client_data(hid_ishtp_c=
l);
>  	int curr_hid_dev =3D client_data->cur_hid_dev;

[ ... ]

> @@ -282,8 +283,12 @@ static void process_recv(struct ishtp_cl *hid_ishtp_=
cl, void *recv_buf,
>  			report_type =3D HID_INPUT_REPORT;
>  			reports_list =3D (struct report_list *)payload;
>  			pos =3D (u8 *)reports_list->reports;
> +			list_end =3D (u8 *)payload + payload_len;
> =20
>  			for (j =3D 0; j < reports_list->num_of_reports; j++) {
> +				if (pos + sizeof(struct report) > list_end)
> +					break;
> +
>  				report =3D (struct report *)pos;
>  				recv_msg =3D container_of(&report->msg,
>  							struct hostif_msg, hdr);

[Severity: High]
This is a pre-existing issue, but could we trigger a heap buffer overflow in
HOSTIF_GET_HID_DESCRIPTOR?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:process_recv() {
    ...
		case HOSTIF_GET_HID_DESCRIPTOR:
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

If the firmware sends two HOSTIF_GET_HID_DESCRIPTOR responses back-to-back
before initialization finishes, the first response allocates the buffer wit=
h its
payload_len.

If the second response has a larger payload_len, it skips reallocation since
the pointer is no longer NULL, but then executes the memcpy() with the new
larger payload_len.

Can this overwrite the previously allocated buffer?


[Severity: High]
This is also a pre-existing issue, but I noticed a potential out-of-bounds =
read
in the HOSTIF_DM_ENUM_DEVICES case:

drivers/hid/intel-ish-hid/ishtp-hid-client.c:process_recv() {
    ...
		case HOSTIF_DM_ENUM_DEVICES:
    ...
			for (i =3D 0; i < client_data->hid_dev_count; ++i) {
    ...
				if (1 + sizeof(struct device_info) * i >=3D
						data_len)
					break;

				dev_info =3D (struct device_info *)(payload + 1 +
					sizeof(struct device_info) * i);
				if (client_data->hid_devices)
					memcpy(client_data->hid_devices + i,
					       dev_info,
					       sizeof(struct device_info));
			}
    ...
}

Does the check `1 + sizeof(struct device_info) * i >=3D data_len` use the w=
rong
boundary?

Since data_len is the total size of the receive buffer, but the payload is
offset by cur_pos and the message header size, it seems this check could al=
low
reading past the end of the receive buffer if payload_len is small but
hid_dev_count is large.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730115600.2181=
72-1-grayhat@foxmail.com?part=3D2
