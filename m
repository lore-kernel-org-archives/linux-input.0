Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113635;
	b=bb4D4WtRzSvkp+IybBZx3V97cGfkIdE+cruM9yASxjBnuv8TWG2GdFgJ7Ghb2Mk14Hrb
	 Fsdvf0zR/b/B2KUSaX/lNdXb42l4RVhsIZEiVOL+O8fEs91m//Udw7k5Em31oR4DO/e0S
	 rsDu2uy30caOYqUPiU3SDsTqFNXL0f9C6TDSoNG4ZSeuq4eIn17jWfsM1lq7sU2+T9z7B
	 gEbJhOEW/YKMlu/BprXxTR3KpxVbMSfFVAzybeL6Z5/yfCxfZgO9wid3x+09JTfn3Wt9/
	 lCfFzjmPG0liGvq2mmLEzfSxPPZda2qwuOKTvmFV/M7J9ZIckpVNdsePi7KupTa5Z6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113635;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+DnpbJsxDH0LaSiokoZCSjMq0v6CvkhiJPWkFMRnQHE=;
	b=x+JhYr2CJOn+1EazJHAFC3XYCsEnTPhr8+WNZ/mabM1+rhOdfX914Pypk9j0fg0yPGwj
	 3856CYHyywxSGrIhX8qIjdqtq8iWGg7/0qEk5cuDtpq1RKHZ+rDrhEWVA9v2QG5zQ8nSY
	 +1IgrnAR/W7z41OIXEX/jjYpdmw09vTwTQ6g8hlxjEkwkhOgPVK+z0zUzSm/JvwRC2jzf
	 myCV4DX9YbYThzLKvjHosJOujS2Mn+kgS3uPqzOUL1j8A7xL2v7l9VTwKsRZfo9Gg7kA/
	 +TzJ+ghjA9BlDuesQhq8RyA0bZqSKC7zs6BbM80ClRq5OmLyux7QgpMAMe3WfGEWyEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxfezcG7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D512606A320
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bxfezcG7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6991E1F000C5;
	Thu, 19 Nov 2026 18:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795113634;
	bh=+DnpbJsxDH0LaSiokoZCSjMq0v6CvkhiJPWkFMRnQHE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bxfezcG7jEGbRRPr8pcaFSKju0HrYWcVbFEAXQKxuJTn1ktgnz4ukr2LzOdDCCDU9
	 2Bl85KE/cRO9oRtF0E+nj0APZ3P2gwdu4OAaW63G+pl5zBXtQ7dmHMIg58NnLU/znf
	 0hhWnYq9gS9WzcAk7l5xbdjxMfWZ+C2k6GP3ubmW7kxGanhyfyAvbd34F5lY+16Gal
	 lfGsIisYoNbs9uHCdfP+sOcKbEBAajRUt/2RXBnO1kkHn4VL8DpzInfdjK0yDAqq/E
	 Jfdw2PagRgzBw5auj0x2e0JvacZb81Tuv9S6um+wthxN9V4eT+wqQ5XWv9T02ucsQB
	 kRJLviii1OZ8w==
Message-ID: <sashiko-outbox-223799@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: cyttsp5 - Use dev_err_probe() to hide
 EPROBE_DEFER
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261119-cyt-errporbe-v1-1-7faa44e821b4@kemnade.info>
References: <20261119-cyt-errporbe-v1-1-7faa44e821b4@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:40:33 +0000
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
- [High] Input: cyttsp5 - concurrent regmap reads in cyttsp5_probe() [1]
--

commit c1590d49f726ba5943ef8a369ba24293879c0745
Author: Andreas Kemnade <andreas@kemnade.info>

Input: cyttsp5 - Use dev_err_probe() to hide EPROBE_DEFER

This commit replaces dev_err() calls in cyttsp5_probe() with
dev_err_probe() to suppress error messages on deferred probe.

> diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscr=
een/cyttsp5.c
> index d4a78facfa815..82209bfdf828d 100644
> --- a/drivers/input/touchscreen/cyttsp5.c
> +++ b/drivers/input/touchscreen/cyttsp5.c

[ ... ]

> @@ -887,22 +882,16 @@ static int cyttsp5_probe(struct device *dev, struct=
 regmap *regmap, int irq,
> =20
>  	error =3D devm_request_threaded_irq(dev, irq, NULL, cyttsp5_handle_irq,
>  					  IRQF_ONESHOT, name, ts);
> -	if (error) {
> -		dev_err(dev, "unable to request IRQ\n");
> -		return error;
> -	}
> +	if (error)
> +		return dev_err_probe(dev, error, "unable to request IRQ\n");
> =20
>  	error =3D cyttsp5_startup(ts);
> -	if (error) {
> -		dev_err(ts->dev, "Fail initial startup r=3D%d\n", error);
> -		return error;
> -	}
> +	if (error)
> +		return dev_err_probe(ts->dev, error, "Fail initial startup\n");

[Severity: High]
This problem wasn't introduced by this patch, but can cyttsp5_handle_irq()
race with cyttsp5_startup() on HID_INPUT_REG reads [1]?

devm_request_threaded_irq() unmasks the interrupt before cyttsp5_startup()
runs.  If a pending event or touch triggers the IRQ immediately, both paths
perform unserialized regmap_bulk_read() transfers against HID_INPUT_REG:

CPU0                              CPU1
cyttsp5_probe()
  devm_request_threaded_irq()
                                  cyttsp5_handle_irq()
                                    cyttsp5_read()
                                      regmap_bulk_read() /* read size */
  cyttsp5_startup()
    cyttsp5_deassert_int()
      regmap_bulk_read()          <-- interleaves with two-step read
                                      regmap_bulk_read() /* read data */

This corrupts the sequential HID report read protocol.  In addition, if
cyttsp5_deassert_int() reads a non-empty touch report (size > 2), it returns
-EINVAL and aborts probe:

drivers/input/touchscreen/cyttsp5.c:cyttsp5_deassert_int() {
	...
	error =3D regmap_bulk_read(ts->regmap, HID_INPUT_REG, buf, sizeof(buf));
	if (error < 0)
		return error;

	size =3D get_unaligned_le16(&buf[0]);
	if (size =3D=3D 2 || size =3D=3D 0)
		return 0;

	return -EINVAL;
}

[1] https://sashiko.dev/#/bug/linux-bab102b6-93cb-4ea5-b362-6d8c8b8866ea

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-cyt-errpor=
be-v1-1-7faa44e821b4@kemnade.info?part=3D1
