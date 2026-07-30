Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A487262E
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415463; cv=none; b=R6ojAeQQTOfDDf/xsiDEKHKXesaprWif55Nsw8NE5Ls3ozX7NAXjn/0ImtioQLPwsPKMH6a3LYm+JfFWhMeeK5hIy+ef6XsitkCMeX8fJ0wZ7SttQZk57DzursBxIvGLmugnI+5Rp4WiCNh9J5/WfzSIDKqQSo0SmDstNJbnId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415463; c=relaxed/simple;
	bh=tiOaJ0dgfgXyR1K/MhyuAY42rExac6UvUiYH5rgfg5E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZHnknOB5cphUfJeXofWfCQ8HfqRmyvMuYSCEji9qWRmDeYp44LQBVJPIhdoBkLuQfQohDaWP2TWlzIrrWwwCPKah21uZbPV9NFM4ca+Obs2J8XVIwey6CUMdyaRIT8Kbub90aRg1XOxPcvnZI5XBHjmZdmk5yPwNcUmaB4sSeJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH8dJqKQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH8dJqKQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57A81F000E9;
	Thu, 30 Jul 2026 12:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785415462;
	bh=cvNPx3EANrBkiuYmn4Sr8NCV7sOYbKuyCwWBM4+/LkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XH8dJqKQ51w9wjK2THAivVvCCgGWtA/q7Xl4VaHNa6RQsaS1ADL7Vs6MZi4ORrmIj
	 UhoLLVGRmxtDY0IZ19CK0kV8gWvxyWIr9dj1hJnX1NhNQpp19udc+26N4046iN1C5c
	 G7q9LcM+LpSU9jfRc1KqpMn5533MgDMy2rNqgzA55XGQjV7HhijDA6mg8ORqhx3zTT
	 LzwpDQL0AVju5K99Fct+3th4qtraK5qgylIB73PNxbRczICK1hgeNH3EZKX9E5BMul
	 INP4McgqpGvhCf3pRKfP3YaMQEtnaGUiH90SHl8HtGzjWITEg90bVRaNr7gLmewGCR
	 uj1GHOafHKr9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: intel-ish-hid: clamp HID device count to
 MAX_HID_DEVICES
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shen Yongchao" <grayhat@foxmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>
References: <tencent_D20397201115F1DCF4D1798EA0BCC6A5B007@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 12:44:21 +0000
Message-Id: <20260730124421.E57A81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap buffer overflow due to missing reallocation on repeated firmw=
are enumeration.
- [High] Pointer arithmetic bug and integer underflow in HOSTIF_PUBLISH_INP=
UT_REPORT_LIST leads to massive out-of-bounds read.
- [High] Missing unregistration of HID devices on probe error path leads to=
 Use-After-Free.
- [High] Dangling ISHTP event callback on probe error leads to Use-After-Fr=
ee.
- [High] Missing cancellation of workqueues in the device remove path leads=
 to Use-After-Free.
- [Medium] Out-of-bounds read in ENUM_DEVICES due to flawed bounds check.
--

--- Patch [1]: [PATCH v2] HID: intel-ish-hid: clamp HID device count to MAX=
_HID_DEVICES ---
commit c49d3200c2984f75996b1adb9efa6e6cf870abe9
Author: Shen Yongchao <grayhat@foxmail.com>
Subject: HID: intel-ish-hid: clamp HID device count to MAX_HID_DEVICES

This patch addresses an out-of-bounds array write in the ISH HID client
driver. It clamps the reported HID device count to MAX_HID_DEVICES during
the HOSTIF_DM_ENUM_DEVICES response parsing, preventing firmware from
overwriting fixed-size arrays within the client data structure.

> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/i=
ntel-ish-hid/ishtp-hid-client.c
> index 6d64008f2ce05..6ea997932aeab 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -123,6 +123,8 @@ static void process_recv(struct ishtp_cl *hid_ishtp_c=
l, void *recv_buf,
>  				break;
>  			}
>  			client_data->hid_dev_count =3D (unsigned int)*payload;
> +			if (client_data->hid_dev_count > MAX_HID_DEVICES)
> +				client_data->hid_dev_count =3D MAX_HID_DEVICES;
>  			if (!client_data->hid_devices)
>  				client_data->hid_devices =3D devm_kcalloc(
>  						cl_data_to_dev(client_data),

[Severity: High]
This is a pre-existing issue, but does this allocation logic leave us
vulnerable if the firmware sends the HOSTIF_DM_ENUM_DEVICES packet multiple
times?

If a reset occurs or multiple packets are sent, and the new hid_dev_count is
larger than the previous one, the check for (!client_data->hid_devices) will
skip reallocation.

The loop that follows will then copy the new, larger count of devices into
the older, smaller buffer, which can corrupt adjacent heap memory.


[Severity: Medium]
This isn't a bug introduced by this patch, but is there a bounds checking
flaw in the device enumeration loop?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:process_recv() {
...
    for (i =3D 0; i < client_data->hid_dev_count; ++i) {
        ...
        if (1 + sizeof(struct device_info) * i >=3D data_len)
            break;
       =20
        dev_info =3D (struct device_info *)(payload + 1 +
                   sizeof(struct device_info) * i);
...
}

The check uses data_len (the absolute total message length) but compares it
to an offset relative to payload. Since payload is already offset by the
header size (6 bytes), this check permits reading out of bounds.

Also, it only verifies the start offset, missing the 9-byte size of the
struct itself, which can allow uninitialized ring buffer memory to leak.


[Severity: High]
This is a pre-existing issue, but can this pointer arithmetic lead to a
massive out-of-bounds read in the HOSTIF_PUBLISH_INPUT_REPORT_LIST handler?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:process_recv() {
...
    payload_len =3D report_len - sizeof(struct hostif_msg_hdr);
    ...
    report +=3D sizeof(*report) + payload_len;
...
}

If report_len is less than 6, payload_len underflows to a very large intege=
r.

Furthermore, because report is a typed pointer to struct report (which is
size 8), adding (sizeof(*report) + payload_len) multiplies that offset by 8.

This advances the pointer far past the message boundary, causing subsequent
iterations to read arbitrary memory and pass it to hid_input_report().


[Severity: High]
This isn't a bug introduced by this patch, but does the initialization path
leak HID devices on probe failure?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:hid_ishtp_cl_init() {
...
    for (i =3D 0; i < client_data->num_hid_devices; ++i) {
        ...
        rv =3D ishtp_hid_probe(i, client_data);
        if (rv) {
            dev_err(...);
            goto err_cl_disconnect;
        }
    }
...
}

If ishtp_hid_probe() fails during the loop, it returns without unregistering
the devices that succeeded in previous iterations.=20

When the probe fails, devres frees the client_data, but the leaked active
HID devices retain dangling pointers to this freed memory via their
driver_data, leading to a use-after-free when accessed.


[Severity: High]
This is a pre-existing issue, but is the event callback left dangling on
probe errors?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:hid_ishtp_cl_init() {
...
    ishtp_register_event_cb(client_data->cl_device, ish_cl_event_cb);
...
}

The callback is registered here but is not unregistered in the
err_cl_disconnect path or the hid_ishtp_cl_probe() error path.=20

If operations like ishtp_enum_enum_devices() fail, probe aborts and
client_data is freed. An incoming ISHTP message would then trigger the
registered callback, dereferencing the freed client_data and causing a
use-after-free.


[Severity: High]
This isn't a bug introduced by this patch, but are the workqueues properly
canceled during device removal?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:hid_ishtp_cl_remove() {
    struct ishtp_cl *hid_ishtp_cl =3D ishtp_get_drvdata(cl_device);
    struct ishtp_cl_data *client_data =3D ishtp_get_client_data(hid_ishtp_c=
l);
    ...
}

The remove function tears down the driver instance but omits stopping the
embedded work items (client_data->work and client_data->resume_work) via
cancel_work_sync().=20

Since client_data is devres-managed, it is freed shortly after remove()
returns. If a reset or resume event occurs concurrently, the uncanceled wor=
ks
will execute using freed memory, resulting in a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_D2039720111=
5F1DCF4D1798EA0BCC6A5B007@qq.com?part=3D1
