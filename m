Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D5537AA97
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884103; cv=none; b=oXR9YTsa/bLfTkokqfiOUMYZpmFETxyeUAyuXUzYckgmSTlJiumHTfKGnUV/krB4g69A8YkYAAB6xn+9JVGymyTuC3gaqa3Iky/uOIj0ObY/sNtAMBbwN0zSZWrE+7elO4f7d13dUU/HHAztTGAcCLJHdsMHrJgb00HEk7grTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884103; c=relaxed/simple;
	bh=KUvMCXecxl1oTGRP8RuaVCGSIIYXm2h5FZ/R4PUy4Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCHxLFTH7Tw+dajtP3g+FOqWJTORmh8zgFVpkpfD9VEP+SwUZ9rMRLe5EGGHnPHix0aEc79a37eGmsOwkK1SjcfRCwpJFUOrEQ5wMSwJL3I7/YO81FTpd7SXhruKvboMkIg51gSD3DgN/xb6/f3gQzfll3j6e4r1H0xS+FcByFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvHbEZ/z; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvHbEZ/z"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12732e6a123so841283c88.1
        for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 14:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771884102; x=1772488902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwmeVddzSBrk6onBg3XthXPBezPsVZCBdsI2Jvj2LQw=;
        b=QvHbEZ/zBwB13I1oFN0JKZF4+aL98Vk/gQFKF2IlM4SA3XRYV0AFs1Kjojh0PeVMu4
         cz3CIcmfZOVs+gbbDlmSlM7WZRTj4E5hSSZidqpghyMyxel5WXw53ZzEFMv+56k2lz5J
         rrUM1BkggQOdS+UyyHscjQbejOR1PwXA/fDUO4BS+W6cpUT+JIWTiRi+IOx/a24mJJUs
         bMWG64y8UL6YeleC+WO3CwWUH1JhQlPVe6d/MknRQAzelYq3ltUPGHp8bgo+dYKO31Jq
         lWtJv+bUdT7g/CMcCmRoFolI705er4sebiEpIoMFHcNnBeq6Qjqjv0lDlNw/E3KywWSZ
         COuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884102; x=1772488902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwmeVddzSBrk6onBg3XthXPBezPsVZCBdsI2Jvj2LQw=;
        b=igmMXfq4/nJPFT+MCj/KhCwFgNYgwium7D5u/WJPNfwCyGIyYngvsm8AbIs4WjnkMT
         VVkrtvcW16ZbXgOZ0dF/Fyc56DaZZpBvBu9vY+OBG5uwdZKlQltgKpfzYgvr5T2FNWma
         e03ZWHCt0WFFrMXaiCxLzgumiypCO0bU38yBdUumds/wcuewaTiwf7/g545bmM9d5ZLO
         0xpnWzqLiRHErjfipvxzD+wb+fNf52hZQ8i/3v26H3FAqrH8gnLSFNOwlR/nKKozHq+N
         JSRyyBSKAxtdE7KuSGdUzHDUfjjAn0OCBrY9HGxz1UUYOrLTmBfmljtlzAJqOSpKMIgo
         xFag==
X-Forwarded-Encrypted: i=1; AJvYcCW946NwYJBxl9UZpWG5rmILwWDfNzkxdyJdPHEAikgeB17POMecVzjSkqib5EFpOsjlx7HM5bL/q30qyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjmhAUQu/3OfFTa1FCG9OD8jjDeyatNMRSNUl8TPvuJMnPntqa
	51Ok86XUHidmZHRm9zRZddkhF+UXNdsPZXz8cZ9r9yFk3AU1M5LrCClC
X-Gm-Gg: AZuq6aJZngZVcPcdsXz9hbKpf1vnyTVl3ICjzyn0OEpQwBJpbdM8V/PDwoKWA0MnaL+
	OTSPcqUP3NUtkh6Pf/AS+x8XsyEozO131RLPeiVQ0IGsgBSrOB6IO562xQjxhpfJlYYSdTVzu3R
	IzaEG3vTXAxW+0gaAQxGDtI2YDtiwd2asO0rf1TQqv6HlwUsX14ISmMj30P3adbILTXdArOf8VE
	EqBKljtLk1itdLj18zm/hAgoyBhN7Pn3ztisZvDqAJdjfHKVs2VNbUqztQmYIZ2+s1ZyPuisrWw
	USBENzyiuFKGvl5Y8nS5Yk0K1w/GSt1zTYZVD8q8FYTD8npDsD7hJyXJKQUvPiqHEM+avbzug9W
	Ie/q7pqbru0WpwEU8uPKPziDOYbDFUIwGtFg6FrKmvQCBUxahpDXNO8q5qyEyoWAs1Lg64rqVlg
	TH2IdXN7mS97chip63FmA51wezeQU6wa6pxdbUiejz7cME9TCW1Cq9LCNMm+o2bGnW
X-Received: by 2002:a05:7022:2521:b0:11b:9386:a3c8 with SMTP id a92af1059eb24-1276ad8bb87mr4839876c88.41.1771884101638;
        Mon, 23 Feb 2026 14:01:41 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:1b48:5d6e:ab6e:5287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af2edd7sm9460001c88.8.2026.02.23.14.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:01:41 -0800 (PST)
Date: Mon, 23 Feb 2026 14:01:37 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, Fabien Parent <parent.f@gmail.com>, 
	Val Packett <val@packett.cool>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Eddie Huang <eddie.huang@mediatek.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Julien Massot <julien.massot@collabora.com>, 
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Gary Bisson <bisson.gary@gmail.com>, 
	Chen Zhong <chen.zhong@mediatek.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH 3/9] dt-bindings: input: mtk-pmic-keys: add MT6392
 binding definition
Message-ID: <aZzOHVh10zr9hiWs@google.com>
References: <cover.1771865014.git.l.scorcia@gmail.com>
 <056cbc09fcbb4a2845cece69209a2a564d993ac5.1771865015.git.l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <056cbc09fcbb4a2845cece69209a2a564d993ac5.1771865015.git.l.scorcia@gmail.com>

On Mon, Feb 23, 2026 at 05:12:42PM +0000, Luca Leonardo Scorcia wrote:
> From: Fabien Parent <parent.f@gmail.com>
> 
> Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.
> 
> Signed-off-by: Fabien Parent <parent.f@gmail.com>
> Signed-off-by: Val Packett <val@packett.cool>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please merge with the rest of the series.

> ---
>  Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> index b95435bd6a9b..2d3c4161a7f8 100644
> --- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> +++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
> @@ -30,6 +30,7 @@ properties:
>        - mediatek,mt6357-keys
>        - mediatek,mt6358-keys
>        - mediatek,mt6359-keys
> +      - mediatek,mt6392-keys
>        - mediatek,mt6397-keys
>  
>    power-off-time-sec: true

Thanks.

-- 
Dmitry
