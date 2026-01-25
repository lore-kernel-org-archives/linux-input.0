Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C3EEC3
	for <linux-input@vger.kernel.org>; Sun, 25 Jan 2026 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769318939; cv=none; b=Y/HeetANra/XKKjogWEhXatqmx5SApA+hst9ks7elgzI/xztCyVXpIpGVYP+HJtEJYqe6VzZHC8EWDuhfd4At2+IHqwFi2ch5EAYP3ixl3DI+5pIvPw3gqWC+oEI5Dgux/0xqtOpELvS2YDaE5od/z9nlCnhroms+EwK2cuMbhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769318939; c=relaxed/simple;
	bh=mUoDWOZFX2QFCGblT3FmWE9mkkOr/I9fos4XR43aXb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnxYbVNOutYHa39NE0ckhrnUcCppwPchWjQGN8rnC8DNCRkgOQdgwa62/V0KgYfBI5H/xSBRJgJNRq7nMoc1ayRnW72GUEZZzeo6OPjKtZhM9u93IK1JNsL5P8RsZiHRZbG1Mbul4s53Iq7eWFMSNNOsgtdbss78KbBh6+syoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTewf1v9; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTewf1v9"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b74f839bdfso583402eec.1
        for <linux-input@vger.kernel.org>; Sat, 24 Jan 2026 21:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769318935; x=1769923735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LsS12VfkA2nBzlw4DSH3X8PhObfJEVs7+ihgzzJpKqM=;
        b=CTewf1v93dOZvbBqFo4MJvlMcrL4VBZcNWtLWBBOQiaui+u795aLpet3jtXD2lG90l
         H4eZwcXWfQOetlnTCkyIjocDeB5Erf69OqGPwaQyBQKDnZlDDo6uJlS7Z+uQiKNhpTa/
         cXkLy3GhZlg0+xGklcOA9WKrYKJH+bGLuwpCfY4q1udjTGOgyYxXM7qJ8TrWAwMhH8cq
         JuciqyWjkfVZGHpQwYb7zmOwA64pzQLC726WU9edDmy73BB0lGiNFvAmUhzppuQoFtqk
         MMhpDh8iT7JaMVf0Yb5e92MMAI9yAR2zfZO0bg+wyEX0pbNlyGDXQ7V6/uTZa34+so5k
         5Oog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769318935; x=1769923735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LsS12VfkA2nBzlw4DSH3X8PhObfJEVs7+ihgzzJpKqM=;
        b=ERA0C3JbiDTHBgSwQjSlzwER9c8WboCJQL/5xdIcHCLDWIp+gZDlOLh3h38SCcMhY+
         p8DDGyQUl65YWlk2zpq/UuA7iyd87xx9xom/sVvScCuJYpajOadPMt7ClPjTgODuaRaJ
         PqoIwvnR2FMN4Xq4Q0L6IstALsD6FS1mTYEog7UNjdTrRWH0VdWxZbgMZmDPIom+Q9/d
         emrH08VFowEJ3R4GplEKj0/fRj1KqhvN0+PGlzSV4PuiCmd3vhI4v16/43bvV4pvhvGi
         oDeG3rn0V7z3adkkVfQde5VtCT2B9Lbyn+M5nOvcztJYW5Crj+QTjNmK7EP3jMrrZ5ZA
         v7zg==
X-Forwarded-Encrypted: i=1; AJvYcCUQgcyjMeH7mVJp8yaRPgGP2uUQk0XV3qaIoad3xHXHtNFQRhUFIFhN7pZA+ssyKQNlfW+dzcxSfvtjIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAn3ZfofT2LgJkL0YCFIpqp+oD9AtJ2TcGB/wFsqh9h7Umyx0
	dYw5ICHlT/vA/lMt9PuMCP4izq+128eDzIO55LovWz0guGj2LPC99bh3
X-Gm-Gg: AZuq6aIPkJaI1IYNnYljOM96qQm7TAUaa1emP+2b3r/ZhenF5/bRb57EdyE9talTTV7
	GuNNWhqQDLEsbNpw4bEdIPjoatDD6Sx2DVIvqFGqkhDtUnEf/wRwFLxgD4ONgIeEmdr5MRAUcfF
	rBEL7QGlymEsZUx4Aj8oKQYZWx0m1clw0x8whnXUmtMK1akvNJErL0VCt79UHnkTAaq+aTcYgpD
	gwIZZSRkkLtq9Yo1amkFQoPxhUY4O3UEYnpq4QubDGP+P8jQ6HBvH+ZCXJSxsaLBByuxrHibgHD
	WG3zofx8F6ap1uI6D2ZClOE38+SIHUMbuKuXzfs4Amq2teEUFaVsMQAX7kzQEiU4fZPRInr20j4
	8HsDjCR0pgRNSgqSaV4Acm2MCDKKK0Lj/Ryh9i5OB1+Q/DE1NxPDvgR5DViJdZkWrQ8Iol+XO4V
	0+GPaESED1krtF/1X+jn47ZIK//xEurwvAcuEPHNFOJygtZ0+bvAsb
X-Received: by 2002:a05:7300:a887:b0:2ae:5431:948 with SMTP id 5a478bee46e88-2b7638ab9a8mr333016eec.7.1769318935185;
        Sat, 24 Jan 2026 21:28:55 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:106d:a8a0:84b7:2d62])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a6919dfsm8940978eec.4.2026.01.24.21.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 21:28:54 -0800 (PST)
Date: Sat, 24 Jan 2026 21:28:51 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dt-bindings: input: touchscreen: tsc2007:
 document '#io-channel-cells'
Message-ID: <prk7r3ckjun77pawdkxpxukg5bv4bj3mv4stjkbyx3dbltnni2@cwy5nqp7e25s>
References: <20260122193549.29858-1-clamor95@gmail.com>
 <20260122193549.29858-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122193549.29858-2-clamor95@gmail.com>

On Thu, Jan 22, 2026 at 09:35:49PM +0200, Svyatoslav Ryhel wrote:
> The tsc2007 can be used not only as resistive touchscreen controller but
> also as a ADC IIO sensor. The second use case requires '#io-channel-cells'
> property, hence add it.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Applied, thank you.

-- 
Dmitry
