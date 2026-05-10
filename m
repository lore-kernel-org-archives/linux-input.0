Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E919F38AC9C;
	Sun, 10 May 2026 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778417050; cv=none; b=O9j1EK0KZ6jTC3kyj7KDPCgkb8FumKDoMKK8qDARuOQnNqfG4b+ou76oroBQbvDvtl/tW+LWfmEAGhYfUREAGAG6l8LDngY+n3jHhYrID9TeRvT8pd3BuOROAJvsZE4YTmWLvMCDr/KsFzrZfmNOPH1baHoLCULYx0c0/03jT84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778417050; c=relaxed/simple;
	bh=XkYjtqEh0x+qK52nljp6z/uh2YBu0HkoogSh7JLdHhA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=ND+Iro7vaNmJgxfE//YXFj0q5GeAmPCEyBvGxNoertKfZWGYI9IUMu1q+ICB8zCty0W5HSBg5bcjdImTD7q7Cymb1qkMYfjoOCk5+0dnNQETkIjQ9LQn0B8qpzkRZxXGvEPtomrfWNUnXai51pM+YDoYztThK8u9+yKA7rJXcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM4Wx9lt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM4Wx9lt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A082FC2BCFC;
	Sun, 10 May 2026 12:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778417049;
	bh=XkYjtqEh0x+qK52nljp6z/uh2YBu0HkoogSh7JLdHhA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=ZM4Wx9ltXjHetKNHgYmbKtVGDYpzJMfgMaMAgulQbTNCk31hyKQ4s/chANuHttg37
	 bn7UE3CQYqU3wXwUigO5++P5BD+RLmY61ZL0eaY2PMUxWbzHcp9sv0ROAmvxuEu2Sb
	 Es0uPSw9MITwC8Nv4CcIZI6XqeVyeM3OVOwAkpe13/5hahCJmvuSxtMaxxAp732zs3
	 iAv4UNqzFbyura10sQ3Soe/Lv+vTClL+/jEH6NExurmPvEmbyFJpYu6ec3EjG4PSPf
	 Lgo9E1m77xjyQee8DEIieUYCq2MTS5c5FjwXCzTNOlOdPbaqCyTWCseM5iMftAXs6y
	 R4NuZqxW2gshg==
Date: Sun, 10 May 2026 07:44:08 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-leds@vger.kernel.org, 
 Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Pavel Machek <pavel@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20260510110804.33045-3-clamor95@gmail.com>
References: <20260510110804.33045-1-clamor95@gmail.com>
 <20260510110804.33045-3-clamor95@gmail.com>
Message-Id: <177841704588.2552439.17208885457870143080.robh@kernel.org>
Subject: Re: [PATCH v5 2/6] dt-bindings: input: cpcap-pwrbutton: convert to
 DT schema


On Sun, 10 May 2026 14:08:00 +0300, Svyatoslav Ryhel wrote:
> Convert power button devicetree bindings for the Motorola CPCAP MFD from
> TXT to YAML format. This patch does not change any functionality; the
> bindings remain the same.
> 
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/input/cpcap-pwrbutton.txt        | 20 ------------
>  .../input/motorola,cpcap-pwrbutton.yaml       | 32 +++++++++++++++++++
>  2 files changed, 32 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
>  create mode 100644 Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):
Warning: Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Warning: Documentation/devicetree/bindings/mfd/motorola-cpcap.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
Documentation/devicetree/bindings/input/motorola,cpcap-pwrbutton.yaml: Documentation/devicetree/bindings/mfd/motorola,cpcap.yaml
Documentation/devicetree/bindings/mfd/motorola-cpcap.txt: Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt

See https://patchwork.kernel.org/project/devicetree/patch/20260510110804.33045-3-clamor95@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

