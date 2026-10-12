Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651CF46E01E;
	Mon, 12 Oct 2026 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795618; cv=none; b=GpE/40nP2PqAYwjVBHaYP2vGDi2zaKHhLfu1B2LpzQZm8jppJ2iKPXo/hQc/nN63J32sOB94scdAHa64qyJYtMV/TxfVXCpw/fVrplvixsftYQIxJzpyOPdG9eH/qwdMfEVXy9BRpNHBUHzxnrQ+2FgufZr1/+D5SZxbsR2rmHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795618; c=relaxed/simple;
	bh=Q3mJIUIzupaCTwR4E8sslo9WFz+q8rVuwZLJKszN/MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlI0JBKgOyV694pK3lgxO4p4Qnjx1k2b4kT8D2QiyYEtlFzbS+JqG08hnpNJWwha1aWEN8nfrMDHpYM/aGu8DxnMCB3XvOLrcziVPpOHPiiBD3Hgwj+PW7lO/EVezY2cXo20+Qq7tJ4VND9Z1mYgQ+6ikdulX4x2bL9847LdTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjzrJK4w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjzrJK4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147381F0089B;
	Mon, 12 Oct 2026 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795617;
	bh=yraBTXL1hctV87L1JCVNYMrGNm7lunduFfWP2hWirds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bjzrJK4wCo/k6NUNhzu/YjzJxAKXaWBxQUWHjgj8TAQGgw/I6T36448n7H6sP+e6n
	 9kM+MSae0QkQX0q53w2EJDKdYNSYDkEj88/D3bnfYM+/geCNoAJ1kcEtIrneRujVPz
	 8aKP0eizhl4NHj3oPVq2k3BJLLJ652h+86/qKamT1HCJCfev+0CEgSNrQnTCkgrNl7
	 hlTSEmHCPr2cAYE3zf8EGMCEOqoxUi3WTZzee5qC69dDVJGeP98Zxc1kKqK9NcAQvT
	 VkCyK4/9X88WvjGyDSyZmtw7aSuEKWwCbH3EyAKzlf+8ATA8vqrgLRq+TAchdDyjez
	 +lMujTnzCxprQ==
Date: Mon, 12 Oct 2026 11:00:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Miotsuki Mizuno <founder@crepuse.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Icenowy Zheng <icenowy@aosc.io>, 
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: add Nsiway
Message-ID: <20261012-powerful-amiable-ibis-30a4ba@quoll>
References: <20261009144729.85832-1-founder@crepuse.com>
 <20261009144729.85832-2-founder@crepuse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009144729.85832-2-founder@crepuse.com>

On Fri, Oct 09, 2026 at 02:47:41PM +0000, Miotsuki Mizuno wrote:
> Nsiway manufactures the NS2009 I2C resistive touchscreen controller.
> Add its vendor prefix for the touchscreen binding.
> 
> Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>

Honestly, how mismatch can happen? git commit --signoff

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

