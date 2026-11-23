Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450453;
	b=lqJECLlZ9qK4QaUlRkefu3sNdBVTidO5opu/Y7YwlomZP+zhEwkoxgsDwOOLYlf2dFvq
	 sSovczSQRCQWYctyMPi1Or1L/1bQI4kb2Tn4L76IJFKwenntBCuLrZxtYzYROZ33TREhg
	 Oi4NK26SuTa/kXRPKHG4cbB7IpKMMG9hxJp7qSG90kjg90bDC3Wz2tbARFWEzdLidXDdB
	 dImfTxyk5Oh3WBIYnyo3tRkfyhnJg2DscxcMoG/Y6Yk2Ei88qsQl3g8+NijO/wWNILmUf
	 J6cM6MNA/2bT9DrlNYZzfTgMhXgcYo22D/ycrAIfuegf+pQqRr0sTES2u+8UcVkD43g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450453;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HuMsJ/NMP6M4D8y009h1H7LqOhbPDVgEF7wa1Gd13Po=;
	b=e7QDfLW3PiOfwXmy+Bskck4nbkIpe4NfQcz3i3deZqgPYnalVsaV+vulKHWg7sfravrk
	 pru0qHN6hRXnQ9KmQkoWyhs62KSosiIXnTflqOnT1W5g/9pNAXhLI+1KPmWA4ELMgo+y+
	 Fqzn8em4j7rXNAbG7fNW17zvVAZPfsAVqaOO4rF6htlFgLFHCW47VWrd5Lz4Ui1thNHI1
	 to3FTEQ3yc5jZNHC/28mEFicQHMxfJJfMgTLqGsvLIkjKsYDVbrZKbMtxf14pe6luPMEE
	 RIgz6DoHLs6C2lfhFXnntqL2t0NVvjd8UY+/Di/T6eQXWJUt+UJWMVmV3+gWjz/iFvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTbXE57l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20484606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTbXE57l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B60B1F000C0;
	Mon, 23 Nov 2026 16:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795450452;
	bh=HuMsJ/NMP6M4D8y009h1H7LqOhbPDVgEF7wa1Gd13Po=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dTbXE57lOZJr/p1sV3eCy3mXKgNXhFHFdNLOF41WdJPr2jdR7amIsRe3pRnkXXbtx
	 YbdRyfDN7u2DFZ77nWI7x3EM7TvKVZTx4i1e7MHH/VXkP0WZ3rvO4XpmSJaHnnyWLJ
	 9VypzmUP3IgSkkfUvFRreOD7t4QhEckq/oreeAhpGJ4yoTRpK1B7CcAZjQ0GmijAP7
	 1eSHJE2+2faDgN8+pLr/gmXr/8Sp0RIMPkiS7H3ionAgzUTmiOq3obdb//dIZ7RhXw
	 oMKLL+dvWfasNS7Nfpqv6yhUdrSiTx/urmJiJAJ8tZqE015KtzE47e2lNLoxYLj3Kg
	 71okkK7cdXIjQ==
Message-ID: <sashiko-outbox-229648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] HID: logitech-hidpp: Synchronise send_receive_buf
 against raw events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261123155138.2907049-4-lee@kernel.org>
References: <20261123155138.2907049-1-lee@kernel.org>
 <20261123155138.2907049-4-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 16:14:11 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] HID: logitech-hidpp: out-of-bounds read in
  hidpp_raw_hidpp_event() [1]
--

commit 289546ca1e2e40f3f7b8470e29a3d15053ba75d0
Author: Lee Jones <lee@kernel.org>

HID: logitech-hidpp: Synchronise send_receive_buf against raw events

This commit adds a spinlock to synchronize access to send_receive_buf and
answer_available between __do_hidpp_send_message_sync() and
hidpp_raw_hidpp_event().

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 60fc6b86a0857..6c95c4bcdd42f 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c

[ ... ]

> @@ -4125,27 +4136,33 @@ static int hidpp_raw_hidpp_event(struct hidpp_dev=
ice *hidpp, u8 *data,
>  	 * previously sent command.
>  	 */
>  	if (unlikely(mutex_is_locked(&hidpp->send_mutex))) {
> +		unsigned long flags;
> +		bool matched =3D false;
> +
> +		spin_lock_irqsave(&hidpp->send_receive_lock, flags);
>  		question =3D hidpp->send_receive_buf;
>  		answer =3D hidpp->send_receive_buf;
> =20
> -		if (!question)
> -			return 0;
> -
>  		/*
>  		 * Check for a correct hidpp20 answer or the corresponding
>  		 * error
>  		 */
> -		if (hidpp_match_answer(question, report) ||
> -				hidpp_match_error(question, report)) {
> +		if (question && (hidpp_match_answer(question, report) ||
> +				 hidpp_match_error(question, report))) {
>  			*answer =3D *report;

[Severity: Critical]
This problem wasn't introduced by this patch, but can hidpp_raw_hidpp_event=
()
read past the end of data [1] when an undersized HID++ report arrives?
The function casts data to struct hidpp_report without validating the size
parameter, so matching and copying *answer =3D *report unconditionally reads
sizeof(struct hidpp_report) bytes from the incoming buffer, and the
27 MHz encryption-key check further below likewise reads data[0], data[2],
and data[3] without checking that size >=3D 4.

[1] https://sashiko.dev/#/bug/linux-f6721ec8-6f81-400f-a691-6d48de7fd9b5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123155138.2907=
049-1-lee@kernel.org?part=3D3
