Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795846154;
	b=Ll34y/Oz5/gOWM7Ps4EcDPuoqTzmyS5Q03xMB6wcE677UCfkaz+j3WtG3cZXTsUZyxvq
	 t8qgI4dgAim/mKXyR0NaBq52g66JcCWzYhuWIhN8oWSBUGKEhX+XgOSnCFqrfZlRsm0aL
	 Sn8smzoWUeEpleYkdKwnNGHEYAJHT1VWv7BFbEgWSaD2Z15YOxXyCHT3WCaf8GOoBBUlT
	 7+sKLbuq1+ynljJVaGx9EE8j64xp73L0Oz3tsRqeg02+es9NxMwl4A4xErsyw06Lp3ADG
	 f6sPQWkaIsEZ/WEsBjMY8o90sl+ADYDdQT6cvp2+9WMIqPzAGJ7ytJzEFNDlIUrBiYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795846154;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nQ2O6ohYt8StqDgtNbo2hP/n3Jenud58IIFUvX2imSg=;
	b=W8WVaoPukiuBqgDZZrDoJjr6On1TQ4tkxLbJJeSurR+jTE0Y8ojSLgrakeE+pvnD6OkT
	 hT1KhV0Qb/I8Xry3sXMetyf8ArrKcl7GOYyjPOhb6RDNE62dl7hG2z1blTYy/oEGePje2
	 E3/+ATGOy0ZkdNhuzFAGBJ9Oz8Wk4Ocr8OPhEu1DbIAuK7P7YOO3YDosOMnBT1lNmNFal
	 0K3Fo4gg4WZFK+prK3e28SKnS4Kvd4cXFSNNT1GGxYGdIg1qtWAS9f+uE8TlRO21HEvqA
	 zoaaf6/NDjfU/OSAw8KR27XrSlEX94U0udqc2Q9OFslPWjydxbV8GjT2fRY2vBRUnYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hpeu6/EH";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FA606A31E
	for <linux-input@vger.kernel.org>; Sat, 28 Nov 2026 06:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D84FA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hpeu6/EH
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-38431138772so11550741eec.1
        for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 22:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795846153; x=1796450953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nQ2O6ohYt8StqDgtNbo2hP/n3Jenud58IIFUvX2imSg=;
        b=hpeu6/EH1AuoMfRw2oJ6yRS0XG3jb8g7+4INvymDZDTO786NoYh0nYs5X7nkugYLZJ
         7jlFYhQl8Z+w2GGBQ+/FXkUxEZaOUQ4j20E03Zrs+4WauRDRGOjSpM+7u885W9UXMeGv
         4ojNOZ0yGsu8BF/7iHPP8VKZ8brkhe/TCvjE0RgTHiksbrTkDNdVnMRunY04himK9uAR
         LuW2vOtyR2uQWqpBKgc8qRdDyEU63S+5hNui5CI+qoMBCfxqgyUhk444O1PKE0MYrGGf
         FM4EucSA5FUL2NS8rpTIDVdg70ZpZAZYdbm/Phw/N1JBmJeRGRYdyBh0G5FtSY9Km5ZD
         my8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795846153; x=1796450953;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nQ2O6ohYt8StqDgtNbo2hP/n3Jenud58IIFUvX2imSg=;
        b=1WDQdTrhWOhRO1PZh8Hejd77Po5Egk/mnq5wbeYcBjSdiV5cIIKuuxA+HfnCnVmunz
         GjcQ7Wza4n2OHQFFT1WYx1TvxcZLf1/dWAUIDnCLV8Aabn1xtVuKG/4G/RbVGZkhI6g6
         dyyCzNPbN3IllWPGNzOonbthTD+vOLrIEHZMDgNRzzYH4ZlsffC50TrjkAzqIKEopuYE
         dL8w8EtBmo3/gfUHk2rSCAkSH3EGZwuPcE/vjn7gjIhBHM8UtY3xDC1QIo54n0hbqVBo
         NXoj4jG9fV91X+v8QqIveLx0sdH6bzAb+FDSGZyGTqrGw/qhtvssbD2N0HI6bL6OWWyh
         V0VA==
X-Forwarded-Encrypted: i=1; AL+hErF1aJz/yas+bct9M2O/pklr8AfATqk2XRTgzxie5yuDc8vc9R25FFoJ0j+sU5tkMLkxl3VrTPqDdDBEng==@vger.kernel.org
X-Gm-Message-State: APuU4Z+8uDJ3FNFmTEBJHPuf8XvkCvqFVACyraeFdxDmgbR5jaTEbozL
	XU9I2qmhMmjvZz7fuoqVCYI9paiynhlqh1WwmTQS6Aqe00qZGKhYhE0w
X-Gm-Gg: AZFdTZeUFknX3rslPqoq9uIqJA/Tzm6Ap19gt88UpUlAFghprRe3J/ejYPPKwv48EID
	0tZUyrmPvHp7S8WPQjvXqU6RKrQQHV2+ibc7YyyvAAc9AGWvMBmdpaQU20hoX/GXGFK4AgDbcQO
	pIyjazgfWqDhR/7Pw8eIqiwFA39MBxZ54zJ6aEiOztaLO68pIuiJr5IKS5DDIzTvMy6pboDNNK2
	EbVHwkVI3T0TDRYstS/ZGqUeLxqXUThL6h7CXVX5hXVoX/i8FVeSHU3gxDm6x/8A0nC5C7XtqXB
	iubotCnqrJfGBJxDrAb7DWI93g1hSow6SBgKfs7Lmq9PU5r9q50/1l64Ihabpd1QROperZLwIGo
	TONvU46rsgs27Y/yxS3Kr3tevIpiOhXjpHlfkuI8z+D0GEfbd5lpOj7PVLnxkZQ9gMviwQOo9la
	ETD5WeE6qI5T8GXSkrpSzrdKkGipIX7jaVImfJDtBz4+OThzkUN953zyM+6BkqSg2MfG7uXQBIu
	LsguEKScOK+/nOM0LJQCYmfqr/gbdudaTBS0M4NqgBDZuIggVAn9yqfg8V5sdniZQcct35MehAe
	qihO4mocZRpZCNGDDzPJS34Yxfb7VNbiuy3CO7c88jLFU2LI/tPbYNiptQChNVFftxKh14mjJYa
	qQxsQ5goJrqM6eLY=
X-Received: by 2002:a05:693c:87d8:b0:386:b896:319c with SMTP id 5a478bee46e88-386b8963d3amr15639221eec.35.1795846152934;
        Fri, 27 Nov 2026 22:09:12 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:aaa:5a07:6335:86c8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm83886487eec.14.2026.11.27.22.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 22:09:12 -0800 (PST)
Date: Fri, 27 Nov 2026 22:09:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, David Heidelberg <david@ixit.cz>, Andi Shyti <andi@etezian.org>, 
	Rob Herring <robh@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, 
	linux-input@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 05/10] Input: stmfts - fix
 i2c_smbus_read_i2c_block_data() check in status sysfs
Message-ID: <awpwAc8i8VE29tt7@google.com>
References: <20261127201050.3532488-1-lee@kernel.org>
 <20261127201050.3532488-6-lee@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20261127201050.3532488-6-lee@kernel.org>

On Fri, Nov 27, 2026 at 08:09:59PM +0000, Lee Jones wrote:
> i2c_smbus_read_i2c_block_data() returns the positive byte count on
> success or a negative error code on failure.  stmfts_sysfs_read_status()
> checks if (err) and returns err directly, so a normal 4-byte read
> returns 4 without formatting buf (exposing unpopulated sysfs buffer
> bytes), while a 0-byte read formats uninitialised stack memory.
> 
> Return negative errors immediately and require sizeof(status) bytes to
> be read, matching stmfts_read_system_info().
> 
> Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
> Closes: https://sashiko.dev/#/bug/linux-bd87edf0-6f79-4318-8780-d69205787e7d
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
