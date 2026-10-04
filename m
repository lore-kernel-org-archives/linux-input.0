Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com [74.125.228.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511C480962
	for <linux-input@vger.kernel.org>; Sun,  4 Oct 2026 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791145813; cv=none; b=mwdd8GA+TNGTa5WGxt1M7TqEhUFWC7pOqh28J6sNdXm3a8/w4/ZqN0/6kQwfR8OpJT3JSJJFbf3n4ruzOjUVCMkmDZKuDbcez8mHyme6W6rpAjKISY/FMJZSCmfU8zt56LGp9zL1vrq50o4RPAJlXUuj/RgX6nUDzWrVagGeJRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791145813; c=relaxed/simple;
	bh=NjrYE4by8IUGX+jLXXoEkanz9j2cBCv2snn0lRwRYoI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:From:
	 References:In-Reply-To; b=un5n8wmvlxDbktPYBkQe4oq0+qkjzho9qQCAhDdvzwXaAxJb9JSU9bCLvFox7tibSO4iC5cXOHdzHviTJqPUKVlmcnTx0PBoR4Gt/QEQhBO3zyFDS+yVfawj70TUrP6PaOlBPCJ3hMIGutQmWy53fonHcotAHhoTcSy6Kazo6so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUpxe+fO; arc=none smtp.client-ip=74.125.228.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUpxe+fO"
Received: by mail-ed2-f31.google.com with SMTP id 4fb4d7f45d1cf-6ae42b3e901so633635a12.0
        for <linux-input@vger.kernel.org>; Sun, 04 Oct 2026 13:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791145809; x=1791750609; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NjrYE4by8IUGX+jLXXoEkanz9j2cBCv2snn0lRwRYoI=;
        b=EUpxe+fOtf9EksVMIs6LJzFRu9HdFznWGj9BciYZ+KiHDySiC4iCh6ahHGO52Zn5sc
         ehlvUPwCv8sMKa7CfsTLvolTKpOHt++VXeJT+EtmyyG7rdZdRS9TjhVq5/SlNwb0WYnJ
         2XQmk+0meesqS23m18pUgWwCJYMx/SnLnF9EhaebBVKHS2QdgJ9MMKTJzXBf5bA4Xgjb
         u2IAXM5AKHTtvD6qv2YuWF2ynMztRZqXTYwnqAbY15lkOCCTJl8LHssFRgY25+M8aEbp
         TDEiMay/OwBILtxX2fScUZh6fmPD/WbjcoBDWoCl4CmKhMv6MiWAiYuhEP4hhOZppXs+
         herQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791145809; x=1791750609;
        h=in-reply-to:references:from:subject:to:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NjrYE4by8IUGX+jLXXoEkanz9j2cBCv2snn0lRwRYoI=;
        b=rELsDjvQ2lNWmz1iGth4ZvKPFRODPqNNqZ8Jgwx4drERPYcmXnc+DVbRonDtoClBDp
         oW292BEg4EFonNjB7Vs6RzSpLB3HPTl53A0uyvnoejI+61IhFcXjEHEi2SZsX6usjvVU
         jXD+l2E6lc0PIiKrfPcyoPC0jpy1b91c/llWI/ivOk0dwJ3GkZ4zQKF3h4a4EtO2ruUo
         eNK26HxMPZwJe9tCG1bLceJcKwZdQXMfzWCa2dETT5RVv/nE9X9VPLHPAF4pC+PAo5g7
         l/f5/eLmti+8mjtck0Ak09hiqGWLbivZqY+mL5HsKHWWJk6cAtQuzLCpF2YVwOqVZumN
         oe9w==
X-Forwarded-Encrypted: i=1; AKwUvByIFYzR6pxmXmsIXc9Kv4H6wDYjvQYUb/ZQ69eWVe01EqkaOkTi5WwMfsDq6XC51fjZCbL8Znq/801HmA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLTC2hHnaxCvGMXTqodL89QCHdjd56prOKLArwWWfsJQseSMbu1
	r9x7apogPUz+JVnSXZYWxxTBgyIeBg2lEjWvtEHYh+n7fmOI1OHMEQMS
X-Gm-Gg: AYBFou1r0yI70p3Ok38SWtBJXCOdMv2CjUyjVr8y/fGzRIQeafFvjLaIIu+ItL/Adkn
	ePHZfE0bRx32s1JGA6+pNuIXX2YYx6Af20W2Xx1H1pNPnW8U90BEW9U2Upd5S4rbiabZF9d6JVd
	e78QakIGaTSeA77PqCwHIUgGkGrvM6d5fJF7XERGMc00WhMwDL8jM99QypyO0WP33jJOu8KiQVr
	Jgc4jFQpDfeeaknliO2U3+LJB2q782Ugear4UBhLC/FHRQqNWqeMPq3P62BfnQUQot3traEdJZi
	ZslWsO1Q2gy7t5BiGAcT6PoAzvXkI4TzjyFc32CWAiAwGYmv6XbTjIcztzUfNW0mWpnisEZDAK4
	WBZuw38laqWtWrXotE8pFmlo5PZoC2RPH2p57EM6c88N1URsLoMpnFTPLQYYk5EuA24wLrY+icB
	/dUf1lZVhUIeOQjRmblu72zdSruZJ8Ljod9yaTEjNt4oCYAHz0omoqNTOPsCFcWiWnMTEI2WLkE
	2X5RrM=
X-Received: by 2002:a05:6402:3819:b0:6ac:7d58:dbed with SMTP id 4fb4d7f45d1cf-6af9e2cb07bmr8078237a12.3.1791145808710;
        Sun, 04 Oct 2026 13:30:08 -0700 (PDT)
Received: from localhost ([46.205.201.71])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e592csm2343641a12.6.2026.10.04.13.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 13:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 04 Oct 2026 22:30:05 +0200
Message-Id: <DLWC73DK15W4.2LCL8MREV6FDM@gmail.com>
To: "Daniel Golle" <daniel@makrotopia.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Hendrik Noack" <hendrik-noack@gmx.de>, "Arnd Bergmann" <arnd@arndb.de>,
 "Ferass El Hafidi" <funderscore@postmarketos.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] Input: hynitron-cst816x: respect touchscreen DT
 properties
From: "Oleh Kuzhylnyi" <kuzhylol@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1790944534.git.daniel@makrotopia.org>
 <75b8436b900ecdce7f29513a7403b851986a3a1b.1790944534.git.daniel@makrotopia.org>
In-Reply-To: <75b8436b900ecdce7f29513a7403b851986a3a1b.1790944534.git.daniel@makrotopia.org>

On Fri Oct 2, 2026 at 2:47 PM CEST, Daniel Golle wrote:
> Parse common touchscreen properties and use touchscreen_report_pos()
> instead of reporting raw absolute position.
>
> This makes the driver respect the touchscreen-min-x/y,
> touchscreen-size-x/y, touchscreen-fuzz-x/y, touchscreen-inverted-x/y
> and touchscreen-swapped-x-y properties.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2:
> - name all the properties the parser honours, no functional change

Tested on Raspberry Pi 4B with CST816S panel, with and without
touchscreen-swapped-x-y. Reported coordinates are valid.

Tested-by: Oleh Kuzhylnyi <kuzhylol@gmail.com>

Best regards,
Oleh Kuzhylnyi
