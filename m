Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895960;
	b=3Acecw5py1YbvKuBLouQTnxsrr9+gsxdYhibTx6pajIVjZriOdm3Y/SCh3+AUe8Drk+F
	 2chPi57W0tXtxjnEm4u+X8QAIPK5Vi16Eckl4HRpUofNSa3Rn+MWlfZ4OgtE040wN7ErG
	 7Qm1RgjapjvUns4kky0Y6v4KMK5u7IDoz0gcL6euOV3mIc81ZIWA4W3DNfp0sbRij3P13
	 1hqPwQKLFuIvrreWgVdCX8PWHu7B4Io5yXOWgoJkrBogZOetFh5EsNAFMXY2blDGDWhb5
	 mcSIn6KcpZY0oi0YdRenRTHmZw+V409HTZyDMKYB8R0MtcHZJ38jKpH7pmSI/JzVqRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895960;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=CHMws3iG9sp4MGsGwaHEnG9dzHeoN48MoG9k6aIiNoY=;
	b=aSfBX+NwyI8g5Ih/1FP7Ttn5s8Abz79JVTR2jOIfY6Rf89dj9ZRY7xNz71BWgb/MOgRn
	 eDZo7NFf1361gmDb6LdU621onZ9a3o/T93tLp+PpSk+CowgvVxQ77B9wmbenP/bdN/1lg
	 /txMhRSIxktTCGXVWYZVsc1DZwpGWDE9pFkjfk0Irmqv6jEItW6SXzslAZQ8TMQZBED+Q
	 unudxH1nCOMD9pO2/9FqKMNRy8o7Fz0glvu3OmW8VeEWtLkXSseoUQjjaGxW/Ba3NLnHQ
	 rb0OVpuS0SwyHfeUuKstOJ2MGHExzmG0fzbSAYaMuGuJFF63LeIs3/eWnkFQiy+71Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Md/X1igi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25505606A32D;
	Thu,  5 Nov 2026 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Md/X1igi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6C81F000C1;
	Thu,  5 Nov 2026 16:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895960;
	bh=CHMws3iG9sp4MGsGwaHEnG9dzHeoN48MoG9k6aIiNoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Md/X1igiF31TbEPeouI3TA3NQK/nErcJ+DvEpF/ocSRtYk3pQa44RsipA8NaAADs8
	 iiKWhJEZRXwes/CNPAHM1G1BNg6PwLkNYXrrnJdlExdHgE4Bnh2UAhdCK6pdoHbLPs
	 AtqW+j9afF/w98mdrcvPoOWYXinipPwRYWSKOwmB4fSR5tzHwK0Eb7mpGqG0Rp1oxz
	 swkw5gthkFSUuHe2b+DRZfMablYaZ8ezlZauqZPxHlHxbWcx4wIcf0W3qz1ZF5zydZ
	 tDJOkoVG2UOU0WcYt+0JMey72S3IQLBsHOWqdGzFVpVAS3H70JHgZyunzeJbGhvsie
	 50dLQzmLJIRvQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Roman Vivchar <rva333@protonmail.com>
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add mt6595
In-Reply-To: <20261105-6595-dt-keypad-v1-1-f0911f40d3ad@protonmail.com>
References: <20261105-6595-dt-keypad-v1-1-f0911f40d3ad@protonmail.com>
Date: Thu, 05 Nov 2026 17:25:57 +0100
Message-ID: <xhkdbo6c3w8h6.fsf@mkorpers-koolstof.csb>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hi Roman,

Thank you for the patch.

On Thu, Nov 05, 2026 at 13:29, Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org> wrote:

> From: Roman Vivchar <rva333@protonmail.com>
>
> Add a compatible string for the mt6595 keypad, that is compatible with
> mt6779.
>
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

