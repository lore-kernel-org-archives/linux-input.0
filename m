Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508B543E069
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571494; cv=none; b=ik2+GU0oHgwmFWSqB19KhrMezJVTVgVntNzd3uZS/926xq3zFp3uTaQ42KenufFGTgNYHA3gPwndPXdFVGMeWAH+P+kjLBVDDcUc6mflAO4pTohvKh4Qm3DBvCNc9eeO7FruTrqjX9GH1x40c5jK/ZkDc8LIlIqpuxJeLjaJGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571494; c=relaxed/simple;
	bh=d+Ddooa+1HHOB0qNznbNcfeUV8FyVOtCCjl5IXxsBZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G+1kI4zwElJG4akeRM7VzRm6cK8XxqcB4CQuBYBk143QTao8qMogJ20qyHXd4dMxWUkEUxmtcQS6fhNnyRxUjg2MhAUyTDSOyc4o2KtrrGRBUldvNQjsoGLvyOTeSqVyBMP65tVfrVEH4dC8x6HTSgvZGcIK2s8czaso+SaDX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkktX2Zk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkktX2Zk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1CC1F000E9;
	Mon, 20 Jul 2026 18:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571492;
	bh=3b+zBLpI6YCckEtkTB8zD74CJG7c/I+PWQKAz12A8P4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DkktX2ZkdR7JB03pWIdZL496ksix3qAfwsDrJqx4P+Po9RDzwxPqFQWDH8LfeKx+c
	 GXdhM7LOd2jwcYLwB2jcgLrI6op7+liRCUUsWZRGDXiJwfCLoBmLD5wB87/lbeGJQ4
	 kGXDIITq3FU/rAf3s6p6EjseACf2F9EntQJsMWjKaNTvo9W8Jg/7lNTF/7DWE4y6FL
	 SrcwRQDo3HR0O4QWMQfzIKILIu6KKx6TQ/zoWAvNLzvfebDkztx9e4Bz3aEkbyKqHC
	 97fwKjjx3aYb3Ee88u9DgZfHOiIxMjqQQ2AgpWLRzQD5FCSm6RgeqTxBdnxz6+5BC2
	 bTV8t0bzzE5DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: intel-ish-hid: ignore post-init ENUM_DEVICES
 from firmware
Reply-To: sashiko-reviews@lists.linux.dev
To: Wahid7852 <wahidzk0091@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720175656.559351-1-wahidzk0091@gmail.com>
References: <20260627224753.35075-1-wahidzk0091@gmail.com>
 <20260720175656.559351-1-wahidzk0091@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:18:12 +0000
Message-Id: <20260720181812.AC1CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Integer underflow and pointer arithmetic bugs in `HOSTIF_PUBLI=
SH_INPUT_REPORT_LIST` allow massive out-of-bounds memory reads.
- [Critical] Missing bounds check on `hid_dev_count` allows an out-of-bound=
s write on fixed-size arrays.
- [High] Missing state validation for duplicate initialization responses ca=
uses a heap buffer overflow due to skipped reallocations.
- [High] Inadequate bounds checking in `HOSTIF_DM_ENUM_DEVICES` allows out-=
of-bounds memory reads from the receive buffer.
- [High] The driver fails to cancel `client_data->work` and `client_data->r=
esume_work` during device removal, leading to a potential use-after-free.
--

--- Patch [1]: [PATCH v2] HID: intel-ish-hid: ignore post-init ENUM_DEVICES=
 from firmware ---
commit f5198129202a132955d59473ed96cfb8c860906b
Author: Wahid Khan <wahidzk0091@gmail.com>

    HID: intel-ish-hid: ignore post-init ENUM_DEVICES from firmware

    This commit modifies the guard in process_recv() for the
    HOSTIF_DM_ENUM_DEVICES command. It splits the check to reject messages
    with no response flag, while silently discarding valid ENUM_DEVICES
    messages that arrive after initialization is complete.

> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/i=
ntel-ish-hid/ishtp-hid-client.c
> index 6d64008f2ce05..ec5e8afe77bd4 100644
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
>  			if (!client_data->hid_devices)
>  				client_data->hid_devices =3D devm_kcalloc(

[Severity: High]
This is a pre-existing issue, but could we experience a heap buffer overflow
in process_recv() if we receive a duplicate HOSTIF_DM_ENUM_DEVICES response
before initialization completes?

The payload length or count is updated unconditionally, but reallocation
is skipped if the buffer already exists:

    client_data->hid_dev_count =3D (unsigned int)*payload;
    if (!client_data->hid_devices)
        client_data->hid_devices =3D devm_kcalloc(...)

Would a subsequent response with a larger device count cause the memcpy loop
to write beyond the initially allocated bounds of client_data->hid_devices?

[Severity: Critical]
This is a pre-existing issue, but is there a missing bounds check on the
unvalidated device count provided by the firmware in process_recv()?

The firmware provides an unvalidated hid_dev_count (up to 255) during
HOSTIF_DM_ENUM_DEVICES, which the driver stores and uses as num_hid_devices.

When processing responses for GET_HID_DESCRIPTOR or GET_REPORT_DESCRIPTOR,
the driver uses curr_hid_dev to allocate and write into statically sized
arrays like client_data->hid_descr:

    client_data->hid_descr[curr_hid_dev] =3D devm_kmalloc(cl_data_to_dev(cl=
ient_data), payload_len, GFP_KERNEL);

Since these arrays are statically sized to MAX_HID_DEVICES (32), could a
device count larger than 32 result in a critical out-of-bounds write on the
client_data heap structure?

[Severity: High]
This is a pre-existing issue, but does inadequate bounds checking during
the parsing of HOSTIF_DM_ENUM_DEVICES in process_recv() allow out-of-bounds
memory reads from the receive buffer?

When processing ENUM_DEVICES, the loop validates the bounds of incoming
device_info structures using data_len instead of payload_len:

    if (1 + sizeof(struct device_info) * i >=3D data_len)
        break;

Additionally, if the offset exceeds payload_len, the code logs an error
but fails to break out of the loop:

    if (1 + sizeof(struct device_info) * i >=3D payload_len) {
        dev_err(cl_data_to_dev(client_data), ...);
    }

Can this cause the driver to read beyond the end of the current ISHTP packe=
t,
and potentially beyond the recv_buf allocation entirely when computing the
pointer for memcpy?

    dev_info =3D (struct device_info *)(payload + 1 + sizeof(struct device_=
info) * i);

[Severity: Critical]
This is a pre-existing issue, but are there integer underflow and pointer
arithmetic bugs in the HOSTIF_PUBLISH_INPUT_REPORT_LIST case of process_rec=
v()
that could allow massive out-of-bounds memory reads?

If an incoming report->size is less than sizeof(struct hostif_msg_hdr),
can payload_len underflow to a massive value?

    payload_len =3D report_len - sizeof(struct hostif_msg_hdr);

Furthermore, even without underflow, does advancing the pointer using C typ=
ed
pointer arithmetic implicitly multiply the increment by sizeof(struct repor=
t)?

    report +=3D sizeof(*report) + payload_len;

Would this advance the pointer wildly out-of-bounds, feeding garbage lengths
and pointers to hid_input_report(), potentially leading to kernel panics or
data leakage?

[Severity: High]
This is a pre-existing issue, but does the driver fail to cancel pending wo=
rk
during device removal, leading to a potential use-after-free?

The driver queues hardware reset and resume handlers on an ISHTP-wide shared
workqueue. However, hid_ishtp_cl_remove() exits without calling
cancel_work_sync() for client_data->work and client_data->resume_work:

drivers/hid/intel-ish-hid/ishtp-hid-client.c:hid_ishtp_cl_remove() {
    ...
    ishtp_hid_remove(client_data);
    hid_ishtp_cl_deinit(hid_ishtp_cl);
    ...
}

When devres frees client_data, might any concurrently running or pending wo=
rk
on the shared workqueue access the freed structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720175656.5593=
51-1-wahidzk0091@gmail.com?part=3D1
