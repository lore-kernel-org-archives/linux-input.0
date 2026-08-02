Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDDA3976BA
	for <linux-input@vger.kernel.org>; Sun,  2 Aug 2026 22:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785710693; cv=none; b=XugJnzzgVadUbnGeH6H/YU0T+LCGiW3y6dniEXWmTBSWqyo9bIZ4bvQRYrA7LvJKHzpvB4yaYvHfX92At098xDBVFVAlOCiKzWshqdkEJ3Rv4Rl8/LGolK7fFMWXfqvcuu4U5RskKsZqTvpYhlKie0pCSfRRwe2CSbAzybdMDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785710693; c=relaxed/simple;
	bh=1sVTYWJpMvOF+9w3s2e71H8B5OS3MATiOxgrCzaVnKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwLJ1s/EugY5vw8kTegr4ezunGWsWakqU+IHyl1IrKxVHgINkilnHqz6f/AUo9Fz0RnYnc3+ioB7e3x25/76NkFrFAYdWCXNLD28mSXsIx++RGDeEgvZW75Q9EsyhhvuoGt7LixHoyVQOD3zQqqM9o7QsOMKKE2TDgG5WK4Qy6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKc4x0Aq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKc4x0Aq"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so2780352a91.3
        for <linux-input@vger.kernel.org>; Sun, 02 Aug 2026 15:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785710690; x=1786315490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bjiQvTX0l6Yp0x86rHCXVqD4HzzA4H7jhBK5W/WfYnA=;
        b=FKc4x0Aq/7kt+Fyvi50SB2zbRruICcW1YJRbAx0MZTZefpp6JTKWaRnFBC3DLSRcKD
         wAKrZAfS0gMZ6XqvlIKJGzq8AgPZoSTJoS+UiduVlfemvSW1zsZvyKCgiAcZy6iWWg9n
         5a0eIypjZJzBm0+CVfycsprSQ8kEei3cXRsJDkHLaJCpvcBPsDoAUGgSNEWgSvo63Gm2
         M0kgG/Z4lrG6Dwgy+A+SI/Enl82OY3MHQ3KPERWcqpsFzo3WTy/dLoZGccdW7MpoIqqb
         TtkJLYUCkNFwymxapwci/ncNsGyq0Wk+AM9B7R2DVzNTrZQZf3vrmxK6qwaeCKzSNdJ7
         VzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785710690; x=1786315490;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bjiQvTX0l6Yp0x86rHCXVqD4HzzA4H7jhBK5W/WfYnA=;
        b=LvZ+LnRPI18ND6sJr0cBDG7vx5DAuwDz+wD577PCkELz1JqlJPC3OSip3tsqkEpnS1
         pruWptm0Levf56WVMu1XpMcmlPC6Ypa6sMVcKCrGp6fLgBiXhm/ITo/4y9adEstzLkyj
         cqGP+wlzY0SUL+6ExE3ouayqJi0gpBth777MxHeGLelZv7EQEa8srU6ZRzub1tr1ZNGy
         yS1z6Xvdj/mOOYmRXw0Bliz8Ht5j2OyRVK/9rDBUprY5E+L3yqdD4KDN2r+7alq6aR9l
         ah15aZqp3ZLMknW4Ggb4S+3FmvLsiVz/YWV2/Qj/OjLK5BVXXGuBHOYV1E3pA6dy2QiJ
         eyiA==
X-Forwarded-Encrypted: i=1; AHgh+RpHh8iU+gFFLWxFWF/HaQt/X4ohrFjDfSe+I5Ojwp0lAUkFdsvNEeUUkjOug1e+xITp5heEDQqC8HY19Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNJhZx8eBgVZibksKg7VjlKWM6SU6Mnb73VZm55EN/2ZYxml7Z
	5c1OSGPKuiYeYHWz2GcEsS96fNwafPomZmrGBbaGBWtnLKvNkVUvOc8fufBssA==
X-Gm-Gg: AR+sD10eL3bEiQqEf+g8/BgvTxf2KZkQN2WLyohm9s24bgyl09TagEXyVDVeEvHrmCD
	lDT75Vm6Pr9a1HOjgUAtnzyJkGLmuVcv0M+sYCo9PDR+reJKbpWKpDiPeIhlYsnnJfesvoebcUl
	xDxs07Dnq6u0TBsbFXIiEtitLg/CDpm8NG56utxsy6MI0qcdiK4XKUGVCqbtqpjc5M03xFuJLTN
	+A1QHzYwaovHtIGSxclWoiMmehX/hogdDvgESDYbsBGbHCYOGCEiMI9K0rPk+FRn6DOEBcCqh8K
	YMhxc8SdmOMBrzYeGFYTcOCgGq9NAgloXuVeAOfRWIZ6a8PUZyla/IC3dcdae6QNBirNb/Hhtyv
	J5j4GhzCl0ROeofsay6Dbd2uwXK9FcNL9z+pyJxc38XwyAXt/PvLskZ+JFNjHBJ9NYN2joNuXrQ
	y4QbIRCsylyoKU1BnTqrMn2dZycBiAnKu2ZbCy0uQ6PXgyWHoJAoL2iTR8465ESGzAz90EQPA9y
	OP+zUaFJQ4VXjM/Nrfwy4bdASfmqw==
X-Received: by 2002:a17:90b:4b45:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-38fbc40905dmr7317019a91.8.1785710690303;
        Sun, 02 Aug 2026 15:44:50 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:4fff:876c:cdae:e53c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab14475asm24000953c88.5.2026.08.02.15.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 15:44:49 -0700 (PDT)
Date: Sun, 2 Aug 2026 15:44:46 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhefu Zhang <a723356@gmail.com>
Cc: Andrew Zhou <zhoulol888@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: atkbd - skip deactivate for Xiaomi Book Pro
 14's internal keyboard
Message-ID: <am_IWayJyJYhMJnb@google.com>
References: <20260801101908.33838-1-a723356@gmail.com>
 <20260802031559.19701-1-a723356@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260802031559.19701-1-a723356@gmail.com>

On Sun, Aug 02, 2026 at 03:15:59PM +1200, Zhefu Zhang wrote:
> The internal keyboard of the Xiaomi Book Pro 14 does not work unless
> atkbd skips deactivating it at the end of atkbd_probe().
> 
> Using 'i8042.dumbkbd=1' also makes the keyboard work, but then the driver
> never writes to the keyboard at all, so the Caps Lock LED is lost. The
> atkbd_deactivate_fixup quirk fixes both without a boot parameter.
> 
> DMI: XIAOMI Xiaomi Book Pro 14/TM2424, BIOS XMAPT4B0P0909 05/06/2026
> 
> Signed-off-by: Zhefu Zhang <a723356@gmail.com>
> Reviewed-by: Andrew Zhou <zhoulol888@gmail.com>

Applied, thank you.

-- 
Dmitry
