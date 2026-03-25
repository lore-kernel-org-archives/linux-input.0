Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BF283CBF
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774407781; cv=none; b=itKzUtiGXbFrn2oyccqDGIT9AQWjWuQKqBN2pBV4RmAo/BKlEqa7XilfeyA0MfHu8NS5QO0FKoPbuB+3PoFtTQS8v3RVauD49ScFM8eADwcX656iZ2wBR8Ua3BAjv0dE39hlPd9rs7pSyRmU/Yr39BiaTAhFUKxHOi+POMnmYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774407781; c=relaxed/simple;
	bh=ciVx9jHFNYrHDZGtnQDQQLsYePwgjL7ss9dD+19+xhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9B+BUx6jZmw7SBxz2L3vLKi761YdmkW6EgC0Z09HctG/pGrayhPrdSPTTOuZ1DWFtzBcEk98IeidPAeN2Sen36T95GkYRkymnp8wILBNw0a7yUeLdVfaAC2Spseydo6l5aU5eUZMuqtZXnA4mX8oLuhMvHk5cs37KX7KuINvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQB/6zPb; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQB/6zPb"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-128b9b7e3edso10759189c88.0
        for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 20:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774407780; x=1775012580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jvHvghd1xcxSMrHBMQMHxfVnj6Gwc5uE+5un2zwivFw=;
        b=VQB/6zPbQ+7iYZFFKaIugChTNATN3trHWSSag4oY9X2/OUIRQ/JOqUlCOC9J/WUxJq
         sfNRP8JyW6F4e6zXJHc43Dlby2F4mEOQebrSHMm3wAQNiQbIOGbnMZsWQWSH3lyOIp0J
         sqqZnZmlgW+kEhga65LDOttj6jxrlXEQWY1+LTYgudntehde0cTPx9Uc/08CtNsUMYEt
         VCl5E57E+CaxKggjXbLNmJzQkV+FTqbGiCZshXRgy51zuZFtQZ2tpnuQO2d1GIbO7qkK
         Hp+cVQ/+hzOnGN7JUjDdYkLIP1gl4SkQon8UF8au+O7ZGxEBpKwti35KPjurE9QTBc7a
         v6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774407780; x=1775012580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvHvghd1xcxSMrHBMQMHxfVnj6Gwc5uE+5un2zwivFw=;
        b=d0UCR5QiXLsBU4xhg/gPTH67vjCiVtC+ScOwN3PTiHJqj3EuKcJBqz148kNHsJP/2K
         eFzDGW3EgBuGus+W0kyt/aAr0IEVX4oEHGDlvc8LXF7hrr/h3HpI6dulm7Mrev/lLymm
         z0Ud7cucyb4FkJD6ZLfM7Zp3WDFtEGL9+byQMm0l0PWAvaA2gMWfJFUWyCXkSbcsZunw
         dqIWxSQ9Se2pAbL7y24NlU0GfhUJFZKOtnHPUiv4X28Ew0jllt7tWpksuxZkbJFv2NP7
         CDFNOTSSlJBgksJiZFYU4yPM+KiFGClWG0O7brGILfBt4CPPQuaocxPT6VKnwVfh+z+G
         tIcA==
X-Forwarded-Encrypted: i=1; AJvYcCUjEd501enL6N9cVNoCpK/VIVdba1rcd51Sv39Bi/jxBQ6Bbs8slbT4bgNa1ZGOQm65REO0teJ7/6xigg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63UrYJE0kiQIpZGlgF57Zszj8p1rsHQQGUmO/d8lurPsjnSQd
	q8KERgZ0O+ds0IrdXd12as0FuSZIOCrJ5te/6edTXH+lq8xghxV/mLn1
X-Gm-Gg: ATEYQzzFREU7U10GG0970L4fI1o9vEgWNHlSCrKM1/5sk2hiJNncw0FEkeDWZWr7p6H
	Nrx4G1w4wVF9Qiva2gI7acrjxzyA8visaemnjrtA3zyowDz0fLUkovk076UV+5D3PzK7cplgUmB
	W9JMxWb1L7mkJJXjPkyOEinX64+OtbupEH7+IgHSAwWq59N2/fnpAZ3waq6/vDaebFtEXOfnEm/
	Dr9O0PFk4UT3j3pOzIMCPQYxhIr1gjR2CuMr9y1D1Np7NqCBt2fhqDAvhQCVh8luefo6t5DXVXy
	a8NwXmBqWN4EH4PUtRUp0SuH9/wuUAU6fLVcWfE+/zVkTKwM5WkZDS8FWEwB2YvqirNYOrsmlNZ
	gvSSNikoh/ssJU2QWdElgqPjCcj86jzOHva6vGHJ27GQj1e+UAnW4ByJ2T1B6RazeqRz0TqcPKv
	M4ssUCDQqmusRobBN+ep+s7OYMnMe/hwW09YGu4xDVJXHo08YNgIJxPPt4VVjvIJ7P
X-Received: by 2002:a05:7022:2220:b0:11b:ec5f:1c37 with SMTP id a92af1059eb24-12a96e6afe6mr1029426c88.18.1774407779571;
        Tue, 24 Mar 2026 20:02:59 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a686:fd7f:70d3:9156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b14bac4sm22668916eec.4.2026.03.24.20.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 20:02:58 -0700 (PDT)
Date: Tue, 24 Mar 2026 20:02:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bhushan Shah <bhushan.shah@machinesoul.in>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT3519
Message-ID: <acNQW9d_S1Zvjtgj@google.com>
References: <20260314-edt-ft3519-v3-1-5ee91b408ed6@machinesoul.in>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-edt-ft3519-v3-1-5ee91b408ed6@machinesoul.in>

On Sat, Mar 14, 2026 at 08:27:58PM +0530, Bhushan Shah wrote:
> Document FocalTech FT3519 support by adding the compatible. It's 10
> point touchscreen, which is compatible with FT3518
> 
> Signed-off-by: Bhushan Shah <bhushan.shah@machinesoul.in>

Applied, thank you.

-- 
Dmitry
