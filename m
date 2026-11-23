Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465533;
	b=C8x44D2UycmiyekuRkH5f3iZyLHfnupbVNF0eqH4s2k8t/rMjPRSc7Y1Mr1IfvB/kiCZ
	 +mHfsDtQInSLfzjCr/5DgJ98eTnVLqccsCYa0/466j8GDqeIfBZ4SmS03SdnfH/vDyp75
	 XzKmQN4kliGGQpnztdVW13cBxyDWhF6dUHz8Z6S4CeCRKbcnLMUCOIveeVNpFCQozPLR9
	 LxOoTOqGMKyoYR2dqBjepdS3UsSeBeGazVKBZ/uVJOXkBOE9GMq8+Y2ZgnDNJeQAd+aQV
	 2pyfwj72ZRhKCOCumWAdZmOasOhPB545XWTOqSmqwo6NZIBzXHjOkVKZqnfQWHL2pNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465533;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3VcpHnSiwyTeiDddBV3SmBxGPQ1li3vFXIux+h2TFxk=;
	b=rDAPDe7azixgrYXP12kd6a1tePYqLIy78O8N2G1y2WNUYcXt7kDTHaO/by55nyekVjHC
	 RVAQqICa8KnXWmh/R6kYCBJSXxDboMw8hAgSHg/mz4a/Eh0WcevN1YpZ6SRrrHe4Pulsh
	 55zRyRFsS01nCgrz94a+oRHpOxQevxKhoSmdjENrUnaj3J+8YZxJhZN/smFNKvybMyizt
	 Ta7cxu26m8EmEtgWXXNUTyvyPod4dOHouY3Kbk7vPoOY1Eu1BN1D0zVdlAuFxt+nyIUXE
	 0IBF/1bNtALmc3kwzV/FAiYCaBtcBvJrNv6nReqoHmjeKcKroRbMcb/A0jPSrDRTTOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCd6gmjn;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAFD606A321
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 20:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDAFD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WCd6gmjn
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso4727234c88.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 12:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795465532; x=1796070332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3VcpHnSiwyTeiDddBV3SmBxGPQ1li3vFXIux+h2TFxk=;
        b=WCd6gmjncxMKRkd3iKSikeE3vcvosLDXqXyReoAZrp6OZ4q2WT8+0IcqcC6y0DBGnK
         Z/qPmKd3p7srywRjuTHqBTPm8wHoCQqGrGMP3tiQFsED0ZnQmO2w5ggdMmOqJnaKA1Jx
         dzPYRhXIXslkbw7j8nS0MqG6ExvbF0rpiQi+u4Acp5jjPSCm1LsV7Sq2cWd3DgXN2jvY
         11FqIOt5eHTARvp4KmADAMrXyHWBX67qEzNn5eVvz8+uSyeAJCE/J200NSoJtSqgvjZ3
         dE/K8YQpTCLaYSaKa+Jg2F6mrpdTitmcWKIn0812wjnhPAGL5aAjGTEyLpbI5bMnBfqy
         JaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465532; x=1796070332;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3VcpHnSiwyTeiDddBV3SmBxGPQ1li3vFXIux+h2TFxk=;
        b=e26HHAKHkiP1AIdpu4dx9vWCSeMuBntZRbFBgjKSOsFhn2EdIE+fCa+7Z2a4Am7bva
         tjZH/bEl0OVktZokfqDlLUkcd+VDjzy5UTwar7jJXu3aSq7Bc77dRJJDtYExtZFFQiJB
         YlzRLPxqKt8OVrvENXP4kbPuBzbGXbOGzIaV7OQQnU/3tCn7ka9rn5n7KkCDpT+UpTO4
         vs7oa/EVvjtUbh4V7aPeedbu6/9mcOabfQAJDNZ0BtmT3ljwOc7MUFkmp1iJhjPjubPD
         XaobTnCkNK1ymQ0mRLQi2Tlnm1/nun5ix+trPDn7WMXYsMMsX93qM9UAGpXCBMKYXA2d
         gHKw==
X-Forwarded-Encrypted: i=1; AL+hErG+M4QhtHS5o3qK4UXcBJVQp380PvIB9OkR6xxNxEMZJR6v7YJQ6SUJesXwf6sXQmHh336ARLz+KdSiNw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/quE7GCSRq349nQHVNm7dELokHNs8sPq6HQkBFFloZQBI2Zw1r
	EH6sTnid1CdjrcfAAdF6Lz0n6EOmnfu8feUX+Byi5Njs0PEtTaEDlf0k
X-Gm-Gg: AZFdTZfeqciNfNoLgb2rHFzMDFc1JBxNjsoHTtS656qEWPIe27bWv0fwiDttEQ564P/
	lGXg6Oe8Gr+T7tE4mYZlxQkAyIGNSUe/p4y1onzZXwF7QLSYngmbE0G9z200PD+pyvEAVMGCVKj
	f1mhZjD1AlDyU6sMDdpiDuf+ubjD88lNt1aN8CkU9uiCXuxbF4rYuXqh2oH04HPAu8n3YfQyRu/
	Lgarh+Pz/+DnkLgEgHXkHp2UZ63tDqVqYqU06HpFTvjtE5PBCM52ZEJOaMrWuDZYKozda7EuRAe
	Yo6kfoD7qu9MH2n9m8AUGX05R/wiQdn3iDiyX/vKIGL0ovYq1XNsoZ0d2gLxsayuVGlY0gNBKQO
	6kXC0ZYz1Yi7BZfg1LN07Pd+LVoKeOhz3491Yfz4ye7ME4FL8V+Wdioj5bb1V5uw42smSXwRDeR
	Z/hcJyk5eycnkkRntob36rqMWQKoULKwHd/3VfhiOw9DV9+FKzriy/Ga0486LaQAiIiUW78gFpt
	YsMnRq38+Jq+nFjfgjte654RpNTrbE90McDeNviOruIJmNz6eDv1bm7+11ZUXyvDSOmZGvcE1lj
	zarNwZbtiJBT7TJPCKhVvXpG8TpNyhKgJLviGc0pCpV8OV3r35jgRypT59u9CazXAJYyGsM=
X-Received: by 2002:a05:7022:290:b0:1b5:dc3:209b with SMTP id a92af1059eb24-1b5568ac6b0mr11976416c88.22.1795465531758;
        Mon, 23 Nov 2026 12:25:31 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e2bd1sm29277191c88.3.2026.11.23.12.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:25:30 -0800 (PST)
Date: Mon, 23 Nov 2026 12:25:27 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Fengping Yu <fengping.yu@mediatek.com>, 
	Marco Felsch <m.felsch@pengutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 08/10] Input: mt6779-keypad - enable keypad clock before
 programming registers
Message-ID: <awShM65vJT7DhZLT@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-9-lee@kernel.org>
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
In-Reply-To: <20261123183200.3900004-9-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:14PM +0000, Lee Jones wrote:
> mt6779_keypad_pdrv_probe() writes the debounce and matrix selection
> registers over MMIO before acquiring and enabling the "kpd" clock via
> devm_clk_get_enabled().
> 
> When the keypad clock is gated off at boot or its clock provider defers
> probe, accessing unclocked keypad MMIO registers can trigger a bus abort
> or silently drop the configuration writes.
> 
> Acquire and enable the "kpd" clock before accessing the keypad
> registers.
> 
> Fixes: f28af984e771 ("Input: mt6779-keypad - add MediaTek keypad driver")
> Closes: https://sashiko.dev/#/bug/linux-fc15622a-407a-48b2-88db-195cdb311dbf
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
