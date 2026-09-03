Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570624FDE67
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467953; cv=none; b=iPLaTfsD5SooD1lunHsXFeqDl7Lv6KkGIKa7zZOKg8if5QrlYdjIdBkb+UA3FPLjG6uyFwadD+hgo8PT4BSaytngRYWLhg6vt7Zvm67d7DonL4HuetnWqoMvM8H05TCgY/tCKs18Q+MeGZ+T8NpCbyxVJbkpns53ToXUQw3w16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467953; c=relaxed/simple;
	bh=eZnBBaxGkNcJX5ratb7mwDxrhK2EaWxSIwLNS7LdY8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwhTvgPnMkVEgldQtF+VyQsMQFymGNJRJT5U+KRCdJANQZ8y2uA+IzElZQOsA0rERnXfQ0Rg+P/x4KVFtUhZjft7jF5HlCp19Th7f/tv9cYFjB4kKFOIU3xZyAbim+lmrY7V3vGq3WU0kcYoDNDKfSsasiXaNxSQWBuT7bripCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LurX8VgZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LurX8VgZ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d58efc7356so3632605ad.1
        for <linux-input@vger.kernel.org>; Thu, 03 Sep 2026 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788467940; x=1789072740; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eZnBBaxGkNcJX5ratb7mwDxrhK2EaWxSIwLNS7LdY8M=;
        b=LurX8VgZ9x7haZNmKlpvBZPk571qtb95vwB97WZHc6q+tz90nG4I8oZih1FTq/2+aB
         a/CYUn89te9NEJ+RXUGV4dEwdKgraNmFgJ47gyDsi/48pvRvbqq23NoHqsioygOnoyl0
         TGMp8ZbzR/J1RaZHX0mmx1+S7XhOFOC9oEq+ghR45qb65Wxc2BGrxLoFV7W2FvSUfgMI
         UmyG9StiVlZNnbIN1bEmJcwFXDrDRlj2fo/JuThXys7xnzD92Py0qhB0bQcRoEoICjKZ
         60XVFfTNc3JA+cxcpwIreCaoDOYdvPpoE05rMZ/fVhr76qssnrkLq3vcX92vGrPVQxDw
         slQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788467940; x=1789072740;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZnBBaxGkNcJX5ratb7mwDxrhK2EaWxSIwLNS7LdY8M=;
        b=sdCwGR0euw92nxYjOhRyCmJtjh+VeWlNbzwOB2jRG+uQLq6t3Lz9Zjm9UB2+QHkpkB
         R/hh/gcQZhAVDkrgOuMC0DYUPrr4RPKHpsky+ghhsTSSn4LGz/Rb6Ry8z2ho4W8ovNZD
         6Tgmh3WLBxbOai8BOtx4/kfHEI09+mUFheMizZPHpHI2Omp/Cn5sLmi5DVdQQgdvBIdV
         pO59bOXY6d32Zxqm0vYaBflS6TOyg8u36YxM4J597L6aYRrBizSHuxs+2ygUJdzVGAUO
         lGby1wso8GS1ROWLPDG5awFfJpmtJU30szdoD1ssJTEKmO1oSFcABjTuXcBCj9/Xf3i3
         DZgQ==
X-Forwarded-Encrypted: i=1; AKwUvByR88s0vy34Lla+YjevqTftf9JA10xWHY+eVAsd73xsqnjGsrvNiGdxkLtr867KUg0vtg+dlhP2LR/Ebg==@vger.kernel.org
X-Gm-Message-State: AFuF++kGq6Uv/Yev0g3fCQV4dPcvALDnnS6ZiJzkCEMfXxfU8OtBlaqb
	HDTJMb9KtLkee7/sMotzyqwoabtFDg57n0L3CvY5ZrN8mI3eOPB4C8Sc
X-Gm-Gg: AYBFou0QuiDvsd73bAnEJhO9MLc1iws30GPzCvaf1zijxADXVZUGm7dmwIMjNdhhiUY
	a/zsomaUIYdAkbFSciN/vVffeXFF3zE0c2cqgRq8baSyXEe+4xYvAH8jZWEyyMVCIxpqLmrUJ4z
	igCKfP62RtAn2pqvY0s2IcgzcJj25nnOyCLjKIdNTsR4mtJ1b26KDlWt5nSu6jVPY+NPnssSgVu
	CM9aBiBpG7eTBuls4nG/lvbRgHtbP5UcrRGfWSSnqrnndzlrl/mNnywAVSEHVdA8jifiFco3L9r
	j3bkexbuFKjDXRm/vacMHUbNM/GgHk6A8sbtENV1zrPz9WXwXBmtZK1NuwwePKMc3CrKTpK57hj
	Ngc6guMaUJRGr/SlLWB22tuj9yT8kmW7qhRZrPeXixcy9rLHLQChG3Wrs44BJC8/SDk/SM8AxzM
	RJCx175gB/adwEZtyJ5PBavWextHQuZxkxFVyETIU7MB3jM3zfKXP0jq0f3opFynNlzho7sqKD2
	aFZUt6wK8pU1YXcTUXR6SP7VOmpBRndL/zb93vCu18RIOuE
X-Received: by 2002:a17:902:da8a:b0:2ce:9c48:22d3 with SMTP id d9443c01a7336-2db127ce3bcmr21894505ad.11.1788467939845;
        Thu, 03 Sep 2026 13:38:59 -0700 (PDT)
Received: from ?IPV6:240a:42cc:7003:3e3a:fc79:f45d:5f5a:f824? ([240a:42cc:7003:3e3a:fc79:f45d:5f5a:f824])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c1363sm892335ad.60.2026.09.03.13.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 13:38:59 -0700 (PDT)
Message-ID: <6c145ac2-2163-42da-a204-4fe775113e07@gmail.com>
Date: Fri, 4 Sep 2026 04:38:58 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Input: tca8418_keypad - fix race condition in
 interrupt handler
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
References: <20260903192942.21906-1-liangzhan5dev@gmail.com>
 <20260903192942.21906-2-liangzhan5dev@gmail.com>
 <20260903194114.D04281F000E9@smtp.kernel.org>
From: Zhian Liang <liangzhan5dev@gmail.com>
In-Reply-To: <20260903194114.D04281F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

You are right. Reading REG_INT_STAT does not clear any bits and IRQF_ONESHOT already provides protection. This patch is not necessary. I shall learn more next time.
