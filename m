Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF8385D61
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 21:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841036; cv=none; b=PdfAkGccrhMSQoBz/V0M3FeIibhG3ahqxFtg+qbYKcXvYJgKim5vA1gPhA9RL+pE/QRAJ+b4e1cIsXJ2aS06xb60Hk67fIrY2ENat62t0P2SAsPqEjEt/A/wLh2/JKvDJ7b4GoKtU1khOIefmSONOoFYx5uN1rYoFyhuwFvFLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841036; c=relaxed/simple;
	bh=7be+ct5aq+8FtJuVMPuOVoji6Y49r6QUec6o6jyC1R0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SNoOk9RrJcCD8cmMlckWaV0d4yBYKtwY3LVTTNVrFAFyuE1a754rJWk/O8r0P48vAsWxqrDK06OHnSgom2vWGcWjG+om5TFjoKOhAdKarl+LpB+TybV+UAArlZT67UFHFEp+6mCIM92kZRV+1kfqsriQKc0lKd3+bzRTrL5FVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftWvSqI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftWvSqI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825A81F0089B;
	Mon, 12 Oct 2026 21:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791841034;
	bh=ZVvreuwP/NgSUK4D3IicmQUKhNsMAFQ+lgzxJi7vgVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ftWvSqI3+eLNyJrj+4hphuoJVIOahrflYB7QA9XkUHo34omSO5l+1fFQ7FIv6oNO8
	 YVKlULhle/EFZIfLQdM9MohEyNWYIasXaqP0IIXcJewzPL9Av6S7SsZXh3P/tEsQPU
	 OJFRsMpkJI7UhnA+7GBY3Q869S6iPGZKzxSKxMJMECdCdNk4dKRogVkbz9afuLr76p
	 TUWfWlx7MC73A4C2KA570Ta24liotjL460qZqjIYUpZzbFruX8LBFbzAmcDl6MjffF
	 49/u5sEW1YrWzexHKyY28gIiTHbaQ9I6Br5qTt6DTJfJ/aslVJSHVjOdZAP3eByNtJ
	 9VcYWadx2AhxA==
Message-ID: <sashiko-outbox-168627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: vivaldi: avoid redundant feature report reads per
 usage
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhengping Jiang" <jiangzp@google.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261012212902.3491839-1-jiangzp@google.com>
References: <20261012212902.3491839-1-jiangzp@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 21:37:14 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] hid: feature report fetch bypassed if usage_index =3D=3D 0 fails=
 early validation
--

commit 31203c2d78508ee9933c6f629cd9827611acfce0
Author: Zhengping Jiang <jiangzp@google.com>

HID: vivaldi: avoid redundant feature report reads per usage

This commit optimizes the vivaldi_feature_mapping() initialization loop by
fetching the hardware feature report only on the first usage. Subsequent
usages in the same field skip the hardware read and reuse the previously
fetched field values.

> diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-c=
ommon.c
> index b12bb5cc091aa..69df3a64eb91a 100644
> --- a/drivers/hid/hid-vivaldi-common.c
> +++ b/drivers/hid/hid-vivaldi-common.c
> @@ -49,6 +49,12 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
>  	if (fn_key > data->num_function_row_keys)
>  		data->num_function_row_keys =3D fn_key;
> =20
> +	if (usage->usage_index) {
> +		data->function_row_physmap[fn_key - MIN_FN_ROW_KEY] =3D
> +			field->value[usage->usage_index];
> +		return;
> +	}
> +

[Severity: Medium]
Does this fast-path correctly handle cases where the first usage in the
field is bypassed by early validation checks?

Looking at the start of vivaldi_feature_mapping(), there are early returns
for non-ordinal pages and out-of-bounds fn_key values:

void vivaldi_feature_mapping(...)
{
	...
	if (field->logical !=3D HID_USAGE_FN_ROW_PHYSMAP ||
	    (usage->hid & HID_USAGE_PAGE) !=3D HID_UP_ORDINAL)
		return;

	fn_key =3D usage->hid & HID_USAGE;
	if (fn_key < MIN_FN_ROW_KEY || fn_key > MAX_FN_ROW_KEY)
		return;

If the usage at usage_index =3D=3D 0 triggers one of these early returns, t=
he
hardware fetch at the end of the function is bypassed.

When the loop processes a valid subsequent usage, such as usage_index =3D=
=3D 1,
it will hit this new fast-path. Because the hardware fetch was never
performed, will this copy the initial zeroed memory from field->value into
the physical map and misconfigure the function keys?

>  	report_data =3D buf =3D hid_alloc_report_buf(report, GFP_KERNEL);
>  	if (!report_data)
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012212902.3491=
839-1-jiangzp@google.com?part=3D1
