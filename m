Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46923426688;
	Mon, 11 May 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516553; cv=pass; b=VJ1aun763jkwRsJpV9Vl8HQ+DCR/XGVrpGS6HZQXB9GWPrHap2iare4LvsVH7FmswbrvlSHweCfZmHpdEoW9frE6WhqvH35jdMZfhbWqURGcDkqAeWSMr5R8D5cMdoqQOf7BDahAI1ay3/4ZFViF+AKINdZKJdtOTBt7hzJqN1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516553; c=relaxed/simple;
	bh=1+xSj/0r2GUZxyrqXhfvgm9GiDZtkYQa8vYuw9N9wsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQU8WvsPCRD20BqBpRwRqfUlf/hJnHfkE3nNTOBU6cS9kjAy8KeQsqVGygieQOz3Ido+pjgUcB/img8YxOeq6YuT+1TPs9JkiIY06vDsYfdBTMv2zvs5+nDU0jf9hVoi17XA2W5UxO4o5lAuen9tbTH1oF4UOBHT5Gcz7lNNCd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=aVA5ALES; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="aVA5ALES"
ARC-Seal: i=1; a=rsa-sha256; t=1778516507; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nQA6Y6JO4vlyV7DDVuzOlG2yGYi5kGtKuIxJfJ9vZW3RaQZ5TZFs3DyVe5doq9QFkadyJ2ahPO27f7Koef+GBoQVlbAmeDB8QXSPFpqxgFpbRPVCC+xaaL+stI5G0Yu/LufPP307oFStV/kWRuSxycNftkCyTN2X5sDq0ItjVGY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778516507; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=e19MX8CU+PB58q/Ph/E5Ue6KATJv/lo98521aDrCffw=; 
	b=e62aMLyUokucuOkHduLUqEuFNl3s7rGu+zDhLmM1m/Dq0CPDgyDCzKT9VPciaL9Ug73wcSbzxnKzxe1K0zw+tixBfydWhHN3CWvq/dFxgyqUVol4q03G6RfqTE+jmVRSGLPgwIy+mp9FiTMfVacjZF4Dk1SeQ1/YTM/UZBNz0BU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778516507;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=e19MX8CU+PB58q/Ph/E5Ue6KATJv/lo98521aDrCffw=;
	b=aVA5ALESMkFpnXqD29o2M8OghNp+RcroIizOSQCjgentZBrUVJiZmL9Vn5lOeaxg
	MlriF7P3GeiNYQRhUmrsAjwLNn8j+hJ6+QPvLWWEgPK/LHV3LRiG31DbX4mzeCg0J3X
	RdMSvQM6vC6BeT8Z5tjqNuzKmPqy0zzm3tu+Quho=
Received: by mx.zohomail.com with SMTPS id 17785165060441003.195712507633;
	Mon, 11 May 2026 09:21:46 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Heiko Stuebner <heiko@sntech.de>
Cc: kernel@collabora.com, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v3 0/4] ROCK 4D audio enablement
Date: Mon, 11 May 2026 18:21:40 +0200
Message-ID: <wE1x9P2vQlC8kihOSm9uOA@collabora.com>
In-Reply-To: <20260408-rock4d-audio-v3-0-49e43c3c2a68@collabora.com>
References: <20260408-rock4d-audio-v3-0-49e43c3c2a68@collabora.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Alexandre, and other maintainers,

On Wednesday, 8 April 2026 19:49:38 Central European Summer Time Nicolas Frattaroli wrote:
> The ROCK 4D uses an ADC input to distinguish between a headphone (i.e.,
> no mic) and a headset (i.e., with mic). After some searching, it appears
> that the closest we can get to modelling this is by sending a particular
> switch input event.
> 
> So this series modifies the adc-keys bindings, extends the adc-keys
> driver to allow sending other input types as well, and then adds the
> analog audio nodes to ROCK 4D's device tree.
> 
> It should be noted that analog capture from the TRRS jack currently
> results in completely digitally silent audio for me, i.e. no data other
> than 0xFF. There's a few reasons why this could happen, chief among them
> that my SAI driver is broken or that the ES8328 codec driver is once
> again broken. The DAPM routes when graphed out look fine though. So the
> DTS part is correct, and I can fix the broken capture in a separate
> follow-up patch that doesn't have to include DT people.
> 
> Another possibility is that my phone headset, despite being 4 rings and
> having a little pin hole at the back of the volume doodad, does not
> actually have a microphone, but in that case I'd still expect some noise
> in the PCM. Maybe it's just shy.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
> Changes in v3:
> - bindings: use unevaluatedProperties instead of explicitly mentioning
>   linux,input-type.
> - Link to v2: https://lore.kernel.org/r/20251215-rock4d-audio-v2-0-82a61de39b4c@collabora.com
> 
> Changes in v2:
> - Drop HDMI audio patch, as it was already merged.
> - adc-keys: rename "keycode" to "code".
> - adc-keys: make the keycode (now "code") local a u32 instead of an int
> - adc-keys: only allow EV_KEY and EV_SW for now. Rename patch
>   accordingly.
> - adc-keys: Add another patch to rework probe function error logging.
> - Link to v1: https://lore.kernel.org/r/20250630-rock4d-audio-v1-0-0b3c8e8fda9c@collabora.com
> 
> ---
> Nicolas Frattaroli (4):
>       dt-bindings: input: adc-keys: allow all input properties
>       Input: adc-keys - support EV_SW as well, not just EV_KEY.
>       Input: adc-keys - Use dev_err_probe in probe function
>       arm64: dts: rockchip: add analog audio to ROCK 4D
> 
>  .../devicetree/bindings/input/adc-keys.yaml        | 17 ++--
>  arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts    | 90 ++++++++++++++++++++++
>  drivers/input/keyboard/adc-keys.c                  | 88 ++++++++++-----------
>  3 files changed, 147 insertions(+), 48 deletions(-)
> ---
> base-commit: 8de395f35e79d9168a78504fed495578ec7bac52
> change-id: 20250627-rock4d-audio-cfc07f168a08
> 
> Best regards,
> --  
> Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> 

What's the path forward here? All the patches are reviewed, but it
has been almost a month without them being applied now.

Which tree(s) would this be applied to, and who should I poke?

Thanks :)

Kind regards,
Nicolas Frattaroli



