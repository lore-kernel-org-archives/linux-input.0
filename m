Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795251727;
	b=G6y5nzV2RYOIsYfnT8rexH2EDArdtIwf1i+f5PLfE4HRsx/+FbuWNIDSRVe5ATyvkTsT
	 dA6rI7Mq2xvAPjpcfzj5yjipXNngf3eWxYS87X9J9t+cHzxqX82pC8bdV1Jn56jfI3sfO
	 OODfvybDjwtrSaD4Zf+OAIOhZaqtxkB12AvB006lOk7119Ue+D/O8S9zJJhhfBZWJfmX1
	 VcD4bwR1XsI8FkF+eZNmXO1yRRIm+JjL/cZiAfcHYzKKddIE0WBj/d3T5liIwO3Ug8iti
	 Y1vNJiB7cjNlLSWWwLAGoVy4WW1ueNjgtmYeg4QU7NDe52NsIsoYAptIbAiCTFx+s1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795251727;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CEJizCMnRTwcJpF0K1dvDIk+sJzM6GrJeylAcp1MkrY=;
	b=OoJ4qbdiECt80Xe37eLj6b4Ly/RqAg7NDMzux3Ht2207I2V5EJydwcqqB6KnGe/zVZ4w
	 50Bm7pdqNhIvweC2M9b3mGI+eoPKauEgRBbHB5sBgy/ZLD3k1TTsnjsE7SZX4wt+YyfE0
	 ETfS6A07JYyQeNLdTCNOtvt5/tdtlknOi8ewjuIu9D/t3mVSM33fabCxbtauAgAwk5ZLF
	 H9Rdf1Fr97jXPRWG1jwx1LY4E4qLO9a/vt/a4aiezbKbhYO8EN3Qc3DtG9izREyfzPJhC
	 kFD82MV0dPWOlb4QCOu0G28XHPonzXPhqs8M0YXcTcPCIWcBYxFcNyRw9y5h/R69BaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DR923WaG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF71606A33E
	for <linux-input@vger.kernel.org>; Sat, 21 Nov 2026 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DR923WaG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE511F000C6;
	Sat, 21 Nov 2026 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795251726;
	bh=CEJizCMnRTwcJpF0K1dvDIk+sJzM6GrJeylAcp1MkrY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DR923WaGO5EsUYP0QTSiz22nAzJ6IBSb/2kyeeyvL5ZV1X5qaBAYXv5PSrAJrBaCZ
	 HSmPl6JhqeQwHhvF4GTwj2Wy/h+pAIbv9k2cHSKmpqTxnvueMThqP3Bs2vtXRWWUXe
	 vQ1b1jHo/mU3rsbaYMn2P485FxsSIE0KyvW6TgS/WJPhVefmwEkCeGqrrYYkxe5Xk/
	 c+jL3TG6QVzlSXOfxpxkUweI5l72idHtjP+tBN6qzxNUfiOCrpHPkoSzAfcGhHCznK
	 uAAdCnSWiSIAlJNPPENQvPJ47LHDd+m4T4Brg/uOkD5vTF1ko7+xVrn3FuwE1PYT2l
	 G3lwTG0bkjNUA==
Message-ID: <sashiko-outbox-226852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drivers/hid: fix brackets in comments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Ebner" <manuelebnerli@mailbox.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261121085628.1430330-2-manuelebnerli@mailbox.org>
References: <20261121085628.1430330-2-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 09:02:05 +0000
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
- [Critical] HID: wacom: null pointer dereference in wacom_intuos_irq()
  [1]
--

commit fe38a9c78cbb9c5469865293835934f3d81cedd9
Author: Manuel Ebner <manuelebnerli@mailbox.org>

drivers/hid: fix brackets in comments

This commit removes unmatched closing parentheses and adds a missing
opening parenthesis in comments in the AMD SFH and Wacom HID drivers.

> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 361738bb87253..0273299454b74 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -558,7 +558,7 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>  		 * physically implemented as a touchstrip. Each button
>  		 * is approximately 3 bits wide with a 2 bit spacing.
>  		 * The raw touchstrip bits are stored at:
> -		 *    ((data[3] & 0x1f) << 8) | data[4])
> +		 *    (((data[3] & 0x1f) << 8) | data[4])
>  		 */
>  		nkeys =3D 3;
>  		keys =3D ((data[3] & 0x1C) ? 1<<2 : 0) |

[Severity: Critical]
This problem wasn't introduced by this patch, but can wacom_intuos_pad()
and wacom_intuos_irq() dereference a NULL wacom->pad_input or
wacom->pen_input pointer [1]?

When a device interface lacks pen or pad capabilities, the driver does not
allocate the corresponding input_dev, leaving wacom->pen_input or
wacom->pad_input NULL.  If a report arrives on that interface,
wacom_intuos_irq() dereferences wacom->pen_input in dev_dbg() on unknown
report IDs, or dispatches recognized reports to wacom_intuos_pad() and
wacom_intuos_general(), which report events through wacom->pad_input and
wacom->pen_input without checking whether they were allocated:

drivers/hid/wacom_wac.c:wacom_intuos_irq() {
	unsigned char *data =3D wacom->data;
	struct input_dev *input =3D wacom->pen_input;
	int result;

	if (data[0] !=3D WACOM_REPORT_PENABLED &&
	    ...
	    data[0] !=3D WACOM_REPORT_INTUOS5PAD) {
		dev_dbg(input->dev.parent,
			"%s: received unknown report #%d\n", __func__, data[0]);
		return 0;
	}

	/* process pad events */
	result =3D wacom_intuos_pad(wacom);
	if (result)
		return result;
    ...
	/* process general packets */
	result =3D wacom_intuos_general(wacom);
    ...
}

Receiving a crafted report on an interface without the corresponding
input_dev triggers a NULL pointer dereference and crashes the kernel.

[1] https://sashiko.dev/#/bug/linux-4a2bc3f1-bd42-421b-b885-0a54a4969fdf

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121085628.1430=
330-2-manuelebnerli@mailbox.org?part=3D1
