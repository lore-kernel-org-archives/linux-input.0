Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794467714;
	b=4YqMOnAg/0v9rR4x8paIDc/MnKwRpRqHJzt0l6gzYVuPbB2BFqk89OkYQDzlEnfqxeA0
	 wZ3L72BZ2+l4YjMO1YThXovM97O26aEvq21RnYBHYPyyO7yJZhEGmdb9VUtyH317hP6dX
	 p3f517tzPEBSkoA9wmQriOB+L2aH2FPOWj3U2lSzwd7bChnGc1jTk5n8OMI6tTxm2sw7y
	 S3OmsUSNrJuKQwJ9ifv0ZqC0syw00WlbE6hx0wTx0ejhFcpecbVsKpV/itkGqbzNuCfvu
	 xzEk0ZgWvIr3P0FDbqPXxoPVxDzGsnvVpvdJ9cQeGAa4EjRW06+CPoU36/cKAS/y9yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Iuy4EgTSII5aComkMofSr4ShqjFett6xQzaRyJYPEsQ=;
	b=oAMdvSEb2uGORq4Jeea7LMwTW1Pi5McztIUUc72l05PqXVE50U/Wa5GR4FsT8m8DjigG
	 D8rqmOnuAy++34WyEtTUxj/xMpGxkt6hNxThJgJtqk8T1UiSou2U6qxwOpelH8+wEG1kl
	 Bi9qBJoKExtZ2nbbSf1UqvwqhYy3dtgztsG2l1XMlCCCTbf1Hc68YMOkeSU3EOwyxkO1M
	 HlplagAB1GHpWndnd5Wv1sVxiyyyg1cS2saQTWqa6Yre26WZQi9sDmgdAnq6ohFM3CHlM
	 RgzMvk5JQrso04BdM8B99h9JUoGkHDC9QsxEaQnaqxlZTLcFPIBmZCl1BSn8/UC2HJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fkb8MuLU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF31606A334
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 07:15:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF31606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fkb8MuLU
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ad5529ae64so32210891fa.2
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 23:15:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794467713; cv=none;
        d=google.com; s=arc-20260327;
        b=l9eGnMoVTb4yfLS2LvdrJUI1DAb7QGHkHbAUMOes8APVFvmisvr135gwg6J/PqfvsU
         P8AXDuSWEPmmAjvAGx/h5qs8Fr65UMW+H0iCDJ8NQh9OHMehiSLOMkHiw1RDFcchTJWq
         ei4qObJ57ZOy5ARUvwARS4oHwtiZaHSUEoXH9TtK3FxaQInYKAvZt+UnUK8MfN5ZyR1V
         TjWbnwe0MOnDOGc2E+1rDC+B3a1DlXv5PA1GE9CsUYqKEhvaIt3NwqUh2Nj55yOm7QxU
         8aAtuSa2lZJVBZzGLndqcrLbTeawssONa/TE/+hDg740JajgZZ3MxUlnhkGct1d5n4I2
         RaHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Iuy4EgTSII5aComkMofSr4ShqjFett6xQzaRyJYPEsQ=;
        fh=rcMUbHsZE+K2yErsGBZWYTaYTonpXD9T0NcWf8hUdq0=;
        b=dCsVGy8PAWjSDFD68/h4TA1jOFGNKvx1E1RgtrMytVkL/6bDNVZO/xcRSz6tV6sdSo
         QVMHJPc35EPcewrGFpEsLNma09H638qT9FeK9NajwRd9eGFO1xUSTrFhihgrCcGuUlll
         ru1xzlRDVpBQa4imNNkTZq7j3XaDWeN8wHGHuPa38am4wpJjfFmxJ5Y488TiBSgBOrvQ
         O3EAcCV6IewBHBzPdziOG1TD+pV3NFd2D3ivXqlCZoX5Lvv/3aSeLahqYGsK8rxDdKMN
         LC0p1SFPgzowepxGYfHgIbLm2GWoaLVu4qeW2Y5n8SJt/f8mI+Zj+HPBHwqBHhflQwY9
         04Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794467713; x=1795072513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Iuy4EgTSII5aComkMofSr4ShqjFett6xQzaRyJYPEsQ=;
        b=Fkb8MuLUesPuHb4fabJGmk9RtIyCSyNsSX4i126TQvAjaB8WJSyVzT1XrvWJSfikoO
         fisLKPt1PAmxZGz8vo9rwUMk41lrVb95VvTbCH3Kwg84DJMSrpWGRcZj1uFlxDOIP56T
         mHf1MgKWkRvoInA5McEjsTpxMhcOLhlnAp1Jj+SPqKdNUW9zd+DPMUxt/aXd/IhrbD0a
         Xw8jFzCp3SzJGPpyoPoywrhfDi8lG/UERx32nxWZaAj4TlrHHuibTQXBGKEi9KaGCtB3
         NovV4akBCrN7Qo0PNMd7tkHEpjlDGZwwxkoYZY8H5cZDBEcbra7CL9wPSWBg3TQFVras
         3vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794467713; x=1795072513;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iuy4EgTSII5aComkMofSr4ShqjFett6xQzaRyJYPEsQ=;
        b=uIpy5B3F96fdOjgfEc+zr1JXgGYPwkmPNOR2sp7fNStDhjwIV3p7rP6IIRlH6E4T77
         KBnfNPjwmsKC00CDxTHP3Y+vFknFkqpePrHmOYcptVLLyYpnWSVbz9+/FYHyUd5/Ga7y
         fdpKWifzYz+lU4pwX/bIo+tbA7Gu+OrhjYJqCuds4qqFFPrEpJkPMnaLRFPkCE6+oFNt
         JRizqKBojSjnQUIgejVeRhiqpm46f0N0ooxtIZ95JY8qBnD0gU5i0JrBo/GXy49BjyAb
         905hzfJKIjc4jFoBnJCKF0YYlMAIs7Kak7RiXE4V6yuTmXTF0yazQgFBJMUTyw4LX9WF
         3ugA==
X-Forwarded-Encrypted: i=1; AL+hErG1uOjYb2NQ4g1GS7hzxMfd0atRsJNgj+z/dELF+hl4MBvXihOSGVSF9U5Tgi8KH2Zghjg6S2BEu4fm7g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ciTUAVaKVvaYhYxnoU4U5r+tvnguyigcquA5n3LAXWrPVDMyL
	oKbeLLuXsaL8MEI+Uic9hGjm7CU6yeCoDlZgEqLVzqotwq3Q9eQ8VQL9phOVOh8FYPFANnZ5icG
	CYvynnV74Czdss8T4Du1cAriOi/oKd4g=
X-Gm-Gg: AYBFou0GK0RhfGzVO2+dymzvCPWJbvYnmrlVYQgoUKUhV1llq3Z9t0eBdywXN1BbJZ0
	4ASwi2PtY5LAz+dZONxg1X1fKLwN0utsDc2KrI/XOZo3AIG0mI3ba62zn8ZP86LJMbOOlHecC4u
	9ze7B7g7E/T+j/BCtUN5scwXaSuk+ak8M884lTl36GbmNSLfn08uKvwobokVDVNxPcIRcw4Z36W
	iGpJMsDwe1q6HijQG8g4YEZ6nPAnECF1ZbJ6J+hF7F9qpyHm9C05smTmJmoveSBOqNmzDa5xJo0
	jHX9r+KBTrKJ7d43GU59WoSyeUQzN8d5GEnsHFY7rLXoQ5KaaChrlESRT5I3Hmj0GoKXYwARyuW
	emu2KXI7gvM4NzMpApwlYbpX9zoHJYTcMIR9C+js+AgpsB7By/rczgrQZayVTESf1Sa/2YVFLba
	6OuM7PvlO+BiOxsL9Ysk8IrczahQ==
X-Received: by 2002:a05:651c:b1f:b0:3ae:68:d077 with SMTP id
 38308e7fff4ca-3ae126b6755mr12031051fa.18.1794467712384; Wed, 11 Nov 2026
 23:15:12 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102130836.11863-1-yaoyuan0329os@gmail.com>
 <20261102130836.11863-2-yaoyuan0329os@gmail.com> <avKBsi-E7IeUgsSY@google.com>
 <TY0PR0101MB4786C8CF42ED66617BD9DA1EDC722@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
 <avMcB0q7wF9oP5X8@sapienza> <PUZPR01MB477458CD012208A31DE60068DC712@PUZPR01MB4774.apcprd01.prod.exchangelabs.com>
 <avRttU9N0EZeq8nY@sapienza> <TY0PR0101MB47865DFC765932B9E6C3E1C0DC702@TY0PR0101MB4786.apcprd01.prod.exchangelabs.com>
 <avVPRySmoH_KKHa6@google.com>
In-Reply-To: <avVPRySmoH_KKHa6@google.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Thu, 12 Nov 2026 16:14:35 +0900
X-Gm-Features: AclHuK_UqmV6H4513JLvxoPp79yhUJsDsz0Bv0l1E2WZSMvlO_OF-RYzRFgtWpE
Message-ID: <CABxCQKt9o--KrucZ-jcG+tb4AGtrBnPY_mypqX64ojWRpoO_yw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Input: trackpoint - Add new ELAN trackpoint device
 variant id 7
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?SmluZ2xlIFd1IOWQs+mHkeWciw==?= <jingle.wu@emc.com.tw>, 
	Yao Yuan <yaoyuan0329os@gmail.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	=?UTF-8?B?UGhvZW5peCBIdWFuZyDpu4PkuJbptaw=?= <phoenix@emc.com.tw>, 
	=?UTF-8?B?U3RhbmxleSBDaGVuIOmZs+W7uue2rQ==?= <stanley.chen@emc.com.tw>, 
	Vishnu Sankar <vsankar@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dimitry, Jingle, Yuan,

On Thu, Nov 12, 2026 at 2:33=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Jingle,
>
> On Thu, Nov 12, 2026 at 05:26:46AM +0000, Jingle Wu =E5=90=B3=E9=87=91=E5=
=9C=8B wrote:
> > Hi Yao:
> >
> > Upon inquiry, it was confirmed that a black TrackPoint stick (0x07)
> > underneath the red TrackPoint cap corresponds to a vendor that is
> > compatible with the Windows ELAN driver.
>
> Are you at liberty to share the vendor name? Or should we mark it as
> "Elan" or "Elan-compatible"?

Sorry to jump in; this is Vishnu from Lenovo.
I have now confirmed with the component owner and supplier that the
TrackPoint reporting variant ID `0x07` and firmware revision `0xA1`
are made by JYT/NDT, not ELAN. The physical check also identified the
corresponding button/stick as white. It uses the same ELAN driver for
Windows but has different FW.

Therefore, the patch should recognize `0x07` as the JYT/NDT variant
rather than naming it as an ELAN variant.

Can name it something like  [TP_VARIANT_JYT_NDT]          =3D "JYT_NDT"
or something like that.
>
> Thanks.
>
> --
> Dmitry

--=20

Regards,

      Vishnu Sankar
