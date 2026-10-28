Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793184482;
	b=AYaKywAgwMOgloE3rSWandM8BxLpYD7oeF2rCguF0jBe6siRmttNQWKnOs2+DCv6AK1o
	 0+dP5wL8d+WodxyUCEdic6haeCjngM2UG3kyKgOEgoKaHcygwgZudNRKlBMtnNVjnHcfo
	 lt3I9a83jiLjgVZZf6BTDdk57STt6RAw1E3Lv6u5xEn2kZBrNho2Ck/YBxrhojonyPHGk
	 Q2fSmIB0t3IT5iqhg5kDsZ2c+nCtyTJwsj/E+OkiamWAu/mCZ4ApI65e06eJPMsDgwWlt
	 9wKe9mSgCzrcRfdAVQyQ+K1Fn5RUcbLNz9CYDFivS0+SuTFl1mDZEHjdf6crovvG0wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184482;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+NyejRjHZfvseTz0BhfelUoicHv1K/z/ho3rRiZ+zdo=;
	b=M24FjfTaJ1MokiUq1G5NG8eXdfDQZ7qZKqbTZhdYTc096IS7V8TJ4LaaVE/JCIUMdBFI
	 ni2qEKNmrC6veVnYprdrhOmrOUmiTb2lmi5BvYzsbtLha3YPFAL0qafVkPZWWXT98DDwC
	 zZKXJHbggCVUAgOjbdMfL6ggsAw7qttc/eDPSEXRgW74GHwY1uLBGGtfJNpPYA9f+Znft
	 fcRsVmuD/jWwiKP+OI4WQUTGCRrU/Ep2XeN8KHSwxAB8XF0rF0nQmkUTPVdlLmnxvuuCR
	 XGziVMv5vofAJVQbcYi3mZ+j+qawrxIXS8s3TBe6SMk+wG+5GJY4nSOxRpXPRcC3svA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpbE1rDa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB9606A31A
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SpbE1rDa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BC21F01825;
	Wed, 28 Oct 2026 10:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793184481;
	bh=+NyejRjHZfvseTz0BhfelUoicHv1K/z/ho3rRiZ+zdo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SpbE1rDaNK/N+XE1cY5ESPGCB2XXwK5ofW+u8+JbgbWxQUa15n0CU8VHzSB9JC+cL
	 RPaCh4WXUFl38xnDxrZIR5x5u3Z9JqdwOEKtyXWv7onNzjzEhwRt8oL0TOgRKbIhzF
	 iX65+QTy1qQ4UEaBXSyfsJSY8i2FlE9aYaQjcb/GP+TZQJZBbbIAKUxPhqxPsoVz6E
	 2NfxUYYy4AqvIs2MzLKoVsQIufUjZvgljoWlgB2BAEMNqOoszMOJXMRzFjEvuk261o
	 V7cZqZHyJETkmX+OMV/IRIC40kwRbcpk5mpyoUl2Pdg/MWB8cdO3ZFIoH+lLlNo+DM
	 uzipx9eBi0eUw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
 lvc-project@linuxtesting.org
In-Reply-To: <20261022054454.238343-1-dmantipov@yandex.ru>
References: <20261022054454.238343-1-dmantipov@yandex.ru>
Subject: Re: [PATCH v8 0/3] Last remaining Roccat HID fixes
Message-Id: <179318447271.1921288.13099676877524488401.b4-ty@b4>
Date: Wed, 28 Oct 2026 11:47:52 +0100
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793184480; l=1035;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=4mlF/s6bidcS5WYQm1ycXBRC6zNehnPKltdzQg/QHf0=;
 b=wOGnTvD6JCwWOUh6pwhKjj7NViFYmDOr9Xkw9RO9u3JWgBdFDva0lHTGDxqfMk7HzV8dB5MqA
 3mGaNF7IUkECJ6ACgrmeuTVaBbYPEtoqhwcS91Y07NdG6QAJtjeJtnN
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

On Thu, 22 Oct 2026 08:44:51 +0300, Dmitry Antipov wrote:
> Last remaining Roccat HID fixes
> 
> Since Sashiko is strongly concerned about possible races, here is
> a bit more conservative approach plus one more fix for possible
> roccat_poll() race against roccat_read() and roccat_report_event().
> 
> Dmitry Antipov (3):
>   HID: roccat: use atomic_t for device status flag
>   HID: roccat: use kref to manage device instances
>   HID: roccat: avoid unlocked report buffer access in roccat_poll()
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.4/upstream-fixes), thanks!

[1/3] HID: roccat: use atomic_t for device status flag
      https://git.kernel.org/hid/hid/c/6569d814fa49
[2/3] HID: roccat: use kref to manage device instances
      https://git.kernel.org/hid/hid/c/be90794d15c6
[3/3] HID: roccat: avoid unlocked report buffer access in roccat_poll()
      https://git.kernel.org/hid/hid/c/8343dd786b47

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

