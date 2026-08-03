Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FC284883
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 16:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773944; cv=none; b=fPZuVL3KJrCZ4DcgKHRXkjTfNOrM0tIY5G80iIZZAnb/JMuAggvokVDirc+vzkpwHU+2qoaqaaYGmE18+UOJHDalY/0LnJ8Pl+hCIYBjkcArlpZW18wrdhO2lOdve3l5HmYeXo2n+K3R6MQkmTf7XyZiv/tcZFQEVlsSq3qEJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773944; c=relaxed/simple;
	bh=mWqoP8mAOiBZDHdRNQs8RFWV0az4Lj6YI5vQAsHzfns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRrU7AFopznhI6Rr2Q7redkmDyDbceOpttyjIWeQqflvLCfTO835jQvqolvmKjlipS/96gmNfBnwzUMpGLUD9Yq1IFx5Ib7RP5sObTTMMP8Ml+ra6oqvVGOzHgy6e9Tpp9xRTCiJUxTinAX65KexJfz4ibkp5mHiC79wtU2K8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Te2BW3V6; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Te2BW3V6"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso3876267a91.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785773939; x=1786378739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MVt9n27aPpUtQxq3bGnx01UB4LZbdXF7CgsyUhjQf8I=;
        b=Te2BW3V6rJL+y4yTstcWaunkVYxpuupKjmBHbyb7vz4qI2fTfRvByOfp+FAtmmq5+p
         aP7HaS67GnuDoxdAkCt4y2Twj/c//ntnntQDJSai7b7itkw7ppJ+FuBDJKJEZbpJwJzw
         PVZdQkFjRyHHpyN70SpFdUxRg15DwGf/IfOqh87qsHq9NqShT7qpBwBJquk4p3JTRC6u
         7koj4cIzuGLITD9aKmB8StTy74GkXpGcTr8iCcdX5vHNYr1cYRl+cNPIxCmpBme1jfGk
         JjVeAvw8mMRWWNKqmln0C5HNG/dCio+g7A4zzAGaEMvvawGkAic04Vtayln3pX6eDlNa
         m2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785773939; x=1786378739;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MVt9n27aPpUtQxq3bGnx01UB4LZbdXF7CgsyUhjQf8I=;
        b=E0rdsETi7bBzDz/ZHaoNJs7P9KuSXFk1Ub5Ydus2O+bkLuCElqwGMSkHagHmT2AjBH
         LDPNk687uefh5oa3JErrPWLMvozyBGdpBXcVvLQVIcy0XGIFi+H+rC0Ueg7NLa0V1JHZ
         KrATYFuc4HgD1kVWlx1eAwMzwwsQfTKGJfTafoTY3AsWEfHO/QYt4mBXXsh74i/9+Nlr
         g8TLqyGCQ1uTup9FTthME7Xw+SYYrBMdiszbAJLKj/QcW7KLTduULCRlIgyBZOOBZuMG
         zue0IFu8rNyu3hgzs3D+uScCWNcgidH8Id4U4dbjVa9y934c5hwwRsE2NqxdAcYfNEbv
         ciUA==
X-Forwarded-Encrypted: i=1; AHgh+RqsPVbiTGLcU2w0R/AX07Do6kmlH0ja0okELnIaiQ7imtCcMuvxXtJvHX2dzbWg5zCk0pJO6D/yDkVh5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkasAiCJAJnxbwPIsqYQU5CBQo12c1yhI8X6FZ3AOhHGxwV1G+
	Y3oOVesSRY75LOp337fFEBNtTs2GZZ3Vjr/3toeQHAJy+765h7UMCd8A
X-Gm-Gg: AR+sD13fCSELfr2ecTF+xJZZIVHplGMqCECbzgYw6x9UcxTJfR1CwAf7h5k50qoE69U
	oHQloq0Lci5e5J9X33ZmtoG60O3FTX3M+AUm+y7qYSS11M4u3qYYA1K2kQflTINGveqNnr3UIOX
	yL9gZrYKssoYpXjhOLbv4CDbCeRjOYI7OJhqlyk6KPCkvGto+HnoxIxZ0PQJsX9hyuWfOBKaWjk
	2cut5eUM3QfAo7Hj6axF4OXQjLXMviAq8hRxCLVSgKdZ6B2G70I+CDvcgZWqsp7iTpy2Q7LE50y
	zZsvHO4/KCH3IuCpYl9WRDKV7DCEg2/yWGygP8c2scO9nSlxEBHKfHDi97BPbqZw2AW24NEC15j
	TLKUY9kNIrhlhBNid6LOzyB3WZ5EQV5FsuDLdWxugJetWQIolwP3mzOgJm2lT0JBXN53U5f0y2O
	rGtEss4OwGtJ/6KruelLvPfCZFNI6cUHdSIcxumQ5NiavEv48x1bExO5dCOWY/8zfKAV04PI62Q
	ZsvMuD37/2gXbJ4GTbXqVeWFB3alQ==
X-Received: by 2002:a17:90b:4f8b:b0:38e:92e5:48f5 with SMTP id 98e67ed59e1d1-38fbc4ff533mr9610014a91.24.1785773938769;
        Mon, 03 Aug 2026 09:18:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e107sm44609477eec.27.2026.08.03.09.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:18:58 -0700 (PDT)
Date: Mon, 3 Aug 2026 09:18:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	Helge Bahmann <hcb@chaoticmind.net>
Subject: Re: [PATCH v2 5/5] Input: misc: Add AMD SFH tablet-mode switch driver
Message-ID: <anC-yvKFovLA5WWC@google.com>
References: <20260803145801.3801862-1-Basavaraj.Natikar@amd.com>
 <20260803145801.3801862-6-Basavaraj.Natikar@amd.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803145801.3801862-6-Basavaraj.Natikar@amd.com>

On Mon, Aug 03, 2026 at 08:28:01PM +0530, Basavaraj Natikar wrote:
> Report whether an AMD convertible is in laptop or tablet mode using the
> operating-mode sensor provided by the Sensor Fusion Hub, and expose it
> to userspace as SW_TABLET_MODE, so userspace can react to the device
> being folded into tablet posture.
> 
> Cc: Helge Bahmann <hcb@chaoticmind.net>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> @@ -81,6 +81,7 @@ obj-$(CONFIG_INPUT_RK805_PWRKEY)	+= rk805-pwrkey.o
>  obj-$(CONFIG_INPUT_SC27XX_VIBRA)	+= sc27xx-vibra.o
>  obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
>  obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
> +obj-$(CONFIG_INPUT_AMD_SFH_TABLETMODE)	+= amd_sfh_tabletmode.o

Could you please move this higher. It is trying to be sorted alphabetically.


Thanks.

-- 
Dmitry
