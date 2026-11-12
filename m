Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482488;
	b=MwnJJvo3AWAqaIX6Yxc/VKfO6d2J1voxFb/8NwCv1hXoZ5tmS7VKwODJ0rHSt8Zul0Av
	 TBrYJJhkLY7076cvLP1EO3MvOcRTSbApvlXQqp4ihyJx/TtOY173K85EoPp+hpCjHnDU1
	 9EagAit7B0zQk16dtGSSigBPzeUDjUmgjh6rzYkUgA9atqSP6aMh+32z4D8xLUDRxG1rJ
	 2ZsCUOktc1z12NIlBQIkD7hNkImE3ulnQdhYGhzMyhCue1bEDaOjjpg0IobbZHaRjRP4S
	 2CuQ9Vlr9MoqMFIS9Jdh2pf0oB/fb1ZFOW4yMLSm26kYbPlGixFWb0k6op27v8RcwTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482488;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qc6BWxmNE5hjhL5q2uywu5GEBWAUTQvzwGRl85K4k+g=;
	b=CSAI4DiYOijNWthMRrDUQ0vMJnwTbRKV/CVtxNW20xWdotKSaGryIolfRoODrzDRwyiE
	 CVx4c1GARYBSNXigYtnYvC3UtnZ6yLJX7PtYhP0bp5bvhFwerRMnrBek6caMe1HMG2A/s
	 MrdU+7R6lAL7ko7I1FoagW62LdEahmr4fMMOJCZ/lUKL9yscbXlNRVb16/iNmsRmm6I1Z
	 4bh+NyIMeKyRcV3Fdlzx2poG2j1I2ySMI0YfGQ/9Kr6BT5ceLWDQ7DibeT80n5OTPAjP+
	 kI7/Ojhdc5RWJXQu6Sg9f03iPFTeXBHrbEJErlFLu5c6VMiV60LOd9CShRcpvTnuBsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnPic8Jz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743AB60A263E;
	Thu, 12 Nov 2026 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EnPic8Jz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57BF1F00A06;
	Thu, 12 Nov 2026 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482488;
	bh=qc6BWxmNE5hjhL5q2uywu5GEBWAUTQvzwGRl85K4k+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EnPic8Jzz4T8GAyAUgO+xkPd2kfMiu4ysaWz7mqZbVGMzqXj7n9VqKajgHT5AhkyL
	 WuXU9gfQaGIiCQIlZGz/miS36Ibzxn7kbdGxqEkLZFTR8t1fIXCKWwB+ks/D7tI5dk
	 9Q6Tt/dH2KudDpjXwA1q8vmEp1xZarDt8CuUyq5aiqZYd4TS8nhziHey/YWNxYv1oC
	 j6SZII6uJB7kNzlSP8/w0o5SZib5iloBRATFjpaR/SM9aqvdY6BgJ044Umc75KKxmv
	 vOukVqtNfI77/aSzzkexecI18ZGolR5Lcn/3JGS4nsI9ZKIsALZeWnhY1mLxiQ167f
	 5AZJkws7xCITA==
Date: Thu, 12 Nov 2026 12:21:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nizat Mikayilli <nacht@dxdmail.cc>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Hendrik Noack <hendrik-noack@gmx.de>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: wacom,w9007a-lt03:
 Add Wacom WEZ01
Message-ID: <20261112-bizarre-futuristic-seahorse-cff1e7@quoll>
References: <20261108-b4-wacom-w9000-wez01-v1-0-c2b5e3466187@dxdmail.cc>
 <20261108-b4-wacom-w9000-wez01-v1-1-c2b5e3466187@dxdmail.cc>
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
In-Reply-To: <20261108-b4-wacom-w9000-wez01-v1-1-c2b5e3466187@dxdmail.cc>

On Sun, Nov 08, 2026 at 04:55:17PM +0100, Nizat Mikayilli wrote:
> The Wacom WEZ01 is the S Pen digitizer of the Samsung Galaxy Tab S9. It
> is not compatible with the W9002 or W9007A: it is queried with a plain
> 32-byte read that returns the query at offset 16, and its 17-byte
> coordinate messages carry a packet type in the first byte.
> 
> Its firmware differs between devices (the Galaxy Z Fold5 reports the
> buttons differently), so the compatible has the Tab S9 codename as a
> suffix, like the W9007A entries.
> 
> Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
> ---
>  .../devicetree/bindings/input/touchscreen/wacom,w9007a-lt03.yaml         | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

