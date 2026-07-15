Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AF441B8E2
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149108; cv=none; b=CzAWHODlOK3KcwKBRbWGv5J2QZQLdiyp6ro4+ZwBDl2AVxbGZfCyniU9lULs1nN37dxL+m8+Y9S+I7m+01NVruYhmp3d7CKchMVoZsX0RZCMqCPUlWygVSIq6kTdl8f8ww/vfg7zH1mk/F8gr+WEPQG0PcOHR3T8tgGc/3abot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149108; c=relaxed/simple;
	bh=aKwNcVwe8k6l1xte5Jc29BllQmYsaGkbBJF3XYL1a00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcLWdFpksWeKHNj7xUwW6fNUXD6JFh589V0IGvSe9fDUOSsl3bd2KOmsUf0G8zaetirZWzTJZBctR/mTq0X0cMDEMo6IhwWIlJ9kbV0IP4KJnaXf3JPubYnwrM4ReZzBy6ebr2bqgzoZ0D0+2MbG4hqX/YL6mnZYyxkiLtUGAuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU+7i/6y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU+7i/6y"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cc73e322dbso72076375ad.1
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149105; x=1784753905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xuPUQonPFmI0rFkgA1ueaWLbPCDRn98daoQtVv6yMEY=;
        b=DU+7i/6yZ4spxBLeIW9UM0D3HfnIhN9+g8EnxAM0SA+14aBImAxNB+CnS+Lg4biJj9
         9w3/dgOka/V32yWj9Q6M5H2/fVWr/F234wmzgGRZo2Yxi3rguWEfZK0CV20FqOExrW9E
         LTf3A9o8bJrPhEzAkAfQVibdI0EvPATTqPme8gaD151yE/PbZk3SoCDRUBP0FJ78vSbi
         oI1PbQOMkaVq+3q9HTn9GxiYDihYpRlbDdOCarBzBSsssh9x3/To0TmLf+79+8/HS5MI
         7yfea2BQ3psh1FyzpV/t66dGlis7R1c706+1BOocLpKxo0lwuR/oetXXTsPV3Kbc3Xyp
         6AxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149105; x=1784753905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuPUQonPFmI0rFkgA1ueaWLbPCDRn98daoQtVv6yMEY=;
        b=NuVcIgylykBG+RhGFYDK0c+WdBgpCg297ywyuY+NA4Q/LymOTphOEQvdeZN9w9lVuM
         kfxxFdBrCA1L2SCZWxQUXz1np+nUgJxR0fP8EGaKXUukPijH3SVA9FcwGCmYzoDFUZqw
         adiKCXKRnNj91n2pfWM5/uYDmAQxzjSEs+pfzHp+OkCFVugFT/YdNh+mQXFnN6sSx+bM
         1m7V5MJZvYfxQk651KN9Qe6sE6kdMMgs3UUUERIWxVFfZvSqupVPMBaFShkPyTnY5PEX
         TLYatIABLKZ0iKJmXiDluuQ76MXdnU6pPXIIwGlmDP9gx2bddwwTS/T8QcntVf0RQ441
         +KoQ==
X-Gm-Message-State: AOJu0Ywkmru1YK2YxrThfmjPKgyRmVOeCEy/emew4YOm5RtZcKV7a5Ma
	kw27u+XYNCBzeDK8hgJB5mkO55ucq11+gOrX+Fy7UeyMw0TrJRrCiv9xNAC3Qg==
X-Gm-Gg: AfdE7clDfnifG7p+TFUZYf/wedbhQXNtQ6oi/PNo/YZmhqdQ/ymhFiq/YCzo/PRWXZC
	aL+FqHrFsHOfIqPwas1CC8Y1wIFALn3TFe/y2M0cAArOVfjh9Ig6wBd+k77ZJsPb1R+TcVilXRp
	NjgKAMU72jL8T6mP17kGXtEr5wBxTkWZ88pvBlpvEJzMrakS9MDT9cTtDP0NNOunFB1vhTYe9mJ
	MAcNCFsS9y8uqI3vc9xYo8/H0krQIRs5czDYBp09k2lBHzSz65AGOnWG04lQijjmZ+/ERXhgQGl
	Bx+DCU+Cl1eBczqE0ASaf5cVhl8HoRNWGOcU39WPtL8sqfUOkr7fsPVc5lxrBQEEYHIhGLswVCe
	zIZaD6ppRCfbJeZEo8epqqtrlX529nDIANvglRMVy7iPOY7rGo8xNcBOvpQwHoCueDiP1+Z5HGi
	21PzeAmLUMUcWl1LOmZh45PIRyqx7AqizhaQK8fAkWaSUscAXFB6rD7udbvQufGBo=
X-Received: by 2002:a05:6a21:a98:b0:3c0:9c19:65a1 with SMTP id adf61e73a8af0-3c36c4571fdmr4362931637.73.1784149105146;
        Wed, 15 Jul 2026 13:58:25 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:575a:5ca:2b13:aa89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e538368sm7007333eec.12.2026.07.15.13.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 13:58:23 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:58:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhian Liang <liangzhan5dev@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: tca8418_keypad - enable overflow mode per
 datasheet (SCPS215G)
Message-ID: <alf0aY63QIPMo3jT@google.com>
References: <20260529013900.43854-1-liangzhan5dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529013900.43854-1-liangzhan5dev@gmail.com>

On Fri, May 29, 2026 at 09:39:00AM +0800, Zhian Liang wrote:
> The driver currently sets only the overflow interrupt enable bit
> (OVR_FLOW_IEN) in the configuration register, leaving the overflow
> mode bit (OVR_FLOW_M) at its default value of 0.
> 
> According to the TCA8418 datasheet (SCPS215G, Section 8.6.4.1
> "Overflow Errata - Description"), both OVR_FLOW_M (Bit_5) and
> OVR_FLOW_IEN (Bit_3) must be set high for the overflow interrupt
> to be generated. If only OVR_FLOW_IEN is set, FIFO overflow events
> are silently lost without notifying the host.
> 
> Fix this by setting OVR_FLOW_M alongside OVR_FLOW_IEN in the
> configuration register.
> 
> Note: I do not have access to hardware to test this change.
> Testing by generating 11+ key events without reading the FIFO
> would be appreciated. Full handling of overflow events in the
> interrupt handler is left for future improvement.
> 
> Signed-off-by: Zhian Liang <liangzhan5dev@gmail.com>

Applied, thank you.

-- 
Dmitry
