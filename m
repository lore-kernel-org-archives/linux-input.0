Received: from mail-pj2-f21.google.com (mail-pj2-f21.google.com [74.125.227.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C09194C96
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959290; cv=none; b=E9vNSiZh/am86MJhs5Z7GF40de8YwwZHJzI+i5cbw5ZKrpNFBjwL6/pQR6PVZlsHUKYrNzbZTyUbzuchjtQdmYf5msMdtnWHnU5Ai9XQ5SuIUGc+9O4rGrH/V57CN2XinDyJeHzaNUxCrlSfciROIsLP4etXoxjZDxaqaeS3Otc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959290; c=relaxed/simple;
	bh=E3JkMnGARLVQZqyo6q6h14g5UvqxXiUDavQnpHXoXCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT3So0FTiFheWzTuQZV+9Be/k9XraFaXVE5ZFhK47vPiVUBblHkRbAKEa71sf5ablX8tXnICUEPR6sDNtBUPOFzV499ZUPUieVl/Y2A/QShS9L6CpJJ0sJztjryT6mmPhNop/ywDm2kY+2iDoECusfhCN5rMLgLkRkfN1cT3B7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wnaj2bBg; arc=none smtp.client-ip=74.125.227.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wnaj2bBg"
Received: by mail-pj2-f21.google.com with SMTP id d9443c01a7336-2d747f0b25dso27261035ad.2
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 19:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789959289; x=1790564089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RymOXsL7ZaFtcdX4qP1HD6ZlQqD0fg82alSWO9QFV0s=;
        b=Wnaj2bBgecGO5NjTd0DhqQZkoa8euHAezP+GWXZh4xEhbaipHyqTY6fk06KigQD6WW
         U9d9M6tDmnZriQSpDYZztozcYxJtYf4H0bU3qZPDV7aNsu/txRQivoR61CxdWUtK/BvX
         wkfwpPJSqIs/t3zfc8Pcra8fSFVRKgn3VWqmAB00as+xhoMFvF9FhUFg/h/5/N7J3Hi5
         ViNrXYvc3ZtyZxdHHb5LLDpwcVNPtNk1sdA4yJZTXZiI1tN5Lb+tzu8ADIv5q2MAUOBO
         jcfrl9aniEzeM+OLtRTml5ln1GUO68NBqB4tYbj4ya11dlhqUkb/VUh1tzj2leLxGxOa
         /0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789959289; x=1790564089;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RymOXsL7ZaFtcdX4qP1HD6ZlQqD0fg82alSWO9QFV0s=;
        b=jWeBMcyoEQLIRpAakp9Nx/SB3wQoS62ugF6qpxM2kz3hlQ6tYsFy/AidKm5rG69Nxg
         56SEkN2W4WRkIW8F6NWzt/udDa9g4kw2Mja8figTYeCszRdjwcwlXVrT+qROb3Iepuuu
         k1GFT5jz7eb/72xR9BR/90IUjyfqGk6+xobsfAo1o+FhA5iT5lnOJ7r0xFAg36Nmzj4u
         J8duTyrKaHPpn0f85bYpjzjbfSTT2PWRsG6vcuYDbIRc9ddmo1k1rUUWLWCsnL6Db2Z3
         QmqOP6UsaBbU+IOUpo9XEdPRZjqYD7QBjYOcLbe9uIP6Vkr9+9YJ8UU9/F1sikeU3JLB
         19jg==
X-Gm-Message-State: AFuF++n43UZtlAsRgmINMmvzhhTHGfg94VazyNJIdFxfgFHYelPxghad
	PwqRXAz0UKs6zQ6fCuHPRA3+fw355fGoenCn9viQP5bJh1EA5aUsZESy
X-Gm-Gg: AYBFou0vpzHT+2rOCJSL1OGtWB1Bhn4iauWf0gQfqXfTf9kgF763dfbZXQJz+zfawWb
	zIXygQVdYanyU35+J29wXJEZSSuigfptbHQl4K3E7o8LstxowsPkVbtc6pKZCmrhLyQhVATHfta
	0c5nDuBvYJIQISdfU+uMuGVDsDkyIz+jOAw+w315GnciW1+48NRABBZhZ/KnWQyFO4TECdOtlKX
	uQE2aeIbNE8g8w+cNPh6gV6EaBKddG5QT+KVnuUAo8e5tFBeW7Z4c2T9G+FJ8s69pFCZ8OA+Q+I
	fOGxM1esnlu0J8fu8Z4phSxnwuNnM1miYsjDjEuLEMjJX0ahQpPXeht6hs+RMRtrwPd1WIPBobB
	8rGMXpLWRvhOVyxKJzZ8rxzCHraI9dRyQMLlT1c6hj1JjjcTTETsxlG5g5F+B1Bh195RZYwIzE+
	5amrIPo++aX2iYOlt2nIq9TmIAv843Q7F3u6rQthB+CBCqYRkci3m+fDgl+9tk68/ZjmSHd8taY
	OHBNxtOd5nwgDmiWW+WVu3xrHsBQoc8vwuLBvg3BceIn+7MC4E=
X-Received: by 2002:a17:903:380d:b0:2dd:c100:313f with SMTP id d9443c01a7336-2ddc1003247mr81656005ad.59.1789959288840;
        Sun, 20 Sep 2026 19:54:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3844:3355:5928:66ce])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d5a21sm15408982eec.31.2026.09.20.19.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:54:48 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:54:45 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: linux-input@vger.kernel.org, Heiko Brey <cico0815@gmx.de>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - add nomux quirk for Fujitsu LIFEBOOK U7410
Message-ID: <arCccVxkp16QbAs2@google.com>
References: <20260920113541.1484808-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920113541.1484808-1-lovekeshsolanki00@gmail.com>

On Sun, Sep 20, 2026 at 05:05:41PM +0530, Lovekesh Solanki wrote:
> On the Fujitsu LIFEBOOK U7410 the internal keyboard and touchpad die
> shortly after boot if i8042 multiplexing controller is probed and
> switched to muxed mode. These multiplexing setup commands disturb the EC
> emulated keyboard and atkbd reports "Spurious ACK" and "Unknown key
> pressed" warnings, after which both keyboard and touchpad stop
> delivering events. Both touchpad and keyboard work in BIOS and GRUB.
> 
> Disabling multiplexer using i8042.nomux=1 makes both devices work on
> warm/cold boot.
> 
> Add a DMI quirk to force nomux mode for this model.
> 
> Reported-by: Heiko Brey <cico0815@gmx.de>
> Link: https://lore.kernel.org/all/89f36f3f5e4c2d07b9ff72bc0b355875c336e498.camel@gmx.de/
> Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>

Applied, thank you.

-- 
Dmitry
