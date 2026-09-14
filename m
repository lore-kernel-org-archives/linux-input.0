Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900319E97B
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 01:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789348129; cv=none; b=QWwmz34PnpOSsgiSDZ/Lk21rPlAq2kJBS9Jjumvhou7+cJmNtQPCscYipcvQUle9Y75YiSLiaQ27d9fXDuKv04CJqW4ldsziMONFBrSEKGuk1KXra3JP3VOacgI/YaSOB+5FKzaJu4Cci2Wa4rcESJewAuKVuOCRshFj2QSXako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789348129; c=relaxed/simple;
	bh=16vb3KZQWUdtN7Kgg2jXydRCFn/oKzlazujQ/uWCQHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOY+qhoIrmUQDtY0TV0uuFGbiQ4ReiN6yI4v7RZ2198P90wMe4X5lzOWh3Ca+Cm/RIoo2yh8tT29M0pCnwjVQSJylDdoOE5yduqjM7NPr3vz4nrrSiYbuxuporCRlwXrWmwGL6IwsUQZHGRagdUmgk7xNCafRGOI668tjbakPV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzvCfaTQ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzvCfaTQ"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4902427c1so2114541a12.1
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 18:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789348127; x=1789952927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pE3zawT4od2ZtheQocZVAYF6r1UYiw8K/mr/U6/fWUY=;
        b=FzvCfaTQ1SJvsYqsWAmVEONU8ue8uCw+0NWD1iC4qyHP0Gr5t7lXKEXzCpNRM2I+C/
         kzujQWvfhtnCDyAzeAgBIWl5GLNXtWkQjrTciber7qPHA7Qrv5zOLJhuCG1bVD+XpHfd
         jrsPaGvXQF2hkIAAN0ACtyDoBMeurCOmX2PQgZWpmnbe0MhgPHfZPPSfK8FJOrhU1gfF
         DLV4wn7weVXUnb4D1ALp4xapJMkdNZ7zMiyWOsw2Iz22nHzChbXU+U92bj+V1cANzL4V
         EQN2eqs/kKMnI3AganCFUY+R04VOdpJncPDZSqCI9wwfPRzK3I37lZPuiZn7twBhgN2N
         cf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789348127; x=1789952927;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pE3zawT4od2ZtheQocZVAYF6r1UYiw8K/mr/U6/fWUY=;
        b=CvIrhT6i61tc9l82YEQIPrcL0d6OGugVU+GGDU/NUjdgUgUBNLhaZH0UKr5rkhxQWM
         MQ4ZRINOSX/bJJoEVFxcb5mPHoE7psE3CCY+y3xySeRPa/iexZowppxFEp1/oZlHTvgF
         EZtcElytltVYZUvSbLVLU21IHC3gEQ2n+Av8l9ZvyjR6X+pKbZZZfPsnaPaGufdH9W/l
         8qTED+rQYPOd/l0cAschKThOCz+gbAaAdl7WSE0Ejg/q1DFP8eIExs0Pf4Xv/b36PqfI
         YvdkpdOCldpLH1OOcHiMuqd9hPuRmDnRtS3zf76JympO/YwtHaWD8xt210PkTeL0s802
         jhsA==
X-Gm-Message-State: AFuF++mT3kAMbuHGsZ1Qm6keYl6ZhvYaJO3WkVXErl0rYYA9UrBHrmRv
	6+W5QyY3zR77xpY1KjLAg+3zVsmggRNJFOgge6NHDqMc0qW5e0uF3wGOYGe8HA==
X-Gm-Gg: AYBFou17JLqmGyxr1VGPp/eVTpPcWnaOURTRcAfiYfCsqyGq3C9PHTr7bszc1CoTGn4
	+mY/r5+pgJBVDynAK4292UvVagKlciVZSawr9RHQpL1Lgwcil/jV2m8vL4mET9bjRln0wOLM3TF
	bh3SU7AGz887XO70vGne7nOoIngXyYXpsQSXxQMYVneblZ1jN/P6nBacUgYKMKJK4sgbc/LYtSP
	4SqnXD6poNcbMqZyK4h12/UW/oTlVR4eaA8lu6wlCyG4isUdxvN+t9AJcWeStZ/Bv3w7udeBf0H
	XI5ceop3hnM0BLqIbt/sdWW1o6SZQl7Bwfo//iBk1SUOUkur4+/DYoRUHYHv3AnpuGjJ0MkZ9Z/
	85Ey/OEtrn+PApcfDdEvS5SuKpMzjcg3uflw70N/F57VZw6vvmuSFZDj4DboH0Srlx2Z5LgFCA/
	7HsF8Q/YKy9DgA/pZ+HRyJ007AuCNZW76GiotSSfUzstkNyxLpql3/0YbzflPILGyfWWf46kd2c
	7e+0zlMhtam2KtGYdormCgFpAnrC6N1d8kHXeXe
X-Received: by 2002:a05:6372:a703:b0:3bf:8a0e:dd99 with SMTP id adf61e73a8af0-3db26e544f2mr4658971637.17.1789348127210;
        Sun, 13 Sep 2026 18:08:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a739:376c:7eb4:ea2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f5833fsm27453770eec.23.2026.09.13.18.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 18:08:46 -0700 (PDT)
Date: Sun, 13 Sep 2026 18:08:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Roberts Kursitis <roberts.kursitis@azeron.eu>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Input: xpad - add support for Azeron devices
Message-ID: <aqdJEeI4gccwzbjO@google.com>
References: <20260906143040.162418-1-roberts.kursitis@azeron.eu>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906143040.162418-1-roberts.kursitis@azeron.eu>

On Sun, Sep 06, 2026 at 05:30:40PM +0300, Roberts Kursitis wrote:
> Azeron controllers (Cyro, Cyborg, Classic/Compact, Cyro Lefty,
> Cyborg II and Keyzen) present a standard Xbox 360 controller
> interface, so they work with the existing xpad driver once their
> USB IDs are added.
> 
> The 0x16d0 vendor ID is a shared block, but this is safe because
> xpad only binds interfaces that match the Xbox 360 signature.
> 
> Tested with an Azeron Keyzen.
> 
> Signed-off-by: Roberts Kursitis <roberts.kursitis@azeron.eu>
> Cc: stable@vger.kernel.org

Applied, thank you.

-- 
Dmitry
