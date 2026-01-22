Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4A919644B
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 00:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769041181; cv=none; b=n9EAK1ZbFOtI6BmhTT6v1QhoT/sB4YfwMdz4/+h2QstMKsj5EROzMYhgcO7mXbCMScHwmPX9H4JsrZKtzeETLn9UTKVNSbjz/U85cFmE7PBm/Ihsw0FO1nh5SZG2hEt1d/5nbTfMTbs2Ww79l66ezthJZ779TlA1BrdwAGQIKh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769041181; c=relaxed/simple;
	bh=toFRl0nd/GnmbDTIg/IXBPzUTdQ0PWBRGTaZB3JomAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vx3i79o1MrVsPNx1g6KmrChJkfs1K10ZFCaZgqFK49rMVOz726HtDtpNXhiHsn+358VdG+Y5/h+0Q6Cw2wksRt2bGR2QatPiJl8QwiMyfyp8EXFUvfrS+J4ymer/MKHYmB5RQX4m0k5b6LcBE5OAUDZCaR/dstADbyJE/z9Ee90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkYowEi2; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkYowEi2"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so778251eec.1
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 16:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769041178; x=1769645978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=my6oNj5dhoGNuHaCENdjfn2I7AS92QIvBlynj8gDnII=;
        b=OkYowEi21T/3wSOHMXcAWui3W89xbyktEDWBId1C7MqtYwKgxWayncCvcKuD/Nh1G6
         islSIRm+nDo0m0/DX0WxElMr+cL8bGoZRJh7Eh3S3+cMqmwQN4TmEJ2+lJJ2KqXOBYE2
         +WyX1jM/5Id7+6ir1peS/Te+EBlKTqz7J+224ZFxJijt2EHrVsLy1gI0kmjfGiH4vvaH
         TcgqxCgofRloR0PWpUr3HvCnxHh6XWVTip3Lbfp3n5g7A+ftg0X5w0kcXy/NRnRS7Pp1
         zhXCmJxhg6rFQYYRb/GZ0vdAQeT0bhHof/chG3z89rId2QOKJuiYz2oenoHnXnTdS7Qr
         B8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769041178; x=1769645978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=my6oNj5dhoGNuHaCENdjfn2I7AS92QIvBlynj8gDnII=;
        b=hlYMORa6ln/toVEJzD7DNYTc7DOH1QDowuEj5ndB10iY3EBFA6EJxDwlysNJX4EeCt
         WQc8lD40bqds6Yc6TwxLbaFTchVOmPCTKdF5XTDOMf/hksD9oKQnx7ckg7le54Mkb8xe
         GhxK/N+IoIwRRTOCRRpzVol8ceXt9+RIpQWKOPZHvGbl0KkF5JEDeW9W42cnSsFQJCnF
         ZmX20GL1/8YH1/G1kyC1ERhcNQ9KG8Z2RsEEbT/s5JepZtI403baZZbVJwDQICvgAUSO
         eVh1PfaXgBGKBJ1tbMxrXqSwij3WUB2/UbxXwQkPdWgcXGTso+EsRfIfFwDOPqxoIwmh
         S1uw==
X-Gm-Message-State: AOJu0YzwUC5kwO+SszBqadoAlgdHRc0t4hCyPCD30mSD3qTVkVUQD9Xl
	W/25gDlX6ecNdLkDn1eQ/uaDvfr4LKYbaX+3ZI0/XfTOXk9iDXKKHQ3a
X-Gm-Gg: AZuq6aLRW4IvbPQjRzlsQqtId/og0fWUnBTiOsxHicKo/J5dzpiq52esurHkcjdVvLp
	muLocTel5ZextmTE6O1jJvJTiAQatmQG32rTtG/bJNZOHsNptWxCl9TPnh17PkPnmNtKu8gxFNa
	nrFrSRvWEIX09t9KS3O+ZuOIDFv5ona2MOqfpWSisU7HRhYu3bVVRLPwqxrXm/wnArpJlzSMxD5
	mQvJuasEyf1vbLeMh8CNp0BacRpk6th4Kk4wLVTk7d4xzdwknFAJw6OnNlWk0KFAgdAQZdtUIBu
	5E1bGLKTl40EUIAaRmpBg90rIVWNumjPK6SXQifId0nYQ9YYLZnFk/HZjSUA9l+dfqHe91C4ncc
	2mpnOvF1JFOzl+tmS2qWsYzeDHPOwOhieC7hczQdVs11ApHZ/zQPxrWvPpge5Wp/Zg+rofIKLyV
	THK9jLFLVNKVBaK66IRlFrNe3kFXLlSTMUA9Es+nM57hzRW0/+EZrC
X-Received: by 2002:a05:7300:7490:b0:2b7:2616:2dd7 with SMTP id 5a478bee46e88-2b72616353bmr713722eec.40.1769041177042;
        Wed, 21 Jan 2026 16:19:37 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b70d7f729bsm7107682eec.16.2026.01.21.16.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 16:19:36 -0800 (PST)
Date: Wed, 21 Jan 2026 16:19:33 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-input@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Conor Dooley <conor+dt@kernel.org>, 
	Job Noorman <job@noorman.info>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: touchscreen: trivial-touch: Drop
 'interrupts' requirement for old Ilitek
Message-ID: <kzt3myrtfigzvtuw62eqts5tjfwvlueuzifk7dsm5jvawztsle@5wyzecmltldb>
References: <20260121230736.114623-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121230736.114623-1-marek.vasut+renesas@mailbox.org>

On Thu, Jan 22, 2026 at 12:06:46AM +0100, Marek Vasut wrote:
> The old Ilitek touch controllers V3 and V6 can operate without
> interrupt line, in polling mode. Drop the 'interrupts' property
> requirement for those four controllers. To avoid overloading the
> trivial-touch, fork the old Ilitek V3/V6 touch controller binding
> into separate document.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied the lot, thank you.

-- 
Dmitry
