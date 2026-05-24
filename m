Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7690AE555
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779633084; cv=none; b=A0f1eAhS6wqIqGy+ILI0pg5Eqb+X6jw7CdHiIikg7eomx+5/hUt7PHHaH9nFN47Gps37JQ7TkWAXSt+/yJByIRHQD1KvvTIYrCwYWf6KUCJpDNJk+D5k7PhIpshQEj709qtOB8sp8rpYrst7eGekF+c9KkWqKpASrytF5EgzZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779633084; c=relaxed/simple;
	bh=8XDBEhfjd74RMoUnZY4UQvKzD7kYU9J1/FOdMGfVtv8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P45aj9gEdWs7+I+nCMYP6nLXYrPdogeYvl+zJeZN+cAkP0mLrIJAUskc81OYBI5OakGeph7n0TwZaUnOLjCd1fgm+NwPp/7Et1MY+mXXcbbKKXr2L62T1JSnHmOJ0E4VgU5E4GjbJwmD9OJibhJ7BCxZuOL/jZFldzRRCekCUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoPQ+jjc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoPQ+jjc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5A01F000E9;
	Sun, 24 May 2026 14:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779633082;
	bh=uo2f8wvJ3WDxSZyPX7WeWVumm7kDm2QPePNODYpBRjA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GoPQ+jjc4MuKS2tk8Li4LUIYtP0R4JKpkd1PdMvLGjQDaL/1aHd3e//KBYfpcevXT
	 5G28R+uaKnyPMGTS41Pige6oLtP7Txm7HD3BE2KHf/Vn8sORy6aGkWSj7BlqiorJB/
	 sszpgun3k9JPWlDaR/VC7aSvTaSYvjT7rf4hGz5m7N8JKigIehZ0hWS3yFHvgGeIVy
	 pu7zql8JwrTuW66PQgou00cISyMuTp5yYb9tiEHjLCnVZ+xPNE0A7WOVteYgfwQwwH
	 UzboBBEC055qyt2Vrg/hdxPGbjX5Rfsu0oEFXUd1Ce7AcFvEtPdQnI1entBaJpYDV0
	 iRrxaSpSapmrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: validate report size before kfifo
 insert
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinmo Yang" <jinmo44.yang@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260524135203.1996265-2-jinmo44.yang@gmail.com>
References: <20260524135203.1996265-2-jinmo44.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 14:31:21 +0000
Message-Id: <20260524143122.8D5A01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] Incomplete vulnerability fix / off-by-two error allowing kfifo=
 state corruption and massive out-of-bounds slab read.

Pre-existing issues:
- [High] Sleeping in atomic context due to kzalloc(GFP_KERNEL) in wacom_wac=
_queue_flush().
--

commit 077dd88850a2e1126c613aafa226a5f028a98bb9
Author: Jinmo Yang <jinmo44.yang@gmail.com>

HID: wacom: validate report size before kfifo insert

This commit adds a check in wacom_wac_queue_insert() to reject reports
that exceed the total kfifo capacity. This aims to prevent oversized
reports from causing out-of-bounds writes during kfifo insertion.

> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index a32320b351e3e..cc82c6f36901a 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -54,6 +54,12 @@ static void wacom_wac_queue_insert(struct hid_device *=
hdev,
>  {
>  	bool warned =3D false;
> =20
> +	if (size > kfifo_size(fifo)) {

[Severity: Critical]
Does this validation correctly account for the record header overhead?

Since the driver uses a record-based kfifo (kfifo_rec_ptr_2), each inserted=
=20
record is prefixed with a 2-byte length header. This means the maximum=20
available payload space in an empty kfifo is kfifo_size(fifo) - 2.

If an attacker sends a report with a size exactly equal to kfifo_size(fifo)=
=20
or kfifo_size(fifo) - 1, this check falsely passes.

> +		hid_warn(hdev, "%s: report too large (%d > %u) for kfifo\n",
> +			 __func__, size, kfifo_size(fifo));
> +		return;
> +	}
> +
>  	while (kfifo_avail(fifo) < size) {

If the payload requires more space than the empty kfifo can provide,=20
the kfifo_avail() check will be smaller than size, and the loop will=20
execute on an empty buffer:

>  		if (!warned)
>  			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __f=
unc__);
>  		warned =3D true;
> =20
>  		kfifo_skip(fifo);
>  	}

Could calling kfifo_skip() on an empty kfifo underflow the internal=20
pointers and corrupt the ring buffer's state?=20

If this allows the subsequent kfifo_in() to write an oversized payload=20
and overwrite the 2-byte record header with attacker-controlled data,=20
would this lead to a massive out-of-bounds read later when=20
wacom_wac_queue_flush() processes the corrupted record?

[Severity: High]
This is a pre-existing issue, but does the related flush function=20
wacom_wac_queue_flush() safely allocate memory?

It appears wacom_wac_queue_flush() calls kzalloc() with GFP_KERNEL.=20
Since this queue processing path is invoked from wacom_raw_event()=20
(which executes in an atomic context from the USB URB completion handler),=
=20
could this GFP_KERNEL allocation sleep and trigger a 'scheduling while=20
atomic' panic? Should this use GFP_ATOMIC instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524135203.1996=
265-2-jinmo44.yang@gmail.com?part=3D1
