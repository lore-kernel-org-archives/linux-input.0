Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792916442;
	b=mZijb5SsgFagGJCsd5HfBXcOr8fLhk6G/aDVhGJuSKcdKOiUOvyzfcCmEvRF7VtslFRM
	 GuprS7a05n3DPEFePQxwo2W69Yxeg4QTPRHnzsNoe3p2RwDMLEZjo/jD/PJlhvIKDfXc6
	 11xrpgZzTknCYu9tW//A40nXKikNp4/XeJ642TumTKk+zQ7poNUsbbgrK3IMAHn9FKpmi
	 FHnweTtlPjEZnO3CaZp4cYcg4CJGPuEzBrPtbWqWDqCO/mgQLWbNJeaZf9soz+XxzdDyM
	 8gtdPLAwahA+Vs6N3dK84F0gmBiutAXXiY1EvTNUvYVGTLK4Rqr4i/slTJrPevSETvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792916442;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=IfC9o90PUIKKuzl9JaxPXUxb/d/bEdtCxGhiq3z6IvQ=;
	b=Iw3xyKbJpa4JiCTDGSfKmink8nPf5bgX1qS8hTj0Tqlr08kV0dZcSyravKA+U97F4NmD
	 odx95D2Q3PASx8XBr4iTXfCyZSI1JChN/F/YtDcljClZSyGSg+0vsufSW3KNG+VJYADs4
	 O0BtPzdjEO5cELMDuR59BzCv8XIMOcRVvFkWnqDn1fUKJ0rJXyrfTEnVpqIA4F+xkAXcG
	 f01cKNpRXdgjAjZL4SQ/Srb4neK5tba6q8KgDnd07DHQoUvaiatSGipLXfoyQvO9ENEWa
	 LgqOSnRLwE8gMx2iC+XXUJBfn+hc+6lHOEQ0ryUgPFQ6BrxnpZBg9MgdYJFocOs3wzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=c3w6wi0z;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C0F606A31A;
	Sun, 25 Oct 2026 08:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42C0F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=c3w6wi0z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792916438; x=1793521238; i=deller@gmx.de;
	bh=IfC9o90PUIKKuzl9JaxPXUxb/d/bEdtCxGhiq3z6IvQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c3w6wi0zBgZbwsyDczjunslZwqly0lfMokVSmC+YOR8TaYfPjLOzIwy+fNfg8QVM
	 bzrMF0bV4wP9k+/FtjNWuzGLOrgI6MlaYeDAOlvxVeztmjwGxStZmWZ9LM+2FzPV7
	 IdoAvHIimgCVzcOIojj+/0R18qQCX1NksB8/NXAEWiHRvZvdYdMHbld36sj27BEWs
	 g17CGh3irC0XCGFkdZJjVBNCi+wriwHJOY5/I89Cq6ZE+CKakn2DFmnjle8VWqGb9
	 8/5VpRNRd9jpWkvH/slG92E+20MdEjLOPr9wAdVGJ4NFD1SohcGKgUPduQfcjry0I
	 wtOebj01Mnb+kpU26A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1wjtgy3BhC-00kmao; Sun, 25
 Oct 2026 09:20:38 +0100
Message-ID: <76cddcc5-2cf8-40da-9139-e78353975e41@gmx.de>
Date: Sun, 25 Oct 2026 09:20:36 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] HID: picolcd: Avoid framebuffer last-close
 deadlock
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Aveline Noir <jm5905938@gmail.com>, =?UTF-8?Q?Bruno_Pr=C3=A9mont?=
 <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <CANOyQmGfmBdTRaEamVdGuMBToVLeXGi6qLrnX=xkA9acsL9TSQ@mail.gmail.com>
 <CANOyQmHF-gjvnLqTGEVBcU6+AWj5ha+7tJhE2E_Cv9aj-gRXdA@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CANOyQmHF-gjvnLqTGEVBcU6+AWj5ha+7tJhE2E_Cv9aj-gRXdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BDj1BsVJZmcxCvp3CBvTsNUQhuVCiCQvbjKfc0DkrfEkj0WXv/W
 UeVHtnVRA7X5TNwYIYwRiF6SM4osi3xksE7CK3G5u6AMuNvLtaFMOF9x75LJQNZ/bUNbey+
 nrO0VtQMvvSJPx7BlMnoVXYxj+WgfxPUEvhq+GCd0JVfMkaQ/RsZbJdAC+OmMWKKEdGLl01
 +9FcqCSg7esXKmKT3JK3A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:K+M9rDFwuTI=;o8OzUJaHBUczPfk/kacgZgLlJ7y
 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
 efS6CXc0Ku63gCE9DdjpcI/t

On 9/28/26 18:17, Aveline Noir wrote:
> Closing the last framebuffer descriptor can deadlock against PicoLCD's
> deferred update worker. fb_release() holds info->lock while waiting for
> deferred work, and picolcd_fb_update() takes the same lock. Lockdep
> reports the cycle through deferred-work completion and fbdefio_state->lo=
ck.
> Repeated framebuffer open/write/close with concurrent device destruction
> reproduces the hang in a PREEMPT_RT QEMU guest.
>=20
> Use a private update mutex in the deferred worker instead of info->lock.
> Take it in picolcd_set_par() as well to preserve serialization of pixel
> format conversion and framebuffer updates. Initialize it before exposing
> the framebuffer.
>=20
> The test with the preceding output-request fix hung in the first round
> and reported a circular locking dependency. With this change, all five
> rounds completed, including 29 successful framebuffer write cycles and
> concurrent LCD, backlight, two LED and UHID destroy operations, without
> BUG/WARNING. The original syzkaller reproducer and persistent-open
> framebuffer tests also passed again. These are bounded virtual-device
> tests; physical hardware and suspend/resume remain untested.
>=20
> Fixes: 3efc61d95259 ("fbdev: Fix invalid page access after closing
> deferred I/O devices")
> Signed-off-by: Aveline Noir <jm5905938@gmail.com>

For this patch:
Acked-by: Helge Deller <deller@gmx.de> # fbdev

I'm not sure about how to handle this patch series at all.
There is still a review missing for patch #1.
Shall I take this patch (#2 of 2) via fbdev git tree?

Helge
