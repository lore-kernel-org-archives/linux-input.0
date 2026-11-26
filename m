Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795676448;
	b=mWdSm712+ZEyVMLebQ86bc8qrgCQEf3qoyph9wg6SvZKgWCVboBzEbfd5QN6hckn7YVf
	 xta4SfdFYV/RBc+u8801IHqi2wyG7lLQKfrV8YAqTmFukB1Z+esDvdBNMvwwN1YMefyeC
	 R+EOt4ZpSXgJM6ebsEhS6R8Q+tLGQBsn1rwVqGN9NFR7QJY1RhdbmLuyUTZ8hQr2Ps+Qa
	 qb5Cv/TI4xbKi1/nc2FHp0yFn2bIIuWCKWaX0OJr2RTZv+sN2t29filz0pJuPSE7xIssD
	 J3z42re80XY16vTYyoAI1K5P95jRhKAftnWZPWbbjsSW6RW5xvyJzGaLo24wayRHuxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795676448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=mStOOu/axIi7drAvoWRJ7r3Hx/Gyqssm2lxGWxjMuxo=;
	b=ZBHQbaVhUC3MvdwcEiLva1Yt5dsF1Pl1RWpnnzEBIiirngLDlojupCgZbV21RaIZBKCg
	 TRokIG2GJlYtrwH9EE9ftOzBbaW8Z7kMouOWH2FIwd5GzsYpaXFIKY2tOZxG+yl8t7Qmh
	 5QoOzh6vcRGrEg7OSEH9XCaB2VZnKEFt5Bbb1EmJ0+SAmxEp5C6AysO+GMuqR1x+gpuw+
	 jOy9ALMq+xdnUeoXFKUF7sOXEzwwNpurRati90jme3eSa7Pqhh5qze5+pFAnfygD7jHwU
	 ll+pG7ZJvAkLJOMgq0oC3oPtfaKXNLnUhbpgkFvoSkfPFAB+RYXIhwq2T2zIKMNu56Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a7hhHVV4;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02776606A323
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 07:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02776606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a7hhHVV4
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3863db981d4so9406602eec.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 23:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795676447; x=1796281247; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mStOOu/axIi7drAvoWRJ7r3Hx/Gyqssm2lxGWxjMuxo=;
        b=a7hhHVV4XOanpdnYhgaaWWjn3hQY2vIiCBe95lBhBpeE6+kD8kXxQL80yRTYBZuk8C
         S4GofioqWONYGV0yc4q3dokog1dyRPKHQ1srnEfUELPk3cBB7qALwKuE+pdT1UyNnyiA
         gm3sW/HZnwSOJVOzT9iMoJXxdkXcOJvsv6g9XO72BlEqnDdXT8pcE50wMyHoBNxsWeK+
         Zleg+TgfAkMjobN396QTacxqptPj0qLTGcbE/yfqtEj3I5nHR8qj47CPOVSPqw3+9zHt
         ZKrdIUnECCJ7fuJkAeDLLySC0dUkCW05MA6ry5TudaVmWUomAzG1uuoeAC7SvyPCo/Iw
         dH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795676447; x=1796281247;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mStOOu/axIi7drAvoWRJ7r3Hx/Gyqssm2lxGWxjMuxo=;
        b=jd7bPk/gJ3eQfmISJN/toqQZTfVFy/A7aEu6mvn4vUWSoXxQiYWYN7bIqdFO3HJbc2
         8brYIYdecmQS/oKaTuVch5Qw3BkuOGWl6Q2FHfgUglcXObR2uQ7KzJDU0gaQyREUP0KB
         FttEP4RRroRg4fb8hARv4R4TJiKR0evdKlHfb2o52P2abyYDEFDJ22/kqYYCRrMITxSY
         pvaBWc4Dof1eBE/54XI1rLxvhH+JAhXIVARoHrrpl7C0DYlj/A9ZqLOeMjTeuCzgBH19
         m8JwLVENsWACPW67+W4300ld1YlJeugJ3DTie62gj4gRMBYCR7CoKCKAIyOnphLwD2IQ
         0ovw==
X-Gm-Message-State: APuU4Z8JKtYzGKfz6E/S70byjDGpxNEejV1YGubC9GL2j+x4sY60ae9u
	qqrom3dC6uoWi2JHxntYrKxWNDHyCEPzplWPY10mUJAZcuMbDmmeGzyyT5M9fw==
X-Gm-Gg: AZFdTZdKD2+2FJMeZRT0K0vAuThclkUA6z/zrsMpvuHyW7wV1tqzyYjpC5wuVwvWjqB
	hRW82Nof8tzDryFeb8Fi00LB9PuRuTK0p2fcJ+3OcUngQy7PldvRmaWsmUWIv3D9MiZghAfr8Jy
	Cn0TNOMgVF9/deEq5/M6UO9S1Q9114TNPk51bJddVqejANmGsMXHz2zma8/42+Q+Iy7IliKfbsX
	dhNLpEwUq2jgV6Bt/SROtpOORYYognSONA1EFi+tAugwkQkt6kpFSK7NnaPk46QI8vPMywFDxY0
	Ht24/YxFD3Oi4WEKmAhGKVuSgkdQg9DME9s3soY1q7is84iS6Fqk2l0jqgDPlTvpXfU1d2uykgX
	Og9b0Z5A17kNmgzRuivlPV+0xsUGVevc5SyfD4wLaHL1N5CDJSpbAJ+7Bs+55MtRXhg4Pc8QhMq
	J7FaZjbfs2gf9TX3p0fkW2e9zY5lx39yeivaHFU5rxBpyBR+zy09axxoHZ9wUje0dMXVdOrMpZZ
	J2/p+A+BLNi4OykAaijFDFnr6G1qUm1OXZXbvl/aYKquwN4CPIQagZJpBXw3ha/PoN5uXWbwN2X
	74SNDg37Czi+dnbA54sYi2Zc4LzoWx4zJnqa1vl/3CN8e23db35TVEEnz5dDAlygfhw2NkPsfqu
	TNXyOTl74Nco2E5M=
X-Received: by 2002:a05:693c:8953:20b0:386:a70b:75dc with SMTP id 5a478bee46e88-386a70b7837mr13493407eec.11.1795676446987;
        Wed, 25 Nov 2026 23:00:46 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:f528:8797:fe51:9f7e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b1965c02sm28281445eec.27.2026.11.25.23.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 23:00:46 -0800 (PST)
Date: Wed, 25 Nov 2026 23:00:45 -0800
Message-ID: <263aac71fd9eccb3cbf3674ccdab4c20@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Input: rmi4 - Move sensor initialization into own function for F12
In-Reply-To: <24dccae7-71dc-4a7a-92f9-bd5e627f8063@ixit.cz>
References: <20260731-synaptics-rmi4-fnsplit-v1-1-8175cec2ded1@ixit.cz> <76e9ad4b-7430-41d3-9d31-9f513beedcb5@ixit.cz> <24dccae7-71dc-4a7a-92f9-bd5e627f8063@ixit.cz>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi David,

On Wed, Nov 25, 2026 at 05:54:05PM +0100, David Heidelberg wrote:
> Pretty please Dmitry. I'm not asking to get same usability level as with Android
> driver, but at least small amends like making maintenance of these quirks for me
> would be really appreciated.
>
> Saying no it's also answer which would be better than silence.

Sorry for the silence. You are right that a clear "no" is better than
nothing, so let me be direct: I am going to pass on this patch.

On its own, pulling that middle block out into rmi_f12_sensor_init()
does not really improve rmi_f12_probe(). It leaves platform data
handling above it, pulls f12->data_addr into it, and leaves sensor
tuning, data descriptor parsing, tracking buffer allocation, and
rmi_2d_sensor_configure_input() below it. The split really only exists
for the hardcoded-descriptor branch in your v9 quirk series.

More importantly, I am still not happy with how the quirks in v9 are
implemented, so I will not be able to accept that series even if it is
resubmitted. As I noted in v5, v8, and the DT binding discussion, I do
not want workarounds for non-compliant knockoffs running unconditionally
on standard RMI4 hardware. In v9, the PDT filtering, hardcoded F12
descriptors, and product ID fallback still apply to all RMI4 devices
instead of being gated behind an explicit reduced-protocol mode, and we
still have not agreed on how to isolate these devices cleanly, whether
through a separate non-fallback compatible or board matching with
of_machine_compatible_match() as Krzysztof suggested.

Several other issues from earlier reviews are also still present in v9.
In v3 I asked not to hardcode a function whitelist during PDT scanning
and to use a bitmap for duplicate tracking, yet v9 still has the
hardcoded switch (which is already missing F1A and F21) and uses a bool
array. The IRQ read alignment patch shifts data->irq_status and the
other unsigned long bitmaps by one byte, leaving them unaligned. And
the PDT fallback patch reads PDT registers inside rmi_driver_of_probe()
and keys off "syna,rmi4-s3706b", which we established describes the
compliant Synaptics controller rather than an aftermarket replacement.

Until we agree on how to deal with controllers implementing a reduced
RMI4 protocol cleanly without affecting standard RMI4 devices, I do not
want to land preparatory splits tied to the v9 quirk layout.

Thanks.

-- 
Dmitry
