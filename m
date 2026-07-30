Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE9A433BD3
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417480; cv=none; b=V0EAvvY8/qp6i6VGPAxkMyIKgvAvwwa6ZWACgoGRS3HYnaJjF/QXtdHr0pxdfQc5vI9VGzD4ywZqh7YZ/CjlOodhvLnUu1oYUhPvNKeqb26m3pYmUy6w49udOuWUwYPxUyxTMnMZlK009squIjQsJq+SiwZtj9CXqvv5/EPUIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417480; c=relaxed/simple;
	bh=jKWtPJaJNA4cwJMqn70fNYmgRRXlPq59FUq/rzk2YQM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DzT8PVI/aAK8UhOx4/yMjAJ7ZmMS9i3cehoAwTZn737Xm0mDIeI1W+zLmcl5jWUsHdng7QEfACxKsWmUOAwbKkBMCmvvfTGUHlKYW/zzeFW3VEfBKbi3Ykihk3UCmFuJANDu4ieeQ3861pqK3CCjwkhPAmsPMSU+NfP8pAhHQM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvfJtELi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvfJtELi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D05A1F00A3D;
	Thu, 30 Jul 2026 13:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785417470;
	bh=nQeiSuP6YAJ/9TRivWgozlhhjppvQnZgvjxudHH2NUY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvfJtELi/MGd7KvzpxVY4vu9+WSZb6/My1g485GYrUE8irvASqIo0lce/5ABjLso1
	 hHD0c7M9X6iAG6HqT321gBSMycJuqu7MGlqdgPkyEQuNhvfpmwFX9agWcT3wVvLu85
	 Q9CJ7lvvGTBD75HYY9lL0I/yY5qEJoNB+BbPZhXBwyqBRQLpwk85xj1rfAqsR0G5Nw
	 GzFw1NtpLO3qQYGfVOhzjYmqhCe+HKAXZRDPykMLz2nh47cGSjyf+W1x/90/5y8dzD
	 sUN1TK7CZEw7xCKpySVGs5plHTcb4/cfizof6nfOyKkTd3PHAoV6h3cfCjrpEs0lF4
	 xLgSGIRRz7hmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] HID: intel-ish-hid: fix report_list iterator
 pointer arithmetic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shen Yongchao" <grayhat@foxmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_F203F6206515915C81D1210ECEBCBCA5D707@qq.com>
References: <tencent_F203F6206515915C81D1210ECEBCBCA5D707@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:17:49 +0000
Message-Id: <20260730131750.3D05A1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation of `hid_dev_count` against `MAX_HID_DEVICES` al=
lows firmware to trigger out-of-bounds array accesses.
- [High] Missing boundary checks when iterating over aggregated reports in =
`HOSTIF_PUBLISH_INPUT_REPORT_LIST`.
- [High] Integer underflow when calculating `payload_len` in `HOSTIF_PUBLIS=
H_INPUT_REPORT_LIST`.
- [High] Insufficient bounds checking when parsing `device_info` structures=
 in `HOSTIF_DM_ENUM_DEVICES`.
- [High] The inner loop handling HOSTIF_PUBLISH_INPUT_REPORT_LIST overwrite=
s the outer loop's control variables, causing parser desynchronization.
- [High] Missing cancellation of asynchronous background works on device re=
moval leads to Use-After-Free.
- [High] Missing buffer reallocation during hardware reset allows out-of-bo=
unds writes if device attributes expand.
--

--- Patch [1]: [PATCH v2 1/4] HID: intel-ish-hid: fix report_list iterator =
pointer arithmetic ---
commit 57fdd01a4139a53de9833b822824ccfd37902302
Author: Shen Yongchao <grayhat@foxmail.com>

HID: intel-ish-hid: fix report_list iterator pointer arithmetic

This commit fixes an issue where the report iterator pointer was being=20
advanced by a multiple of the struct size rather than bytes. It introduces=
=20
a u8 *pos iterator to correctly compute the pointer arithmetic in bytes.

> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/i=
ntel-ish-hid/ishtp-hid-client.c
> index 6d64008f2ce05..ba52e185ce051 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
[ ... ]
> @@ -280,9 +281,10 @@ static void process_recv(struct ishtp_cl *hid_ishtp_=
cl, void *recv_buf,
>  		case HOSTIF_PUBLISH_INPUT_REPORT_LIST:
>  			report_type =3D HID_INPUT_REPORT;
>  			reports_list =3D (struct report_list *)payload;
> -			report =3D reports_list->reports;
> +			pos =3D (u8 *)reports_list->reports;
> =20
>  			for (j =3D 0; j < reports_list->num_of_reports; j++) {

[Severity: High]
This is a pre-existing issue, but does this loop lack boundary checks?

If the firmware sends malformed packets in HOSTIF_PUBLISH_INPUT_REPORT_LIST,
could we iterate past the end of the containing message or network buffer?
There don't appear to be bounds checks on pos and the sub-report payloads.

> +				report =3D (struct report *)pos;
>  				recv_msg =3D container_of(&report->msg,
>  							struct hostif_msg, hdr);
>  				report_len =3D report->size;

[Severity: High]
This is a pre-existing issue, but can this lead to an integer underflow?

When calculating payload_len:

    payload_len =3D report_len - sizeof(struct hostif_msg_hdr);

If a sub-report is sent with report->size less than=20
sizeof(struct hostif_msg_hdr), will this underflow the size_t variable to a
huge value, which is then passed to hid_input_report() and used to advance=
=20
the pos pointer?

[Severity: High]
This is a pre-existing issue, but does the inner loop overwrite the outer
loop's control variables?

The inner loop modifies payload and payload_len:

    payload =3D recv_msg->payload;
    payload_len =3D report_len - sizeof(struct hostif_msg_hdr);
   =20
Once this switch statement finishes, the outer loop uses payload_len to=20
advance cur_pos:

    msg_len =3D payload_len + sizeof(struct hostif_msg);
    if (!cur_pos && cur_pos + msg_len < total_len)
        ++client_data->multi_packet_cnt;

    cur_pos +=3D msg_len;

Could the corrupted payload_len (now the size of the last sub-report instead
of the aggregate list) cause parser desynchronization and out-of-bounds rea=
ds
on the next iteration?

> @@ -303,7 +305,7 @@ static void process_recv(struct ishtp_cl *hid_ishtp_c=
l, void *recv_buf,
>  						0);
>  					}
> =20
> -				report +=3D sizeof(*report) + payload_len;
> +				pos +=3D sizeof(struct report) + payload_len;
>  			}
>  			break;
>  		default:

While reviewing this, I also noticed a few other pre-existing issues in=20
this driver.

[Severity: High]
This is a pre-existing issue, but is there missing validation of=20
hid_dev_count against MAX_HID_DEVICES?

In process_recv() during HOSTIF_DM_ENUM_DEVICES:

    client_data->hid_dev_count =3D (unsigned int)*payload;

If the firmware sends a count greater than MAX_HID_DEVICES, the driver=20
directly assigns this without validation. Could subsequent loops use this t=
o=20
access fixed-size arrays like hid_descr and report_descr out of bounds,=20
corrupting memory?

[Severity: High]
This is a pre-existing issue, but does this allocation logic miss buffer
reallocation during a hardware reset?

During enumeration:

    if (!client_data->hid_devices)
        client_data->hid_devices =3D devm_kcalloc(...);

And later:

    for (i =3D 0; i < client_data->hid_dev_count; ++i) {

If a hardware reset occurs and hid_ishtp_cl_reset_handler() retriggers
enumeration, the check bypasses reallocation. If the firmware returns a=20
larger hid_dev_count after reset, could the loop write device info past=20
the end of the existing heap buffer?

[Severity: High]
This is a pre-existing issue, but is the boundary check sufficient when=20
parsing device_info structures?

In the same ENUM_DEVICES loop:

    if (1 + sizeof(struct device_info) * i >=3D data_len)
        break;

This compares an offset relative to payload (which is already past the head=
er)
against the total data_len. It also only checks the start offset of the str=
uct
rather than the end. Could this allow memcpy to read up to=20
sizeof(struct device_info) + sizeof(struct hostif_msg_hdr) - 1 bytes past=20
the actual recv_buf?

[Severity: High]
This is a pre-existing issue, but does hid_ishtp_cl_remove() need to=20
cancel background works?

drivers/hid/intel-ish-hid/ishtp-hid-client.c:hid_ishtp_cl_remove() {
    ...
    ishtp_cl_driver_unregister(&hid_ishtp_cl_driver);
    ...
}

This teardown function unregisters the driver but does not call
cancel_work_sync() for client_data->work or client_data->resume_work. Since=
=20
client_data is allocated with devm_kzalloc(), it is automatically freed whe=
n=20
remove returns. If a reset or resume work is executing or queued concurrent=
ly,=20
could this lead to a Use-After-Free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730115600.2181=
72-1-grayhat@foxmail.com?part=3D1
