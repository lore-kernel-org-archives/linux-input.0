Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E5048F835
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031364; cv=none; b=GoEDVx5nlXw4X+ejrxpuvuZH34Go9miNYKGw+LFyqWaPb1Sb/QjXQcbFIkamXpckwpqKQDz5DaYFgG+9smHDUl6+lBMM1Aj9kXJYBWQ4ucfPycCX/a8u4AAaqXNkas29Ti9vUzzINFIEXgnk1fKlOTrt6TTUCNA/JvP7ZVdB1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031364; c=relaxed/simple;
	bh=vFb0s8fL44YTlDkGDFCDrZiqpDKoxKlGjsgafYTpl1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GNAfDVJRZcsEWtXD5mUm/vjg0LPJVYMWu6loFAuYeIOA+IEQxWK0Rn5IiCALRbauj1z3GI/g1ww+NYqXE5UQZ8gt8OF1pdcy7K+HZW4ooa1fTG3lldte47ZDu/A1GjailOnCL3RLekuvlZ/KtwVCilClAYyg4gFMyL0bVuo6C9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZphIYVoF; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZphIYVoF"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2db1ca069c8so35339145ad.3
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 15:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790031362; x=1790636162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y2KVqETD0PLe5DSffZm3q7gbgMSzknmXwrxtUM2zolA=;
        b=ZphIYVoFhstelDlX7de9lq4b86qvbQnrbGl/N5SgWALIvYofYN5p8I48X5BZRv1j0m
         ekM3YqzrDWlKIXWjPCzAyBKn3qtweTIolAh9bydtkKBriFqfxKzcEyD37TY3XO4B4/1M
         UBsOd1DqMwpKTbc8IYCLZjBO9S86aQsKAIQPA26WInslGKe7UMTKwxF1UNs/7TEEFJiJ
         eeh7nNek/IgnQgE2ZAz62x8B1/u/wBKuSQXrG7JgsSHE6cPgavg4YmAeR2qDGmI5A8ch
         07/ZN6+aWkyzQ55MHbjjYS0zqEwPr/eU58dlec6TLMsZJoOmEINRfKLARZ3TFsunhrQI
         9YYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790031362; x=1790636162;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2KVqETD0PLe5DSffZm3q7gbgMSzknmXwrxtUM2zolA=;
        b=SrzeEY4cNIy8ImwywORXgTTI4bnINnpMQD+Sc6fvD4J3LIgKahwFkd6CRA1OiOApPO
         tOoOrWlrBBzcOGMOeuEvEX0ejlgMXFaHifkfosNGoC7SYJtxYhtnauCrEgrtoK98Rgaa
         fXznkpD/H6bFsJVW/JDo/JQq/HuTGvlBiXPnkA0fDSFRoJ3FbJcSqOeWzgoa/k+7gfLV
         Gd3sRNpDi7Tdc87XCEmlrMKWJsuel5IwNmkhnTgq11FinJ5SV5q1RV4fH3JRzAr0nMuK
         +jJctq8fVUhMjlFpy8yjPl0chDYTonADR04RT5lLrUsSQVpBLOvOiYrg5zrX0QKtqU0T
         ZD3w==
X-Forwarded-Encrypted: i=1; AKwUvBzZra70D7FHqgGaItD6EcOMZC6TE+QFxV6hOEnFr3WwO3x9RgoWwJkUTyG4iYZRX9b1iKTP5SDYwkF/kA==@vger.kernel.org
X-Gm-Message-State: AFuF++lXNcDn5OMdjPRO3XX/+VMK3C3GsWdstzRJmg2LPkzFpCw5bgl1
	VtJMbU4ehhiV3eYAr1LYHDA2dOoIvzrz1Rbh/ViAKLlc3MFS3j7bfVDs
X-Gm-Gg: AYBFou2MdG6T5HRJV4lmFQFycxYdAbVevQqF+Orvdysmxk4pgKVQmyX5Xued8cu7cSm
	TutZaQKsyPpluiq41hqWKcq8rgEOAw+JoZKUU2encDeNrGkOl2KYYlN8elttfsUFXx8LRDq5Pv2
	VMRoUejDq+P/041m0bBYXGM+TsabpK1HGi2WzvxlscE0dVHI+dWBH5GmaZVRrMJs5OW8mL1fvgz
	SEpntY08l5KCoX34fG7xLtFHAnJ6IzmGJmc6iihHs5qp4y89RUqhMMB2bipeuXj8i8WivHhsj1h
	vAjXDnLtBoqVpZklxrz3uriPEfB1Rkoop4teidges/yJWy9pKBkPpwENOHzhoPCwW4JvdMcQs25
	Mg0s2YOjYqIB8ym5wO5xqaM6GidIoSVhNgZjXCFIHE/yi/ljHslq1Hk//HY1pirVyiQB7voJObw
	RSDdoYCMxJ//cfeQ2zYkQWsqpl5Li0SMThuGgMmfJEKhRkno3HAoEWwvc+n1t3erUzh6xecLHLk
	4Hv1pB0ZdBTE/UO88PgFAujOIhen+akqZc+2JiQ
X-Received: by 2002:a17:903:1a4e:b0:2dd:c053:c20c with SMTP id d9443c01a7336-2df5b26c9e3mr5826985ad.40.1790031362176;
        Mon, 21 Sep 2026 15:56:02 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e1a7:4f7b:11d4:34fa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e6129b3a9sm183847eec.13.2026.09.21.15.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 15:56:01 -0700 (PDT)
Date: Mon, 21 Sep 2026 15:55:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>, 
	Kees Cook <kees+treewide@kernel.org>, Zeyu WANG <zeyu.thomas.wang@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ariel Silver <arielsilver77@gmail.com>, 
	Donglin Lyu <DongLin_Lyu@outlook.com>, Alexei Turtanov <9alexei9@gmail.com>, 
	Zhefu Zhang <a723356@gmail.com>, linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: atkbd - use __assign_bit() where applicable
Message-ID: <arG190_ETQKrSSXS@google.com>
References: <20260919130741.3041442-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919130741.3041442-1-peng.fan@oss.nxp.com>

On Sat, Sep 19, 2026 at 09:07:36PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert open-coded if/else with __set_bit/__clear_bit to the
> __assign_bit API.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thank you.

-- 
Dmitry
