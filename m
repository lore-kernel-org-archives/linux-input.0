Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795495366;
	b=iCJNY2k8bhgf/SftHGlHdr7VuXfmwKHAoOwT4kCaxut9TNqQQVyA9Fm1nP5NATqg3zP1
	 jsCIpMh5zsEMc1Bjhuqb/2gczdl4/bsMubkQtbZ6qsdprTV0u8Af31QmnsN/jtfppwXKz
	 joaCygfxA9/hZ/O1glb9xlIXuFATI+zqQ2WL3uBGRGrn4rlABTbqMT5LOqdbkGYfuxDHf
	 uMrUYnKyxOn9X9cJhBgD9mV0jYr7fa7HKjul6h7s1CiLhPYbTG5/nCKrqGymsQUv/Pi/e
	 8ToSGlaz1ZqHpzl3lshW5dh3poCvNcNhuQY1sj9NIAb0RE0wWFE2PZWrbW2wYPRmwLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795495366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=BVM0klEKAcwZ1Rgn358Q4l72nbxlX3JpSv5yqpJcU1A=;
	b=d6LXwjlFlg9k0NI08D8NdutfopgVxG7jLjnL9yMWDeoh/LBhRiQZ5PsYAj8ei8NcoJsn
	 GgaecOS/1n7/CENBUz4gE/cQOe5gEGFKY9ucoCxm0PAoy72biGppVnKxiy5pwQusUOllC
	 rmfKKsBeKnQyGw1jfbBctuGJNmfHknjhsD9mFuyadzDtW0eDLklOjLd+NxPjlzyPTRzyq
	 nFOvIySM7QOJ8cBScxfZkGWV15s7c1TLY8vzAIijv07fgXtRzBfAYdTt1IvyytTn/Dr7R
	 FDOYi6curjWTkXXZY67/9cJWds5qlGGYL7aGWeF1q3/mJDzksWZiM1U2PosXFxMZTSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCOXoLb0;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 088BE606A6BC
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 04:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 088BE606A6BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TCOXoLb0
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-38644aedba1so6267097eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 20:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795495365; x=1796100165; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BVM0klEKAcwZ1Rgn358Q4l72nbxlX3JpSv5yqpJcU1A=;
        b=TCOXoLb0Fd7EWrHlEUDshBAKxbWOLCYu03wn9X4bfGaFTLPqwL3T/vcfsAFR2eoH0P
         003fq06ou+l1j2ZG542h3B4AiX93jegkRi58ac+u+KCkbKSma35HTDjhaRSuiBejPU5w
         x60nPAZtBvylYXuSm/Hy8DgZX+eyUnXxwc6lSJjdJ+hAEY2hFdhiLBLvqo2SYlFoaw/a
         W/lS36sDxZcSysPmSiM1sQgZ3fttMdUjBLxRUdnE4AaLfwiJPtE1i4qvVKT8kkcsQyov
         7h00fJPrnMykzACUNOg0dudPrpta+g/cKxkPmnCMwhy/W88gkX/n9rlYMGKLLeI9dpe9
         iZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795495365; x=1796100165;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BVM0klEKAcwZ1Rgn358Q4l72nbxlX3JpSv5yqpJcU1A=;
        b=Ua7Sh3IP/z13ZhcNZ0KyzEGEfHfIWc9H0shuxAJS7VU5xUTaC+mHpltjMnzETYpGpf
         e7DLMweHfU2CsOANCxRmVwiOsEr+wXhx8zakuZiu182rvtIgkH1gAQk0jQ3oGFe19qMT
         MBjtbdrrVPA3f7OAwSP21xAHEskMCdjLN3x/VTFmsA1DQMP+OcMEMC9A9hYJdqg9H52/
         vC4+lus3ofOv7XO1D5NPEIo4HhWK859aN/gTJ55b4XoQNYIVUQo7kOImyAbJfsOsWxNF
         MCPz05P3x/OfRbuwiy7jtlFuSS6Lnljxq1Ozv5j7qV2CP0HBJXUqr63MzY/Uj/Tf7O3S
         g90g==
X-Forwarded-Encrypted: i=1; AL+hErFM7CINWJDcFkU1TkHUow1bV0Oz0pWBE7rarZxXHS1O2MuHxQYA24VfNLCvmdvQa7PyLrx7X4ZqFtyLyw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/NJInGvhmYx3XSSiK1b2TYGOx3n6zyu4mmwMIaburmazezXEzC
	2agAhrinlGmHLp6WOZYR+5NlPBlZJrkZR2ZpgTqF+pEQo9mS+TJLBfK+
X-Gm-Gg: AZFdTZcRd41TDaG5MJ3+Ry3DyDUjc6Gk6eVH30mmn24dJLszNmy53JAGwndTTlKfZla
	kyTyE3Q21PuKhvev7YjM2EvIAkqtikQ73se51snaESSitBEkJSiTIlTNS6zIf4q6zNzyw6+hxcO
	egrs8CNWzju/GtRMP6HvcDt736Gmc2XEXo44tka5rd/uPZaVjbxWKcKcW1ZToRi7ugTZE/PB8Z5
	ynkJuYdoeN5RBMzzoTlwpc+vbDYYO/EWY9hlsa5ZbkfOxgG1uSg89qiktpgvWjGCVK0gDAk+npR
	rWC4eHMzQPprt0we7ubruUsLY+IhQmngqVdUmTr0cLInAiRAiiiTCNZ6jPK0MnEUHf3Bwu3unx4
	BsNAsvwAgrIihsiaTtwt2+vsbUuxhn3MlLxywvZahvMWBSHz9OZw+s5DNlXm6tQbnJc1GFIJaBa
	VVULAgOtR7MDKNMuun1cjNLVEM/KJMbyycHQdk1b6fWiaaVKoFgHnl7smnnGldld52DW8f1ngwE
	js9CmkFx93yCY0Sch56iWZatJiUw+CVjf2dN/8wdvzmhct1s4dWDbklSbke0iMI6fKBArbLSxNq
	cTnpIayUtHKpY36RE6EoVy2ai1plzcdf+rwnmQyv42RTi7Rhvj/YNh2z7KcCTcJP8w0+YJ0Tmit
	tHI/WxpaqUlnTgpDW
X-Received: by 2002:a05:7022:7f18:b0:1b3:9b4d:85f3 with SMTP id a92af1059eb24-1b5568a28a5mr16074647c88.19.1795495364940;
        Mon, 23 Nov 2026 20:42:44 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm45597778c88.14.2026.11.23.20.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 20:42:44 -0800 (PST)
Date: Mon, 23 Nov 2026 20:42:43 -0800
Message-ID: <4ab84021a5d175f5d3793e52fd818a21@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Pooyan Azad <pooyan.azadparvar@gmail.com>
Cc: Uwe Kleine-König <u.kleine-koenig@baylibre.com>,
	Muhammad Bilal <meatuni001@gmail.com>,
	Herlangga Maulani <w1zardsec@proton.me>,
	Rob Herring <robh@kernel.org>,
	Jeffrey Lin <jeffrey.lin@rad-ic.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] Input: raydium_i2c_ts - validate report parameters
In-Reply-To: <26ac42dd18a98c4928cbe7f6b6adb4b396be4c8e.1790612085.git.pooyan.azadparvar@gmail.com>
References: <cover.1790612085.git.pooyan.azadparvar@gmail.com> <26ac42dd18a98c4928cbe7f6b6adb4b396be4c8e.1790612085.git.pooyan.azadparvar@gmail.com>
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

Hi Pooyan,

On Mon, Sep 28, 2026 at 06:26:16PM +0200, Pooyan Azad wrote:
...
> +		if (data_info.pkg_size < RM_PACKET_CRC_SIZE) {
> +			dev_err(&client->dev,
> +				"invalid report sizes: packet=%u contact=%u\n",
> +				data_info.pkg_size, data_info.tp_info_size);
> +			return -EINVAL;
> +		}
> +
> +		report_size = data_info.pkg_size - RM_PACKET_CRC_SIZE;
> +		if (data_info.tp_info_size < RM_MIN_CONTACT_SIZE ||
> +		    data_info.tp_info_size > report_size ||
> +		    report_size / data_info.tp_info_size > RM_MAX_TOUCH_NUM) {
> +			dev_err(&client->dev,
> +				"invalid report sizes: packet=%u contact=%u\n",
> +				data_info.pkg_size, data_info.tp_info_size);
> +			return -EINVAL;
> +		}

I folded these two checks and duplicate error messages using
check_sub_overflow():

	if (check_sub_overflow(data_info.pkg_size, RM_PACKET_CRC_SIZE,
			       &report_size) ||
	    data_info.tp_info_size < RM_MIN_CONTACT_SIZE ||
	    data_info.tp_info_size > report_size ||
	    report_size / data_info.tp_info_size > RM_MAX_TOUCH_NUM) {
		dev_err(&client->dev,
			"invalid report sizes: packet=%u contact=%u\n",
			data_info.pkg_size, data_info.tp_info_size);
		return -EINVAL;
	}

Applied the updated patch to for-linus.

Thanks.

-- 
Dmitry
