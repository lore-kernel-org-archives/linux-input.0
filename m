Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8810A3D522C
	for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 12:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747728; cv=none; b=WYSyRWro+hUy1ykqoNNzVhE4U927TYQI+JZmNutjmUifds818saQA0giEocnMa9xPyhndUuuoJ18dLVi4UeZ2EY43kSQym+40iTLEEmW0YXYVKeGIv2brq2in87vzQ7WwloD08uTpTa1JnfHm7FLpGtxlzavTHRTLItXJtUpbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747728; c=relaxed/simple;
	bh=V6o8/Gq5JSA1hvsuomub+jf7dy5sMCVKfGHckD5JYt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc4LWTT/UkIomPsDYCIP1VlcqsA9CUaDxNuS4JC08gWcvl71XFo31DvrJZQEZTUhSVGKClziChigUlDtXdDHh3bxgmGml1i8h4nqEduX17fl999oA9XDDMO4Z6NL71P5gZDZsSCzdsxyCEIPeUKgAtmh8Yi8oXRUVS62MNJ87xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z111cfjF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z111cfjF"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e041ea211so1159870a91.0
        for <linux-input@vger.kernel.org>; Wed, 26 Aug 2026 05:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787747727; x=1788352527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7tFmCMlIdazreXwyWNHIM7U0F2LSAg2/FgtTByBRIJs=;
        b=Z111cfjF+MIKPOo+mF/4D/10UEfDu1XdcB8CJnwatfN1dz49BpPKFVpq5n+cWrAOWH
         Y++XjHF4LLhii1STKj83qeFbMC33I9EghPcu9t/+TGETi5hag+6dp+1XC3mt7s4pu8ll
         uQ3s34axfLzoZDjN06f6V0sltf7Adajt4S/Jdbww0unvhw0LrqjBe2xFA6MSDCmNnbba
         3sncFvmgrVXX+jhFAbUa7gpO3AoFhOgwXvVUwfVYohxjCQr5LxVX16WkBSLdrmPdwtQ2
         KZraVZalZepBr6mirTUf37HjsrGUc38l/xTLx1czEpOqNGlGF6/sMz7Ki+lP/mHzmYE3
         E/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747727; x=1788352527;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7tFmCMlIdazreXwyWNHIM7U0F2LSAg2/FgtTByBRIJs=;
        b=DDZfHxoQB86ttKZJrZvR/+O0Fu9La0/+92uTRjpY+e8MsetCHt1cvriCPkV5Jh7+h2
         eWmLbW4G7enX3K+q3MekHKWGnjcikPYbE07m3LE2TkMMU+uqFsBj33AbqT5ul2lzzrEH
         2/RB/7PfnOggJape69/FWbNtW2klvnrXUek7eodumbmZ+EeuHr4gwZfBdnmGLPDb2G5I
         rIqcj5wk8m/YgkdntUBJf7uBqn1CvGMmsYYPGacawJXj0cM60nunPBFUPPUTbJ9YnKuH
         JeUx96E6a0QNWhrKKozmAq5BGcH6JKO/WVFNGJ71tbCcmtSagtfz2pVmSdGbJuA4kA/U
         ym2w==
X-Forwarded-Encrypted: i=1; AHgh+Rphz5FYduyZdWy5JNFasmzeGv+kwGwfY0MKmfwiVxgCuVbrxAnApvTafOyQdEpSQTBxHXXxboHPqrROoQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l+ouKvy/NI0bzaChNo62qpsHUbJaGFPHdjoG1bULF3sn/D86FF
	sLpmalT5i/M+gwKOn9KQ8G3qovp1uAuZYNl8BaAHw8zefdaSQSOhIGuO
X-Gm-Gg: AR+sD12cUVqKuDORTNnZOaK6VDARLJI5VV1LekPZLnfORyjpQATUMKIqKp9jja7RM0g
	r52XqZJIUdChkgE239WWRUChQhcTlkacJepL2f4qKsc0iJqgmBXr7dKRa2y83ROyExJPOx898qH
	j15hNyodFkkDGTXg6hLusalwN4NnJTuegrAIWQZum2vIVOFkuotqnIPNGBdkenOfgT/cbRefGW1
	5t4A+E7KdnKk89posUljkDVZk2OsarZ3gQ9XP9iMdBYE3EfdS1h9eIMMoxBoq2OQlBohMBHlwWS
	j/eouHv3wJnvYQds+s4y5dWJNtp/ztUll46p/2iaGjWwzSbgMEcGkmNFYYXPqpm0NwMefp4DLAY
	jfKb+hD/SGAZgkxeLsR6BqAoOdKbr3LZms5W3HV22wnawh1qfv6doKwXxmKSnmThZs7Lp4fGJ2x
	Xgs66baYZ8jN4MIkmDCbWdtB8TYzrJCZQD1UbxC5Le4085BDAxjBuKeVkQFk/Ho6WmZv5qet/Bl
	BjZ4cNklc8i9yuAgp+qTj11nGVp1Q==
X-Received: by 2002:a17:90b:4b04:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3966d5f900dmr13609817a91.8.1787747726840;
        Wed, 26 Aug 2026 05:35:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5877:641:857b:1318])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20095sm7925744c88.6.2026.08.26.05.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 05:35:25 -0700 (PDT)
Date: Wed, 26 Aug 2026 05:35:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: rva333@protonmail.com
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add mt6572
Message-ID: <ao7dfxkXtbt9BybP@google.com>
References: <20260814-6572-dt-keypad-v1-1-2ceff2373211@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-6572-dt-keypad-v1-1-2ceff2373211@protonmail.com>

On Fri, Aug 14, 2026 at 04:13:52PM +0300, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
> 
> Add a compatible string for the mt6572 keypad, that is compatible with
> mt6779.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Applied, thank you.

-- 
Dmitry
