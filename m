Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1324379EF5
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 06:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787551305; cv=none; b=bbPF3nZPpBq8DT2TtH9ooa6UubCz/Kucm+5yKRTwQiqOni6EdH0T93JedZYlsA3hEM3AesCq48+wIgfuLu0uUAbdyY0Ndh293O1pFbq6Gak8D+vuYXPNibeHGzmNEyCqX+KYk6Gg+6guak2Fzaw3rS8XE0ihnnahcLPYNrvT0vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787551305; c=relaxed/simple;
	bh=wookvDwII7nSeqXzAvMzi7G7Ko7B6sdYuOF1mzsZ8WI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jtpI0JjXYra5JpF6mS0ISTdmp6sHkgYXY+8IIUvCbAQAQ3Fqer1ndXS9eADZuVCsejREp+fD8u2ZipvJnj+owS74w92Os4i+/Dvgfw6pV3A57RacpA0kPKWOkkhV8uiNlmwCleupsFwvfx+ER2TxMzM0lPCORMqBD56iODFiZR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCpxvQsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCpxvQsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CCB1F000E9;
	Mon, 24 Aug 2026 06:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787551304;
	bh=8pya1PmlWOP5zkCEkClpnKaPGZoNvdI7ZQddyVtL5uc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mCpxvQsIOM/dTE5n+htoyTTNK5T+2MGYRzIKzsi19UuY4cDOxZZXcEKBGUSZAguHl
	 3xHr3r2klDPS8NolTsDPn/w0GwKyxshO8V3xXrg5XuhC0Mj4Ksg0iNAhMG5WPjyeb+
	 VEqH9SWx1VQvJlgFexsqSoVXSTZAz3s6hQr/8nFaQrTDmPjqrq3oR6h8K/M1QhHBQk
	 Z98m5zCEoWFZRisy5sP5iGoeXNFbf+bG0EOcVMVo7fbuWG5bkanRC4P+96ffQ4bXm0
	 c/Qm2/v83PAOzxZV9M8Xcz9oY32kQutOJtfG0REaK7PuJ0L98BP3pEgldryDS++WgG
	 H4FWlzHAcOyjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: rmi: fix OOB access with undersized RMI reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie Law" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com>
References: <00a489f38b240624dcb5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 06:01:43 +0000
Message-Id: <20260824060144.17CCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The device's read state machine becomes permanently poisoned becau=
se the new zero-length reply error path leaks the `RMI_READ_DATA_PENDING` f=
lag.

Pre-existing issues:
- [High] Use-After-Free occurs because `reset_work` can execute after `rmi_=
data` is freed, due to improper cleanup ordering in `rmi_remove()` and miss=
ing cancellation in the `probe()` error path.
- [High] Subsystem guide violation: `rmi_report()` accesses report fields b=
y index without validating the field count first.
- [Medium] Data corruption can occur because `hdata->readReport` is modifie=
d concurrently by the IRQ handler while being read by the process context.
--

--- Patch [1]: [PATCH v2] HID: rmi: fix OOB access with undersized RMI repo=
rts ---
commit 08dac6ce9a3b8c9a54acc37d7e783d9b9cfd4864
Author: Wei Jie Law <98lawweijie@gmail.com>

HID: rmi: fix OOB access with undersized RMI reports

This commit addresses out-of-bounds read and write accesses in the hid-rmi
driver caused by undersized RMI reports. It introduces size validation duri=
ng
probe and clamps read/write lengths to the device-declared sizes. It also
treats zero-length read replies as errors to prevent an infinite loop.

Link: https://lore.kernel.org/linux-input/20260822121007.153988-1-98lawweij=
ie@gmail.com/
Fixes: 9fb6bf02e3ad ("HID: rmi: introduce RMI driver for Synaptics touchpad=
s")
Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
> --- a/drivers/hid/hid-rmi.c
> +++ b/drivers/hid/hid-rmi.c
> @@ -235,7 +235,22 @@ static int rmi_hid_read_block(struct rmi_transport_d=
ev *xport, u16 addr,
>  				break;
>  			}
> =20
> -			read_input_count =3D data->readReport[1];
> +			read_input_count =3D min_t(int, data->readReport[1],
> +						 data->input_report_size - 2);
> +			if (!read_input_count) {
> +				/*
> +				 * A zero length reply advances neither
> +				 * bytes_read nor bytes_needed, and because a
> +				 * reply did arrive the wait above does not
> +				 * time out either, so a device answering 0
> +				 * forever would spin here indefinitely with
> +				 * page_mutex held.
> +				 */
> +				hid_warn(hdev, "%s: zero-length read reply\n",
> +					 __func__);
> +				ret =3D -EIO;
> +				break;
> +			}

[Severity: High]
If a zero-length reply is received and we break here, does this bypass the
clear_bit(RMI_READ_DATA_PENDING, &data->flags) at the end of the loop? It
looks like leaving this flag set might permanently poison the state machine,
causing subsequent loops or calls to rmi_hid_read_block() to pass the wait
condition immediately and fail with -EIO.

>  			memcpy(buf + bytes_read, &data->readReport[2],
>  				min(read_input_count, bytes_needed));

[Severity: Medium]
This is a pre-existing issue, but could this memcpy race with the IRQ
handler? While rmi_hid_read_block() is reading from data->readReport,
rmi_read_data_event() might concurrently overwrite hdata->readReport if an
unsolicited report arrives, potentially leading to corrupted register reads.

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but can a use-after-free occur
during device removal? In rmi_remove(), the work is cancelled before hardwa=
re
events are stopped:

	cancel_work_sync(&hdata->reset_work);
	rmi_unregister_transport_device(&hdata->xport);
}
hid_hw_stop(hdev);

Because hid_hw_stop() is called after cancel_work_sync(), incoming events
can still arrive after the work is cancelled. If rmi_event() queues the work
again via schedule_work(&data->reset_work), could it execute after devres
frees the rmi_data structure? Additionally, if hid_hw_start() fails in
rmi_probe(), it appears to return without cancelling the work.

[Severity: High]
This is a pre-existing issue, but does rmi_report() lack report field
validation?

	struct hid_field *field =3D report->field[0];

The HID subsystem guidelines state that accessing report fields by index
without first checking that report->maxfield is at least 1 can lead to
out-of-bounds accesses with crafted descriptors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/00a489f38b240624dcb=
5a4bae36a53fcba9cfb47.1787549195.git.98lawweijie@gmail.com?part=3D1
