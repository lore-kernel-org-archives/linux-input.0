Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766986;
	b=fJYaIlWC0S5aAOgR14DjS8LcWS8LZoPnJe8ui7lJ4gMX3HNua3B+SFiw9TKGD+KPiG0u
	 GC396K5Hh/yy1DjPc7CSUZYIUcsp/4WUvnZwGaEm+A611m8zFBr+u3B4lFYL/4uD6uwUo
	 nP+3jLmUK9/BXcqcW6SHw7lX4m0Q6dkW/SXrGfIvSUATn7+JzqOxaa8mh4Z3BShQVk/xT
	 TeeGGqoGPeMwpfIDSzldMLreV+ttsL7yescb+LG0uFof0+tig5a7aG/3sUgGmEs3cUYBM
	 6UEMshY0WMmt3uTtkkiyie8KTOQO8KZhs45Z3OM6BZUdd8ydRqo4z4yFFi0yO3t8HkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766986;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=MAMaxZoMs8CgagnYDqjvxS8twJBIZGh6zWGDLjJib5o=;
	b=Yq2qe3ZuhzTimmJFdrr0jgcAQ8Zd58c5sSa2HHuTzJQuSGPxlNglWzyOPQvpBonm8aMi
	 6TsSPrth4KnJCkFk0olWswD1sMD0YX62J7AMvg5nSAHe8gyzo5/EPSZ+GWHN8ZlXWRimB
	 +8rdYAaX5sEhVt9ISdaYi2OEPBHiDytlEURrWaXLmuuWs7dCWvm5G2wVOhzDr8I3VvokH
	 cZ9kAI7S5R7OjGm+b5tGCuhyDM09zyX1YJXBOLydPV0ljiw3qc/AMADjaJ2txlMmmWcs5
	 J2JNNG9XWezqfMy8kEVjk/fTPOcJScCETBM1ne4K6M2CheU1QopJjKJEx5XCQJkX+xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOA09vyv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58767606A33A;
	Fri, 27 Nov 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOA09vyv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2D51F00929;
	Fri, 27 Nov 2026 08:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795766986;
	bh=MAMaxZoMs8CgagnYDqjvxS8twJBIZGh6zWGDLjJib5o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=lOA09vyvKpmxTGFVml2vkQE/QtOMagKPFQqllLqDD4QcNJrfgARRKfqTALhZUcWgx
	 IOjp/69dz3+65kZJP6IuCwfwJlcVVkLLYkQgmNdf3pmKfSMM4Bf2u8PE27xOkddvgY
	 JUrvkfEX3FnF4OLFAK/iiMPk7uxzdzpw1fhZiwgRjlaGZQ1w3D4xfHHJlHZJyCK98H
	 XY5qZbcFnryxW0gFBd8ILDzFUkeEvf98XZGO2gbl4BaC+nnkqFmALMsOL82NCRQg8N
	 ziuHFv9u7gxvrSDBZn65hY27sz5e3/vwqX1CQhlARkjlMbtrvYNvy07nB+9VNPErHl
	 F+gusZWoPLLiQ==
Date: Fri, 27 Nov 2026 09:09:43 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Emfox Zhou <emfox@debian.org>
cc: Even Xu <even.xu@intel.com>, Xinpeng Sun <xinpeng.sun@intel.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-thc: raw spinlocks for
 registers
In-Reply-To: <20261118065704.672557-1-emfox@debian.org>
Message-ID: <3no60948-8638-992o-pq37-32986916r889@xreary.bet>
References: <20261118065704.672557-1-emfox@debian.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 18 Nov 2026, Emfox Zhou wrote:

> The primary interrupt handlers of intel-quickspi, intel-quicki2c and
> intel-ipts reach the registers from hardirq context. The map is a fast_io
> one, so its lock is a spinlock_t, which on PREEMPT_RT is a sleeping lock:
> taking it there is an invalid wait context.
> 
> Ask for a raw spinlock instead. The accessors only touch MMIO, and the map
> is fast_io precisely because it is used where sleeping is not possible, so
> nothing else changes.
> 
> Signed-off-by: Emfox Zhou <emfox@debian.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

