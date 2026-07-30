Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBD33D4E2
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417110; cv=none; b=P2U88uyN4S+TLlfTF3ENaxWE/hIYe44OQd5JHu6WoY4G5Jdz5NCeVK1NZS+jL8bytwmvUTLoFGnSoSGraztKNH0i9CFhY2lZ9HE7SQmQG70GdCNdoA9Y7mS/0Zy2X0BXknaHul2aVEyJcSmRvWYRnwpuajPCp4Ouky6urmu7vFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417110; c=relaxed/simple;
	bh=YFtaYK9PWs9W0z1tw0W7Dn9CH2zhpItXYY47dsyqE4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kRpCjUGHYKtnfF3P6Beni4COa9dE+AHf/Zg8JlLVbg05Uke0y9Azyb9jJevRJ1N7iInEmx8dobiCh31chTOZTVfRqjf2OyqC2wr4CaggUhqYsLUIV036ibrM+rLt8ww5MAxTeNghrFdsKDjvZkKnvAJUicyZ9Lr7fil+DkHIVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv+C9TeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv+C9TeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7261F000E9;
	Thu, 30 Jul 2026 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785417109;
	bh=/SuZCFFK2QzkY4hZP/+qoHM1YKnkNRHl04vMCIe7vcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xv+C9TeVRiTRInyzwrtwcPlFFx/YpxI2jZgtFaniA2pxBjCVzlr/OuyYjl4IFCVQa
	 9VhrFttLCuYhiFZwybzVtqtUrmI36WUEKyXzqEGbpZcTVzjQPk2Jlhbjm28BZEiZgV
	 U0QOWTq6FHr5LETCSV5DdwbKOp0Yp85n/UUmpmb2absXSiTGB4Wv826i+FkNM2ISyx
	 iCtoA6crorh0LUvfu44aDLRT1e05GBysZgZDIxfu90c9GZZK/HwXgAYVjLGkN+e/Hj
	 ISa+0b8pN3a2vtK0RPQz6Nj9e1r0hJ1PoFo8CoFQPWXxgDmRvsyh8ZRpwXQLanEtGr
	 9EPw3UeFeJ7MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] HID: intel-ish-hid: prevent size_t underflow in
 report_list parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shen Yongchao" <grayhat@foxmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_6D1C4A793D4B3D07F0415D2A86B91BA33508@qq.com>
References: <tencent_6D1C4A793D4B3D07F0415D2A86B91BA33508@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:11:48 +0000
Message-Id: <20260730131149.0C7261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Heap buffer overflow due to missing reallocation when processi=
ng duplicate initialization responses.
- [High] Missing payload length validation before accessing specific messag=
e fields in HOSTIF_DM_ENUM_DEVICES and HOSTIF_PUBLISH_INPUT_REPORT_LIST.
- [High] Flawed bounds checking in HOSTIF_DM_ENUM_DEVICES loop allows massi=
ve out-of-bounds read.
- [High] Missing bounds check for sub-report payload length against outer m=
essage size leads to out-of-bounds read.
- [High] Dangling pointer in hid_sensor_hubs on ishtp_hid_probe failure lea=
ding to Use-After-Free.
- [High] Missing cancellation of event_work on probe failure leads to Use-A=
fter-Free.
--

--- Patch [3]: [PATCH v2 3/4] HID: intel-ish-hid: prevent size_t underflow =
in report_list parsing ---
commit 527ae48f789326594bc98a86ac234f6084ebf2f5
Author: Shen Yongchao <grayhat@foxmail.com>

HID: intel-ish-hid: prevent size_t underflow in report_list parsing

This patch fixes a size_t underflow in hid_input_report() when report_len
is smaller than the hostif message header. It adds an explicit check for
the length and uses a local inner_len variable instead of overwriting the
outer loop's payload_len.

Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/i=
ntel-ish-hid/ishtp-hid-client.c
> index 6609130ce63e1..efe5c5326de3b 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
[ ... ]
> @@ -293,8 +294,11 @@ static void process_recv(struct ishtp_cl *hid_ishtp_=
cl, void *recv_buf,
>  				recv_msg =3D container_of(&report->msg,
>  							struct hostif_msg, hdr);
>  				report_len =3D report->size;

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a malform=
ed
firmware message to cause an out-of-bounds read here?

Looking at HOSTIF_PUBLISH_INPUT_REPORT_LIST in process_recv():

	reports_list =3D (struct report_list *)recv_msg->payload;
	pos =3D (u8 *)reports_list->reports;
	list_end =3D (u8 *)recv_msg->payload + payload_len;

	for (j =3D 0; j < reports_list->num_of_reports; j++) {

The num_of_reports field is accessed without checking if payload_len is lar=
ge
enough to contain a struct report_list.

Additionally, in the HOSTIF_DM_ENUM_DEVICES case:

	client_data->hid_dev_count =3D (unsigned int)*payload;

The payload pointer is dereferenced without checking if payload_len >=3D 1,=
 which
could similarly read out of bounds.

> -				payload =3D recv_msg->payload;
> -				payload_len =3D report_len -
> +				if (report_len < sizeof(struct hostif_msg_hdr))
> +					break;
> +
> +
> +				inner_len =3D report_len -
>  					sizeof(struct hostif_msg_hdr);

[Severity: High]
This isn't a bug introduced by this patch, but could this still lead to an
out-of-bounds read when hid_input_report() is called?

While the sub-report header is bounded against list_end in a previous check:

	if (pos + sizeof(struct report) > list_end)
		break;

There doesn't appear to be a check to ensure that the payload itself
(inner_len bytes) fits within list_end. A forged, huge sub-report length co=
uld
cause hid_input_report() to read past the end of the receive buffer.

> =20
>  				for (i =3D 0; i < client_data->num_hid_devices;
> @@ -306,11 +310,11 @@ static void process_recv(struct ishtp_cl *hid_ishtp=
_cl, void *recv_buf,
>  						client_data->hid_sensor_hubs[
>  									i],
>  						report_type,
> -						payload, payload_len,
> +						recv_msg->payload, inner_len,
>  						0);
>  					}
> =20
> -				pos +=3D sizeof(struct report) + payload_len;
> +				pos +=3D sizeof(struct report) + inner_len;
>  			}
>  			break;
>  		default:

[Severity: High]
This isn't a bug introduced by this patch, but does the boundary check duri=
ng
device enumeration correctly prevent out-of-bounds reads?

Looking at the fallback boundary check in process_recv():

	if (1 + sizeof(struct device_info) * i >=3D data_len)
		break;

Since dev_info is offset by cur_pos + sizeof(struct hostif_msg_hdr) from the
start of recv_buf, this check ignores the initial payload offset. If i is l=
arge
enough, could the memory address calculated for dev_info vastly exceed
recv_buf + data_len, resulting in slab-out-of-bounds reads into the hid_dev=
ices
array?

[Severity: Critical]
This isn't a bug introduced by this patch, but could duplicate initializati=
on
responses cause a heap buffer overflow?

When handling HOSTIF_DM_ENUM_DEVICES, the code does:

	if (!client_data->hid_devices)
		client_data->hid_devices =3D devm_kcalloc(...);

And similarly for HOSTIF_GET_HID_DESCRIPTOR:

	if (!client_data->hid_descr[curr_hid_dev])
		client_data->hid_descr[curr_hid_dev] =3D devm_kmalloc(...);

If a second response arrives before init_done is true and contains a larger
payload or count, the driver skips allocation but still uses the new
payload_len or hid_dev_count to perform memory copies. Could this copy data
past the old buffer's boundary?

[Severity: High]
This isn't a bug introduced by this patch, but could a failure in
ishtp_hid_probe() lead to a use-after-free?

In ishtp_hid_probe():

	err_hid_device:
		kfree(hid_data);
	err_hid_data:
		hid_destroy_device(hid);
		return rv;

The hid device is stored in client_data->hid_sensor_hubs[cur_hid_dev] before
this error path, but is not cleared to NULL when the error path frees the
device. Since the ISHTP event callback is already registered, could a concu=
rrent
firmware message processed by process_recv() find the freed pointer and pas=
s it
to hid_input_report()?

[Severity: High]
This isn't a bug introduced by this patch, but does hid_ishtp_cl_probe()
properly clean up if it fails after hid_ishtp_cl_init()?

In hid_ishtp_cl_probe():

	rv =3D hid_ishtp_cl_init(hid_ishtp_cl, false);
	if (rv) {
		ishtp_cl_free(hid_ishtp_cl);
		return rv;
	}

The hid_ishtp_cl_init() function registers an event callback via
ishtp_register_event_cb(). If the probe subsequently fails, the error path
frees hid_ishtp_cl without unregistering the event callback or canceling the
pending event work. Could an incoming ISHTP message arriving shortly after
execute the scheduled callback on freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730115600.2181=
72-1-grayhat@foxmail.com?part=3D3
