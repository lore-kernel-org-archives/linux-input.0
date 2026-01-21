Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB7F2253B0;
	Wed, 21 Jan 2026 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033407; cv=none; b=IePVgOQTO8vxCROW3AiDjTPG/irAHUO/8YZUWGQIBbn7xSlyM+9Zr1QTtEG2vysLMUZ5bnQKjCVTQq7xldbCgfdaihZGh6YqrdxswyKjtFucXq7jhjT2wEpD23xH7RmIy5NaraqlKQsvrB318lM1ttREpCFCISKa+ggVyN8mc0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033407; c=relaxed/simple;
	bh=HabHZvVwJ+bnQvpGNtcIBPQgIUhvIVff0ZI0l9wEe18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLAXELK1iTgUCyUzZRgGvDtYI6/7ozksjzDNUU1jZJ9WpAL7GhceH7miQCtm8eEm6DdhgKaVOLdcjZIoI6oQyyRklXoXs334PKX+f1i88Ro+JdazSfFlHP6nPvh+DZZk9z8cofmQ32UbdU8mEu/aXjNn4xXnWMWX0vzhfeSxCkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3QuRKWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3QuRKWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B002C4CEF1;
	Wed, 21 Jan 2026 22:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769033405;
	bh=HabHZvVwJ+bnQvpGNtcIBPQgIUhvIVff0ZI0l9wEe18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a3QuRKWuAEbFR5HY292kAUNuNV9mgsqshG+6WJTwBgdEmXel0nKt3y2hDeu6pQ1ik
	 xJJx6HkdeKpCQ2dbE1Y+0t3DadAFhHFiOjhtL5nyPAhqCH/zpDVyc3k9ik9y3EDxqr
	 NRhi66jCjqanIREemYfEAqHd1MurrB1LqKp68Zcp5xP1XNoSEBTyVdsEWeiwgtzMkD
	 yIjvfEed+pqeKDiLu1XdSZc/dmVEwObFM0OO7ZGiZOU9guLyvGfH3fYb08yAjvmH7s
	 SJ24esp++DhPRmi+12BhRJlekAg1VvPYuXR6FYvDSg3F9aNyGUvx+Hhn+CL08LQfCF
	 gy0G30U7zT7PA==
Date: Wed, 21 Jan 2026 16:10:04 -0600
From: Rob Herring <robh@kernel.org>
To: Gianluca Boiano <morf3089@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	krzk@kernel.org, dmitry.torokhov@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: input: novatek,nvt-ts: Add
 nt36672a-e7t-ts compatible
Message-ID: <20260121221004.GA216413-robh@kernel.org>
References: <20260120193600.1089458-1-morf3089@gmail.com>
 <20260121214141.36858-1-morf3089@gmail.com>
 <20260121214141.36858-2-morf3089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121214141.36858-2-morf3089@gmail.com>

On Wed, Jan 21, 2026 at 10:41:39PM +0100, Gianluca Boiano wrote:
> Add compatible string for the Novatek NT36672A e7t touchscreen variant
> found on the Xiaomi Redmi Note 6 Pro (tulip).
> 
> This variant uses different chip parameters compared to the standard
> NT36672A, specifically a different wake_type value.
> 
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>

Missing Krzysztof's Ack.

> ---
>  .../devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml    | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml b/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml
> index bd6a60486d1f..aaa9976bd65e 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/novatek,nvt-ts.yaml
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - novatek,nt11205-ts
>        - novatek,nt36672a-ts
> +      - novatek,nt36672a-e7t-ts
>  
>    reg:
>      maxItems: 1
> -- 
> 2.52.0
> 
