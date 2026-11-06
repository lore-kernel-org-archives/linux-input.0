Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000016;
	b=BA9WwOS6AiSY7XMV/fP2aYKzSt1+rimlbWM8i01IcmFDpDhtNI/MmcbicWXyFCFjJ5qT
	 qlpc1VR8zra72lV6JtqTtnDdFIJ50kp/N3OfxHJkd3OH23o7tKoFDfMfB/8vCAXBHKsGf
	 0yP37jBLyuFCXKmnKZnctcTj+zYHer3pXkCeokq9pbnZe7fVhzwOkTxbZ7ggVEI9ZdfNg
	 4CJLKXqvLSL+G7Tq19RngxpiDdZyhQtYUPJlT4wzoGTCv9AgSiMrWNuAHf4+Xc9y5V4fW
	 UhcplPSH6w+hmZoym3PwRL6EvADjQJvkPYNmIQh/xM0D2LszIvCJrCTflO3pI+7LVsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000016;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/7WIUwQsHsrE8kG3FNYzJsoVNXnLuePlN80xSjXv/fE=;
	b=zD2n1Mqc+q5uq3dRN9Ecd4+0mHvpK4m3HZ9bWq3W7YdyTYxo2czh6ElRTPLGiqYByp23
	 SJl//Utej2TKZaMplk2FSnP1n6Hs5Q/2MN0TqHTJ4VypFAxtDdbzNHaDVW4dx9OePvQ21
	 grpwgRQw33ADIGxSlS4wZtg3qcVDZOTEW6NUsCh4rgEv8rfFcTO6rBGJuT2D9wr8J/iij
	 lnaogJqrZErQnI7rPSsjWHMEXb5v0ADUxXlWAGfQHxnIGfKbAOjTj0oPWeKzx/7CRaYKB
	 w1xgsjjat7CdIdicafbeVRUO75SlFdWeLSPSZ8JIV152dBEM8n5/XrYbqsaH4URKAog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MM+uLXD4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C1606A329
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MM+uLXD4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B14D1F0089F;
	Fri,  6 Nov 2026 21:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794000015;
	bh=/7WIUwQsHsrE8kG3FNYzJsoVNXnLuePlN80xSjXv/fE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MM+uLXD4w+/Y8ZKRhC+FAwngJBu1ecP3Apu8bpjqykyrAJav/N3wkex5GbkCgG8KO
	 kMsWJw+XcNeiCKCWgvTZmoEi5vL54sj8JGGbCUjbtUBbe1kS1cDugNklNkXJz+tIlt
	 6abM5ZL4Rwj1agS9qTI4m2bhSJqIfQDvLzvIVqKFz/sX8whJ5dLzFqWiyKDvQJ3Yc8
	 tFgnfpjg6jjaFC5Gcck/ySV8ONMzcvkvPxsX3b9RPQ1+BAKMH2yOPDJ4MGmpusEPCk
	 2eaK+caB3w2UVa93xQwCFUzRmwz7ph8xaHWKfTXlJjJzzVCdUCqMJg3oP257M4eURL
	 ARtAJfq60KFvg==
Message-ID: <sashiko-outbox-202295@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] rust: input: add input device abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: clicedvly768 <harepro29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261106211034.401918-2-harepro29@gmail.com>
References: <20261106211034.401918-1-harepro29@gmail.com>
 <20261106211034.401918-2-harepro29@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 21:20:14 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rust: input: non-vertical crate import formatting in input.rs
--

commit d03870e71b5fd937f97b178433700c90c89f7646
Author: clicedvly768 <harepro29@gmail.com>

rust: input: add input device abstractions

This commit adds safe Rust abstractions for Linux input devices,
including AllocatedDevice for pre-registration configuration and
RegisteredDevice for event reporting and cleanup.

> diff --git a/rust/kernel/input.rs b/rust/kernel/input.rs
> new file mode 100644
> index 0000000000000..707f2af3110d6
> --- /dev/null
> +++ b/rust/kernel/input.rs
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Input subsystem abstractions for safe Rust drivers.
> +//!
> +//! Provides a safe Rust object-oriented interface around Linux `struct =
input_dev`,
> +//! ensuring safe allocation, capability configuration, registration, an=
d RAII cleanup.
> +
> +use crate::{bindings, device, error::to_result, prelude::*};

[Severity: Low]
This isn't a bug, but multi-item crate imports in kernel Rust code should
use the vertical layout with a trailing empty comment (//) per
Documentation/rust/coding-guidelines.rst so rustfmt keeps each imported
item on its own line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106211034.4019=
18-1-harepro29@gmail.com?part=3D1
