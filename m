Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7914EF143
	for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663922; cv=pass; b=FFaFFmlobgnJD8rnVK7ZF4g1Z206/zFrci/5IsfVKMnkDUr/gHGEHrSdtMqVWGgpyhcJMSzSacF4xL3PkvLmdCg9QyJzoaSfJRiyEFIwMQVv8j0rUvud5dJ0X95Z3gAerRih32lZ+oxVywyI4KrSGNVQc4SU+DMkFTlovOobYiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663922; c=relaxed/simple;
	bh=hEHMAKUllCDwfWN1D2DXADtsf72BtNJRtUxT6u8f6tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXcW8snae5ryHN35gZdcumXpET4GO8KSqG2+LZYU8fQ3XHMyAmR/amtwRMOwLJlKT6BmFil4rZvzrJfGF0KgOJs6JiCKHIrCF02woznTvxrigZdlCMQ852H324xokx3IQ0NSWCiPX0sByChe84a9XYk7UAZUoeGgTbw0CbdMo/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Umdir/c6; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Umdir/c6"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa053900f5so1900833a12.1
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 09:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789663918; cv=none;
        d=google.com; s=arc-20260327;
        b=r/85EajaLSVp9MtZDkR5icJOi42j1+ukidBAXIoMOl/fZZR5CqFDmqC92kvRYahuGf
         KKpJjYzMbpPodT0K009jKWPUMPRe7wtuV9cKnqS/BPbQM7wpg2hHtTegJ3q9KR2uNgHm
         YN/gFZko96mmqrY+QCXbuKSGXMoMhDux5YImD9YqNLfRWATfTnQnxCrkq6NrHyvnY7j6
         oRZv7M8uUv6EmHQqeMHsvcKT3MlM9T1X7OIkyEw2Dpzo35MuBUIba+0Hf0Qz1cqlndUm
         Dow9Dps69Uf23KEW2QZCGm8HZ+xwELy0fPN9vU1AHo9LiZ4wlaQtADTOMHYanFB+LqAI
         Og7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0dTGZsVCSr6ANtWetAbHE4IIsX02FpxvKoMT01AVXUs=;
        fh=z8FdgnobKZ+sanlqRQMApaGff9iN03gIeVF191SqqHY=;
        b=FYCxmUMv/X4xemfczZMG4CukQiXxUuSULu3104k9MYyhKB+2Y7oijTgsh5E3yjW9L5
         urF2IXghUvoWmu56N795qYcHYMLeGAMjFEQD4u5lLPw5x7wAMQd4uWiPTG5RpF/6z9vI
         y55sOsy7Gf2A9bR8AXwE3Zzjwx3RGkw/B+y/uv2UsdTIOfeWAisLibyFbtHGPOT05gP1
         5M/q3J7QZYgdw5WxHOvH6D+svsvNWHBO+UGbElilTOqVo/F7VLgOaCxEMJSewonI9lc5
         hqKsweY7QxKLmvtaxJzpX7m9Ls+zjFFF0ERhVhKyMRy2jzIAWg0Fqg1I/fqaLiyBss5A
         DGRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789663918; x=1790268718; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0dTGZsVCSr6ANtWetAbHE4IIsX02FpxvKoMT01AVXUs=;
        b=Umdir/c6HrNFBOOQJduM6SqCOAdwSy6ZyL+u63FbbjqPSkqXRet/5s+yDMp4YNjYN3
         Ita+VQyRcFzmRG9DQvzdjIErpzAlOQM3yfnWdmoT+BI0uhEAmm7CNQ9zBBHIE4PTBJsT
         u4O29zn1XHk7lfqMIu/0IJrlYch/5fZv5NcCYTQPSHGed7rsq3bxmci86KIG4CKRPazG
         26n1ETA8jIThSMYV/LUhzaPBsjUpNVu5R2qhDe/PX2P05Y0mkxSf6WmsJfcI50NxbVuT
         zhHAtNqzxvTxNG7xhPfFeuQyvKu3USpvLpjVAoPyXm6bF5jAtEYIiIfgReVDGHskLX5T
         ecuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663918; x=1790268718;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0dTGZsVCSr6ANtWetAbHE4IIsX02FpxvKoMT01AVXUs=;
        b=KmEg5xcPv8g1KR6Wl/zU9m4MkDdPYpwrgW0eTsunFCEIi/2oRutmq3ZkCOyrVIbfL5
         lSoLq5BKdToaQCPHTM44FBUgLnyGZpDKhlfyguk78bKurlZVe6XrLlpraU/XpEZJ+xt2
         csD7PlVbG0/yyE6GW7ZKQayH9HAnFSODI3VaYD717lSUmBIru0oTGV7xd4F3Y3TyAzj5
         u2nOPFcMTkEtzyRdGKeM0BqUKq+8MSZAHNFGIKNdN8aUeN28uYs8nH2HjKGnoU0JoQXu
         7LxqQRlnnm9hDLJwJm3ivD9U/1cTgqkYBimCs2D1Nq02Pt/m/dDo2Kb/4J5rW8AGda7e
         f/2w==
X-Forwarded-Encrypted: i=1; AKwUvBxn1kBpNEw/SVlSm3uPi/v8kkZQxvuS0PwhGXmpAlSVeUYI0K9vO0OiEm091uSgzJgWhrnNbFrqbLEYug==@vger.kernel.org
X-Gm-Message-State: AFuF++kZXWu8dMBfIaMEqRbmeTmxjlAhyYrRxCYkL0U/z86se2Oaert2
	YMlofOf9LD9qEqVeyBp8zHXmE7jjQrJs9OaB9rNNQ69OOBX/F6a5zNxeZizY3fvnzrOZSgnDl41
	59Ze7vHXuaEA1sEBBwEbaPLcZ8h90JPg=
X-Gm-Gg: AYBFou3o/BmOFZozT3WsfJkse8/fipIr3svGWI37N7EynEpy0259gKcW230TlF3WgVt
	578o0WuZLs0p55qL4hJjLCEjioMqI7M41nlyWZRpq3T2+TERPDaP+zEVEQu63Pk+Nk8I6ahfU1I
	PjSz1qcozY4inuYxG69oN+6LCPArQ9tmnp1bgvirTHkN30dlIg7D40vcuCHXE0jB8pjXYthfTkf
	XIawbqShvvJ2OqhOChL8ciCKSgun76x1lpZWurvkO1iMKJmOSx/ZHiQSuIRo7y9t7OskVJXHNx7
	wz2UwbvQxUVmi2Ym6NjR0NoBLcS96MLA3IUycaHGCZZPqWFPuxlL8J4=
X-Received: by 2002:a05:6402:3789:b0:6a9:98de:6d8d with SMTP id
 4fb4d7f45d1cf-6aa2245fd0fmr5568315a12.45.1789663918221; Thu, 17 Sep 2026
 09:51:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902193351.185771-1-l.scorcia@gmail.com> <20260917143459.GA2348773@google.com>
In-Reply-To: <20260917143459.GA2348773@google.com>
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Date: Thu, 17 Sep 2026 18:51:47 +0200
X-Gm-Features: AcwNN1UCLyUlHms-nbsVMpe5KcLakQ0vi0ozu7P9tcFuOM-WKvxcQ6ubbojqdxA
Message-ID: <CAORyz2+rT-oNJtWc5BRDrpUjBPVbO6A=qrX_K+J7fAR5Ebm_3Q@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] Add support for MT6392 PMIC
To: Lee Jones <lee@kernel.org>
Cc: linux-mediatek@lists.infradead.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sen Chu <sen.chu@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Julien Massot <julien.massot@collabora.com>, 
	Val Packett <val@packett.cool>, Fabien Parent <parent.f@gmail.com>, 
	Akari Tsuyukusa <akkun11.open@gmail.com>, Chen Zhong <chen.zhong@mediatek.com>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Still waiting on Acks by the looks of things?

Unfortunately yes. Patch 4/9 [1] was suggested by you in [2] and it's
independent from the rest of the series; it could be merged without
introducing functional changes, but I don't know if you can provide
the Ack for it or if a specific maintainer has to provide that.

[1] https://lore.kernel.org/linux-mediatek/20260902193351.185771-5-l.scorcia@gmail.com/
[2] https://lore.kernel.org/linux-mediatek/20260520150014.GF2767592@google.com/

Thank you
-- 
Luca Leonardo Scorcia
l.scorcia@gmail.com
