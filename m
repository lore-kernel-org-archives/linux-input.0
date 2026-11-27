Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795742079;
	b=BO+ivg17Qypol1tmE7HwUueY1p4WaoKeaotzkUZXevExcxGVRiPT75JnZVytdaOVNaac
	 h/1dw9WmtRn2SPJGNY+VFsdDlTQEgRHbdeC0rZIkPD2R4ddHlH4Wd3Qe7Ty89zZ+Vpb4P
	 9UBC9AeQEPFs+uPGmQWZQIfbZ4FiZ4ffdiUQOzBvYqXk6QoRywbhZwESMvqVuA32CYJcm
	 /O46zd11+3wJ3Dv1mRhUIXjmZfp3FpBvdB8M/8tAze63lupnjnuRmf6NvUsZ7S0ck1dZS
	 Kh4w738C0jhP/3kTTS6Cya2W961do+gO4cNYkmnH+mKdVxsGDBIYOoCXNgyMWf+1LQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tUBA6pVGVzuWRSoOa+DeUxU1u9Vo4hxpo45FKzvoAQQ=;
	b=lbgy+Tfe0QXULPjr+ZySzr/LHEJ12a8/WwIr2rxBzgrcSQPjCi9n29BxfxuxRF/R1a0H
	 wtV40ajwmKS4e7V+YKPyrq6pqhG0gndTKSyGgKfjchs3M1oVlGpMA3e942o6ZwXxbY7P3
	 AmlW3oIYT5rlDoitVdNLhkKM8ifeE+b8Q2kpPJ5RwBJxee4AcS2oZ1vaoGq+WguQSQMcP
	 +1WdM/t/I4BGQRs8XKFA5OfnT2VU5u+Mbn37IirDOqlL87Dn8aJKEMd/QDKelrzIUzmIk
	 70jUZmvSRFlUPW9tseVdugLLOfalVv90GirSSJMNtmxTcglSiZZZi4tD9rnokT64jMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ffNnuWKs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E4606A321
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 01:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB2E4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ffNnuWKs
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso10213287c88.1
        for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 17:14:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795742078; cv=none;
        d=google.com; s=arc-20260327;
        b=MrrJvvAdW+GykTZr3roV+sfuCH99c/A+IV3zmklLjUi3TgAbFVFHAKsQ8WTzAY/9Lh
         hPT/tOphK7RchIjF5/10ptIONcjsDHwVQ+3yWRBBjSuiZdg2UUMghw4vfOOCysj78PUt
         OQxrurOH3LyIK/cVzALseDzMIBmW38bgy5LrRGdFsaRry4YqRq2EwSjAdVdYwe32S4cx
         GJilApUaPPQUPsc32AonFcejsl4FJdQiXyplt1CiF4pf7u5VX50S5ahor+9MeghrlelP
         14dUevkGDuv2UpZtkrISairtfp4gfV+1N7ETDolaef0oFnRf5DVW4uuNrduNOif5cPpd
         QByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tUBA6pVGVzuWRSoOa+DeUxU1u9Vo4hxpo45FKzvoAQQ=;
        fh=LkAdHJfTjQWeE/AZFAZQUQtx3EvEZqnrX+L1nkZkm2A=;
        b=s6czSTC3qY8VNab5wBtQMjH5hYCQKMY25HquoLdlqRezFk1mlyPKSslveSMaspJW+y
         82sOWWp7OwunKyIN0RPEqH4yjkSXAhLVukgFQYML7mi+1pnPWQWkKbgnRj25Mrb0gUtb
         UWLB1w+vUxQqBNYZFtuD76xFMzr2m7/XhV5s+/zrX2FG3WLItu7rigjyrTUWW/72jKr5
         LyjjtEqJYvZRRjO02sEt5T8cSkj1ZXXmQHrVjyuuAh/l1izvxHgBuK03kFz0tlr/oFpM
         C00dQgYyap2wnUdEMTN1ew+Sp0iC8rua2aoY5kVZLSfBCOGMPognQxMTdVldEEJo8RTO
         9dtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795742078; x=1796346878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tUBA6pVGVzuWRSoOa+DeUxU1u9Vo4hxpo45FKzvoAQQ=;
        b=ffNnuWKsKYf3sXG4mlzfQOZDnQ75A/qYCr+clralhQcT6oOXBXG0tWjZStinG/DyYN
         bbuusKzV/KbqywIJB81kJXk9ODltskVMUuVVf7AY4vdkl0PoF2IfWcFv4XoXXbp/Nfde
         IV/QsMH2QZ76adKWUtTDal6dwRH5Le10IH7ZtAmmPYXHKkAnuNHgxuYXRFPOE16IuGN0
         bUprouJRbFA6+bTbtz6yXe81amUxWejn9wIi0Y3jkt65m2qI7HS0J7huABICF1Qwjl+C
         gctpVnDwBibg2moRpmhEDlELaBEpIBIhS7hjwSEFQkRj4ZLzCS5U+Ncy+kQHIpv5LBgE
         ATtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795742078; x=1796346878;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tUBA6pVGVzuWRSoOa+DeUxU1u9Vo4hxpo45FKzvoAQQ=;
        b=hnRv8GMnh/blZPdHKYPHRayYYCCm7EYdrm7lAX62tPSjPUm/N/gjpB31Kszdy9wJ7j
         tSK95jJVf0ObSsLaK7y2FcCVCMIi5iUbGvAvqZkaKKFLLyDZ03E1oxqmPRtShTnhcIRJ
         CHcZoY1TiFiP6xKkVffcAFnB3LbEmsdGSrJjjBd46EumNT9f5au6EupxJZDUuhAK4pys
         T16rxNQtup8WGCHZ/Qgzyh/fmLhxAGP1rUvL3xXd9BSFY/UqOos2RmsekhmT915RMS5U
         kFsHbapdtqY7VIWq/ZtCoRpPMcYE2l5/+E441MJVAPCbISz5QY/rXEzLdZm4qXsELubh
         ZPWA==
X-Forwarded-Encrypted: i=1; AL+hErFQ2eCrHljRDcZ+79gqXGx1R0SelgXWR8+rlCQ957gZoHPFSbwyoFYo2G0gvXoOfj3WqfZCq2T9Ktu5YQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9isoN8ZxoQQUu4Nk+P0aRsGNtZYfhfK1nqh+q8qcupA64bkppJ
	xyplhMUC8uIqlq4psXllDptq4yIEuKB/M3nNTKspzmKr2xja1ThCLt5t0q7V3d4aUHjW3xLxpum
	QyHhL2KCMsX0ijDju+QvG/lZF4tNIewc=
X-Gm-Gg: AZFdTZchwYnhiEueoOF1vg1D/niFjjA7bywFvItvgbPgSmBBMASjtRjfsyu/v42efT1
	LLomig24gVu6DSk8Cn/zRrxRP3g1Y5rEi/gAjcqMvyOTk5Fy7QtBvT5AB9RVYjBVZ4Je7HLKeqF
	z8RbYuiUqTIn3jebpQM5tk7JEqFyjLEjfTQkCWNC88U6f6Mb0vFwau5Ta14pKooOS24GcT2uDFF
	TSjEQGH5fTVrj195C6E0LevucJLLVCf/GvwKFFMYICz+5IgFnJuuN6R2GFqXeODf2p91NCB/GKH
	c8B2JjN8AC0enSyvVKALMbiiFYHFEP7dvAgYsa5W3Io8IoCxavDYQO/7Dv9gr5FYiXT9Dle2msY
	QT7oHyFWfXuTQqm54kextoilt59/wFvjJFFKQ
X-Received: by 2002:a05:701b:42c6:10b0:1b5:49da:b969 with SMTP id
 a92af1059eb24-1b5568fbf25mr23134158c88.36.1795742077731; Thu, 26 Nov 2026
 17:14:37 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com>
 <20261110-legion-lighting-rfc-v2-2-845726afb71c@gmail.com> <3e8f3452-06c1-8194-2d76-524418f0194c@linux.intel.com>
In-Reply-To: <3e8f3452-06c1-8194-2d76-524418f0194c@linux.intel.com>
From: Ciro Pedrini <ciro.pedrini@gmail.com>
Date: Thu, 26 Nov 2026 22:14:26 -0300
X-Gm-Features: Aa3M54ooPyM-qjfnlrGm_Sa7EwjiM7vZt76XOBAjXwxqti8qG2MPIB7IOQa6o2o
Message-ID: <CAPKD0HcrVfvQyCTZ-1s26EO9wsLXxwJoeBRMro5jmt0BRjbAZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: lenovo-legion: Add keyboard backlight driver
 for Legion Gen 10
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Rong Zhang <i@rong.moe>, Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Werner Sembach <wse@tuxedocomputers.com>, Aaron Erhardt <aer@tuxedocomputers.com>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

On Wed, 11 Nov 2026, Ilpo J=C3=A4rvinen wrote:
> Thanks for the update, this one looks much cleaner already. :-)

Thanks! All of these are done in v3:
https://lore.kernel.org/r/20261127-legion-lighting-rfc-v3-0-15c55d9f15b7@gm=
ail.com

> > + if (ret <=3D (int)sizeof(*msg) || msg->report_id !=3D LEGION_REPORT_I=
D ||
>
> Just remove this cast.

Removed, also the one in raw_event.

> > + hid_warn(hdev, "unexpected answer to 0x%02x: %*ph\n", op,
> > + min(ret, 8), msg);
>
> Printing data like this looks more like debug level stuff.

It's hid_dbg() now, without the dump.

> > + WRITE_ONCE(kbd->led.brightness, level);
>
> Please add include for this.

That write is gone (brightness_get reads the hardware). The driver now
keeps the last known level for brightness_hw_changed with
READ_ONCE()/WRITE_ONCE(), so it includes <asm/rwonce.h>.

> > + * LED_BRIGHT_HW_CHANGED: Fn+Up/Down are reported to userspace.
> > + */
>
> This only documents what these flags are so why a driver needs such a
> comment?

Dropped.

> But could you solve this with devm_add_action_or_reset() (for hid
> teardown) and use devm for everything?

Yes: hid_hw_start()/hid_hw_open() with a devm action that closes and
stops, then devm_led_classdev_register(). The .remove callback stays,
empty with a comment, because without it hid-core calls hid_hw_stop()
itself before releasing the devm resources.

> > +MODULE_DESCRIPTION("Keyboard backlight of Lenovo Legion laptops (2025)=
");
>
> I don't think we should put year into this

Removed here and in the file header.

Thanks,
Ciro
