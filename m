Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3329355F4E
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828055; cv=none; b=L4MP0JegmdT+lns4AvFTgDcZr0vxYXh9p4zD5eZRVDJtPkUCNCr3lY/hD2WZCPAxmWoPvf28tOrcUGnLiTyGCpwTmvYOE3inn1EJv2D4aa1LAPHQYlbXYmo8EUFB8UBs5t1cl9YvcQTkqE0jB8/GbLtkLifoMeFMIuKFlBNfN/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828055; c=relaxed/simple;
	bh=fW0M6GAPbby5cq+rLe7EDVEPDPTKOeUYuXNND5QQBpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgGz6ancVBWI/y8ZUdWX1AxWUqWgyVSXqZ8Ec+fk0I9nH6hXqc9aY1mi6BzrgqhZHonvvi+6jbmR4BNp/UUJS70qGYzJm43a5NPqlumG8OeTJeeicqMHxDI3akvT5hnrCsx8GTX5jzJMFiuSPXLGvPU5xBNQiKaxJPHLXPDMZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceuHCrbo; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceuHCrbo"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso1691646b3a.1
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787828053; x=1788432853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BkW2H9+00u6MydNAvfOuX0lwP+2vDTkZWWM1bwvT0lI=;
        b=ceuHCrboWyX98y59AD4kNV8lBn9a9+diFTOqJKi6EkPiyhmBvI/byPo9Gfjwj2mEG/
         n0KhTP+sPMkDPxnnv1fDZdN0OltQr0xiOEmrKasrSRL+RWZbWTXqffSygR9iRYx3fYDw
         7VVMAHtmXeLnQ5mBQOi9ntLAqDJ3Mm/jsPcvZpdw47Q+9SuDDmHjf28ipid2JyQ8eXuQ
         vac8dEBvMP8NuM4Bcuo0NSttdZNcL1qYiDuWu5+QMoEaZe/zvrdgGVATZUuWXzQSesha
         5NkqNfYGjq3LkFyz1qd+07tjCJR77Ac5vRngGRL/hQV7mkdhhgP1PqCh1b21clzYI+kp
         GzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787828053; x=1788432853;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BkW2H9+00u6MydNAvfOuX0lwP+2vDTkZWWM1bwvT0lI=;
        b=pfNQAikJaRb0o+eBxHlS7LXPQ22o2HkoUDwM7jBW0/huildccpNa68IShQBSNDR13K
         4lGnCdu4Epeloq/yrI4br12vnfBkKK5cdxT2eH6iqSimMliZtKaFDIFvEYX6I2WkouPG
         7RZct/p7+RiZQZX9HbMohB4YE5u+6QHFqZhBvXXcUXYr0VmQqvAEv0oQwrM243hbhN0B
         YolVCP1L+2z/ZfBW1Qka5l2YlYlRXyQJO/cjckINUXpSHP3MGaSc5TUSaIgg3QZID4I6
         jf7oFz7sWpPWS4eS0dFbtDk/Sa12eQAkKVlgf9S1xTFULsh071Ax3UVtLaHKaFl+TJbw
         s1Rg==
X-Gm-Message-State: AFuF++n4+TGu1CN5C6+a9idO1Gxzj0jrcS3PHD/B3ZPc/fjXUJkdDW+D
	tCEcvjbHRbmkXB326WcMw4JbKrqw0B23TYEf/6/TNk5hOK8Xciulsp4s
X-Gm-Gg: AR+sD11Y/WaG/1VGn1LWDWjCMH20REqkp+ilaVOCduVc55g4EVbkOE8Q8tu8+wW0KyG
	TGTs41um8hRJUb2RyQdH2HhwSUvId68Uo6cCcgH7aRXaqQDoO85sbMvyiG8qx/S2KBKzrw0hubK
	n/MeZip1krUgH+lFLDf6vQpfsusmpmPwcV7hvgcT9ijpuoXqV9sQsANugxrP9zLej8GsvlCVhZC
	PXQZBaA6oDv6g9qkMDenbsLN9VqhEJhoiu28biIvSXLKuNwDSPLCe9864D67iMyGwjj5N3JYn/c
	JnHPSMgLE9DatYdA4xg5VGQ7vgV9bz3aqs/N3Lx91INt8BCDMgBkEMa9BSlof4iksFt83mRjsJS
	gMPUJ7srS5JhVwOiJJoaP8Ixeip3QWp2YhDyu0BtYshEnL3zVNm6FPTY4q+9Q+7j1oCnXAxRGdv
	LyWqb8mYv4TRRoFEuQllA/lI2cs0DQbXosJ1mpA394gJRVdMxQWIhcSxZ5YGS7p4P/DJ3BVO+XD
	xb/aZSKYIhJTaIN9LYSjDgdw5EVr6thvZPs7WKq
X-Received: by 2002:a05:6a21:e082:b0:3cc:c7cf:5a44 with SMTP id adf61e73a8af0-3cf7596a921mr25262336637.2.1787828053213;
        Thu, 27 Aug 2026 03:54:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d96d:bc4e:98d7:146f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20036sm27194403c88.5.2026.08.27.03.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:54:12 -0700 (PDT)
Date: Thu, 27 Aug 2026 03:54:09 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Maurizio Casciano <mauriziocasciano7@gmail.com>
Cc: linux-input@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: drv260x: Make vbat supply optional
Message-ID: <apAWXyPRtSe0Uk9_@google.com>
References: <20260826132211.3341936-1-mauriziocasciano7@gmail.com>
 <20260826132211.3341936-2-mauriziocasciano7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826132211.3341936-2-mauriziocasciano7@gmail.com>

Hi Maurizio,

On Wed, Aug 26, 2026 at 03:22:10PM +0200, Maurizio Casciano wrote:
> The Lenovo Yoga Book YB1-X91L firmware instantiates two DRV2604
> ACPI devices, but does not describe a software-controllable vbat supply
> for either device. The generic regulator lookup therefore creates a
> dummy supply.

Yes, that is how most of the drivers handle supplies on ACPI systems.

> 
> Use the optional regulator lookup and skip regulator operations when no
> supply is described. Systems which provide vbat retain the existing
> enable, managed-disable, suspend, resume, and error-unwind behavior.

regulator_get_optional() should only be used in cases where supply can
be left unconnected in normal use. This is different from this case
where supply *is connected* but it is managed by ACPI/board firmware.

IOW this patch is not needed.

Thanks.

-- 
Dmitry
