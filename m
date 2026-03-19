Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36238422A;
	Thu, 19 Mar 2026 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931452; cv=none; b=BlLfw1ubxBdrZXgAyWn0eh55vsOnh2qP1Bdij+CeB6nydC0wLAfhPB1KqrDSmfyZ8BoYCverdXwNYAQTem4mswNbeMv/+sbOHIzVSXySialgWoWPpItD2fHL+w+eKX7BLvBlTckCBpfBDM+UobhmembyI+EN/sH56yXxVpbFp34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931452; c=relaxed/simple;
	bh=sTGmiklD2tcpNYpkOOx2CIDAhq83C1OkRPhDzO1C9EE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r3J1sYieQ6QpwTamTe54nY6JT/wi1LraW0LyVTdJu5Ix92xyrQvWO/BJ5+GmiEVeu/9P6dtHG1fJP01TXxjWWapvsRHVe6eDHyMhjPDVaQDU0j49AYE9S3/QnhVTx8VU8SGPYq2yAgvZaID83fFUkm9woRNWwxvytoMGgHatooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuDhEb7r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuDhEb7r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D38C19424;
	Thu, 19 Mar 2026 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773931451;
	bh=sTGmiklD2tcpNYpkOOx2CIDAhq83C1OkRPhDzO1C9EE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tuDhEb7rPASYtKMUvgusN672z4034w1ncPa5IEEkL3+iLQB8g8+DiH96XPXQOjOtI
	 YLO5RqLeVZBkiVo3xW95wLkA999K/ASqi+YDJtcr6hWAXxGlnCTFrUxq8gnjbdVjSn
	 /rOkLpsH/TcS2a7Iv/OUw45IBxAs7CJ/hAU0WS1YxgiZ7BHfiqOW7txykA2+20iGpc
	 buzGxsFGLwTdy1JKhkptotx4TRtYMTVa2apEA3REGZ1Q8Kp2/sG6upsceIxR4u2gk0
	 MROe8pmwUWVnZ5HJhM6L8UnaOCZB0kwRRCBBtKeAuH6OwF2hxryIbbEhCOnOHmeHs0
	 hpEaeeDkEV4yg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Rishi Gupta <gupt21@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260314170225.1260440-1-colin.i.king@gmail.com>
References: <20260314170225.1260440-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] HID: mcp2221: Fix spelling mistake "Enfore" ->
 "Enforce"
Message-Id: <177393142895.111633.13460322534663563257.b4-ty@kernel.org>
Date: Thu, 19 Mar 2026 15:43:48 +0100
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Sat, 14 Mar 2026 17:02:25 +0000, Colin Ian King wrote:
> There is a spelling mistake in a module description. Fix it.
> 
> 

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.1/mcp2221), thanks!

[1/1] HID: mcp2221: Fix spelling mistake "Enfore" -> "Enforce"
      https://git.kernel.org/hid/hid/c/ac977b900907

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

