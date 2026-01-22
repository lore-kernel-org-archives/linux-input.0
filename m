Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47F3815DD
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095539; cv=none; b=SJ9KqsN/EqhiXUTM83W7iKPpQNk2iAgvdBSz7Yk8FivM1pqS8crZs9oCcj0oDkM7VIDOeU2pg2lK87ZWoVpxGSQO4VjbCso4NyxMuWi5akSq1oIlNrpqExzs62+6UV6c8LqO5Lk+oUrPFg21iYndEy+qGKae+ayKxMSAjy4klxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095539; c=relaxed/simple;
	bh=pgNiofgJLQjI2k4U5MZqlxSIxjaIGbb5I0Xm0TFUekM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQTgNo7Oh1LxtG2UAxIwES5mBsEGBT30f4WjW/IdOnmXRhaeHUmYfzrB0X/mEslv0Yg3IL7WvpH+6fSbTtFnEYuJsykj2PJMu28prmZTCpAbQc4DV5Lvy5/sQSf0NglU3hLD1RuyJu1MFyl5+PTxcc4FLTQ1YPNMr9SvrXAeYQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJM7lGcZ; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJM7lGcZ"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b71557299dso1488430eec.1
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 07:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769095532; x=1769700332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fK/Bd6ZC4I2BWi9zAGM5OINFSwJZAF+Q/z/0mdibPSw=;
        b=jJM7lGcZQUti63SuVaWGjewgg2WaDOH3jUktgukA/4WB6eAcAAvFTrUEvzUsmwDxWq
         dxy8kqGwFlWxvvjtWKRfYBwBKUK7JR5+/dvKxHac7RJUmpQ7r1oaJdkaySW6uEW0oAJb
         J2BRu+iwfIkNNZggRn+e3MXOIkSV+E/DDFbrC66xG2EYP3D5CdvzS16y1q+mCSMdCWq4
         o75S+nwPYATFeq9aH84n3lyUhOLPNM8xX2ldEfZZDxo2oJ1Y7r8tsJBGe6qVF62PYumn
         ejFgQP5CP4sk951Ea3Y9bK/oLQc6lEKnVeUSX/qI3ijWyaAH4dOnex8Y7zcc3BItoQhu
         7drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769095532; x=1769700332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fK/Bd6ZC4I2BWi9zAGM5OINFSwJZAF+Q/z/0mdibPSw=;
        b=bYU/J75g0K8EPtH3jNdgNnNKL2tR7MtWPBkA03Hu9J0EVPd5l1QTe22OjnPjHviemX
         vz539qgrXcyH35OA/CmvNbqsOSj/v4UM7p2VztxVUxMYnj8uus2yBWNK5EKzaMNRzalD
         RwSXOaI970+PTCCCCqSFPf+98Q+Syms6JoZcSWXWqYnjH64Q9HztmqZt5IVEx9Hjv29i
         ysC04RRSNkmwGWmro4AwE1zrJ+31g6YglU9EumJYFyoyk+6IqUSP0p8cABUwh/M7Hwx9
         w+w/VocSnrKU7dcnxOKAH+OLO4cIkrgXiBElFRd7d/+pfMaYja5TAESqLZ5VPpBEiOIR
         labw==
X-Forwarded-Encrypted: i=1; AJvYcCXtXyAwZ+5xcff7m3KPEOSziekfuZXhVUxKDA8CI7yednqtpk/gp6xaYgE8TrSIp3qKgqLYuU2CtcuhmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzvd5OOKJU3vTAxsy8T/5BuUgr+eh7kr8uZkrFT/4LgPHBeTJQ
	mGAw94mQ2tzlZjiTWVaASXeswDM8fzJHxzxEdgBvdV4S61LNX5fH8RXb
X-Gm-Gg: AZuq6aKgSEgjgrSVjkM135KZc029pX+mqfMwFNC5FP2VE6QmaFZIcYgF7KLsjqdVmeS
	PtfXQMip9eFxr0mF607Zce4mA/lipIZPvVABfwpCvJXW5sxmmhRvNikBRoCaMZfVgme/VKYP2FK
	lD895cnm04bn7qMhhx0NGm0vC/pX8coxL07N1IrEuFOAVM0xc2KshLialQ4XLVTi6r66mqDRnaD
	9fqE1aeC1OuzNkozZW6nkXWiX8RUrd56YPJkcUw8c4GImBXwo/GqdmAtDyzLSrwKrcHSuOiGedQ
	h15UWdKcsUF0qpc2u9ICjqSWUTzwsUFqVmKaXRBKQ5xuraBjqu6g/ZjDCzTSLhN+77r9IWOVsnl
	BURqFc2r9t83yKS/xxcjt5EFSjUttWxpZiCvdZZkBN8aWqAPikambxZW8ZSdkhVO6yO4WwY4vUa
	yXQew4WP/dof2J0GuOIIrCn7Na4BXCGGu1Q6hmSFNAfmGp+eL4btg=
X-Received: by 2002:a05:7301:9e43:b0:2b0:4c5f:c05c with SMTP id 5a478bee46e88-2b6b46c691cmr14222927eec.4.1769095531525;
        Thu, 22 Jan 2026 07:25:31 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:777f:716:9c18:5588])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7070eeec2sm9198224eec.21.2026.01.22.07.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:25:30 -0800 (PST)
Date: Thu, 22 Jan 2026 07:25:27 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Samuel Kayode <samkay014@gmail.com>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>, imx@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Input: pf1550 - Remove "defined but unused" warning
Message-ID: <qrtwktjjxjphuan2brtltc54p7j5hryl62hghwyjmloujpwonz@eckisacyhd73>
References: <20251210211149.543928-1-vaibhavgupta40@gmail.com>
 <wfdhjzhkggp26mwqgvxuanuzjq6v2g4pmc44jz6kx4xwkewwhr@movikefnuvcz>
 <aXIhp_c0zjS9dfWQ@sam-fedora>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXIhp_c0zjS9dfWQ@sam-fedora>

On Thu, Jan 22, 2026 at 08:09:59AM -0500, Samuel Kayode wrote:
> On Sat, Dec 13, 2025 at 01:38:57AM -0800, Dmitry Torokhov wrote:
> > On Wed, Dec 10, 2025 at 09:11:41PM +0000, Vaibhav Gupta wrote:
> > > If 'CONFIG_PM_SLEEP' is not set, compiler throws warning for *suspend() and
> > > *resume() function for this driver. Using new 'DEFINE_SIMPLE_DEV_PM_OPS'
> > > fixes it.
> > > 
> > > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > 
> > Applied, thank you.
> > 
> I think this patch was dropped.

I see it in my 'next' branch so it should be in linux-next.

Thanks.

-- 
Dmitry
