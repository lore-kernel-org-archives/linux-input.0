Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C1312B94;
	Thu, 12 Mar 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324035; cv=none; b=e4OBsJ4KnFdI9Zgjms1csp89i1cYxZHyFobZ3G7hQRmTVZUPt93eYF5WJRcQ35rRXbYSCuJlvYuhKMG4PAmHUxxRqZCHeOu6MNQ74721rptnhnj00oh2erTQq9n0Ygq2iZ8g5xCHla3P1i3HdeJP+Ji5leSWcUd8o0xN+JP9DAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324035; c=relaxed/simple;
	bh=lgzAwmcia1bIMN1GXKk0zq/eE3MT5qXplE1hzEEEs5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upDUmoxgapZiPhov0P3hXtR2Bre2g/XQ194BD7rVDs00aGqM+jbsp7eqBUS0V75mVdQ5dUaZVNlHGGf7v/QuiRsKC8oSYkzb4wHSkZD+A7RjDwq4xt0/mk0dzv/ER2nBy3Ce2ma8ZP1+uDVpnllvIz10seBRU+RrKFtYUdp+JRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMGT4feG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMGT4feG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F01C19424;
	Thu, 12 Mar 2026 14:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773324034;
	bh=lgzAwmcia1bIMN1GXKk0zq/eE3MT5qXplE1hzEEEs5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMGT4feG0qm/dNmC0kI18hsGyvHTMrmIX0kDEHPHWL7UB352oMdTlgIKXYfNNew7/
	 1Xt9zSHmZZ/JnC+6zzuRVbhkrzYhPdlqfoEaP8aISQ3Dxu3RhidELIayZ4HIND+jcx
	 guvMUahvzZmxPvxcjNZLhkMzdwHIWNNrToo0BO0cTp0FaZxPQU3C3AqjsH8UKPdOyQ
	 iA1w7hcVWmk5qorI3J1lBD9Jcjr1AeG/v+NSt+eodGpbQPXf9X285jYMjEzfxteKuy
	 7lKup7ivdS2jWbgw0ZELBGgsTNGUXlxJ5gB5Q6QbQb9qm+VqLX4+I84in/oOUTfV2f
	 fI5xq2q+JgNwA==
Date: Thu, 12 Mar 2026 09:00:32 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-pm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, Pavel Machek <pavel@kernel.org>,
	devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>,
	Ion Agorria <ion@agorria.com>, linux-leds@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] dt-bindings: embedded-controller: document ASUS
 Transformer EC
Message-ID: <177332403209.2914211.14156950861343429723.robh@kernel.org>
References: <20260304185751.83494-1-clamor95@gmail.com>
 <20260304185751.83494-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304185751.83494-2-clamor95@gmail.com>


On Wed, 04 Mar 2026 20:57:45 +0200, Svyatoslav Ryhel wrote:
> Document embedded controller used in ASUS Transformer device series.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../asus,tf201-ec-pad.yaml                    | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/embedded-controller/asus,tf201-ec-pad.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

