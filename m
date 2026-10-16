Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7261F4DF4AC;
	Fri, 16 Oct 2026 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164841; cv=none; b=DwQ+xAWEQyfBmrn/xs10WBzI9PN/VnJS9BHghXxuJ8c6QEARLkO9+vK3Gs59N4hLKVkCwTW+r6/rj/wb+ePRAeMztSBam8ioFiS5R5fP/DGvXCDNusTF3oYYyApn4e60bf81L6k5eK6RPa7/rZEsHpeVsLhMGVi5WyTdDw6wQ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164841; c=relaxed/simple;
	bh=sETNLtKYVIgvX6ysWodANn/cYHZ89DFRmyDKzRb9spE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=XpKzaZIz2JeNf6J9oXKPjO9HP3nXTLDDR52Kcn+Hy/gubsX0BPuRJDS/NXD1XkPqGs8FAMt8vE7VryiFMimn1BW/tH78S7TgTQ0IdM+uHAjdm4jhiJdcwFqtxIj+79iDkcmybCVC0zLavKjbtmlaWXHf4TEUPnD+UWOt7iOwWuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPINw0KH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPINw0KH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716BC1F000C4;
	Fri, 16 Oct 2026 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792164840;
	bh=g12RPAkUhN6F/vsgmV670xCvS7Raw3QlamgkZuaHpys=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=RPINw0KHRtawvRpWSUfN//FNoW5bd8lgz6UB9Ly/aHPoxfB+oWOQ/Ccvp3DMTkEUS
	 bToQzp5Im3WJwmqq2odOlRRN1wlG3damOk9fvC/C7v0f/r8wCTYaaHP9oPvzbCHI/+
	 vJcEIhH8OY/pqED2T62/rFwnYxoYggfEiCCjO3rfzSrnzemToRmkoOT+rimPQqe8ae
	 exlb3pbs81gFtvUULuOvwqXGQzbVWz72Ucu6iFZ91D6c0WW5LRcXU7F887cOiTSHn/
	 KaatQxZhvOQK8NkIIMokZjnx9hOwjLhi1eP+oUgI3YYbPW3ZFfD1161oFapFs7G693
	 Xv26P9PLsI4Hw==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] HID: bpf: add __counted_by_ptr attribute to
 device_data
From: bentiss@kernel.org
To: Bill Wendling <morbo@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, bpf@vger.kernel.org, 
 codemender-patching+linux@google.com
In-Reply-To: <20260923065612.2707049-1-morbo@google.com>
References: <20260923063114.2683575-1-morbo@google.com>
 <20260923065612.2707049-1-morbo@google.com>
Date: Fri, 16 Oct 2026 17:33:54 +0200
Message-Id: <179216483464.1243348.6374444567336475731.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792164838; l=1139;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=sETNLtKYVIgvX6ysWodANn/cYHZ89DFRmyDKzRb9spE=;
 b=tmZk5QW/9BOZ6A9Ay2Offn6euZSOm8Mo0yCSTa+ZD/C91d++4gfgT/mmwmavWvZFDom5bC8fm
 8pcxyubnAMQAXl2MOj+04J+f7OWoFRaQT4j0uAi/QtTJmASVudP2al4
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

> The 'struct hid_bpf' contains a 'device_data' pointer field (of type
> 'u8 *') and an 'allocated_data' field (of type 'u32') that specifies the
> size in bytes of the allocated memory for 'device_data'. Since
> 'device_data' is a pointer to 'u8' (elements of size 1 byte),
> 'allocated_data' represents the exact count of elements allocated for
> 'device_data'.
> 
> Annotate the 'device_data' field of 'struct hid_bpf' with the
> '__counted_by_ptr' attribute, pointing to 'allocated_data'. This enables
> bounds-checking sanitizers (like KASAN and UBSAN) to detect
> out-of-bounds accesses to 'device_data'.
> 
> Because the count 'allocated_data' is always set before any access and
> accurately tracks the allocated buffer size at all times, adding
> '__counted_by_ptr' will not cause runtime panics or false-positive
> bounds checks.

I've applied your other patch touching the same area (please always
regroup patches touching the same area into a single series). Is this
patch still required? If so, can you  respin it on top of for-7.4/bpf?

Cheers,
Benjamin

-- 
Benjamin Tissoires <bentiss@kernel.org>
