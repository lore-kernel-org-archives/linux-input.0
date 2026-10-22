Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660336;
	b=qO0UklW6wr/qNrDlRQl+H3qDVD4pz4QKV9f9dH1hrpgiUeB6Wzv0su8lJDb0yeh0G/xX
	 qzPTcUbcH71kXfvMD7dMxHUDtTqkOGScMH+XM5+OooWLTc4Z+RI1KXwxoA0KT8JZpvJFz
	 1KhXQ9M1suLOO9oxnO2YhvKe8F6tWMq4MCmpcgzed+gS8ObMIYOVFzEescLb2V+flCLEA
	 hbChxnXBaYRpWmjbtVoEl4lmkbIABuCTOqpL1+bAwnTPI2dc8ZOVc826f+QA2xtyaAD6I
	 no1lwzEN8XFInkjXf93X9MpAo5QPLZUXeyekrHfyMCQfwSeC74n1ioChz36X5mD0vbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660336;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HjXKRcvWomakY058picrQgLccR49c623nmtT0sjd7iU=;
	b=Hi7s2E7tJbH8yfIqstgMZEDL/TQVEoTsZ2biPYgkVcl+VQnQ9ZAg4t51+MAxvyuy0P5d
	 E7qMBk6ojCdlCTV3lDc17bMbsXoNgD6qKDXATsl2CDkWD+x9T6KoDnUC/56PwbpXRWWhW
	 qnBawLHURh7RB9j3sT2Y8u4x5J6uOI7k1bx2S6VDrw0z+iydiLeUoGCmGwtlhlG8zrTeE
	 ynHjwgfj/C/GfOGWyQ3jM2jXbyXxqEOhCIq+gm6G3HwYiVUtagHk9CnHGhjyQzSM3cL1x
	 G00BmByMMDJhKSA5gvw4gGg40cnhDznGPh9WEbgKjxWzgy3o8CmDt3EgOsPHvGy4Vcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCEvsJxV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7F606A31D
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCEvsJxV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F921F000C1;
	Thu, 22 Oct 2026 09:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792660335;
	bh=HjXKRcvWomakY058picrQgLccR49c623nmtT0sjd7iU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=MCEvsJxVV0zYMmKfCmWh3ZqbRRmueUOjPdGFQXV9Lu0itd14Jj0WqAiI9Y0WOmmVY
	 SE1chkgMBoLqyD0LT6DUQnZEQkdxQju0LIJbrOgaCokgJU04zXjPiSiSYNNPsV0MPE
	 bUHxBlDlrfzMYKDVjvTRs+3X3+cqEvviw9jvX0A80XxZinoRGjrFx1680bywOIPW8c
	 YHJd5f+M1rZKymuvi/gcvpgKJ2PJRHyBWK9YNtVr8davvhvjgMsaAcoIdGYnGOMx3Y
	 SUafduz4NN1Py3nAw0DVdSLIrJlUxFbx36/VQcCBNHEjauqTYjTbWZiHANYwX+3RG8
	 uD4qOZBxUfIyw==
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
Subject: Re: [PATCH v8 0/3] Last remaining Roccat HID fixes
From: bentiss@kernel.org
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 linux-input@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20261022054454.238343-1-dmantipov@yandex.ru>
References: <20261022054454.238343-1-dmantipov@yandex.ru>
Date: Thu, 22 Oct 2026 11:12:09 +0200
Message-Id: <179266032982.2930942.382679507948154546.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792660334; l=455;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=nciji7cySzqGEASVzrENDRKcWJxZmTxMQyRW06hmENA=;
 b=xHp3I2ZonSXn4+Uy0eiROOAGLrWrqm8uidel9lTvMzzQLpx5RH1FXnjC2D3CqTR2Z70Eug+v+
 lttr7VBOy90BqaYZ+eSDfwxNDVNpJ4hKJ6NV6Me3Hn9h6NN2hoqSpLF
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

> Since Sashiko is strongly concerned about possible races, here is
> a bit more conservative approach plus one more fix for possible
> roccat_poll() race against roccat_read() and roccat_report_event().

Thanks Dmitry for pushing this series that far.

I'm happy with v8, and I'll push it for 7.4-rc* once we get our current
PR to Linus merged. I just can't take it right now.

Cheers,
Benjamin

-- 
Benjamin Tissoires <bentiss@kernel.org>
