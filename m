Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795590813;
	b=IkJmRP0TCpY/ukIw/Ng8lECfptl46G8XS6yYGNjtgXjXVOLkQ0U2GfqUwjKYrqLvuzOQ
	 RIchkKNLMK44LO/vuzDJ1wUutzjJycD2PnSa6yj8kEcYbUBQpoiuU9CO38DHXUu3VZLsF
	 L3AaW0zUCRJ8pBKEANR67OuD6kqLVuPwWLoTP3SVA9JjK0xgVUF5R2wC6kxGxZs14hmL5
	 uaHyZpqWfcZgWHZGWUhuf2iOv+zC4p01aViPNpU9I5lHGG+21UvUZ1pbfjUfUi5Pkc3aa
	 DJkLJymlClBGcVuxxqOgCObWXZ0WNjFZti/osCA5xOdtDivU8FYVN7ytcdPhiQMUkEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795590813;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer;
	bh=4qbr+XP/W07IFoinYY/JS5Q6/NHAvlLOGK7BiMA8ui0=;
	b=QNl4TIfvXI7E5+mdK6AV70IAErZ+c+T3n3Lbc7Ed82QrvjW/FflIh/IjxQHfjawM59p2
	 /bt0WnNqXllCtqviWoblxDTt0p+I3m8PUlHQWqWaGd7ly1qOzAEuBoOzZgfxrTdY91O05
	 J7+3rSUcaoz1BH2UqM0XFniRrHVOCpsWWNaLXY9Vs0XO2LujYKh1ohB3PqfXjPPwJa7Vn
	 aCwECgwIRVxA+QeNVKPrkxst5NUQbMDv21XLOCtaacfsFqNh2Cbg/SRVh1NsslIBX6KaY
	 rK+oR/nThvVvZknTnTHKOdQpXhiU+FIn7rh9Nc9TESLg4lVjdu9phuZBixgJ2vyImUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rmoay3OR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15072606A686;
	Wed, 25 Nov 2026 07:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rmoay3OR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7291F000CA;
	Wed, 25 Nov 2026 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795590812;
	bh=4qbr+XP/W07IFoinYY/JS5Q6/NHAvlLOGK7BiMA8ui0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Rmoay3ORo30nP6bKHTq5PNW3QTRX8PYNHTXA1nLqHSbhEVwKxzVO+G1h+fvMBXwPs
	 5YoHlZcORylh1FkygCSep7WPoJ4HmrN/uNwxClTF6aNDRuvoRLqwqgzL8QR6qoTsrM
	 JtXWHbNdJBxnPn7I9B4qoClENg8RIMqX6VWW/7L05ZgVWHG4jRD/NbGeuAwi81x1Du
	 PLeuRJGywZwyWd0lXTPI4UDK4zH+JmkusYp8mEXPJQsqZK4dWmYVwRhCnP0xVujqtO
	 MxButjDt8eM5UHkeiX+feQIoRNm4Ao/1o777atqo8haqUYmuxzjlgKe6CZlLY76wBX
	 FKUFny2gN/XPA==
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/6] dt-bindings: display: add VIEWE JD9365TX panel
 binding
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Hefei <3066883572@qq.com>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, robh@kernel.org, 
 conor@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <tencent_A3BF23A8B6E3691F0D567ADF8B84194F4408@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_A3BF23A8B6E3691F0D567ADF8B84194F4408@qq.com>
Date: Wed, 25 Nov 2026 08:13:29 +0100
Message-Id: <179559080931.9063.6197450233674722560.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-25 10:11 +0800, Hefei wrote:
> Signed-off-by: Hefei <3066883572@qq.com>
> ---
>  .../display/panel/viewe,jd9365tx.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
>

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

At v3 I do not expect such feedback to be given...

> diff --git a/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml
> new file mode 100644
> index 0000000..1043f93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/viewe,jd9365tx.yaml

Best regards,
Krzysztof

-- 
Krzysztof Kozlowski <krzk@kernel.org>
