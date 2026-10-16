Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9387459B683
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177077; cv=none; b=fYQt+WMlNYfJIatT6oxeEb7z5efW4J6+YoW8CDktDffb6EKnsCcTrERYlv8cT4FmCH1HN3SszeP6FCPaUFM0ei7mitOmw7N2cafUcN+oahAexK+CKGP8alGfy5CMDzZS+zR/nPvo3fXK5d7vYbvfmdzQ98eLmsQfRsdjCx0JWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177077; c=relaxed/simple;
	bh=yjGvkbjtlQ8T3eF3lK7dFpTqZrAVoRa/Y8faWedXed0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=latY+JinvDt7TYdNvt2p0loupjbpHevkWdNf0KLz26KUDwFyBV70wG4lXFlUvDA/xP4z5bEfDoz2+kA3lvVeKTFJL0SMxzwMu9ESGtNKa3QTTZI8ODyDgOojW9ufKHeAIxbFnqvu/PkQT2ovBebUK5KzjknL7pRf7wuCT7GLE7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPmk7Gti; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPmk7Gti"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35f1f76ea84so339883eec.1
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792177074; x=1792781874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1gNBlH02GoDpR2nYp3eqisK0Fq8pIiVS9sm1oFPVE4k=;
        b=ZPmk7GtiUu7Xe5ew3KZSPAeotVwjbV4pb3gFM2DqU/wwE1pgrqEtDGEpOCYIYhwYUJ
         ZOLvjNHuj+MPawHn9adML7f8OGFyOW55OPG7vHoPcaibLqCzUFVmIMIH5d81Qr3QKzuM
         LQXU4rERPt/+4vxpaT/ZkD3IZeSVR5j7MFmiPIzu97HrYfL4swZnZiHUHDRUtTVSAj5L
         QGIEKn/Pt5bshaezzowvozHnIMMtef7zD0m70hV3e0ByfReG+62UCmb/V0pz4bAhVzpI
         zdXAmuabmd9Gwbj8LblYwQgJnzhd6P39YGC2gO8PbH4RUzPA9U9oSh/WVtdeCUPRZw27
         /+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792177074; x=1792781874;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1gNBlH02GoDpR2nYp3eqisK0Fq8pIiVS9sm1oFPVE4k=;
        b=fjytPgh5LjL/NAsmAHWoF7BOhimLrfqMXxe46IRrySSKohrvusfy7jITJWR74UtZ6X
         HvVj/vAv8bLUux1nrZA9k/3tiAawEk7Sj+e2VJ7Tuo/FNjYAxYA7VLRAjSH2VqC+QYDf
         PQ6ti6hXgVOZBkj/HicegO9gcVTW/jHAlg+i3cshB/0NpNYVX+WwG+8JPFYlImrCjjPE
         /WwS2/shp5v8UC1VmIqHV+jlfhJTySWWqAYQeb/PfYUDk8Ap1z5gt4DJ1iTIcsvh7Ju6
         G0cubGjRmwuv/5GzVPnW1V4ZbsXhdg4CtOvRAQbp1k1KbLxcnU6s3bfGNL9Avh7EWWB3
         9lEw==
X-Forwarded-Encrypted: i=1; AKwUvBzo65nKETFjsvWZe5id8R3xl77BI1Jkm25tcT7ESlftq3SIapiowoSun5cICKm7Sb2yVocCKwz0GdaA6w==@vger.kernel.org
X-Gm-Message-State: AFq9FYK+f0j59bArk9PZiunYuKXmc89pD5yJmauh2s7+KosrOcU1KEQM
	ReP/epHvIkxmJ9sxQV2Q1qFegsGQ0GEKf8MnhV6UrR6GbhzsrMsHCEmt
X-Gm-Gg: AYBFou3OcYtIaynWmmT07GNphEqGu+nyELcPJ9xKQe3pVzM6sgiTgMhVt5Xjq55+1sn
	UwOhq24840BeoBvryhUc6eL5djUgBZxroGAVUuas6gqtCvqg+uphvrjUI4om5Ii0548VpBPDZAv
	HcX2Bo+nl61TpNfk2+4Ko2nQjrhsJcTuMVRHMZQT+cXfvRB82Dfhk3OaVrpCsu6B8ol1AbSEXsJ
	jZdUJCVNWfZL4y5T32tewKaPvC7fhzTcAqGhytR/E8ITqYsPzWn0aHFpYnx0+neZyCgp3FfaR5C
	2j0pHjPfhbyGUHzjJCtJ+8QXQblLhnliyvwxqFUB8TUkaNDVeW1ECgbJU0RNgkAWOnGPJ20LDh7
	Dbk9hl404qnuf8Q5P4m+02seSlU9Izi7YHwMqAZNoVp2LhEMCInielc12UrRvjBhtDPc7fxNdEk
	rYHMFrohB4+cnDkINAbZYIeqXuR6fLSBIseLmHAImzXP5Z1rIQeebEHxHuxPKvPrIGY4O+Qb9vt
	YdHkGmx+yiqRW+wxc6rE8I5bJoX7B5fH1/RKGVq
X-Received: by 2002:a05:7300:d404:b0:351:1e72:7470 with SMTP id 5a478bee46e88-361a0b98466mr826776eec.13.1792177073308;
        Fri, 16 Oct 2026 11:57:53 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e6ab:aea2:fd2a:caf4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b63e1sm9431144eec.8.2026.10.16.11.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:57:52 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:57:49 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: patches@opensource.cirrus.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] Input: wm831x-on - free the mapped IRQ on removal
Message-ID: <atJycIEnUZKVdTjW@google.com>
References: <20261016024300.3660850-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016024300.3660850-1-mhun512@gmail.com>

Hi Myeonghun,

On Thu, Oct 15, 2026 at 10:43:00PM -0400, Myeonghun Pak wrote:
> Probe requests the Linux IRQ returned by wm831x_irq(), but remove
> passes the untransformed MFD IRQ resource to free_irq(). The two numbers
> are not guaranteed to match. If they differ, the ON handler remains
> registered and can queue polling work after the input device and driver
> data have been released.
> 
> Store the requested IRQ and free it before cancelling polling work on
> removal. Also cancel already queued work after free_irq() when input
> registration fails; free_irq() waits for the handler but does not cancel
> its work.

Why don't we switch to devm_delayed_work_autocancel() and
devm_request_irq() (or maybe use devm_request_threaded_itq() and get rid
of the delayed work)?

Also we need to get rid of wm831_irq() and make MFD give us already
mapped interrupt.

Thanks.

-- 
Dmitry
