Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC4D35C1B0;
	Thu, 21 May 2026 15:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377025; cv=none; b=pxyiisxG090Quq79Y9GAwNowY0uzjNBgQb7qAO/tGfnPcpA6IAph7POT319oR2z3kUtCjIKh9fZyfiJVhPgbh/uB3jcnYApiobpJNTqUskBojvPVLj9goAZNilcprP5TVlekAj5qAZa+Nk6vVURKtMBXuGeXYfma8n3d7PPvBT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377025; c=relaxed/simple;
	bh=fafYulwagA1PLepVTUdiZ29TG0txWJ5c7m2NE7EV8io=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oz/UbV08kHsSc3zcBorYKsVR4mE6xumVQOzCKlLGTCSCP80hiVzl8LOjQwYoBhesAJuN7038zpbvVTvQyB9kr7+TPieTipzr48NG2D4eq07mCuQeQM2QaV2x82/rhJ2S0klsWcREavYrWE15RGY7MYzSqU04yreqfTnp6M3c584=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7t0/Y6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7t0/Y6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08371F000E9;
	Thu, 21 May 2026 15:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377024;
	bh=Oer5SVpL9P/4kJmSZst7H1qaYwwcuSP80x1RTJZGj3o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=J7t0/Y6NAmwfOrS7KbXPky6HGpVbG7I4DQx1Z3cDnyo7TUwB7ID6NaxITAyVRfqG4
	 ASocoCBYGK6yEo/R+y+SK/DRdy2xNIPl0UWjFX5bM7QAV4DsZJxFDuOVcDAi3cCB0V
	 ECg3bo9OACFXOHyUY6Nv/XGdh34exFULLW6BSKfJdEs+n/Qm2W9yOXnhDzh8E33pN6
	 r5JlIJCw3zvvdBJ7H0o300Ixk5MCl//XL/VaOTW1dEdqkl6J7mSpxjhEH+L6DYgZZX
	 Y4bHFgfrVP7W0TCHqop2jvtw4BHmUzekP7z9Wt+kQee5YlQE1QWZiyBXYIWc9Aq/8y
	 Q14cxMLjYpOkA==
From: Benjamin Tissoires <bentiss@kernel.org>
To: sashiko-bot@kernel.org, derekjohn.clark@gmail.com, 
 Kean <rh_king@163.com>
Cc: linux-input@vger.kernel.org, mpearson-lenovo@squebb.ca, 
 jikos@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260514125838.3307386-1-rh_king@163.com>
References: <20260514125838.3307386-1-rh_king@163.com>
Subject: Re: [PATCH] HID: lenovo: Fix buffer over-read and unaligned access
 in X12 Tab raw_event handler
Message-Id: <177937702252.1117151.7175731834832764213.b4-ty@b4>
Date: Thu, 21 May 2026 17:23:42 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 14 May 2026 20:58:38 +0800, Kean wrote:
> In lenovo_raw_event(), the X12 Tab keyboard handler reads a 4-byte
> little-endian value from the raw HID report buffer but:
> 
>   1. The size guard is size >= 3, while the access reads 4 bytes.
>      A malformed 3-byte report with ID 0x03 would over-read the
>      buffer by one byte.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.1/upstream-fixes), thanks!

[1/1] HID: lenovo: Fix buffer over-read and unaligned access in X12 Tab raw_event handler
      https://git.kernel.org/hid/hid/c/c7ee0b73c8c4

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

