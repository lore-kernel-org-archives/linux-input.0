Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795400923;
	b=ZgyHR8qgaiOn0peFI6uilgo7kDmdjurHN2qkLAv+WRbQ0gt6qbEC1evjb7x6QWpONzJw
	 Hbwv+k12CfPt9UVqbmWVW94OMWcOKYohJvYNQYiUeV0l1hh2In7QhYoQ7VI+vopEaHWfU
	 KlbrdqAXRIBd9TqhPsKVYuT5Whaqw9gQBca3oPEGo3PimjM62qwwZa5ukBKGunRQPJHkj
	 TCC+I+BVnycgIDhHv7KVeWxilqIhlPhxwcVIykaiKP3Up5cQchQ0e+XAs4LenWn8wquPg
	 OFSinHlod9TnIGrB4OP3epW6CPzjWsjqdQH/WbO+JlwBko9fibd1uHoc/SHVpk+8yag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795400923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZicVV9Z+dbEcvbsxd5GYeloidM7KPsn1mE2hWsjYDlc=;
	b=ZXhk34PQXe4hNxbUZYm7qBF37K4TlDE1UmHyhPwFuYGvgKmLj4eE9uzOmtv2G1WDrAHl
	 HohcZiLL6AYHewaVaa3P9kgsOvKLoDsQBMAVN1Q0uSHwov6i89qyt9tF0TzOrCIiQ1Ycf
	 T93IHuHPGNlgokCY1JYzgEaHlcd6MIFBoLsn0aV3/SYtT5Zhw+AFIWRVQcSQ5N3mrULVo
	 WtWF6PCC2BdyB/whgx2hACUN0S2KCoEVRm0ZjVszP/2oHYlUVprlVUhOtGthMjntS2oBX
	 1r3YN7EzWLLuKZsu52twjWaivt+f6nRv8zWXyjvDnKSIj/WoXikB2+HPYfG0TGfD+lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1VNUVr6;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD25606A327
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 02:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD25606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y1VNUVr6
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-386ab9ab619so1295777eec.1
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 18:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795400922; x=1796005722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZicVV9Z+dbEcvbsxd5GYeloidM7KPsn1mE2hWsjYDlc=;
        b=Y1VNUVr6cZxi6mv7oTelykzw32dhCaT4Nul0xpjhZF7276mJ/5rBfU4HjZLSZJNZnm
         6WsiDlMKLMEVujePFH/6AV0cZBl/X5lfHq+cuEyCqFV5SSFKB01dB0XsQQiX4JDcRNYp
         fm7XfDsnwCg9V+3oxAS1lO7Fj6H3kjrLMjasNU+sXhn4brbP/NTN+Wsp3hNdgFZh37GZ
         7ARLvJrrxe+fGrGiMFUPsLg9H3FiBeILJ7kd0tAfQOl/fco+GX71C5jwPDtte1AzDICh
         7vKDo5yfpywIj4czLxiqwgSqj9N79h92h0707pQeVEzlhaUC/9W9T2aiRd20L18DcmlL
         5XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795400922; x=1796005722;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZicVV9Z+dbEcvbsxd5GYeloidM7KPsn1mE2hWsjYDlc=;
        b=hwyyz6GziANQyWp6kU8S2u40IR2icVzFOFdN4mhDw6THhACYTDar4DQbdYDxHwihSF
         3DHu5lZ3YtIcGBSFS0GHV1OOrnibsgscQ+MiUD8wL8jPNg45GKAA9V42I+tQDgPLP9YZ
         Yf3ZoCHFnEnVMNYNUNyECu3smb8yLL8IwQtc1WsKRF2Ob9ZYlm/8LfOHdo/6B6iBzzDf
         08mQvCBAHhMXus/ajq96M0/iY2cOR5IhBmPW0cUE5eUc0v6CbbyYFFyJAJc7XVJ/5yov
         F0iPm8CUVHpbPLfACKNMkDNceu4yrPFtvR4qcuICZtgv7rZRasS5MVBcCdEaHF3ZFzui
         vMHA==
X-Forwarded-Encrypted: i=1; AL+hErGxkMdqipQ2oQvBu9kHWg3qxso3KEekuXIoeR9YPJVlJp0FLEq7s9OdzggSmrJjYgVOsCWNBDQVdNuuPw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/BGwegUkFNN0pJYwJdnwodeloH1d51N1bDv40vNFamjthfN6z3
	xp4+CkRx9E9iT9wY6V2WhQuqIJIMWoO7lH6h4/JkVAq7icN1YRNt1p/2
X-Gm-Gg: AZFdTZds07u//s3JDKb2qoMVszUuZFX+6W51KMqqH0Dl47cf+AZFiK1fFAJqXrRQzGr
	gtf4dxBTMf5u3v90Q9PrXfXPdxBpUpjlV3ji+YiP1JmV+YXYhpyYTkAz7gRAJr5x0OVsPdiKXJU
	rQ3/GsnJaRd0QmG720+pPy9Kgv+ApcuZaNAUHeazxc55cAmCfg2lc+dhd4MwpjZDZhh+F5Ko7vh
	1yb1Cxhhh7TGTulSezA7ccT4GDyTGzgtrOi2GuMCrHLaX+rATXmoGZezf3GRD0nT2vPylUUq+mG
	rv83Yfweiwp8CYI9xolO2JdK2jtONxrY7CA7hwmTYgwvNK5Tof/AL3MOzAUe+0LkkNal7Y9udHR
	kqOAaFy38OegvUesCIb/BE3AluumHUgNRdMZgWa16+PGmbaAaSc8bJBfLYBXkTBToPUA+BiuRcK
	+pI/SEbl7wuQF2KyjBW5UZUQDT3RdTrQ54ubli62Cb1zrrNX9UjEkrd+9nXy+fJmZfQMNqPMJxV
	yES0u1I3wmffQOgJUBAwvf/au2PAMiR7zAcCeOz1OjyYfLW246tGJ9ShfV+zQPd1rH/uclVC0+q
	Ha2aYFOamhome1x5Cx9gpBNDxOcb1HQab1RmorZMOVgTGyUH8MXbDSugviKQKDU5uWmPiOM=
X-Received: by 2002:a05:7300:50c4:b0:386:121c:c275 with SMTP id 5a478bee46e88-386121cc3c8mr9558886eec.10.1795400922103;
        Sun, 22 Nov 2026 18:28:42 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:f002:4621:aeeb:e0e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385672ce402sm28632639eec.16.2026.11.22.18.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 18:28:41 -0800 (PST)
Date: Sun, 22 Nov 2026 18:28:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Geert Uytterhoeven <geert@kernel.org>
Cc: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v2 3/4] input: serio: Enable compile-testing for
 SERIO_ASUS_TRANSFORMER_EC
Message-ID: <awOk0yzFfiGt1kro@google.com>
References: <cover.1795355432.git.geert+renesas@glider.be>
 <234c01e4ac98bf72e3e2bbfa7b4fba635530ab8c.1795355432.git.geert+renesas@glider.be>
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
In-Reply-To: <234c01e4ac98bf72e3e2bbfa7b4fba635530ab8c.1795355432.git.geert+renesas@glider.be>

On Sun, Nov 22, 2026 at 02:56:32PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> The Asus Transformer's Dock keyboard and touchpad controller driver
> builds fine when MFD_ASUS_TRANSFORMER_EC is not enabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied, thank you.

-- 
Dmitry
