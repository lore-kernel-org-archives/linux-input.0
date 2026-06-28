Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5F175A69
	for <linux-input@vger.kernel.org>; Sun, 28 Jun 2026 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782665886; cv=none; b=JbzuQP534pU67teEi4Qf77B0jr8NDci0gw8BDx3NbyT5rB6LXXw2UmI1AxKxWSgLAOEaDsKJv7MGpmVwhphD0JZvFiMPORfni9aFvral1chbfB5xNuswn/csOA8Wd0yeCpmoa4BnI4e485j4VFx+Lki5AGAX3QnsUL7dS08j528=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782665886; c=relaxed/simple;
	bh=X/jRZxKjgyKFvOvzEpyhkAJIV+nfC57me6QeROEJ+1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u1oq+dqVZxvpHmTxwI/cGMYNtvSBjYDh4zp7tY+uRU30zn4028vAnH49wiOjB4hsptmziUhRbB1mj3+zaIccM3n+WO+8qZYv5jxkWqvlgLtPiI09svRf7EQbZYXc95Jiw4OoF8hgKgXcxrumSpwzANGgpNVb9dIs8QJzIBdwMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqMCXiBT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqMCXiBT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452451F000E9;
	Sun, 28 Jun 2026 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782665885;
	bh=t4p5ZV9jffmkBMNL3jI6Ke/6R/oFdMSWr3rjF7ni8F8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AqMCXiBTwYZDtG58SLmbwA6iqrZ3lJ66iUVvirSxdcwyiQVjvXN4CyBCXTdg+wYgG
	 oJt5i5Klb6b9IpCp5k+hM7KgtDNaoGLvSsoCdP2JEVWBcp2X/CaFAyRNoQdp7lRU+2
	 XOX46heG580hjd+BYQYERR53NLr3lm/iTHElhRRKZMaA3E1AFbcwVNGr3yeJQPb4TI
	 /VKM/UynLtkry42cZ140V1u3kTPSXmvjNJbiTkd3OnNNlQYZ1tmymB7V55E66nROto
	 Gp2zdquVx1P4+c8q1LnlCn3GjnRsAG8fz6ZmbGwJXLQuDdwBfHPA8gFXdQhGyr3j8Q
	 hrkWTQl1ddRdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] HID: roccat-kovaplus: reject short button reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260628164611.17467-4-alhouseenyousef@gmail.com>
References: <20260628164611.17467-1-alhouseenyousef@gmail.com>
 <20260628164611.17467-4-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 16:58:03 +0000
Message-Id: <20260628165805.452451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check in savu_raw_event allows out-of-bounds read a=
nd kernel memory leak
--

commit e1ed8982777cb731a4bf22c7e12d12c6c15620cc
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

HID: roccat-kovaplus: reject short button reports

The Kovaplus raw-event helpers cast button reports to a five-byte
structure and read all payload fields without checking the received size.
A malformed USB device can therefore trigger out-of-bounds reads from a
short input report.

> The Kovaplus raw-event helpers cast button reports to a five-byte
> structure and read all payload fields without checking the received size.
> A malformed USB device can therefore trigger out-of-bounds reads from a
> short input report.

[Severity: High]
This isn't a bug introduced by this patch, but it looks like the exact same
vulnerability exists in the savu driver.

While missing checks in several other roccat drivers (koneplus, isku, pyra,
konepure, ryos) were addressed in this series, it appears the savu driver
was missed.

In drivers/hid/hid-roccat-savu.c:savu_raw_event():

	if (savu->roccat_claimed)
		savu_report_to_chrdev(savu, data);

This calls savu_report_to_chrdev() without validating that size is sufficie=
nt
for struct savu_mouse_report_special.

Could a malicious physical USB device send a short HID report with size < 5
and data[0] =3D=3D SAVU_MOUSE_REPORT_NUMBER_SPECIAL to trigger an out-of-bo=
unds
read and expose uninitialized bytes from the HID transfer buffer to
userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628164611.1746=
7-1-alhouseenyousef@gmail.com?part=3D4
