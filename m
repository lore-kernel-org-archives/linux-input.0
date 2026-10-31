Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469921;
	b=x43cW2qDQv5k7iiKK0TZAg2VcTe51mermeSLKX40c1jGhqVcXNDzA5Qa/rfjtEXun7+g
	 k7yzoxctpxWqveTRMpxhDeRUt1XUlvISiRshd4M8kxlRnDRyauKVYjKP+vVy/r4a6OqqF
	 n8/zifbnE++rSEb5gNMaD1OzUWhcokXGd/No4a209YzSmaoTK+sd87TrnwUQLqtIyAEuw
	 HHIc01f+M6eFtGNiQvGAtD82iNLGzn48mv6FAQnCFMEY3P+Vn2IP1VRlOLIHQ07tJvOgo
	 F2X2yeRLLMoVCJSw4xDAHQ9cvjZb1iXEPMQXZTScW3HCwWL+ehQU8U+LDvb5iXLL2dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469921;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=XH4PbSUddZVZXZtjZ75jfe0i+WJ14qbL21Dy3aZUb14=;
	b=K3LBeeE7kz56KkM6a5IOtFw1hf/0cD9VeMaRhbc+AoQXM8NcFXB8c7OmxbZI6x8yhJ9N
	 xJktbGZX9ESfX6vl8i81LaEmNdyBWaACJY9mcsf1ieY44GdwcYwZsKGK6OYG8FqFVw2Ie
	 4dQbVzq4bCnxobk/FYHXJaK4w1saNpY+CmbINcLViDp19c7ryH8yWXpVysXJLDJPZ0JHA
	 lVbHxNm6sHm3AfnNXnvAa/jFeoaijFq2FcdSdic0yed2WOg8QK1oez9eKm5T+Rh1M27Qm
	 yw3mPgrDGF1r3tsiViHmyqwFJ9q+JYKrohvpKsIX9+76pQxlOW/AsNLxd5tQtc+9wNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=ySZx4w7x;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D217606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 18:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D217606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=ySZx4w7x
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id N7khxG1Qhv0ndNDS7xxI2V; Sat, 31 Oct 2026 18:05:15 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id NDS6xINnokE4RNDS6xvDLv; Sat, 31 Oct 2026 18:05:14 +0000
X-Authority-Analysis: v=2.4 cv=LuaSymdc c=1 sm=1 tr=0 ts=6ae62dda
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=PR8N35F6eJWpYSb-7tQA:9 a=CjuIK1q_8ugA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XH4PbSUddZVZXZtjZ75jfe0i+WJ14qbL21Dy3aZUb14=; b=ySZx4w7xmJA7U4Ymz/fdAkBCSj
	vgac4IRO30r0dfM9itNmp04EudBOnmAS80NMyDN16duvBJG59nF1WLOPfmbtQqqjdYYRurqpNWXT4
	EF8Gwu160dfK+6Qe/5kLn2SDEFL52pew52cXlrpwnBy4I5JA3WUsRNryJ2Gng5uTeOt7WjC1oWbiy
	H1kj+hB30xh/74vwkK3Df7OLS+wnSwxtqxD1DFVoadO/J/16VjzMRSZT7VuJEaX7giWvEn3vIg+2c
	KteZxtgZ3iZwLr3ddtfMhjhh+h/6YPMyls07HawUz6xwMYqvqGdMOaMw8jEyPphx0t9M/CwgHvEbg
	cXqr0tBg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36812 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xNDS6-00000003Rms-1L1i;
	Sat, 31 Oct 2026 23:35:14 +0530
Date: Sat, 31 Oct 2026 11:05:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ethan Jimmy <duhxu0@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (acer-aspire14-ec) Add driver for Acer Aspire
 14 52MT and 52M fan
Message-ID: <985bd253-a9da-4b72-9348-956094625a3e@roeck-us.net>
References: <388aa474-3606-4c7f-b073-224d5e0880fd@roeck-us.net>
 <20261031174651.856627-1-duhxu0@gmail.com>
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
In-Reply-To: <20261031174651.856627-1-duhxu0@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xNDS6-00000003Rms-1L1i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:36812
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLrPuWpuZEy4YGsEGGza/nwX/fST7pIaCTWeskbzykOVhWqr2dRL6WA39mPlhBJ5aLgnTdOleq6BG3AMX3UP/fBKuaTSfZzMl49l6/DBP4XXhsbOq5lY
 XXgH4a8q3uE9vhm6+o2Rg3icrkDkAB9Si0xFIMF9+WIvwf3HG+iP3UzA8XI4EBU/0RcyDioKw0MzFbw/D86A1PpBoshbPmx5aIXe+s5NbDdbVrWhbbPx/Chg

On Sat, Oct 31, 2026 at 10:46:51AM -0700, Ethan Jimmy wrote:
> The Aspire A14-52M and A14-52MT expose fan speed through an I2C HID
> embedded controller that also serves the keyboard. The same product id
> is used by other Acer keyboards, so the driver binds only when DMI
> matches these two models.
> 
> Signed-off-by: Ethan Jimmy <duhxu0@gmail.com>

Applied.

Thanks,
Guenter
