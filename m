Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D36314D37
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 07:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593554; cv=none; b=HehH9wpIvBZ65G6MZmaoMghn2MdrpkGEvz/hpdQK0AsQ2nHFRP1gH8qKLOHlyOYYvjZM8RnJrfUVOquPdeSzZGQsAn8seT4iCuhBAeFVXuT2bEu5R1UXIMUguuxMHmKK8AZQrY4AQlg8ktOxBxK0V8CFTKOF/8c1hzzMwEOC+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593554; c=relaxed/simple;
	bh=K4TY/wMtQQHAGTe+nAtmGAk4JRdsKv0zzLJ/ceEhInA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIbHpsjL39wpNtsBBi02mNu720TcEcxy9LNgWhRDD8dVwj2ogk2rKmtWjjr5Fe9gixNvEevccyrtTCrdo6SdihkYhmlIpE3prDxKyev5S+2RLLJu/lbJXVir5oz5z4iPcUHcbqByMyw+Sy9c6EgXhXyaozGV7X2ohj+7tIt4enY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LBub1Rdr; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LBub1Rdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781593540; x=1781852740;
	bh=9Mn5QzXURUbaIYZbEKAspbwSL54DUxJK1laLx368P+s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LBub1RdrBtpG5vmnvT29fJLBWPEp/pHgRghDxSTB9OESwXgHO+tb6DO5T/7LLwHTx
	 zdx2hr0JlMbQQaMUFeU1mfq/fXuYliNgF4fHGmCeL6sxxMf96+I/MQjP5rQTjo9rTs
	 2oRKD8hocR1nLry98ux5bMeZ1poaRcZl4komNLnlVxMEntzPzR5c3DlrpvYO1+C3LC
	 0ufnvXiS2LjWvSkJcp4c/cCRDN+cmMFqH+mwCjfixY62RYbLgEIAwPVUe8Tla7+Lla
	 solX/qgBo9Y4jlYqOrFE+nimC/X8/RlG2eFc61bDm/C9TQ0VpsJo97fqfMtaMPZumc
	 X98zPq8HMCZig==
Date: Tue, 16 Jun 2026 07:05:34 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-input@vger.kernel.org, Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] Input: mms114 - fix touch indexing for MMS134S and MMS136
Message-ID: <20260616070529.156342-1-hexlabsecurity@proton.me>
In-Reply-To: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: c11f723b3e0b42ae08499ad3047c45b8831ba187
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

The indexing fix looks correct -- deriving the byte offset from event_size
instead of leaning on sizeof(struct mms114_touch) is the right call, and th=
e
cast is fine since the struct is __packed (no alignment issue at the 6-byte
stride, and the consumers only touch bytes 0..5).

Two things that might be worth folding into the series:

1) Fixes: tag.  The 6-byte event path for MMS136 -- and therefore this
   stride-vs-index mismatch -- predates ab108678195f.  It was introduced in

       53fefdd1d3a3 ("Input: mms114 - support MMS136")

   which added MMS136_EVENT_SIZE and the "packet_size / MMS136_EVENT_SIZE"
   branch while the loop already indexed with the 8-byte struct stride;
   ab108678195f ("support MMS134S") only extended that branch to MMS134S.
   So MMS136 hardware has mis-parsed multi-touch since v5.13.  Tagging

       Fixes: 53fefdd1d3a3 ("Input: mms114 - support MMS136")

   (in addition to, or instead of, ab108678195f) lets stable pick it up for
   the MMS136 range as well.

2) Unbounded packet_size.  Since 1/6 already rewrites this handler: packet_=
size
   comes straight from the device's PACKET_SIZE register (a single byte, so
   1..255 after the "<=3D 0" guard) and is then used unclamped both as the =
read
   length

       __mms114_read_reg(data, MMS114_INFORMATION, packet_size, (u8 *)touch=
);

   into the 80-byte touch[MMS114_MAX_TOUCH] stack buffer, and as the diviso=
r
   for touch_size -- which is never bounded by MMS114_MAX_TOUCH.  A device =
that
   reports packet_size > 80 overflows the stack buffer on the read, and eve=
n
   with the indexing fix the loop still walks past it (touch_size > 10).  A
   one-liner before the division closes both:

       if (packet_size <=3D 0)
               goto out;
   +   packet_size =3D min_t(int, packet_size, sizeof(touch));

   This one is pre-existing -- the unbounded read goes back to the original
   driver -- so it is really a separate patch in the series rather than par=
t
   of the indexing fix, but it seemed worth raising while the code is in
   flight.

Thanks,
Bryam

