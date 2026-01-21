Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706D389452
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 20:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026003; cv=none; b=Z9R0D6mk/ZgrfeMW5u3BDfoAiQtcilW26j+9mc/aIaYpv7aY7WCjCKoMqT0lni+h9wUvesnyf8uakHKUjICmUTfckbU2tEBWuWEE0JivEbiSPffXz7RauDVJOfS9X61hrcpfKBOLQz0y8CwnBtuP/BOQ47zO/VRf2yXpnFyTDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026003; c=relaxed/simple;
	bh=dAoMhTBJ7WQm0hDGz23fZyaeSXaElPVE4fcydWMuctE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6QalYf6XMNb5pzmz7WQihizZ3tlV6mTBbWK8S6w8hFB/5bvWWbLlQMknftnQijViUHicjXeXFylhbtKlgfl9w8cRuCJ1g734Rxdm9ygYZKqzJVQ4Uzv/yyA6UXTCQ3MPr2NIcwagiXmUYCIlmaABVhrrloyblLkTagzVupMGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep6sIcUx; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep6sIcUx"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b71320f501so364869eec.1
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 12:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769026000; x=1769630800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXiRa33oFhWGW25XGgj2/vno2dQCcapC4LgGpnlRseQ=;
        b=ep6sIcUxyoJVVa5olxz121bIe1qCt15LSZizapdEZuMZK4t/em8mI7m6uAVRfQolNC
         gTAiXnFm71zFgE8GlOgpSJk63W7egLmIBHWBj96gaNc+ncsL1xWLIc83JCmb/wAaAZLb
         byQJiFgOP0vRk0bV/7oCVFBTAig/qWkkgr4mGu5g8YBJRSNZvLxnCOBAl8cbZX2Ybd3I
         JNkmD+DK9u21AHWnIBHCivqt4HIDa47wBkwBd8wdtL7tts0ZRAYdUCB97vKEyCaNCgJc
         v8WTWu5/fxF/XoFQ6uTKeQuKe5it5j92hN/YLyniH0XDILZjP0K22H7BwDu6cAPZUKbz
         BXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769026000; x=1769630800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXiRa33oFhWGW25XGgj2/vno2dQCcapC4LgGpnlRseQ=;
        b=af+/8QWWRjuwwabOd74RCPw1epDrhzq6Mny58YjBEId+J/HQGCpX8Idr67ShwTsDvY
         prGOmOVz4s0XkUxJHk32galEcSfXa/KOVIac3c4SqUtBZPu0zdRo/Z9MTENW5qEmBi8D
         5y2ZLkhdP+V8TJ1wMoMcDE5DIGoPqxIY78fA1BXeZn0E1/IVcXFFqAJFkpTJmXYeqQXT
         VPXm22BTVYDwW5NyAqPv/TGaQ6NBlr3rqtj98+jCeaHbb+3K4tgjGssz0dSO79uI9DML
         aE2im8dThd5AHWGLgoVsPtVqVXU9+xYyhpHA9SUKeaa9iO3iuE9+N3ZmrKQS2irJINh1
         NsWg==
X-Forwarded-Encrypted: i=1; AJvYcCVlisILXkVHYyXCgmSaxQ0mwmjZ1PVUjMcHS14H9j7srtiIRCniKt3kHB28SBM+0eoJWuC2QRhSFfaZ0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5hT0RsZFwii2QehFCG+t98nyWBP9+jTWa5LeiLVZqZlax/av
	tnoFfEn1S00jSHAxI5VLewj6jrvH8Cx4hPZ6b4XsnJGX/ApQYt46ofvp
X-Gm-Gg: AZuq6aI8WyoVOLfh7ePJtEqGE22XZctl86BdjNsjYv8+R4s8wD4wACdvYL+0twccBEe
	YUyu7QGp7hkYfreEkMzr8gtW6090HELlurTCoOQ/K8OIc9FFTsAprAkEact9VnZX+j3DkF609xu
	ug4E/+ys6vErkK9j2H7iFrW0iJNdqvi3jOxIWfiEJPXF/KcjRnmk+3ISxwYx2akAMheoEeyFNgg
	PiW3bCOmSJ682DjzkkVLBminOX1EPwCI3h74oC85lH+bsRKwr4XGH2INtwASH2kDoDWXLbYs/mH
	RBhsvi+e6bdwEkK1mB/3aIxTbWFr4QLt9r/KsIaQm3uhARBBVtUSq6NUnguGcYoHisbYSQM0/ZA
	9fJ8cMNYXeTxToDGecKcVEfArH/avPxUt+3S0/+ZZzq2Mt/WiScQto1gcjCYcNDYs/XMBhdu7p2
	gCYMuaHOnXNXZrrzXI87zqiOtS4sAUUsxIt2T7M3crVGTo3kMHy3Ut
X-Received: by 2002:a05:7300:188d:b0:2b7:1253:3d54 with SMTP id 5a478bee46e88-2b7125358d6mr1686918eec.33.1769025999975;
        Wed, 21 Jan 2026 12:06:39 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7093325fasm6060746eec.24.2026.01.21.12.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 12:06:39 -0800 (PST)
Date: Wed, 21 Jan 2026 12:06:36 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: milos-fairphone-fp6: Add Hall Effect
 sensor
Message-ID: <t4yjnuty7tmvs4vqzm4vdid7oowicy7hcnmqmu6nqtit3yru55@zpo6kprnarth>
References: <20260116-fp6-hall-sensor-v1-1-69275c6bd809@fairphone.com>
 <3a17f2e5-0724-4d70-bd22-1e612142b3e8@oss.qualcomm.com>
 <DFSOPXFSOUY2.2Z6XCLCD796Q@fairphone.com>
 <wpjvuclvpjft7y2rlrmfgszkzmc5vvmohif3etqrtvymxjjyjk@h2dujh5egdvd>
 <DFU439A9HP2H.1Y9OS2OPAXGOI@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFU439A9HP2H.1Y9OS2OPAXGOI@fairphone.com>

On Wed, Jan 21, 2026 at 09:07:44AM +0100, Luca Weiss wrote:
> On Wed Jan 21, 2026 at 12:05 AM CET, Dmitry Baryshkov wrote:
> > On Mon, Jan 19, 2026 at 04:52:23PM +0100, Luca Weiss wrote:
> >> On Mon Jan 19, 2026 at 3:41 PM CET, Konrad Dybcio wrote:
> >> > On 1/16/26 3:22 PM, Luca Weiss wrote:
> >> >> Add a node for the Hall Effect sensor, used to detect whether the Flip
> >> >> Cover is closed or not.
> >> >> 
> >> >> The sensor is powered through vreg_l10b, so let's put a
> >> >> regulator-always-on on that to make sure the sensor gets power.
> >> >
> >> > Is there anything else on L10B? Can we turn it off if the hall sensor
> >> > is e.g. user-disabled?
> >> 
> >> It's the voltage source for pull-up of sensor I2C bus (so
> >> ADSP-managed?), DVDD for amplifiers and VDD for a most sensors like
> >> the gyro.
> >> 
> >> So realistically, it'll probably be (nearly) always on anyways. And I
> >> don't want to shave another yak by adding vdd support to gpio-keys...
> >
> > Why? If it is exactly what happens on the board: the device producing
> > GPIO events _is_ powered via a vdd. Added Input maintainer / list to cc.
> 
> Yes, the hall sensor which is connected to the GPIO on the SoC, has an
> extra VDD input which needs to be on in order for the Hall-effect sensor
> to be on.
> 
> See page 133 "HALL" in the center of the page
> https://www.fairphone.com/wp-content/uploads/2025/08/Fairphone-Gen.-6_-Information-on-how-to-repair-dispose-of-and-recycle-EN-NL-FR-DE.pdf
> 
> The IC is OCH166AEV4AD where VDD is (as expected) "Power Supply Input":
> https://www.orient-chip.com/Public/Uploads/uploadfile/files/20231014/1OCH166Adatasheet202203221.pdf

If we add regulator support to gpio-keys do we expect it to be
per-gpio/per-key? Or we'd recommend splitting into several instances of
gpio-keys so that there is on set of supplies per gpio-keys device?

Thanks.

-- 
Dmitry
