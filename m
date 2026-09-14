Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B3A26C385
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 01:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348398; cv=none; b=n1U97ifJTUoO2RqwWobbxoneF8rjSJmox7ofHeVzbxW1ZgEkczFuCZWjXIlAK8ZCnyfr44D/KCWtR2ViSY3J1PgbJJqxSr08VulyHaHdLbWu8wW9VC7fMrKqiLp10qI80C3S+DFdDlLKoNFPMDJ/fj1A+NZGneYD7Koam/RXeEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348398; c=relaxed/simple;
	bh=nEiwzoK4SoNy8IEzELJlP5xTHu5XFQc/2OLa7Gpxo+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ci9jyhTsXvyVWAnKn+HE2k4tZWpqxBIk9rgVF+WAFDaxb8F78G1IEaJbZVrr19yFmhZkfinvxZKivdXZdiSzmIO8/seK5SdaMc1wKGr3LlvrXc8WBvQoz4tR1tUfiESxzeDR5el1urfrKkKzbaUmofelM4Bv/tmyRPdJPIB94z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVnttTLP; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVnttTLP"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-8631d0023daso715801b3a.2
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 18:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789348397; x=1789953197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AYhF5pMkaESj6kjmpcCVISkdRjgmdv7n0c/SdhgqaIU=;
        b=SVnttTLPQltCdRMbkj5NmnIeCRblPHiYSoyv6pKqYPf03rN8NfRqXQ51MpZwqGq+V5
         TjMN8etQeb7yH3uO8KQ+gmVlNW/OLXEKPbhaRLC1owz1Dlw3hKv9RzfpuB8qVU7seZ7b
         VNcceZCmth4n9nPsrDL7vcarFVcKcbBQIZA5pfORZh+ySg+hUYoIozBC236FT5/fdMLH
         tiJABXRBvvlwuuZrf94HG06AOIonwDV3K7x8DnIMnBYpzbNFv9v9lXOEQZ/heCv4TmZz
         ozFKht8R2yPOAdDdGTM2zqDiFGVzeaaqL+jC/T3dNC6b/9meB/EugH3PTEL5MGyH01Ek
         OVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789348397; x=1789953197;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYhF5pMkaESj6kjmpcCVISkdRjgmdv7n0c/SdhgqaIU=;
        b=ZF+N+JFj95JAF3YW+gjXkEaZ21ihRoKRce++3/QAhLFWUvxT1uklgevaOUqr5FqS5E
         DbOoa2ghcDbughWPOFqxgkqd06fXqnea5MACec/bu/dcjzqvJkfSFh1Zf12HqKZCP1vP
         fXY7p3bYMyQiQX4OLjt1/y0Xwmq0XouoiJGsRKvNaCIeRpE2+jj0KVBVOzUnTitI3ObH
         dO15DmYi1XEnbfgW/RxQQ4wNpiQ/GwjMyOqfz1IviOgXHOy7x1U/KRwQ+PoLqH+SJz8Y
         vzoO4FocNKomW1DHjhJa7XoAMiCV4CpQUjYmtmJM/F6lf68DAZPuDYvFA7o9e1UGCPrL
         MHdA==
X-Gm-Message-State: AFuF++nMKFCBxo9zChIRwG/ofLkj/oEMrvBqIrOiNGApGaCAgqmvZbm2
	lk3ue9nNvGV9tnHqS0pxQ1JieoLIciU8OOu8j1MLNwgP7bwiLNLoMhlv
X-Gm-Gg: AYBFou1gxOYSKak7Xu7jqdOqh+JZ3Ce3IInGdcz1ZlhH3+t8+fA+5nyp6bBsv5qWs90
	GBv3ZnUWUnPjPMJovU9wKUGLPXJqLJYBFJM9+VCkzOMeH+om1i4PqaFSo1mzgH3tr4vBZUxwTcI
	AQxWbzLkyH4x/6vMFbrWcj/W/vzH1DMZLnWQgwTrEkwauDK6A5/O7DZHUN83vOE8MaSN32tjUlp
	2qyaBfMSaVjIJRjPxYYSg05ns/LEXM5r2xBZJVz0KXej1i/rzyiBqi8Fs3NVf9PjtPAN4qOdKXp
	RbDJd50btO3hlRPtN+oxDKDHdcoy+l28vHNtKVxc4uDRee+JNHB18wQ+mdHnfar74yYzFfQVrVw
	IzWjxQhk9YwWm4DYdzMx5vEOoP2ivGDH1i3IPo5sCeL2Nd3hQKAWjd/xh2Pm474kLnbvMvgz8kL
	k5B7N7jAkZPyViUeXyVHgGylhctElF5aq45esrPmTmYraayOAf3VuB1weg3SbhdfoL1PmrnEtHz
	HyX/GfDOA90VEEGoFnBonA64j/IjX0tFXwgEHSW
X-Received: by 2002:a05:6a21:4cc6:b0:3cd:8bba:824f with SMTP id adf61e73a8af0-3db4042265emr402955637.4.1789348396768;
        Sun, 13 Sep 2026 18:13:16 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e4fb3esm22832868eec.7.2026.09.13.18.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 18:13:15 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:13:12 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "hpp.iscas" <hppiscas@163.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] Input: eeti_ts - publish the OF module alias
Message-ID: <aqdKI55w_6FCCl4b@google.com>
References: <20260905134004.66336-1-hppiscas@163.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905134004.66336-1-hppiscas@163.com>

On Sat, Sep 05, 2026 at 09:40:04PM +0800, hpp.iscas wrote:
> The EETI driver matches eeti,exc3000-i2c Device Tree clients, but only
> publishes the legacy eeti_ts I2C ID. The I2C core emits an OF modalias
> for a Device Tree client.
> 
> Publish the existing OF match table within its CONFIG_OF guard.
> 
> Fixes: e32d7f1b246c ("Input: eeti - add device tree matching table")
> Signed-off-by: hpp.iscas <hppiscas@163.com>

Applied, thank you.

-- 
Dmitry
