Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409343;
	b=3axPcUuFAeumTHTALsIVaEJXaFYMK3HtqH4UJbvQIOl1nQY3sKpXg5DgUtILTiriAAFm
	 33iPHZ2ksFPD3Z8D2sH8XDDuXh74RNX5lRMEIbUVmd9Vj5ewrI1I5RFHV+ywZ25uKDCdy
	 xdSCyV1SPAwN8vXk7PUBorElrLLscbEVVdQlVmxlWo5gaIJwnzLoNv7X5Nso2T3HsEDSR
	 y6GqxtamB82JW8KLIUDWY6Vg97mcNuV2gb2VXl6BYjjM90M4i3RohX8LrQdhpxQKBiUoY
	 xoLIaXgaErDY8OVOGI9JZIZurA5D5cccCkNOB0A/GrFiSl8gFva/P71IUqhpdSRQ2mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409343;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=BAHrssDvoJWyvJEt2ijYOpc6taHKwRkfIV9AuIwRDeY=;
	b=LUrD4csSNsuthYElMonkwWSZUtcpki/RV6Lc8b0hqEgSK4yuaZ1mDU66achvJ0T5KBAZ
	 WGFgE493S+7vfGhdz6Wss7GlJT8UH08Ol2MnZvFSf8XEMXtmP+snQ2RAr01D7Cw5xM9w8
	 fry+DOezG0u1vBnt+4fqHzaO4ugtJ2uWvpVTCDW9Jl4GyiaD5ay8MN4KrBQANQb6Vsx1T
	 YHonN/DFeJC5NkWPtx4wyXS42s3jBwjDwqd8JxXRcW/iLrBSVRIadISc0EBD5sfwMuPod
	 04ihMuvNcyMlgxm8MS55yRUN+EQnVrSnCu09cOGi6vAujgnOo9I96cca6StCJXeQkMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W5zqY7Pf;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B749606A31E
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B749606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W5zqY7Pf
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-38587f3de36so3485783eec.0
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 20:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795409342; x=1796014142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BAHrssDvoJWyvJEt2ijYOpc6taHKwRkfIV9AuIwRDeY=;
        b=W5zqY7Pfm0VZ1qs2KuucHTU0x87cYA55l0x+4uN8ugZe9MURfC8Xd+IAinCo/v/Gk+
         /vUOCHmq9qjzPuJpKYT9m4/msiC74kW3amdp5ynJGVPgcn/H63TqtPT7nhKUgold+DL2
         zdHTDPMBJSKqVwon8OrMFTxOzUhF5sRa2onsbmB8XDYtyvMaXrT65+tY1pl1DLtLpp+A
         Uf8QqWflB/YGTh9+jGMmynSFJ/o01HyQu/bZMyxczMFvW9XjsZT5+4zy9G45fy8AQAj7
         QTvquYBG7TgQpvOvVyoTUr4TW0+VxCw0RYZOx5vKYbnuTlBl7sXV1GyioVidXK2m8xS2
         WJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409342; x=1796014142;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BAHrssDvoJWyvJEt2ijYOpc6taHKwRkfIV9AuIwRDeY=;
        b=azRTqWgodj3hzJy5qJoBjfeK2neMLdZy7PzUMQBcrRNj4lwSBOfsAeSACjxPl7p3/E
         HN73EnEF6Z7B0xCtO0hleH9EPROWto+UMlIAb3tiUWmo9PRH3lb82E+1fRIWL41hJ/Je
         LaU+EcTYFNm4t8aCLvnyb3QZAbycufznz4v3uOzXXa1qbw34PfEDaBzk8k5LAZGDZgOW
         SWOkafXYS2dwTkxzL2o7i42PTeJJ9o6N4B3FrfWIY3bCbS5mqI+O2c+MmZ4murohcL5s
         LKc5rN9+7Mqg+ONNxsP+CV/a3+6+2gBAbL+Ez/4DVhLDDkkLfd6a8ZVkXkjm+6vhozdm
         D/tQ==
X-Forwarded-Encrypted: i=1; AL+hErFtNiNGiwGnE0bF/ODCPhODjkdI4OU5bjiRA4Yp9eUMJyZCdBNie2Ddwb0bLdQXXP5hHor7ODYhLlWOPA==@vger.kernel.org
X-Gm-Message-State: APuU4Z83dCswPuO/2PE+hBcQVF1v4Xyvbr5UP0Gr8wN1tpuKG1yghP7p
	Qw8BJijV0iYUdehc11Nh3rfTv8aYWcCdxmKhvjfsFObCFaOpARrFZvIy
X-Gm-Gg: AZFdTZfvDknuHX8ZZ3+o4ZXudjWc0PV6uYsDgqslu5SzV2xIOmIXLbLUY1Uu3YUCY2k
	qZDYLkNthsrF2P0r0N9Jtt7Omez7exS0Tfj6fPkpbOgAPubfZo83AJ3E0w/LDaQ3ebskSTZV3iT
	70nV3BfpcGo+npkyLF7twSt68Dect4Sam8bYHLd4LXe/t1vxq8cf6EpXrY0hxSt4qGpBaHVXfzZ
	GYmXRbfgxW7J1dy2j0Gxe6h8eZc/IIToe8c/DJQA1NhyAUIVzELF3VIQNC/rlmmVPb9/CmNiVro
	X61Up9E34Jy0vl3RY/XBd4WKqjjlKLGzsPGg4ZAj6dnrO96SJyZYdDxJIV00Zmitzj7luNT4Hid
	RYqmeLKVEGp3mT90/glVTnEiheBje6UIp+plNNEgqBtQcVOHvc1dbA8/BWBxXjCHNMPewRoSm9g
	mlCBIHa2wfvwsxMZpcw0wFl+nf324pMjTJG/SpxlDDmkqvSabh7qubk8wz8N5OwZAyHKcgr2efj
	C6wPGdBwdz96lYJ6cf+t/OUUDxm2cKvjtJTv+vZo3IMoT2w8nB6HU93wM/uXxFjN28VJlxF1JsV
	m3ND/w0m9xeiBwF9HOH/8IndulQ63p1mmq9NQnPY630p2Q8FICUNN+OV05vN1KOvyrgUY5J1ibB
	YSWJES1b/zqC5rd3L
X-Received: by 2002:a05:7300:8807:b0:369:5583:bf4c with SMTP id 5a478bee46e88-3856ff5bb62mr11127752eec.28.1795409342440;
        Sun, 22 Nov 2026 20:49:02 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm37583575eec.11.2026.11.22.20.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 20:49:01 -0800 (PST)
Date: Sun, 22 Nov 2026 20:48:59 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: cyttsp5 - Use dev_err_probe() to hide EPROBE_DEFER
Message-ID: <awPFtpjkzpQZeheQ@google.com>
References: <20261119-cyt-errporbe-v1-1-7faa44e821b4@kemnade.info>
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
In-Reply-To: <20261119-cyt-errporbe-v1-1-7faa44e821b4@kemnade.info>

On Thu, Nov 19, 2026 at 07:34:56PM +0100, Andreas Kemnade wrote:
> Use dev_error_probe() to avoid unnecessary noise if prerequisites
> are not ready like the regulators.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thank you.

-- 
Dmitry
