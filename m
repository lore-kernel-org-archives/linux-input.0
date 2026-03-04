Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3237F8B1
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 04:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772600201; cv=none; b=d0XrU94oC5COlJU08pdWgER37wipbCNYCVFND+CohZch9Z6Wq4F7IThQEd8JsHjPfpbO6XrkeeLNDNhMNCdhr8IRw4VXfo0Ug8tYrZs18XzQp4dcXSx/2N4Qzdtv13Fkwy0yWeenTAnYsXfXl8V2OKmOuOpfRQEUhmWp8pZuhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772600201; c=relaxed/simple;
	bh=iH6bY3bQDWYTZcVp7FU43vS6MgcMofNwA9FfZQqvXfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FalPdLlVUpd2y5Fk6CyyGskgy25olnAJYkMvGxarQUDVYDflTX1LVH2uG3qySht7txJc1bLoi299/oGjHkPFSfnAp0Hs675oSEF4gyXK+MZQHN+zpE/PwqKzoSx56G1D7q+iotVzZXUbK+bfJ0G9dHS9QkFfavKgCzluaaK0JQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URYdIAzG; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URYdIAzG"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so2958623eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 20:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772600199; x=1773204999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7nvtEyu92HttU76y4JGJxjLhcfE8nKk1Gptt9zFfUY4=;
        b=URYdIAzGdRzysA12xWf9IoAk2bU59mCoOD5X1ehLyi02pLlMefrJ49zJeK6ns6j154
         8YYjR4bISCIJT4wSg3/v6/+qtw/zfBDHHGmlbXt1OXmLZTbbWL1rAiGzZJc0L9PTQzZ7
         /T4hSUU+VbsvjR2n1wDKEeRZqiMXrYU51yyacnHAAsKNUx/okudp3ft1xp0y6xRIFwnZ
         Oh3/39n0t9YKv6zqzec+hEYkhJPYoqBJgvdn4N7VWux46rO/KqeGPo8gPY19Z1c41OFr
         DiU5w7gUWZSf/nOykOF60h+DgazySVkCaCVxUavFjP0L4Mv+HHrqw0SjrIjTV36GfxRZ
         jrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772600199; x=1773204999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7nvtEyu92HttU76y4JGJxjLhcfE8nKk1Gptt9zFfUY4=;
        b=A2UzurxbwYJyUD2rO3PVKSr0+UbKRelrQEFAyPO4mgDZYLHXuw8uA32ihnM6cEm2eP
         1Y9B2xygCHJ9J+zLtiGHiOoTpR2Hu5bHPIA1pGW0Af9QiqjMiZG1xqRIz+T8xWEoTUWN
         YaF5YpDGqY2R27th0nnznI/xkm4ZrtWcQCcgIzJnjJAsAVAOiqBpB9mHNaIzNYDXEyW8
         m3dYjdR1fMjRXhBpf6t/d2vMRWhIIcZTLgfQfkmO0GYTuR/XIYz2k2EmfhBQLlI5NjC4
         ygGTfKr/BJJmhKX/wKQ/8rUXzdQ3nz5DfxNOQ3COp9/PAWez6CS49zMPFLjMeKXJ1CmR
         ksDg==
X-Forwarded-Encrypted: i=1; AJvYcCV35zFTDQZgRg1ixnHRufhRoLX1F7sp6jMCZC32i8q0tueSGPZK8W9tCzHXdQZUUUv28JZ81goZnW4U3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxkP25zbivbSLS1Bry9eAwRSREZu82bLFVBikVsxI9r2C9kZMNR
	C6MM2CXJUIgPgLRzbuB7RNeCuu4aHkSj/7nHzZj3STYB/o6qDrCuFn11
X-Gm-Gg: ATEYQzwwQ5I6iRuvCVMkjAK16v412IfoxK7aFWrDGK+biYBuorve/Ky2QwmQHIHm6xr
	TTGVz8mSBM+jJTqlkJMPf3NcGPT9Gj3yrWtqNYencQUD00pKS8xSN+tB9f+yFP3/3UAl0uZ5Xnu
	shSdlSE+XZb5uMoyH6YoH0B5mgwOHZcQdX4ShuShOYrtI9Odi6WFHoKdUpdan3xcvFZKxDrwjy7
	nai5JWz3skoBv/ZrpAr8SFtisjxJzcsIkbMH+3+aBPR6XzibGLpH1Lsb+uuY17pT0DkE1Pg63TB
	t0YedGLjR75wpBTMnScr49Boq7+N1TKVcT+P62suhT/8lUQ/Yx90iSOJHytgspzVPkxoyfsRN3O
	Z1OQtEAdjHPjoNlLoq//meHIIsajk7O/0iPt+giivbT5bXkjeu38LTsEQUjveXlPiNrvdSBE9Mf
	o4XSiH3xAvPRDBbeXxySdD6KHizfGw/5MQSKO4aflFJvIEk1sOMi4U2nUBM3SbPyJ5
X-Received: by 2002:a05:7300:b90a:b0:2be:2f58:2eef with SMTP id 5a478bee46e88-2be30fc22b0mr343124eec.2.1772600199248;
        Tue, 03 Mar 2026 20:56:39 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:a048:d9ec:d217:7d59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be2800c89asm1899030eec.31.2026.03.03.20.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:56:38 -0800 (PST)
Date: Tue, 3 Mar 2026 20:56:36 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] Input: aw86938 - add driver for Awinic AW86938
Message-ID: <aae7fRYaoDHMptyu@google.com>
References: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
 <20260302-aw86938-driver-v4-3-92c865df9cca@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-aw86938-driver-v4-3-92c865df9cca@fairphone.com>

On Mon, Mar 02, 2026 at 11:50:27AM +0100, Griffin Kroah-Hartman wrote:
> Add support for the I2C-connected Awinic AW86938 LRA haptic driver.
> 
> The AW86938 has a similar but slightly different register layout. In
> particular, the boost mode register values.
> The AW86938 also has some extra features that aren't implemented
> in this driver yet.
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

Applied, thank you.

-- 
Dmitry
