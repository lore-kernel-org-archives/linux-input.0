Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A54825B1;
	Fri, 18 Sep 2026 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789756430; cv=none; b=fl7HywpWx2l1krETZdRGCnYoTweT0NAIGOwP5p+986KW1xvu8j4Y4N0oLTijvX1OOBP5M0++E+jdjB4fNBaCzAg7PaBN13hZZ5cNztrrfcanmsLXZTh5fhpM6p40cEZ4fHciHg2rbVzLHs3ZXDAbHE69R87H9ET/OweqgtAnwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789756430; c=relaxed/simple;
	bh=0+IGNcZo3144rlFi9CAyh1mnHPYi/es+hISEivCY04o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLnG1VpbUnhdqQpNc10K+5UiNpr+xJKokmIMp7Y/efMyOX6sVHVFutYDWJ7xLsOBAr3tVE9+ihvZQnXjNn6qBq+rvRenB56u8nloRo/a+ZnfJnyRvVDXvIq6FSASbruwMNnxub6fFqioMvfpTgdB9+vZjs1wgJzoMBimAzeXyhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aftqt770; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aftqt770"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FE21F000FF;
	Fri, 18 Sep 2026 18:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789756425;
	bh=ckgq1zxLiBMa2DV/jdhbjMFJ15tJAgMXA9MDLdNaT7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aftqt770gWEjWI7N29HA0MPfAXURXxtzpHXttP/82tz7yERO8gpK7jSjsX0/F4qpu
	 iWAGSZa9UjCLljA0u1b6elgdMwO4CwrBcJQhC03XGBPFVFrGYdrAmmwTf1tpbHY9Vp
	 T1rRfRo8VgdZlzlNNzWFYdRv+NQfXo+MRDd0jfr26Rs6jGlVmOa6GWINko6Jw1E7g6
	 0FzZ+Y0Jrr0YRE0LfiDjXReqQ7zOq4k8LRaFSZ8tLdUdDZF2Em00cs2Ab4tAnTnHED
	 kab+hY4bSKEPd7IZEFABQ3KtXX1ihtHE4RFKe/jlD0d8U3MUHqZLc2/RED+uOTi3iO
	 lqpmuKboHRXmg==
Date: Fri, 18 Sep 2026 13:33:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vsevolod Nevorotov <sevanevorotov29@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: add Synaptics
 S3908 controller
Message-ID: <178975642338.1321546.11664883250943780820.robh@kernel.org>
References: <20260910091405.354058-1-sevanevorotov29@gmail.com>
 <20260910091405.354058-2-sevanevorotov29@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910091405.354058-2-sevanevorotov29@gmail.com>


On Thu, 10 Sep 2026 16:14:04 +0700, Vsevolod Nevorotov wrote:
> Add devicetree schema binding for the Synaptics S3908 TouchComm
> generation-1 I2C touchscreen controller, found in devices such as
> the OnePlus 9RT.
> 
> Signed-off-by: Vsevolod Nevorotov <sevanevorotov29@gmail.com>
> ---
>  .../input/touchscreen/syna,s3908.yaml         | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/syna,s3908.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

