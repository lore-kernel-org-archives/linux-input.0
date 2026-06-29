Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB203F823C;
	Mon, 29 Jun 2026 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782723259; cv=none; b=Nk3YxqauEbauvjo59iQJNSjc1CHUb3qZxLtaU2OWJC5tBJKH3Usa1WhA6tbIdrjjw5Bxo5Mtm77ilKXr5p961igf4QU2qM2u5rUSR/4nyWxDX2q6XArYoX9B0xkMaLEF8m44PWOEjok6ulAa/YaL0GU6E04aOb4XJTHqYAuqHPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782723259; c=relaxed/simple;
	bh=+J+6hcyvBqw6Jdg9LMTyxnkGWY07PkNt3oopqTThxVY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EplgCUltfqkLGSAK2Ov3f5u5OlrVwlQ2Qs90TuGVs5XIBztDq1bm43zgT+BYjlZ5UhjpZtyiek+KHDbqBpQO6ragUPTXJeUGRIRqTq5/RymtKum+MJy3r6mJNIrBEC9VxyMkDEx/a32pB0PtwPKjnD41+Rpd0hDQ0x3AUTD9Phs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwK6xEKE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwK6xEKE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4691F000E9;
	Mon, 29 Jun 2026 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723258;
	bh=CRn4DkO5EAYqnIe8Qvm7cGhkqGFLvITkfXbXzVXIndk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=dwK6xEKEvrzYS9zcMG94zVjgXfdlj6gV+Uaq3Yt4BbBTJRoOuPqq1FG9yLf0yjAN3
	 1mNO3yRXORIDCQXVy2SFX8sB9ZXSS6JLyLUGW4IxymSMcFqzztV60wfmCSJ2XOZDEF
	 OrDIKHBVe9g6x1HpJhmtclC/7VDsw8v9JkL5itV1dTtkFDThg4zoKhQlqLqPpOdFNk
	 Fdouy95iBbD8bEyB/Lm8Ffp5HPnwR1zIUeKcu68c1JqRrOp9/Aio1pfyngtIIHsGcO
	 hndErYfMbAeQ/9HTgFajgl+NY41BgnX1GcilzoeKDIcneAGqcMlJ76a2jnREAV39m9
	 N9mMOwv31XTUQ==
Date: Mon, 29 Jun 2026 10:54:15 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Ruoyu Wang <ruoyuw560@gmail.com>
cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: avoid copying Bluetooth input reports
In-Reply-To: <20260617072035.3373487-1-ruoyuw560@gmail.com>
Message-ID: <qrp089so-6r2o-06pq-3424-n602rpq89sq9@xreary.bet>
References: <20260606040344.4-1-ruoyuw560@gmail.com> <20260617072035.3373487-1-ruoyuw560@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 17 Jun 2026, Ruoyu Wang wrote:

> wacom_intuos_bt_irq() duplicates the received Bluetooth report with
> kmemdup() so that it can pass 10-byte input report payloads to the
> common Intuos parser. The helper then copies each payload back into
> wacom->data before calling wacom_intuos_irq().
> 
> Avoid the allocation and copy by temporarily pointing wacom->data at the
> current 10-byte payload while the common parser runs, then restoring the
> original report pointer. The Bluetooth report parser keeps using the
> original report buffer for dispatch and battery parsing, while the common
> parser sees the same payload bytes as before.
> 
> This also removes the unchecked kmemdup() result from the Bluetooth IRQ
> path.
> 
> Suggested-by: Jason Gerecke <jason.gerecke@wacom.com>
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

