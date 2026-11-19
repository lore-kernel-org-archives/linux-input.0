Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122394;
	b=EBZcWXYKwV1IXD2MgsN55nj7f/nljx13U/ljgKFqLkiCu1zFtMC9ZFPlz8OG3IX2iU4f
	 VrfRSa97Ef4RhW9CY6QzEKXxtyAOnvht7f5xc/nNuzpRDCFUCo4mBGqr1gfQ3VISu8Qo5
	 XfIh2TR9Cha5m3jjmMf7xBpBcJ7FxRNEuXsdYNNuscFL+4XXmJNVVIkwoDX2Jrf0CtmF1
	 E14FDPVeRGKcKW96qxh8IIjNkzESwKkuJHCCRIu5TyQWRQmysCj8h8MjV26Ta6ovyXrjt
	 Uqrt/iZozaY7W/vKiRqppZPvVPSybTnVQrfZSiLrFbvHX1yPmopWAQKxJXdzeYBBEgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122394;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=FqXHu3pfayu/64bIjDmDaCGUPn15UWAAZfSzqCyYAsE=;
	b=GsKsKUjgf6t5G+dET9A/VueVO85HFWP73jThOaPqXf2y4DDlIEASuV+qeQ+NK5inLBGm
	 jEXUr2wV/2oZXaef8LlE3chFeB+Q3VwFWNfL6mWzzZngDEVpd10pmOxvUZdB8Ok9N7iZT
	 QbURYsSPGR6uaAfWaLh32JhlA+9nQLLnoQk60nhwvKD37ajp1M/aTpNOl0DwZ8u9kV4RQ
	 xBt9gtkb0VhF52ASVrgb0NheKIqZZDukzt6HCnPYPSnA17hJssRKKwdlXXoySv5wBap36
	 afMvqeiUj9AiURJvVB6uWHbI6PnuDFPZ2bES4+FQKlRmuS46jucrfEH4AavkqKjHhBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3hJClL0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD1606A324
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3hJClL0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F571F000C4;
	Thu, 19 Nov 2026 21:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122393;
	bh=FqXHu3pfayu/64bIjDmDaCGUPn15UWAAZfSzqCyYAsE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=F3hJClL0QHxmbPeVg7oK2q8beuTN/ku2wMD9WTtmF3MvywsMUs7n64w25cHXZdszg
	 NMZbJ3cU0skQLin5ar4JAeRKSP7xeOfYMytr87+m4zj0oQUVVveBvkRnQznz0NeJQo
	 tYy4jMons27cZ93bIPTEIaBFgUfXFmCpx8kacdDuDNd4dugxvSLpzdo8ON4F21zAWS
	 X+YET53tSbHbg+wVA3l/Nikg9stzgULG1B/1cAg8xo4sHubNB2SaxLixvl4MnKihoH
	 X6L0PQVkUZtWv9yToIIfFBqqQ4kKd8CtjtPk2W05Kb2x4ZZHPWiJCXa8eozNtTnRvm
	 JsE2I4s98+0WA==
Date: Thu, 19 Nov 2026 22:06:31 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Michael Schwarz <michael.neero@gmail.com>
cc: bentiss@kernel.org, lains@riseup.net, linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-dj: Add support for G915 receiver 0xc541
In-Reply-To: <20261108170117.76927-1-michael.neero@gmail.com>
Message-ID: <821s2o67-orrq-o57p-s004-nq355ss5398n@xreary.bet>
References: <20261108170117.76927-1-michael.neero@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 8 Nov 2026, Michael Schwarz wrote:

> The Logitech G915 keyboard has a lightspeed receiver with a product id of
> 0xc541. It seems to behave like its smaller brother, the G910 TKL which
> has a 0xc545 receiver.
> 
> Add a definition for this new receiver id and a mapping for the
> recvr_type_gaming_hidpp_ls_1_3 type, the receiver now reports battery
> status of the connected keyboard.
> 
> Signed-off-by: Michael Schwarz <michael.neero@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

