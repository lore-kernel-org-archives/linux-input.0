Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482249;
	b=nTbarGUP4DQXXI4RzcJt1eP8TO10SSN/rX1cUv0XR5OorkUIuNyMa3fZ7k04EZNFlx/E
	 2+Bv+AeyrMniVB7c21F1GuMiNSZTMY6rfffqJlJS05/vY/fVklZLdWQaDo25wCVToy/BZ
	 yo2kkEI1vKfmDgFDPcschZvyEoyag5e3X1NLK6x4zpo8lk7YLQny/TWgDOERtQTVRl2Tx
	 HgO1ypJQflsDyX7KnpiHOONPECD0DIyy98YOhdhJL3oLGdTHOsjwoLe4ZYHooa+fSPATZ
	 jUQ07rd8kgICU/MPHPzk8sHP+wF1Hal8A3E+ZuEBm3izfrCSPFVjJz933TGEK+Suwyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482249;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gDaoWXcLGzrj9tIXDqipCb/rpxK/E4hqffbRtR2914g=;
	b=IMidUVNaNSCGuIdYFEJdMLrJSgTXCPqWPgdam8YAPTsfUtIRpt8kkl+COgpeGsON1Vrp
	 FJjlGPvTSx4cjh26pQGbUVhp4A1JylQQzbZ7d1jD0A7vVklXB4GUT7mS/xeGq49pGA8V0
	 poTsSx/g0H3rhFsV4+UldTm+E6Ct3kGjETe5sYJc8GnDpH3FHEGCjQ1P6CxF9uCTJ42vd
	 z/+w594OV+LaWJgGhAcjm59tJ9bmVMqKTjseffAKvnLqKSHKVsaTODs2FvXhh7zLqsTMW
	 anIGPb+v+BQvOWJTgJGLsE6KD+rGNlf00raHRGArsdkGLnFvrg/YbXAT1VKsFrShrOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjlzUV0Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066AD606A31C;
	Thu, 12 Nov 2026 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BjlzUV0Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A881F00A06;
	Thu, 12 Nov 2026 11:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482248;
	bh=gDaoWXcLGzrj9tIXDqipCb/rpxK/E4hqffbRtR2914g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BjlzUV0ZM+Jg7mv2H/7S5HHK+m8rwcR+xlo4uLF2S6ieEbAAjHuM0misQvLP6hBJa
	 oDTHjcV/BVQEUIodwudGpFIg5pgLIKEKHAQB69FC3Dl3JME8eDd+wG5NAZi1ntPBhY
	 cztAToS/LCgP/rHA+JUc+y0oam1NxUdTrD3OGgUtlQxlvf4HhfYfKu+ocnlAU+Qr7+
	 oHMsbrve5hmh1SQ2BNEqVjQ6zx9HBocm8bdOXB3yZzECEKKItlNRYEnHvtzwrWkwk2
	 6cXSoFJiX7PVpWGRb4w+umXEF3yW4+gbwQBiE6UmvvE/ngb7I8s0wjhQg2dHOl0e7v
	 DLM9jI3ChPi4w==
Date: Thu, 12 Nov 2026 12:17:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nizat Mikayilli <nacht@dxdmail.cc>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH 3/5] dt-bindings: input: samsung,s6sy761: Add ST FTS1BA90A
Message-ID: <20261112-steadfast-sloppy-hoatzin-2efbf7@quoll>
References: <20261108-b4-s6sy761-fts1ba90a-v1-0-999b3cfaf82d@dxdmail.cc>
 <20261108-b4-s6sy761-fts1ba90a-v1-3-999b3cfaf82d@dxdmail.cc>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261108-b4-s6sy761-fts1ba90a-v1-3-999b3cfaf82d@dxdmail.cc>

On Sun, Nov 08, 2026 at 09:33:55AM +0100, Nizat Mikayilli wrote:
> The ST FTS1BA90A in the Samsung Galaxy Tab S9 Wi-Fi runs firmware that
> speaks the S6SY761 protocol rather than the ones of st,stmfts and
> st,stmfts5, and it has the same supplies as the S6SY761. Its event size
> and some commands differ, so there is no fallback compatible.
> 
> Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
> ---
>  .../devicetree/bindings/input/touchscreen/samsung,s6sy761.yaml      | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

