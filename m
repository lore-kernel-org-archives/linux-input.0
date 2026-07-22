Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0E36B937
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 15:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734287; cv=none; b=shGziWJUeKq7KOYJsJXLsNimF4Uzvcm7n98fXKQCXDQJ1JzJTw6jCrgpJ2q2cynUnahkgDNs8JCidzaeE5ocOQEslFI6iksHIaryJ4eNsebwbfCvKQOGZLx2/yQUP1wlEjqV2gGBI/Be/ID8vSQsi6jaQBy7g/xI+CBKuU4Qrq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734287; c=relaxed/simple;
	bh=25eR6IORAeg+BJ95HEQGj2JLdVumdAVnM5WJNvg0pdI=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=lieNiJ2JfuAh6G6mGyb1ybXETEFLQdDaadWH67E3xWI29Vs3tTBTSDFsP5nQhboLs6CFBQN0qgCxv0SjaVKHxRKYLBiQX5omiZs8HBn44DIVgykY6FRlDuxeQArVI2JzkdbZFMxW2qXftvixpzXts5URzf7uXVh7gFjI27G7m/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dz3hcZcJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz3hcZcJ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4956242332dso28768565e9.2
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784734282; x=1785339082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EGApyBTE5b4jGTRLUHAvD3BADA1gtPfspkpd7xsnlDo=;
        b=dz3hcZcJlg6klD3BkJ6FGqtn2AQrWF8ojoFfm+hmDvL9vskA4sG6VENrDkhXvmVSvz
         dPekpiEYHEO6F0oimWMMeBUaSzuDA0khgM92+iM+O8lAv0oZ9FCxoRhVJR+OVugwHFhR
         ZEZJG8izGAZXSGgyYCoDg00Fv97kr1yXX/NNkhGczYREwmMhn2rGzBoaEU5C5npDlMv3
         vHUzP32/A/cNAbrcdLr5YYgvsqkdywK/EityFnmLVaU3HCeo81vFlmylgcA+cz9VCiJx
         eisnMZ5EXwoMcvJPR+o05pBB7VD1IceQ30uoyqgXFgKaBMXw/kdm8ZfiNCl8uj8PlpiA
         uJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784734282; x=1785339082;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGApyBTE5b4jGTRLUHAvD3BADA1gtPfspkpd7xsnlDo=;
        b=EJIvQOgu+zSeI8+iPwMPLXWWaMyleTni673C4R43j58IUdutFepMI5ZVC7kfhw65IF
         kbBIh4iWCl4ye7FYUVgJlZPYmPflWtUQ9SHRolMbdI6izADNhc8y8mTA4ELDywV/NMsZ
         VKmwFcVsDLW+cdSCSuSAoTJ7+FLLEFP3ufAvHI+K7xMnBnw6Iir97BZX53siJtq5OA99
         LFqWV8bBMwOx5TCJfq9wDRKwP8UVt4tyDCTgCS/KoC8yObNxdyInEffkM11Pb6ZDeses
         iuUpNyK2+htwDoxRMuiLofIcVcS998MbTpsqr2Q5jPZCTq/Rubm/pZc+Rt4tw88L7gp7
         gJwA==
X-Forwarded-Encrypted: i=1; AHgh+RovFNYAvVsO90rMURo1lsrxo9zdFCY/vXWIqfKctVtDaPtVXIgmdn/UR0CoSOG5Uy3q4aPg7tvQPFSYtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlLawDwHPF8/rmP/A5G9x5WF0pzboIPMw0qtAnmO0e+sx7ojRA
	4AQu9IGemoBnfJci9CW8HleEwwySU325c4cak2Qb6zRHPziUK41XbMU0LlBdMv0v
X-Gm-Gg: AR+sD10/rVfpIaOG3jvucrPwrJiokQkdGDwnSxzYxIPgr8Vns7zcBqFGF9JuMAKWtQ/
	kpL6x4ayYXkD0+UcNaNk/BV1S//2SvJrSVVnUzDVLJtYDeVTUILvp3VyVMdg+CPYN3cCAe+qier
	OD6wJ/hZeeSiOfe6rwLpNb+Z1FjFfr5mS3ig5H51fln2bkhVpY8NzrHIRL3wXxNiXQIGONyMaBM
	edVCn5ff3Komp1BGMC+D+rHBocESEJ80FpoqdK+VJYK2BEx99upLnMdpnRGW2pudLouq8M2CRTX
	V3g3SuJmmp/X6sNYFj8NqaKFN68vkBFPCyFACPMMQ6kg4flMvd8Buk9Rv5Lvy6BtodeQwsr6eN3
	DTQRtr0X+kQYxg8B+WndH4Ls9Wp2Hiter3eivUvOm79xS0Z1SeUaTmh70efkowTeLRZaBxKS1Qp
	T9GzJK
X-Received: by 2002:a05:600c:c84:b0:495:4491:b8c2 with SMTP id 5b1f17b1804b1-4954a3e6ed0mr255571095e9.3.1784734282446;
        Wed, 22 Jul 2026 08:31:22 -0700 (PDT)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956b021fa6sm51073175e9.2.2026.07.22.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:31:22 -0700 (PDT)
Date: Wed, 22 Jul 2026 17:31:21 +0200
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: fix out-of-bounds read in
 joycon_ctlr_read_handler()
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20260715115253.91029-1-security@auditcode.ai>
In-Reply-To: <20260715115253.91029-1-security@auditcode.ai>
Message-Id: <1Z0LP5TPL7LU9.3C7JC6QACT6RW@homearch.localdomain>
User-Agent: mblaze/1.4-3-ga04b747 (2026-07-03)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

heyhey!

Ibrahim Hashimov <security@auditcode.ai> wrote:
> joycon_ctlr_read_handler() casts an incoming HID input report to
> struct joycon_input_report and parses it, guarding the cast only with a
> 12-byte length check:
>=20
> 	if (size >=3D 12) /* make sure it contains the input report */
> 		joycon_parse_report(ctlr, (struct joycon_input_report *)data);
>=20
> struct joycon_input_report is 49 bytes: a 13-byte header followed by a
> union whose IMU arm is 36 bytes. For an IMU report joycon_parse_report()
> -> joycon_parse_imu_report() walks that union (struct offsets 13..48),
> so a report of exactly 12 bytes with data[0] =3D=3D JC_INPUT_IMU_DATA pas=
ses
> the guard yet is read up to 37 bytes past its declared length. The
> over-read bytes are decoded into accelerometer/gyroscope values and
> forwarded to userspace through the "(IMU)" input device, leaking
> driver-internal memory. data[0] and size are fully controlled by a
> malicious or spoofed Joy-Con/Pro Controller.
>=20
> Receive buffers are sized to the maximum report length, so this is an
> over-read within the allocation rather than a slab OOB, but the decoded
> bytes still reach userspace.
>=20
> The sibling subcmd path in joycon_ctlr_handle_event() already bounds the
> same cast correctly:
>=20
> 	if (size < sizeof(struct joycon_input_report) ||
> 	    data[0] !=3D JC_INPUT_SUBCMD_REPLY)
> 		break;
>=20
> Use the same sizeof(struct joycon_input_report) bound here.
>=20
> Fixes: 2af16c1f846b ("HID: nintendo: add nintendo switch controller drive=
r")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
>  drivers/hid/hid-nintendo.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

This LGTM!

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>

Cheers,
Silvan

>=20
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index e7302ec01ff1..11b5fe05acf4 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -2607,7 +2607,12 @@ static int joycon_ctlr_read_handler(struct joycon_=
ctlr *ctlr, u8 *data,
>  {
>  	if (data[0] =3D=3D JC_INPUT_SUBCMD_REPLY || data[0] =3D=3D JC_INPUT_IMU=
_DATA ||
>  	    data[0] =3D=3D JC_INPUT_MCU_DATA) {
> -		if (size >=3D 12) /* make sure it contains the input report */
> +		/*
> +		 * The whole struct is cast and parsed below, including the
> +		 * IMU/subcmd union, not just the 12-byte partial header this
> +		 * used to check for.
> +		 */
> +		if (size >=3D sizeof(struct joycon_input_report))
>  			joycon_parse_report(ctlr,
>  					    (struct joycon_input_report *)data);
>  	}


