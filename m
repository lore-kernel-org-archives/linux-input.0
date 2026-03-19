Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39D026AA91
	for <linux-input@vger.kernel.org>; Thu, 19 Mar 2026 05:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773896728; cv=none; b=bH1yOa970cQENo/2Jmb/7UBke2aKEmEr5/80RC4S9A+e4aA7QIud1TWR4KshlLjeouHcPpnsO96dSl8d7R6sbYHJKvVvsDM4BF0juFDLG0IF6WWPMS5v9LtH4FHXSmf8z1xxpH4gYU5gyR/YVxvFy1DaM+zyLdHZki2d7K+Mrwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773896728; c=relaxed/simple;
	bh=t7AD1W4oc26vxJ396UlI2p+sFRRUjpy/QTkzcQyVREU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoJsa2ih/TkGWtxiPhutJcn0jUJEeF+wjLO66QWgCXCUTiGtVBOmMITHhFAn9ZTTHpjTxkdOtGAGQnjMaVYjrHpElReWJluoXhUn+9eTn4Wm4O8mgS1DIy6SEPiKhoGkFj5A0Wvo3IrucLZxwm7OZSW84f3Jy9/DDEhpMpGIMJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6G+FcZv; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6G+FcZv"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1069062eec.0
        for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 22:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773896726; x=1774501526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F8SjrRV9Yg0anFvQFZOjECns1z57O1adeI2TqSANhPE=;
        b=K6G+FcZvUItiJregkDxTVKv2I7RMnxi2V98WZdh6KmwYAVSNfb1wvwtoU9IZTooE+o
         bxDdqtFYtYdhHP1T42Twg5afbW7pmxJNrFJux4fh5AEdYgjzUWFm0BorTXHJy2+SzdsM
         zYYf+afFNX83yTcTuxWtwMG2UbvDy/ZUJg9SS7g7oyqEMHNU0qrDT0ES8Hdem1VCX8md
         Co2+AkFKREj4TzzW9ChZX3q3B/deil+fodi6J2NCC22ynF4udHF6BOJ8IbUb9ob6E9ad
         cUJVm16/qDEOTg0HZqPLwr82sqCkdWSGji8YQ6W7f13gucK+thSCnS4+aAi181UelvwJ
         6bBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773896726; x=1774501526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F8SjrRV9Yg0anFvQFZOjECns1z57O1adeI2TqSANhPE=;
        b=Suld4tK8GhyXIm+p6r/416lUONLxMLAOCb0KN1T/y1bUuxP3u5mqLjYNvOEHHxlncs
         kj5h1HWvBNazeq84Z0qNQJ63XhrMdhg7gvtQtNbak12CvkPEcXz6w/NmPkwSBEwTy0pw
         xLHV0V9d0z/UUygfZMV+i58j5jDzGOXvd/cq/nbe824y0oR0oNIw6Q5EY/8NLQ+6ukiz
         21RWppCg4FsoMByYM8sm0ahToxjGqkHUoVZMhhYPItpEFqVMxpy9AsS/mu5IM+NOVB3U
         7D4RvTEEFUm5pT21RVHwbgp1eODndiZxvJIHHEY+ai+5LNvQGBNcbCCie2v8k2yaCYpz
         eKaw==
X-Forwarded-Encrypted: i=1; AJvYcCUxFmNPcy6H8kc7Ul1RnPIcGAbKDvdnzYt0/Ukk9kfbVJkLVFEEqRcuEEQS3++kumzrrEpcUVCSk2qN+g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi1wVel+NHldIkJ0i8tS65EvesaAGRMXDucFVEEi39gbnqjsUs
	uMqcT4SHnBiMaBJfnbdJY3ubeY9/9pDLMwJmxuYNzgViAGCE+unjENkdu5+TDLA7
X-Gm-Gg: ATEYQzxOlVw8h9DmdOknc2puIA7KAIOn7Ci62yv13UsCmJL3yr2M/S5NQPSGcIdIupY
	Tky4KSwPa2VzgTl8I5zJOLaLDavG8Fr47G9AiLJe+HhBFvX7XMDmteZVr9mH1aW0wHTcfJSEPYC
	rBMX61FedQYfRDPrHOGniuCaM+4eOQL8EEYi6rMY+JVcboYEh1dspqxHKROVG6UTT1mLSZyPcDf
	Oy5PasSA0+kMYMA+J88tRxeWG+LCxaCKdMrPVwBp/H9NUIDZnHUE3END+PqshUv+a6mC7y4TcmL
	uy+TsnH1hmCdPygaeUu/3ToIrl6LqneGKT+vpPcai+nznVEaspnkXHbMds0IsgHPv7XnemsLTGZ
	GY1gWrgim76qIPffRRw/7azq9qw+PYGUk2tL1vSG7TlRqg5yRewdvcRvw6XzlQCytsvNcjL3ztE
	buKKfn2Q5igxsLJmg0CmyZoVX8sSKVtk+wyplg1ydmJ7OiGq0pSVbtUy1ub6gf46s=
X-Received: by 2002:a05:7301:168b:b0:2be:ca4:e13f with SMTP id 5a478bee46e88-2c0e5085f7fmr2369601eec.23.1773896725720;
        Wed, 18 Mar 2026 22:05:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5966:2bd9:1ed:e7c4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0fb178b82sm1036378eec.6.2026.03.18.22.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:05:25 -0700 (PDT)
Date: Wed, 18 Mar 2026 22:05:22 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eduard Bostina <egbostina@gmail.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, 
	m-chawdhry@ti.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: touchscreen: Convert TS-4800 to DT
 schema
Message-ID: <abuEDqUuFElpmEwp@google.com>
References: <20260316181038.9771-1-egbostina@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316181038.9771-1-egbostina@gmail.com>

On Mon, Mar 16, 2026 at 08:10:37PM +0200, Eduard Bostina wrote:
> Convert the TS-4800 touchscreen bindings to DT schema.
> 
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Applied, thank you.

-- 
Dmitry
