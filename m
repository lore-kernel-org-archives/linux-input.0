Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C992F7EE6
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783810320; cv=none; b=QU3DNteqYvL4PjtZQLwfT9wONJ4WRf1tsyllRCEes0xbVm2diGHGYiohl7srRKainvQNStGAUhjTv3twZFs3ginqzRFdsY3298fBkAgINWhSB3EHCFwbj4GcCIGXrT/xiZEb6OWxsuHZOSHSeBycd/1juxpQ/mRUb5/SAJzmpW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783810320; c=relaxed/simple;
	bh=Q3fna+fyqkSdiYXMn24PvP5qB6z7sTN43i/Af23ccK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE1BsxVX6D4vSwTIjdv3BeNs1LsXwxhW3cZFSXptCfY4XjQqwibgmHIjSwiHfLZGt4T4hrWiwbyeASP4d+w8aBXLF+pYCX4j01MJaDuSZ8NloIXHF86bAWDxJ2egIphZSKeVXBCNENenJf5YgYRUu53FaisZPQlZdU6YXQErQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhF7jn9J; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhF7jn9J"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37df72c9984so3532210a91.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 15:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783810319; x=1784415119; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1polsbdlsUrScFHxtBkOPcfF1y9tBpMWRuKC6MfI+pk=;
        b=JhF7jn9JtlOZHO61W+SMyhKtKLyPHDOGIFPt6m+xABsYpVyEjhYCRosXHwAxa0f6r1
         bbeqev30/r0ny9Z30kjQIJ/bir8hv4hPjkNe15Hi+qL4SK0esPLxYfExZGkSvBxVeUWg
         rJ2yk/o04os+80+g5Q8bA/C0w8TNSZOtAnKhagTAS6Si8+wgw5viFWiSBjCMyWKMm3CO
         GrN5fmDYTtw7TxgB06FMWMm3/VbmWj3SdzyQ71EELVdQZ4G0URWjOsNzTlrJeJrnU4Vg
         CQFiE7nVu/4DPyvlUzET0y5YnjCER0VysVU1UZ3Dn6wfBbRQfVyzzLRMpve37kKRyi/L
         pYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783810319; x=1784415119;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1polsbdlsUrScFHxtBkOPcfF1y9tBpMWRuKC6MfI+pk=;
        b=euAAws9QbngOnrZil2edkzdETMkPDK0u+CwbyUZF3pAWdW11diiwhUy6DnB76qVhr+
         Jh5y6pBDAuFWWHbS4ztGOAdHI2xAC8FH9bvd9keqqdVD3cT2PHNY5gq/aazbIsiFq7Po
         rCD4XX9U+rkMt+hBqoankKVwLLwctQUPB0WUfPGsj973v8ucySC9C4j9q8/WcWL4ZfIV
         mqeknG9EleoFIRsJgos5QRAstvu7OM/WWEmk7pRpmpHfmOqV7+Atc/fsa5YHscdY7/8s
         GQl3GSFVPQ6/kiuyvSYAAYQXjg9Q1w8QzV/i5hvV5MPg2kjVDNA61Iaiwj6pCu3uRF4L
         iMvA==
X-Gm-Message-State: AOJu0YzyN/qiIsT6iTIT19lQfCy3tVFWX5WdDa0JA2HatK7v9ZnGcjc7
	+LePETxBa0D7Luelk0TrxTVcOoNPBrsVN0qBAAVUfHXqMAMD2lqqn6GB
X-Gm-Gg: AfdE7ckSrNtVZtG9sWNGGxo4FukkmLCuSXZCeIEWTf5Iew/pFsPti5hNRYpZa70mEaH
	h61Kg0pAWBtXVrOc0FzBCpp0iHNSTlpNQcfmkLCqIfr40uOQt7sI0LPHZ/iFct5XMskVe9KOzQk
	uKJk2/iW5irB5lhdeeKNRcYsc82GyZcn/cKSmPi3RGHvbHTV7ycr/bYDGTCIeoWumNqy68tAVcm
	HMWhG/CWeeXZa7fcwzSjoIitxH/77Gso9W/Z4mZ02qOr2g/9rliN6twTZM4r4k/z1Qqg9Y82EZe
	DNl950yU5+0j88dcdKFFAY3sIpYuCNKGM0bOzjDmtcUhPBj0zkB2aS1zP+9yvkF2YNTpF8AavTM
	EFK5ADdc2IK6a+cuYjJ6OP3JhNHcaWA8ds+KWXAzTaPAY9+YvtuvG+X6J2NKt7e5JC7K/EkqpPA
	Qip+91BURR6vbFdLov1byh+9kYx4j/FXP4q0ZOJskrS/2LE0joamia
X-Received: by 2002:a05:6a21:62c8:b0:3c0:9c1a:8938 with SMTP id adf61e73a8af0-3c110e61f41mr4875147637.64.1783810318989;
        Sat, 11 Jul 2026 15:51:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm46388700eec.9.2026.07.11.15.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 15:51:58 -0700 (PDT)
Date: Sat, 11 Jul 2026 15:51:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ian Bridges <icb@fastmail.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Input: i8042 - replace strlcat() with seq_buf and
 scnprintf()
Message-ID: <alLJCOD4fcYlnq7I@google.com>
References: <akyW4xkvCCROM0SE@dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akyW4xkvCCROM0SE@dev>

On Tue, Jul 07, 2026 at 01:04:19AM -0500, Ian Bridges wrote:
> In preparation for removing the strlcat() API[1], replace its uses in
> i8042-acpipnpio.h.
> 
> i8042_pnp_id_to_string() accumulates a variable number of PNP ids in
> a loop, which is what seq_buf is for. The kbd and aux probe functions
> build a name from at most three parts that are all known up front, so
> the whole construction becomes a single scnprintf() there.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>

Applied, thank you.

-- 
Dmitry
