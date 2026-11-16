Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811328;
	b=M8us95LHRqM3k0d2wvM+rA2rViayl5tK0YbLVnpAX8ceVfBrmypufRKptdwwCW/5YMns
	 TM6HcZTpdPEj9cC6QK9IPB/jwkvmD5zttwK3LYvdOfLOGDB3wengnN1ja0n0fEHuK3gsP
	 x+QbGvlgImg9BAlTn2QLl5pM1tt957o5itybfQFo30zlMAVzPxbPiKT+UCTy9q/8daSuJ
	 xepCqIBqBmXOSPhKwHWZ9bgbUssmwY7s/gnwKNUCheZ3b1lIu1YlPK8uCcqEUbEesrF2/
	 6839Q8LRUlqnDS9AOwGrjoRBbGSSSwSRhxh2oIG1Vpj+HiTWxeq2IfbG/BBei6E4MYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wRWcbRGa0lw5+zrHUwoAEHoN60ejoMH5x9ja73muYZA=;
	b=ckQPdfEtHsZGnVLHC70rJxTfVgue/DBuAG6P4VWypKlxstoSbj3q0xviXIqTyEOZJ6BO
	 sdw44pRT8pfT4+UjzOzooZWCjSo4o/odquJyLXJ+FpT3+g5awAkDZ4VxktI5F2cjwIpzG
	 XbQkUPtl5wazueoF8ycwWFUcgFmFac/MqzNuxn1f3cjSProdqhVzThIHoV2BMyDR6zV12
	 lbMcY1BQFnMQld790+n2fUU8Y0P7Poaj3OCVAE3K5tk3c2/MWiomQ8toAw5tPUEr8Bswd
	 mbkCh4XYJSvXm9FxEFh1nRGQdCvQO/nfoWmXvLq7R7qtL8RdzJrLJ8QwUGlUyS776JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifZf+Fwd;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37434606A31C
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 06:42:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37434606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifZf+Fwd
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ccca948203aso1331054a12.3
        for <linux-input@vger.kernel.org>; Sun, 15 Nov 2026 22:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794811327; x=1795416127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wRWcbRGa0lw5+zrHUwoAEHoN60ejoMH5x9ja73muYZA=;
        b=ifZf+FwdSDqg952lqdRo/+g480XgHdVYCnHVDpT/TyiaidyOuqYX8xE8J0JJguMUZo
         uKqHgl1Thu1cLd6z6/nqK+p8Y9+rRhdgTQb83+trn98vVrQ+vYgXI1eNxgEpif/R1V25
         f32rYfrseR+mgJltUArzqJlHFUNNzxVt/c9fzCoK2gPkMJkk33qyzsV6LinbqoWzN6fN
         70xcz3xTSeN0u8Ozxq/NdqqY8gNaTm2f4lBIx0q+JCPrIAfAZ0AeS80QgQRCCfoFJJ0p
         eM76MzSbQfcDm/rG7f69Lv3FIxV8cg5HYnWBBcs/CyZX2IkWDp98l2FYJTmOA7RfGs/G
         iKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794811327; x=1795416127;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wRWcbRGa0lw5+zrHUwoAEHoN60ejoMH5x9ja73muYZA=;
        b=EeGnXgravh37CfKVKkVMKAULTaxCIY80H0IqT2AIj3i/oqzSY53laQyk5Rd2ERzBmL
         RtyufUOUJYyv0lpWDpusJHSy5ZQRj+3Qxuc3Mh74Y6AVumb29Mx8oZYhYWvuLtCuucMz
         6IM7F+/qKkBIgBf9+rAZOBr43pZ2/syd/X48NHsCKjD2LCul1v6jKgMNdnnFp+6YYb6S
         uM1HXUNwQO8zE1SDzIQAx9VaXnx9w1gqZZBAZqSXUt3OFzYmrxjt0wwY+mOE5W+kGAGi
         Bnbn/ECDWbuA3l0qYktrxNjdVdBZ6naWJ6mOxCpgJ4DJAJkbULoTgZSUfLQDVkZciND6
         FF/Q==
X-Forwarded-Encrypted: i=1; AL+hErEZ3P7bdMdpv+jxbscqKLLkoSI8zj47lARgkyfWENzoJx2pS2n5ibcbz+5PY1GxGeFJzpnJ5bZGju2ahw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8H650j2+qnL/yh7oOj2+tDrQkPCA2q7oMmU4mW3bxrpOqERVpQ
	y7h34oUP5r6VWzp0Fibbqn/LRy3dF8yVrbMph+NiTIEnN3dMuK1tEe42
X-Gm-Gg: AZFdTZfMVC5GsgIUEMh+OVia+92pWZnn2f/FnZij9jq8xx9W5TSyX5t9JTLdZUX+2gH
	XcR9ZjZt1CkZLcuZ/XR/9HVXV/HdVgSYKJPBeDtAy5XYECH9w6q+IXNbt3pvuT391V3CD8a4Qys
	VqIZte0mLcxmWTeMRNCNmbjxvJ0niTrxpwGFnLIp7mzkUykypY4PS8EQ6h8FrPQi3c65EXDl1Z+
	c92xovx4fU1LReBAo/O8XcOJbr3jJrjrPSDhEJ7TagPGK3k4WaX10XvdKqg+89iCkpz7UgmOJPr
	WksDhCaF987RklbMpbf40a1MbSS+7nd8COwo+ykmS5D8IO90DgWVJz1oj548XefaidQIvjvyZQr
	hfrExodftYYZ+zTuZMq6Itb7DBQs4RtlVtpsmO1US3+AA4NhGsXLDQoiJXoeQuhmq0JXdrKbxdf
	MZG1s72ibHPgC2pgCwRIPEzGr7sBThXknQC4bGYU8m9eYq6Z3RfkOYgSidMZNUKS+TJrv2mc/xc
	5JjSHk4AiZglbjQZ5pHbdOUKnb2iY0YN6XUThw05ZTOTFfGQHw44srgfTXv/9YLkcO42S4x+8s3
	Tooz1GS12FMSHY6VMEXYvqxkH1jYs1OFLPXO7UENQ+L+IGkVBycaPCj+Oyj3nRWf2SZvF+bChww
	=
X-Received: by 2002:a17:90a:908a:b0:3b1:bee2:223d with SMTP id 98e67ed59e1d1-3b1bee22478mr5477449a91.53.1794811327578;
        Sun, 15 Nov 2026 22:42:07 -0800 (PST)
Received: from ehlo.thunderbird.net ([2401:4900:8fc5:1e29:1b2c:eea1:7fdd:964b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec43699sm14960106a91.10.2026.11.15.22.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Nov 2026 22:42:07 -0800 (PST)
Date: Mon, 16 Nov 2026 12:12:02 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Joshua Crofts <crofts@kernel.org>,
 Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org>
CC: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/5=5D_iio=3A_Remove_redundant_pr?=
 =?US-ASCII?Q?obe_error_messages_for_HID_device_drivers?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261105165254.00000896@kernel.org>
References: <20261105-19-oct-hid-iio-unified-print-framework-v1-0-0b360d9552d9@gmail.com> <20261105-19-oct-hid-iio-unified-print-framework-v1-1-0b360d9552d9@gmail.com> <20261105144036.00002e1e@kernel.org> <20261105165254.00000896@kernel.org>
Message-ID: <0CDD7FDE-6E03-473F-8910-2C33973F23E0@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 5 November 2026 9:22:54=E2=80=AFpm IST, Joshua Crofts <crofts@kernel=2E=
org> wrote:
>On Thu, 5 Nov 2026 14:40:36 +0100
>Joshua Crofts <crofts@kernel=2Eorg> wrote:
>
>> On Thu, 05 Nov 2026 18:11:43 +0530
>> Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse=2Egmail=2Ecom@ke=
rnel=2Eorg> wrote:
>>=20
>> =2E=2E=2E
>>=20
>> > @@ -377,20 +377,16 @@ static int hid_accel_3d_probe(struct platform_d=
evice *pdev)
>> > =20
>> >  	ret =3D devm_hid_sensor_setup_trigger(dev, indio_dev, name,
>> >  					    &accel_state->common_attributes);
>> > -	if (ret < 0) {
>> > -		dev_err(&pdev->dev, "trigger setup failed\n");
>> > +	if (ret < 0)
>>=20
>> You could also remove the comparison and just change the checks to `if =
(ret)`,
>> as devm_hid_sensor_setup_trigger() always returns zero on success=2E
>
>I suppose you could also add a precursor patch that changes `return ret` =
to
>`return 0` in devm_hid_sensor_setup_trigger() on success=2E
Hi Joshua,

Thank you the review and input=2E

I agree with your point to replace (ret < 0) with (ret) as devm API return=
s zero on success=2E

Do we find value to add new check and have `return 0` ?
devm_add_action_or_reset() is last operation in devm_hid_sensor_setup_trig=
ger() API which makes direct return as simple to follow=2E

Based on your suggestion will send v2 with additional changes as trailing =
in the series=2E
>
