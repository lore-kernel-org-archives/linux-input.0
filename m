Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049B26159E
	for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 19:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777233456; cv=none; b=Bnj5WQUMJmrt8dD3xn9hhDwqR34Bj/04jj6/S+KzI/uWy3jQieitj6h72ABXrmOTnTfABbK1+dPpgAQTWZp/sunxiO7jisTfGXDmgIh1bYKLYxc5XZkjct2iGEVcIldOMxZa6bb3Qs5IdjZwwHsks2sVG0shLhFPS1ySgjvnyF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777233456; c=relaxed/simple;
	bh=j+sf1c1fROzf0gnuoplaarm1uc6+4qSB5pi/L+eIL8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eP+P+nRv67GwNvCaXeVFsT3McwlJh3F8W0NDP1kk3/Uic7pRJY9DomCUQJ9VXEyE83o1wRM4EeBGvYYSBgpsESpeuRiMFNj3SBai63ZmaIkzTMOP2fA8eX1NKXAGD8wMAhkaRtASvipH6/j+wIHNfeSO5CpmkJD/MvL9ISXXqlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwYLNPVW; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwYLNPVW"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a41a9a97d3so1355791e87.1
        for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777233453; x=1777838253; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j+sf1c1fROzf0gnuoplaarm1uc6+4qSB5pi/L+eIL8w=;
        b=AwYLNPVW98a1T8lPAObCPfneeqxig6Q1KmYLTKOiCcpAzswtzVzs2zuBtnI8oHcBun
         iiB90tO+FhmyJt/HAgqHIAtLsUc2ysktrg+yG0IEba8mjyEzK71Z6d619xo9d/JqCHB+
         SnlVkH1ipDQvZSDBfJ6DAi9qT2Q2vVtQXmQK0mS4V5TkZ1p2CDirg6wHd6gwWFL/CKKk
         wQZWBHf1C/CTcj5RxiGWtKkrBuqlN0uW8Iw3iq4cQQZOBdqU7fxTG80COseYKjKySW48
         fV4a4BPCbXIEHTSz5NOhPSwOkLsxCpD2XyJnelmE2M3ZV7lZeucVmSgQlVfk8xUNytvL
         RGzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777233453; x=1777838253;
        h=mime-version:user-agent:content-transfer-encoding
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j+sf1c1fROzf0gnuoplaarm1uc6+4qSB5pi/L+eIL8w=;
        b=hzdz1dxFkcFc6VuObGF8Jm3gQilvYXDcHDofbN3tc02KhA5FaA3kQ8qte19P82W5ZB
         Jov4wJimvZNgozBc9Ak8AzvxonxhE1aGT129nECsn01NBvp/SKQI2A8QIQDcYRcJ4Hd2
         ayOKWGEIOgZAZx+PsKwHBL3oyBAvbC8joeIivVktfl2jp0kORnPrlMu/EbBRLutnYGjF
         QXJqk9f83yURIvBCP0DuCZiqLNs65e9Ty6/Nlc/u923Y8rSMA/fPeeQLxsD0ojIICwZj
         qk1lrVQWNY0dr46H5NFN/G6hzX4oXy5G2QUVEf8Ve8AAGkvJMDgk4Dd3Jq6lqj7r91qd
         dqDA==
X-Forwarded-Encrypted: i=1; AFNElJ/fDWAZpaGMjySjSyUfrlQ5ob+BUDbXsBpVOhpcQh9eleGPYON6BWK0ZP8mjJdPjqBTmcqoUj5f4Uk7cg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1zReUdHlGg9fuAJtwc1yjWODk7q/dU986JEykM68fJEQgyL3n
	3zJKH9UflxiCT0jF9n2sfvXmZSRYYkeGhNzj/30g0zui+p/Jk6+0Z5VpjR4/i0vV
X-Gm-Gg: AeBDieu+gD7q3YA5YWQUZpizrBhKppGGYvAMm2rIBJhdKPEb2xk4tZgc2VIMTZ+sXjq
	TXTDetq1A5jjIH0u/4QJlFY4Gu47nYmbRmrmU8pACdPa/M+aNJkaS+EEZeL1f+iqUFiYaFZRzWL
	awhL83nFiEoQR0sYDkWGt1ImTX94v+al9tmBDIulmkRhoS9/cRX5o+jIStrUfRLJKOpJdxnTR7o
	kxqpGN8CzLtgzILNY+ofwVAEpDDImdD+WY5exGI7Zs3dvEyYc4sLOytTf7maiBV/o+b2Zh7TNO4
	VMOX7Yh+TEJsBbNpEeyZENrYbJULtOjrouE1ZGULyKDSi3xJXf/ivLNNutH7LD2b/CaJXJKkAso
	gj256g5Ree7ryF44TAkB1G4L0Echxm26O/SlC3Fn6JUn6D9YIIPmxs38cK/Q9h62MTGFcAMTasR
	ThpjnucD3z9NDrU1FX6Bnu9bM9HMjfHTHKEOFSywShtH93NIBtlS5cvdi7w9A/CYcd/AAYtpHcM
	k/+C5ZXBoO5CKkRyYffkknTgI+2ZSnz
X-Received: by 2002:a05:6512:1590:b0:5a1:38c4:424e with SMTP id 2adb3069b0e04-5a4172fccc6mr5122413e87.7.1777233452916;
        Sun, 26 Apr 2026 12:57:32 -0700 (PDT)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7a3fsm7630070e87.59.2026.04.26.12.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:57:32 -0700 (PDT)
Message-ID: <25715cc23884f74a7417ba53ba144cbb7f675293.camel@gmail.com>
Subject: Re: [PATCH] HID: pidff: Fix integer overflow in pidff_rescale
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, linux-input@vger.kernel.org, 
 Benjamin Tissoires
	 <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Oleg Makarenko <oleg@makarenk.ooo>
Date: Sun, 26 Apr 2026 21:57:31 +0200
In-Reply-To: <dd6e5b2c-700e-444d-a9e5-8794c0ff8e34@web.de>
References: <20260421194941.1422722-1-tomasz.pakula.oficjalny@gmail.com>
	 <dd6e5b2c-700e-444d-a9e5-8794c0ff8e34@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-04-26 at 12:48 +0200, Markus Elfring wrote:
> > Rescaling values close to the max (U16_MAX) temporairly creates values
> =E2=80=A6
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0temporarily?
>=20
>=20
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv7.0#n145
>=20
> Regards,
> Markus

I don't quite understand the point. I'm aware of the error but didn't
have time to look onto it yet. I probably just need to switch to the
division functions exposed by the kernel.

As far as the other stuff you mentioned, I don't get it. I don't think
it would make sense to mention the 20 yo commit that added this driver.

As far as the temporary status of the value. It only exceeds the s32
range after the multiplication, and is reduced right after, during
division. I think "temporarily" applies here perfectly?

Maybe I'm not seeing something here, please elaborate so I can fix it :D
Tomasz
