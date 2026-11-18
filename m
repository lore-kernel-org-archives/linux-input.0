Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020014;
	b=1g+VTMCBYWTA8Viepo+Tw7tfbPoIHGq9WrmUwET4mHorsyP1QufTrsQp4S5oBxVxOC/z
	 oXcRtXBDT/W/BOatsYqoqYq5L335lQpJC4uCtdejDWmQMCpZW8Sa7fROo0PmkAvmh88Wf
	 bYlW+ZN7nnw+a+wV4YiyDbOFA9bSHejkYnTLPJGhByYyVPOBWAbAubpKQaIyZlj8hOdYV
	 TaNFnFUKWY8IiZOB+sDZqy4/CHbcgemlMZ1vxl91KOh0JmngvelxS16GIkxJD2uPVohl8
	 YSe9us3PrHN3iCl5/U00JwJt9zkrm8uB1kHgV7Drp45GmwOPipvn4hU8jsVhcTLNu9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i+3+UkuuTd3PtMb87HnGpsXm1NEacz3pju9b62z1nDU=;
	b=MH1NRZPqt6kqkUIpRawHsCp3amOGE3qyutVVZfRJ4G5SKqNLc1fKRopcwMshFa+s5Icv
	 DIMVL0UqQe0JR7LdvbNtD1I5qQHWbt+dUK28cXzm+XI/EsHFdlLOslI+gbgpdUcbK5xJs
	 V2AGUrscZDjC8de+9RkWiuN6bs62EnptFHovFoC1xY+xUmYXcVAnxXheUmHNYcvOSsc9e
	 UZppCwo7BsPWAYUs5DO/Nal0+E2XhqPt9ohI+GGNSL7w58oHjkWdYu6nVI5fs4UFQsNqL
	 jY3AtmzTn3VqIOwStKEUmj7kBh+j8zMdKkzg/7Liut2y1qF5v3CaMAzZ3EvRxImvTeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4U9mTZD;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F683606A334
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 16:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F683606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E4U9mTZD
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so9816415e9.2
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 08:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795020012; x=1795624812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i+3+UkuuTd3PtMb87HnGpsXm1NEacz3pju9b62z1nDU=;
        b=E4U9mTZDlIksJjVDWFzuHLbz7qz+H6X/WuZ+ANBvE5aFdUKR8wGJnCGbI38Iz/2/Am
         DcYffqId9bYDRaceSRCjX0vLa8N2I1YNW8Nj1qZQ3GuZ73h9A9UTkhDsV3iQxJvUqloo
         1qMFUUlT9Uexndc0moK7CkwofIBYGR4tJyD+emRsHapyfy2d+KrUNsMeTIWGDmfsN9A8
         n0Sr1ChhOkJCtqcwuL0MKUD9rqm1bq+5vNOmBkoyrmnodDxhRqx2TCVJVvvt7P3+SNGo
         Wu5SygkvVbJnpy7Ekh/QhM6Qt7MKP3IelqkgrWCVRnNLdHHFr4gSD62k/UvxKTiQFyLW
         u3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795020012; x=1795624812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i+3+UkuuTd3PtMb87HnGpsXm1NEacz3pju9b62z1nDU=;
        b=04X8pPQ13ZVhLQZF7ir6fqu4MtJ8Xqs/2nIaFe5Iwuu2cUmtthMybl6yT0KqgaQrZz
         ag0tL6sTV1uYn8WtdQP4V1ZmOvdTkumuV3xoftuSb6hu2KISet0B2YWA8itRK2xe+jRS
         n/1hOdkF8pHquLZsRBkzY4u8AmtCZFzmCgr6GHeca1qdacTmf7dR8sAY/XLt3S79zQgl
         by99RABDDd6FVsCesK5ElzxtS9jkkOdtTc+GhOsbCB4S+sqisoIw2lgaIcEuthTtSm6f
         7+SUD8s33GI07l3R51Y0jA2+nI2UG0m8HmKeclZlVTRjdAijvTvLqcFJ91Ad5gilSIx9
         1WlQ==
X-Forwarded-Encrypted: i=1; AL+hErFCx/wOmEhcL2I3O30EMUr7UQf86SJ6gBKQqpXoh/LoWAOWhGRT82HlQ3OT/3K09MvYouh3Kqqr3Q9UBA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9QhIKfR5KzhIepHth6RJsjgXDbu2LOOgDyVrU3msSSzcpUEmab
	Y5DqSHKer+Qy5qWOggTBfcrySUoHyCuw8mDUr2cNFpjjVK8DsJvEzU8c
X-Gm-Gg: AYBFou2/5snxGXA1O8Gz93WVmv7tA67ympBquPvJM/SEwHhBRqX16XBlwhsYQSNRR+L
	2qm5bOzU58dNOXX0bhexUmoBPnmdMNQJ1sXywraDCQLI5Z5gZNwVTuLnuMgImgy0NMGYoRtUE49
	wGec5WYF+JzcjipS70BR+7xCvc4c1E7gwOiLhXIyrc8eTzfBwyqjBKfTfrYx6KGm4UrWTQRA4AF
	knl+fFBcml5Rfyw2yUfpw81HeQZm97nblCirqRujbPX8F684t7bJ2a61+iVm4Rbwcl0U6jAj/1q
	W8P2SpQHcrGQjkIfuS5S9J2HKsqB2xEg4KCmIs8xJJAtWb/kHThCAkz4L1cI6kqbWgNdVfMmLwi
	SvY2GiGEUHY+lY4Fy+ncNiYE1/yqZYC3k5bQEHgyXjgvtiGfptpsZssAXmdpQU5cR/gKuA7s0Z7
	4d1IuGy0BRVLW22yAmpZv++64GzLlB34PPIobTh33VdNaDN6Hr6tixaM1TbQ4omhU2EsIbLIUKf
	/sCxKVO5FoYMlemkxmKUOCXeIAnK45scUvJlsX1r7+07njMyHD8j0PQ9dUkH76i7MuQhmZ7W4jj
	3z10bx0GSLde4NqfkzyOmlUX75Fr
X-Received: by 2002:a05:600c:4715:b0:4bb:76d9:f81a with SMTP id 5b1f17b1804b1-4bb7da3d288mr60167565e9.34.1795020012419;
        Wed, 18 Nov 2026 08:40:12 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb78430918sm137986135e9.13.2026.11.18.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:40:12 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/16] HID: ft260: uart: add modem pins control via ioctl
Date: Wed, 18 Nov 2026 18:40:03 +0200
Message-ID: <20261118164004.28739-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <BR0PR05MB0491322068606AA1720DCE14C0837B2@BR0PR05MB049132.eurprd05.prod.outlook.com>
References: <BR0PR05MB0491322068606AA1720DCE14C0837B2@BR0PR05MB049132.eurprd05.prod.outlook.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 17, 2026 at 11:56:36PM +0000, Maarten Brock wrote:
>> +		if (value)
>> +			gpio->vals |= !!value << offset;
>
> Odd choice of asymmetry: !!value == true, then converted to int and shifted up.
>
>> +		else
>> +			gpio->vals &= ~BIT(offset);
>
> And here you choose to use BIT().

Thank you, you are right. Inside "if (value)" the !!value is always
1, so the set is BIT(offset). In v5 both branches use BIT(), here and
for ex_vals.

ft260_gpio_set() from patch 3 has the same two lines. v5 changes them
too, so the driver sets these bits in one way, as ft260_gpio_pin_set()
already does.

Thanks,
Michael
