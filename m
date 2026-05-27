Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138CF34E764;
	Wed, 27 May 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779893186; cv=none; b=gLaWbNM1SVmTql0feHZmFum0uUWnT4oSYa0T3o7sACprIhZyJYGXzzfsxD62c8NA2z/deMaIomxn1ibN0NJaYOYaDfDaLBqQ+7cnJNFO7mv6jKpTYIarVHI+7E2X2PX3+4PQIJJKkBuVfSpl0R6tW2Z/Wa9npQQvG5sadc1DwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779893186; c=relaxed/simple;
	bh=xFQMrbAjqAe+1dNeRKFuktRv41PIA6iEbe6pHIU444U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/SEM6yzryLsHfi4QLhJCCCQ61RTV12J/n4CAk2zYy4zU9Ig6D/o9A5D67XQlHzEhRSgRtd7e9eCjabA40fUNJd/EzrkGvbamIz9tWiXoB1WgsmEST2fR7198e4C7j3GSpycZUkmEoDxHHDd8RiYBUpnhYSi0iJhpySg+Ah7xFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hulfetsg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hulfetsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DE21F00A3D;
	Wed, 27 May 2026 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779893184;
	bh=g4+j3ka9qQEevfco8FAowrQvCaf03gTn2X1D0P2KtPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hulfetsgz+CTnlKQjyDa5nvmikyCu0GkZD4GMwe3aFQ8iHSp1/AR5aIaK5wpcMF5p
	 zovWEbrWmzaQPPa8C/v51oDNBd/V4IatFT/aiKsss1R4it0g+anH0qx9bZJkFrBwpK
	 /UVPbWicLo4xrenrXXxkKDXvnKaTRRT6G6CQ08oX/MZIxUj4NnoQcsd52Ij6BOm/Q2
	 tZvx7BRKOV7lL3wx7GcQuovy3k50AROMiX+SyTUn4410mzXVSaJVosak+oqYYoq6mZ
	 SgImPTRPsvOJDqXo7wiL5dPGyL7Q5UhYFtznPdGWBklYIq7B6JZ3LRgVnj1tNQcthN
	 oPyDikhg7TzNg==
Date: Wed, 27 May 2026 15:46:19 +0100
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Sebastian Reichel <sre@kernel.org>,
	Ion Agorria <ion@agorria.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/7] mfd: Add support for Asus Transformer embedded
 controller
Message-ID: <20260527144619.GA671544@google.com>
References: <20260518095907.36158-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518095907.36158-1-clamor95@gmail.com>

On Mon, 18 May 2026, Svyatoslav Ryhel wrote:

> Add support for embedded controller used in Asus Transformers for
> managing power and input functions.

Once you have your Input Acks, I'll merge everything through MFD.

-- 
Lee Jones
