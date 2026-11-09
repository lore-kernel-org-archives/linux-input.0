Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794208512;
	b=UpOpd41F+NC7GSB2eQuRBYIebh/HBSzRagBnxDHnEq8mkt1gaR7/zwy/4o8mYMUQjWWC
	 R6ouASIzFbl1U8Tb1ImolRHeKPI+KfF6lfr943g/KXA7Aug9wCmxf+s5Fct5s0tZfhH8t
	 z80itUh3BJ4+T1hqTxUW+4LwE3o2c9HDTN9sazZD2muvxm2xmNoLNoqaDwXPT2n8ftZlg
	 1Kpl1EYx6EXoyZqdMadNhd7d4hDDpn7FL4Sm/CNcHJPsWfbhQLhIhmPhkWnVl278cAi3e
	 rf6DoADfBLN6zsbl2PhnhUiQnUWxwkJyn1qmSTClNs8LmJ8FJBDJ1wBg5fUiz2yJ+Og==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208512;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=W3TH+FpKDkN9+upkUl+wnaxnw+xID6Ayvvs9bsXe9Os=;
	b=UJEn2sR5hmAc0sZEI2swtE0Ra8RjWNmdnpAiYSrjpM/yZFNwBIi/qN60yhtOHuu6LoC4
	 0ftV9G6Cw2/WLbRz00vQPnNHNP9+4tBD2/l5g174p0KuNCaX/1cYGSVwM4l9mJKx7HAnK
	 UUys3GfAtAHNko7bX9Ihe3EoV9lQ2G1FA3flV8TYVIMXEuEH6zhRcRLIP8QsaE06LnKG1
	 VCTH2eD1q4ShVe0shdDV/Za5kVH70saHBwpduXUFOEILZeOA5Sv1qH8TQjJG9bVyopjh9
	 yVVEKLgU9PO9+j85SYTCQwNfx+02ae9tFNwsn35dRfqVViqTIXuY46w3yvZH7LnX33g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=csU26nM3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED1C606A326
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 07:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ED1C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=csU26nM3
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b31ca7e0bcso4813137b3.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 23:15:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794208511; cv=none;
        d=google.com; s=arc-20260327;
        b=KYSsJ9hzHjHd+kHaWNWinRtGHHKeymDVBMeLiCnOSBhCmxAxK1iPqUQQ3VzoF3eF7R
         NcaV1KKYTkgxrh6/HElYB0aEGGkCi7TlIJfJREBNRwWNKE66Ol99ctK/Epxj0K9JTGtN
         6uecExIDKIwf/749zE6A4jHDjRuxyFRNS5Iw7J6+aJFmchgpy1OSyunxe+RtaA2fO5Ac
         tBcJNREmOXngFwqAGR7BraTgbsnK0y3ZSF4sj0q4hFa/uCnO69aerxp6Qek5u6hgeng5
         pf6Y7A2UYOvGCPnw1l+YFKLR3x/evvoV4P8Ds50zX7A8Q+N6pSDQxIZ/DJOzVQOdbkLE
         eKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W3TH+FpKDkN9+upkUl+wnaxnw+xID6Ayvvs9bsXe9Os=;
        fh=G2KBqJwTdK71ibhBdGj0RnKPeWEuX5LTl9ANYKR71+I=;
        b=dVVk6hpbYfN7MMs6CwUFFhTAh6BlVNFdwl9DpTw0+bwEl+oCnf6et/xZW+PcSOVi2Y
         O762ZzSUVUKNNgUxzNUKtr6nhNdXkH7f6TO1eYPKy6Zf/sJQgM5wkseO8pdl9hyn7CuP
         5DM0+4AG2Jlo69Q80MWhQ9wlzy9HhIhYf23kk4TvK/sslgWjrjYt0ISv+uoDQ0tmI52H
         5Gt7GMXZ0V6ETfAjlGZeRIB7wIJ737WXvdnmQxIT1T0a71hzW2PHilIsFEHGrek0KWPB
         BKHCpG4C3gXarXNuCG+8/tMUnY11gjCp7P5qvGsl9G4VYp+yELFp3fLEc6ScX8dwtsUi
         4WTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208511; x=1794813311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W3TH+FpKDkN9+upkUl+wnaxnw+xID6Ayvvs9bsXe9Os=;
        b=csU26nM3k4fPR6c+45FXgNSnRd6mcGiFaUu5fBYpJCB35zLotT2fORe0o7XeUCLaY/
         hjVDjwdD4kDmKRqzjXaYFFBeZ5XabH172MZi+LniP7uqs7p9+8Sho2n/M//EeF2v+Z0Z
         bIF2rTnHM52w4rZ8UxueOZN/q3swm//FfuG3oAXlS5lfeHcFWFpPrLhH+FMQCJh9n98Q
         g1fMq00h5DXiDnowP5J2Cysl3dMXpGL3+AmNLAcUnzIALcCARYG/n5E+0yNkz4QouzUr
         akOFfvi4XQndFgLZBxT/3aR2OWfzVUkGzg5mR5kAq34rjnqlsOPJKhfC/MfQwatFvjmA
         7HOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208511; x=1794813311;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3TH+FpKDkN9+upkUl+wnaxnw+xID6Ayvvs9bsXe9Os=;
        b=arGPFLmfjSIMMZQ0tyWT6B7/85dxtTeikSicrqMq6K/fLE74JQ6Y/BzwOnppV9cbOe
         5uc3RNFDpEE8zAaWxkhEt79jadsXK9DpcbVFbD2+Scy8Aj75K1wRLfqKACKdkaURZunc
         mpbLPOXALO/3P8MSwbxu23UEp3cqRS2RXk6kVqaHa3AlYI8umykz4Ogxpiv8aArxT8Mf
         emKsxynEKON1pJfWBBMxxHsYie3vJNktGiB2YJn+NqhKVXmPkWZCME8wXlbeSzKF2kYZ
         QwR70mv6KtDuwxyRA1rqTRwQ1cuJB5Dzth3BYKxiy29Cq9sQTL82YK/69BYcddTb5cBc
         OAAQ==
X-Forwarded-Encrypted: i=1; AL+hErH6ySY5AOeY0cILbP0bTOm/OpYqZ1KyZxOf0t5cUNfVTKvaNcMFC50h3LaERligHtYOKefE0BmaaxlbwQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/wf5BdgllFUfMNQpwso59WZDtbgArzbFknQ8ZS7UYkAt8vkYzj
	bbTsQFivOTUeOWFIvEl2NXdxjm9nPAiUyhyK9Gm5W3CJT8JTv8kySFRwXE/yE4jyJr4HQlB+2WZ
	gpSHvrAaEpvj5rNg0x8RkhQ2KNL+nMIQU1Q==
X-Gm-Gg: AYBFou2KKXlKbXDt9TFBhmMC+HAYJTykesgH/bIY7Jp+9eCcN6MtfJAjKaWtJ7j89Rg
	5fwTSoW31imHCBvnHLzxUvqYt+w89hPdH1sOnZd9vohrR8EeMTCYb14F+7l3PcoLH0bruAj10H4
	j9xmumcPejIEKUGjzqXHz3AawUFkOIG1x+gtRibNbTWAKyyOx5VyD3YuM/yYTm/wrkFjA6Z3s0r
	zM/7JNDDjwVStfCi0LFnafqLl0Qz8UYIV5tRg24/YNqFUaZDxc/EyO5QKs30ORoaBMWJCDqPmJD
	Q3QcQBPvgDV3hbiiWEbyXpErteh0P+O7iFJi2HDrdP8ESEGeviWzcRkkDeaqZn1+nUj2UStYTRg
	i8sjANFlJ83nhwqrJ9TZ+EjyOMetrgoCGasSwFHU1384e0vo2R2NdzMEx3RqAJJuzzdYHjT+PIt
	fJa2P7j+Slk2iTw4oahBQqJ/eu7jh2+3Vin3z8BtS53MwE0TzPq57Src82ZQYMjm0g7KtMSD4gG
	FQyETCuCN7wPf1S1yMtZ9U3ogSBkvaXnIPQqNbJOj5LEPNwzn/ddD1w4AuEww==
X-Received: by 2002:a05:690c:a4cd:10b0:8b3:6430:6728 with SMTP id
 00721157ae682-8b36cb77a09mr16346547b3.53.1794208510681; Sun, 08 Nov 2026
 23:15:10 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108213656.13031-1-antoniovazquezblanco@gmail.com> <20261108213656.13031-3-antoniovazquezblanco@gmail.com>
In-Reply-To: <20261108213656.13031-3-antoniovazquezblanco@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 9 Nov 2026 09:14:34 +0200
X-Gm-Features: AclHuK-MowMPC7nsIXdyGu4QxS5XFSL9LJIdTkFEgLEwFauodytJ5sllsbRZ9KE
Message-ID: <CAHp75VfuW1Xz=UeEqCUtnwQF0+auziyTa4nyhHWSa6=QuZMV-g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/surface: surfacepro3_button: don't load
 on amd variant
To: =?UTF-8?Q?Antonio_V=C3=A1zquez_Blanco?= <antoniovazquezblanco@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Chen Yu <yu.c.chen@intel.com>, Sachi King <nakato@nakato.io>, linux-input@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 11:37=E2=80=AFPM Antonio V=C3=A1zquez Blanco
<antoniovazquezblanco@gmail.com> wrote:
>
> From: Sachi King <nakato@nakato.io>
>
> surfacepro3_button binds to MSHW0040 on the AMD variants of the Surface
> Laptop 3 and 4, where soc_button_array is the right driver.
>
> surface_button_check_MSHW0040() evaluates function 2 of the MSHW0040
> _DSM, the OEM Platform Revision, and binds when the result is 0,
> assuming that only a failed evaluation yields 0. The AMD variants
> implement that function and legitimately return 0, so this driver binds
> there as well.
>
> Decide instead on whether the device implements the function at all,
> which function 0 of the same _DSM advertises and acpi_check_dsm()
> reports. Of the 32 Surface models carrying MSHW0040 in the ACPI dumps at
> [1], only two do not advertise it, and they are exactly the two this
> driver is for: the Surface Pro 4, whose MSHW0040 device carries no _DSM,
> and the Surface Book 1, whose _DSM advertises functions 0 and 1 only.
>
> The driver currently reaches the right answer on the Surface Book 1 by
> accident rather than by that test. Function 2 is not implemented there,
> so the _DSM falls through to a trailing Return (Buffer), and
> acpi_evaluate_dsm_typed() rejects the type and returns NULL rather than
> an integer. The revision is left at 0 and the driver binds.
>
> Keep evaluating the revision when it is advertised, so that it remains
> available through dev_dbg().

> [1] https://github.com/linux-surface/acpidumps
>
> Fixes: 64dd243d7356 ("platform/x86: surfacepro3_button: Fix device check"=
)
> Link: https://lore.kernel.org/all/20211109081125.41410-1-nakato@nakato.io=
/
> Co-developed-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
> Signed-off-by: Sachi King <nakato@nakato.io>

Same comments to the tag block and the commit message as per previous patch=
.

--=20
With Best Regards,
Andy Shevchenko
