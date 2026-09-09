Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595B62D2381
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917412; cv=none; b=PJlWS+65tiShjFjNzEGZt2wkcbqlul6AQW/oHsxOUODd4xCKW86YnmeALh7BDmlosYL0GOCHy5KUblTm2ILXDmSlELFpmrxCAWoJJ2+H1SXLlNB8RYcdtn8SPTQA3FQKBhuale0MOkybRu9yzN0jEG4WWLwt/tL4UBdZWhlOOW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917412; c=relaxed/simple;
	bh=mJrGMS4TA2q3L/O3jvmZMWqpd7PZFbUFCdZAMUfnIjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bdJmc3vKtCBk+CfIAh74mClq1Zk4fejJmzPamglevi1qJ9ij9IXts75vUssh0N3ctnQg9YYvlC/kPYaoqz3kKVCgZexzHhLbgewU7S+rvAYA7v2X7GDyqMY6Cl8waCD++hG4WN5OvBhe14o63Nh07dqfdmVXeGTeCwWSpZP2nKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0SXwqsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0SXwqsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3C51F00A3A;
	Wed,  9 Sep 2026 01:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917410;
	bh=gBQFcoJe5WikHBT16kOM5FTVMCl0Jl2HWfxSYmz5n1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V0SXwqsuHrR9K2O1eqY3JBXlW1MVGghuM4PmaD4CjwXTtVv2Ny/1/+ByWOaCWuyz7
	 O+bYgQNsfh5mkeB3GCFV5QTo3OCeXzlfc/qXyuO1OQMF2cy0v0AYSrFbn6iFmKilbS
	 KjfHA8cpoXjZAKKCFGEC3H9hTuC8wa8A9uSUodyBv78X6khDSWCGOiXU32rRmm6uJb
	 p8+OQysoxgSSjuqRf3OaIxvffoKxHuSFQkSUmT2tMnWBeh82q2wJKMPu+C8F1IwSEH
	 K4r+MzoSgncy2MQC1+5eFFNF/fJyCIYNm91pQpOFGdw7/ssWii7z+p+MrPvRMrXAwT
	 NObrfbfvNg69Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] HID: wacom: fix OOB read in
 wacom_wac_pen_serial_enforce()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Jie LAW" <98lawweijie@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260909011515.2314-1-98lawweijie@gmail.com>
References: <20260828033323.82958-1-98lawweijie@gmail.com>
 <CANRwn3RFVDy+y-fpLkb1mfjiKyQgp1Jg0tyBTO+G0xem2s1jkQ@mail.gmail.com>
 <20260909011515.2314-1-98lawweijie@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 01:30:10 +0000
Message-Id: <20260909013010.AA3C51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free in wacom_parse_and_register() error path
- [High] Race condition leading to Use-After-Free during concurrent unbind
--

commit 63c430d20632598184f0ad0353c6bd9e43f51d20
Author: Wei Jie LAW <98lawweijie@gmail.com>
HID: wacom: fix OOB read in wacom_wac_pen_serial_enforce()

This commit fixes an out-of-bounds read in wacom_wac_pen_serial_enforce()
by clamping the usage loop to field->report_count instead of maxusage.
This prevents calculating an offset beyond the end of the report, which
could otherwise lead to an information disclosure.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 0eafa483b7f75..40770affdbdee 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -113,8 +113,9 @@ static int wacom_wac_pen_serial_enforce(struct hid_de=
vice *hdev,
> =20
>  	/* Queue events which have invalid tool type or serial number */
>  	for (i =3D 0; i < report->maxfield; i++) {
> -		for (j =3D 0; j < report->field[i]->maxusage; j++) {
> -			struct hid_field *field =3D report->field[i];
> +		struct hid_field *field =3D report->field[i];
> +
> +		for (j =3D 0; j < field->report_count; j++) {
>  			struct hid_usage *usage =3D &field->usage[j];
>  			unsigned int equivalent_usage =3D wacom_equivalent_usage(usage->hid);
>  			unsigned int offset;

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free in the
wacom_parse_and_register() error path?

If hid_hw_open() fails for a WL_MONITOR device:

drivers/hid/wacom_sys.c:wacom_parse_and_register() {
    ...
	if (!wireless) {
		/* Note that if query fails it is not a hard failure */
		wacom_query_tablet_data(wacom);
	}
    ...
	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
		error =3D hid_hw_open(hdev);
		if (error) {
			hid_err(hdev, "hw open failed\n");
			goto fail_hw_stop;
		}
	}
    ...
fail_hw_stop:
	hid_hw_stop(hdev);
fail:
	wacom_release_resources(wacom);
	return error;
}

The init_work is scheduled by wacom_query_tablet_data(), but the error
path for hid_hw_open() fails to cancel it. When the probe function returns
an error, the driver core releases devres resources and frees the wacom
structure. Will the pending work access the freed structure if it
executes later?

[Severity: High]
This is a pre-existing issue, but is there a race condition leading to a
use-after-free during concurrent unbind in wacom_mode_change_work()?

drivers/hid/wacom_sys.c:wacom_mode_change_work() {
    ...
	if (shared->pen) {
		wacom1 =3D hid_get_drvdata(shared->pen);
		wacom_release_resources(wacom1);
		hid_hw_stop(wacom1->hdev);
    ...
	}

	if (shared->touch) {
		wacom2 =3D hid_get_drvdata(shared->touch);
		wacom_release_resources(wacom2);
		hid_hw_stop(wacom2->hdev);
    ...
}

If mode_change_work runs on one interface (e.g. pen) while the sibling
interface (e.g. touch) is concurrently unbound, it reads shared->touch
locklessly and retrieves the sibling's wacom struct.

If this thread is preempted and the sibling finishes unbinding, devres will
free its wacom struct. When mode_change_work resumes and calls
wacom_release_resources() on the freed structure, could this result in a
use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909011515.2314=
-1-98lawweijie@gmail.com?part=3D1
