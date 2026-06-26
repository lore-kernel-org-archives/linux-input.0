Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3C3C4B87
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452256; cv=none; b=RhPxa7Z9dnGQpzmmEnUx4WaAUvIDPm/EWQGIXUJ0wQXlMHCgedcqFRq8diA0vg1K/eu2cogdb6m/4ofN0ajQGjNWBaSv1fd9c7mQDLLI1d2Y2jY79r9ftqe7DcfSkbcUEpwRDGShe3xX9keH4j7B7m4gtwyLSjoyIgf0pbkEyEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452256; c=relaxed/simple;
	bh=DaIliwXZnq+xhC6xHv4wSGHImwOEOkUrH0LZfBOCFhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Agcqe6y+EQLd02g2IhXh6BCuycwWf/3sW2w6XvHaOBTmU3WNDMTxbQKTt3CehyvCyqvz0pbkNw2cJfJAYZ2rJSJJ+g2WYScFJpEMnB/Y6sj9qIQR+wWFIwYkyMS/SOScBRzvEy8CKe6T4WiLWTc3eM2cAqzoT/+bi6A6ANPmNik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4OtvwYE; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4OtvwYE"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-137eb0d76beso892860c88.0
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782452253; x=1783057053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KO+dGl8JOZI5P4Y+BNYLE/H+0UT+mgOt+djr4eqcLp0=;
        b=K4OtvwYEUVHFNHV3ogyYU4n7Au2r/1gOwxi+1XO4J5y7mohBUggnsWyZPz0x8tMCAE
         iy1o4T+1IV+DfIGtnR+hv5R+OSJkdZlRb8Bz0nHWFenN868s2qcoD0WlIlKHa4Tni2WU
         ov1LonlYeXY+Kh0BOAZ75uRl/D+WN1sgFlAIFFJkDWZa0t5Y8gI8fhhi8rM1qerRchad
         prncmAUyWm032gKWJhrjEhGIJ6nTQft5iVm1hF1WO4dEWWg9sr71m4rh8jMlmWUhGrJw
         vHrVUbjwsmSnEiF3AAJQJPEZAYqFLOEfjXBuy4YT8ag5GOnqoFHKiR86N/qluum3QLzS
         /LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782452253; x=1783057053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KO+dGl8JOZI5P4Y+BNYLE/H+0UT+mgOt+djr4eqcLp0=;
        b=S1OpH6gnpG2ViNCrb86ty36BGycEuVbPqNogWwR2UBMYL5LJAVxRde6p6nE1gIfTId
         ewgNoW0UfiZBRo8fvGLHUjIGw9cA7okZYW9L61YvfmscLPFjC3WYCgyc4fXufeH8SU8w
         yrutZVNYkwyto+5wTFWGogiG7/eYbFLr3bfFzHMLIRU9+We0cSAhdUiy1Oz/VfXQC0vg
         zdt1saHTnvvrVyLo5uHNqBFaq36y+uKxV8K7i4ZZaqBh+xvLuKZ4MaqjPlNGP0V6kqnl
         tGyrbiK7xRecldQIw6oglsfX2oIYdnZOQrlCf22M3a7SWIT5yq1L/5kETQt/dNECjq3U
         XuBg==
X-Forwarded-Encrypted: i=1; AFNElJ8WqJvEYfzF3TTREr9gfpo+XBmcsn2nAf9d+o/lP+Ax9DpRKtMO7AxJYUCsivNZskSVY/cAn2RGqFJFyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZCTtf7xgMkhov7GepHr59TZ0pyHnbWSijvthQBhwV1j7Z+yLy
	6NJULUkEZZ+PSNooMtAFyjihL7fqmKj1Xhnt8ptAbweIcQXuQdw8UQJh
X-Gm-Gg: AfdE7cnygYeikF4L6Vy+/fhQoZTTvIUquBSR5yzpspztxcmyFkigCRs4hiOQRU9Orp0
	esB9eEOe6zk0sBt4SJU5LxWJGGRJtCF2Mb6HqAQHVl76FC2li0aHlKWPr4Jc2AoNy8tukyAf9Gq
	kd4moK3YEFGLmruq13ND+XcE4pNvI91BOLx9ISGs5aXO6R81DGuK6+5bFQkHuatHqITI2KAl8BS
	UTDagZoxScDkjWU+A5KGXPdiQ2y2EzHnvISG8pSvJk8HsNDuah6nBcQfU/mYpZ6tQUQg4Fk2b+E
	jDxaGm97qY9pW9SqYzPpnRCpIYioRj0r7syf/SBntyO9ms5ae627Vm3mirDkoHtlZNlTXXOfpwp
	6Sf0FVdoAOuY96Of2hRkiWbjqFmfUqFVhprNKEZMFy6WOHp4MfDSaQfKwxSm4hGxcNiUcZgV2RV
	osr2A7E2yZotjyx13uY8+qGbjCFyTFVYk+3cg9uCxhKW5lPozIJlxERg==
X-Received: by 2002:a05:7022:120:b0:137:edae:540e with SMTP id a92af1059eb24-139db95a6e7mr4536991c88.6.1782452253331;
        Thu, 25 Jun 2026 22:37:33 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d912197bsm22472462c88.15.2026.06.25.22.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:37:32 -0700 (PDT)
Date: Thu, 25 Jun 2026 22:37:29 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
	Vincent Huang <vincent.huang@tw.synaptics.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: syna,rmi4: Document
 syna,rmi4-s3706b
Message-ID: <aj4QEL9o94PityxA@google.com>
References: <20260523-synaptics-rmi4-dt-v2-0-0645122babdc@ixit.cz>
 <20260523-synaptics-rmi4-dt-v2-1-0645122babdc@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523-synaptics-rmi4-dt-v2-1-0645122babdc@ixit.cz>

On Sat, May 23, 2026 at 11:45:34AM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Mostly irrelevant for authentic Synaptics touchscreens, but very important
> for applying workarounds to cheap TS knockoffs.
> 
> These knockoffs work well with the downstream driver, and since the user
> has no way to distinguish them, later in this patch set, we introduce
> workarounds to ensure they function as well as possible.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Applied, thank you.

-- 
Dmitry
