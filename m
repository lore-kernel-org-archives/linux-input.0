Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402C41A547
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359853; cv=none; b=dodc0EZ+mURV9EeVnTJL2xr6T3Cuo03zKzZAtRBvyG+Eh48AkyzLuBw+ybam1UTsncqrD7XHgVYwmMlUkR08Wor2rR6rEkBEViB+Xr/Y6TKryIDUPWf2L9MxM8JEOfiNQdCYU02Hbug46QQR6OjJe67CnvovKBL1jTw6WN5HHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359853; c=relaxed/simple;
	bh=tWxng+OpI6vtcpYIZrzY5hW0zPHSrVOv8yMttwg9nPI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Zekw4eN2FmVcy35sBqpcdw0+RFSyK8A2kZ+TjOl1CvSQS+FqHQFJwZrGAf27R4s6jOuLHQ5MlekJsbPspKbCcgGmy+db2Pl/zkOACCNJP73E5SyIOCssn+Jet5Dy3QB5PInOTKE7xnfiFWa9a/IxH9bvo+tCrKQdykq3RyntSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW4QovWV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW4QovWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DAE1F000C4;
	Sun, 18 Oct 2026 21:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792359851;
	bh=bK1O/8Kst/rgAs1aNWqjWoPELvkG2XkW6IVMYb417k8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cW4QovWVgg1D9kSxACD5teD0R7E8ntSgDKdBt8V7GqMqRV1YRAxCh6AYf8qN3VgMp
	 4V19oULHEtID6L45RgxLy21j+7cxDZL9UHs4LrG1AbqxY6MPl9Utc7/sSQoOZf6wJD
	 jvdIH6znxAQHLc/A77CTa67n9dxWjxS7aNvwVwcTiLHYQ9ERwtMmMtKdubU/C1xAfC
	 sV3q0x/tRSDllTPc7cjPadOY3Grup9bbSyzRvvQkWD22yeWJbZRBvYnmLGEDpnxmCS
	 CO9a3v+GJdnU7N9zpRULDjdDSomQvKNLry5NBD3aKOqFHkf/5BDSUw+amUlob6pxkn
	 ucUJ3+oNvLusg==
Message-ID: <sashiko-outbox-176410@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] HID: prodikeys: validate report size in raw_event
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261018213754.1951187-9-tristmd@gmail.com>
References: <20261018213754.1951187-1-tristmd@gmail.com>
 <20261018213754.1951187-9-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 21:44:11 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] HID: prodikeys: pk_raw_event() drops 3-byte report 0x03 MIDI pac=
kets
--

commit 2a171eaec1ee7f4c5cfc52b5bb2b8e59c517ae46
Author: Tristan Madani <tristan@talencesecurity.com>

HID: prodikeys: validate report size in raw_event callback

This patch adds a minimum report size check at the beginning of
pk_raw_event() to prevent out-of-bounds reads on short reports.

> diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
> index fba01e4fcab1c..c1419e6703777 100644
> --- a/drivers/hid/hid-prodikeys.c
> +++ b/drivers/hid/hid-prodikeys.c
> @@ -768,6 +768,9 @@ static int pk_raw_event(struct hid_device *hdev, stru=
ct hid_report *report,
>  	struct pcmidi_snd *pm =3D hid_get_drvdata(hdev);
>  	int ret =3D 0;
> =20
> +	if (size < 4)
> +		return 0;
> +
>  	if (1 =3D=3D pm->ifnum) {
>  		if (report->id =3D=3D data[0])
>  			switch (report->id) {

[Severity: Medium]
Could checking size < 4 before inspecting report->id drop valid 3-byte
packets for report 0x03?

In drivers/hid/hid-prodikeys.c, pk_raw_event() calls pcmidi_handle_report(),
which dispatches three report IDs:

	switch (report_id) {
	case 0x01: /* midi keys (qwerty)*/
		ret =3D pcmidi_handle_report1(pm, data);
		break;
	case 0x03: /* midi keyboard (musical)*/
		ret =3D pcmidi_handle_report3(pm, data, size);
		break;
	case 0x04: /* multimedia/midi keys (qwerty)*/
		ret =3D pcmidi_handle_report4(pm, data);
		break;
	}

While pcmidi_handle_report1() and pcmidi_handle_report4() unconditionally
read a 24-bit bitmask from data[1..3] and require size >=3D 4,
pcmidi_handle_report3() computes the number of note/velocity pairs from
size:

	unsigned num_notes =3D (size-1)/2;
	for (j =3D 0; j < num_notes; j++)	{
		note =3D data[j*2+1];
		velocity =3D data[j*2+2];

A single-note report 0x03 has a 1-byte report ID followed by one 2-byte
note/velocity pair (size =3D=3D 3), which pcmidi_handle_report3() already b=
ounds
checks via num_notes.

Should the size < 4 check be restricted to reports 0x01 and 0x04 so that
3-byte report 0x03 MIDI events are not lost?

>
>
>

[]=E2=96=B7

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018213754.1951=
187-1-tristmd@gmail.com?part=3D8
