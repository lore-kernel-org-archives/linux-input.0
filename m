Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0013164DF;
	Mon, 23 Feb 2026 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865215; cv=none; b=pyTI6vQt5rOY3O7soL2XrtHi4+CF7rsPh9NbTd3NN4QOr8YAmnUiQQtDAoCTU9fZZmrqWeZ7BLNSdSFKEskH/wIR57CnY+JhhQ5lpZwkQC3fhptqVkpvh3k+dgo0Gjpfe3k6tNwHtJacz+UV6YE+KCgFF5jcRw6cR9iFrDqGyFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865215; c=relaxed/simple;
	bh=ZdSlZZKuJp0uzRMfDVImy1TUOeUNlxOmQOtLAqM/3J8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRyCRqYK+JB4fyKawpelQL+25Zxr3oe6B6qhLPAyoZdDWarL3zMvnchuF6fc7eGfmCdEwdo+ditvpO4UwlYzS9R8m8eXLLMui1o+QWg+68UlFrnFiev6fwtANeCBaKrzRqLV3bX37504UgbwTIKfucZM1kRy0IuR9+YXcomCaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmq8yT8u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmq8yT8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006F1C116C6;
	Mon, 23 Feb 2026 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771865215;
	bh=ZdSlZZKuJp0uzRMfDVImy1TUOeUNlxOmQOtLAqM/3J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmq8yT8u1hpf8sfvib8SAFKqOvCI8IhVTUuYT4ozUgiqOqCNzHCXXUjhpr75ZpKKE
	 u/w0UIi11GrtAo0Sm6eJEm+kI4I6R6I+pLqLOzwQJhEw7PzBIStNQXwtatnamNpcQK
	 bt+DzozRLjJBR/CpP+ECStkraLDCVcwo2R7m2pI0PdR+CSzYTf9zKTm7vvSL6vdmur
	 V1hlNo98lUuwC7HhyaamzrHQKVZ6Dpci454cVD8eYgDicMLl6YqHbHCgSXmjGfeJaj
	 KF1ljMNwEI9Gy3OMlPa252giuHlgoUouawJqGiQhbLDlGqhFO/vlWElSS7R7lAXiw8
	 SFRT+s4tzJ35Q==
Date: Mon, 23 Feb 2026 10:46:54 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Pavel Machek <pavel@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	linux-input@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
	Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>, linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 5/9] dt-bindings: input: cpcap-pwrbutton: convert to
 DT schema
Message-ID: <177186521369.3975744.16898258990517269078.robh@kernel.org>
References: <20260223063858.12208-1-clamor95@gmail.com>
 <20260223063858.12208-6-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223063858.12208-6-clamor95@gmail.com>


On Mon, 23 Feb 2026 08:38:54 +0200, Svyatoslav Ryhel wrote:
> Convert power button devicetree bindings for the Motorola CPCAP MFD from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
>  .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
>  2 files changed, 32 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
>  create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

