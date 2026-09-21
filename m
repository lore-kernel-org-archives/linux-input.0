Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3BF472552;
	Mon, 21 Sep 2026 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790012936; cv=none; b=ViKICk00tqxgt0JC+4rFfSXw+r5/8+25ex7eQswcyhGyQ8kp/vWfzqbbndY4NZuf0bFo2vhRrTQFOFI3k0njQbXzb0g1x7dhy9TSlZPwSnxqCUMR1YS93wqS58FhsymBe5s05dwn06o2juUk38ajtvpy5u3VmVJxDomANiAa6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790012936; c=relaxed/simple;
	bh=K/RRlbftxPFONQjtmNs2iuwJehkAEwOWtVZ/Gy8r0KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQzVEm1dbqVECgziQ1dKdlE47Y2ttLItw4z3N/LFhMwEJH8026Lr5GeImZk4MQhvM5BXqTs6A6kPVaxXGVst/Iy9vC/e8tUXygg3i9VuICl++gc+0I0womeDeQbLKnOtSlsluvWeJYo77Ymu/Un2JFBRangHuNkN+fmzoThdo08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnyqIG4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnyqIG4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D1A1F000FF;
	Mon, 21 Sep 2026 17:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790012935;
	bh=dKQ0TekucpNtI+i6I1k4qJag+fcr5izaMD5vy3kgNko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LnyqIG4Yf5/dTN/fEwinJ4Oq4274a9bKDxtUuGMKOSxM2XqhOv7D1YKdgKQ0BgX2E
	 v0BdGsp4HMuXgMPc56pL4ICDJIDZLLSSC0tbOnlH1js4g8NbNnAryjPBl1V7XCnKm9
	 kaWzpLLmjhM8ZamcNuBWeXfwuSawoRjdDZ/nF0vz9x99PWtpNcaPgtxqwrHS80Wb38
	 AjDzXbjtoiQHxPbzlItfZhm+IrtaAy10QrWGL37OiyQo+BIGj6eXfE598sQhw/c/LZ
	 vQtEgi2aBbts+CleVzt6uQ3Rdg1/mknDZhdOIDdBCs/q2edW00f+ozDf3Qw3rlhNun
	 JTx3htEr24OBQ==
Date: Mon, 21 Sep 2026 12:48:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Artur Rojek <contact@artur-rojek.eu>, devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: Use consistent indentation in the
 example
Message-ID: <179001293281.1071018.1885750627335325381.robh@kernel.org>
References: <20260913123310.100170-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913123310.100170-2-krzysztof.kozlowski@oss.qualcomm.com>


On Sun, 13 Sep 2026 14:33:11 +0200, Krzysztof Kozlowski wrote:
> Correct indentation in the examples to consistent 2- or 4-spaces
> indentation to fix dt-check-style warnings ("example 0
> [indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
> re-indenting entire example just for that is too much churn.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  .../bindings/input/adc-joystick.yaml          | 20 +++++++++----------
>  .../devicetree/bindings/input/cypress-sf.yaml | 14 ++++++-------
>  .../input/mediatek,mt6779-keypad.yaml         | 10 +++++-----
>  .../bindings/input/microchip,cap11xx.yaml     | 14 ++++++-------
>  .../input/touchscreen/eeti,exc3000.yaml       | 16 +++++++--------
>  .../input/touchscreen/ti,tsc2007.yaml         | 12 +++++------
>  6 files changed, 43 insertions(+), 43 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

