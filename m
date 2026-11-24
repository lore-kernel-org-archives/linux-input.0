Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795483943;
	b=vUUvqJDuBo5HJVMb7CJIvG1sbcwi56o+NZxv/sWub2P7p7GtsoWHyAs+mObdGqUb4gx8
	 JXLVrOOzoo8FlkgVNmb3mjthP0VAStlmEVzRgW5yJWiPaSuaqUs2O7aQvVzNW+VnwkmH/
	 hhz/z6uP6SwlAFM1jsMbHGo0mynl5nVBiXwfpC6Z4hUn2NDGGT20L88aP/HUcnO+U3JN9
	 8MAYWMZV/OznmtDNpg7guElIgqEq+ECFrRNxm4RKCB8s27J/RfNQAHTiwYxJ57GxR1OXc
	 DZC2+m5FFPwLOcPVmTeR01pvMIMq/pKamegNiOs0vOlW+nuIEln3K3YqNdpcixZhYFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nAKiNemk2GJJwDYP8p1zRplDTIqlR1poJkDMNc9BGdA=;
	b=kFvPWJuQP5mkjl1LriBiz8qjwV7dz1F4gw+YJjx4153UMYSd5319IOGiJwWq6ZRc0xTw
	 dxJ56Q+uG9ncHPTmIUFHHLDt8oqltrLO0xeAIvIAhyWcb8Pnsy/HHyCuQYrf/Je7OqHyv
	 2G2Llq6rY0Lke6lxUY7+j3wtMdiY1I9zc0x7WilgktEXrC65Z5xO1P+g+lNoVNu5ggqKd
	 RIC1cKbCiLWVDskSKwegJpqQGGOT088Rmg3UzL4dnHaPZaztrif8EMV0pOaYTyMkEFdp8
	 trd/dCaFiD3yxZOOU2qcsPV9GRLf78Wf0BZ1Nwn25E1mZ4x0cC85e3H7pw9Ndq6RiyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fgZSWi0C;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03BC606A331
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 01:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A03BC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fgZSWi0C
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14394530ec6so5736361c88.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795483942; x=1796088742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nAKiNemk2GJJwDYP8p1zRplDTIqlR1poJkDMNc9BGdA=;
        b=fgZSWi0CfA8PjW8babAeGvHSPwaWYbL89BEAHJy+ktqIoYDUEZME1smhCOfnnxW0+v
         AFjfxviZRLBb005A2J+N/u36TKD+8tMxY/1SOdJbY7xYvu/hKN6jekjXk0e1gaIPmd74
         QPSr+c9G1gHQukDwmEGlBUeunAbqz5t0Vbq4EqemoslU1kmBx3b8CA+HoBhDsv0ArvYq
         U+QjlfzW1u1efaiUDglKRnzWqaBCiPSsx7ev1Q6t8ZLwrCeywfWkt5bYPmdbipveu3Tw
         bK8aaKxc3z/js/1HAmRkiAQn8uwcnzE+jUkhP05Jyge0CHDjEMfxgwhiIi2bShYoInug
         rYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795483942; x=1796088742;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nAKiNemk2GJJwDYP8p1zRplDTIqlR1poJkDMNc9BGdA=;
        b=B5onzd0wlaxQwNC7i+jZM+93ZuAmgo45yoID2OxdsBNTAPZ5Ez70wwQ2OSSbQJ1YXS
         5TXw/tzAnialsdbHpOwHkC+hT5fvOAbPuvjOq4KiGtAlRGQ+F6LIZ8uZTHIAwmtEOvc/
         DSX5aAITapLeNev86HCZ33cch7fSu+5FdXjJ4J6NBbqLAbVvVYUsJuMD6s/YK1m7DwYk
         9YyaqXed46QjwJc+W7Zy0d1vyM8ZcnEQ61Elbfp2qBIeWXkAMbKWSXpwBozAV2tSdTNX
         xh1GCLz3AYMUfGw8S3j+5X49mW0HFQ3mRC9+cIN0SNGazehS4UyioMvMTOun8zArUQNR
         jxaA==
X-Forwarded-Encrypted: i=1; AL+hErGHjTc4KhLneiH1w7mwe2Za9zX9F7NFKj/3Kn4/jxmadAbdHNja5uOhls0pT5IRIlYpTwYNgBvI8MtY3w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OV4qC0zgLF2I8lay24L/0RgM4IIJKWzRj4zhaW6Gb1dpMvBN2
	3HDZaEPgWCg2GKpCV1uuCLEg5p+9xU8jHdV8M/guAnnxMnkvBUJxW5fs
X-Gm-Gg: AZFdTZeOnSdekBOA5gAsdJRn48x1LgOzEHzX0ljuVzL7mihjZaeCLAwEcXVgC3SFDlH
	tDnu7MVBq1q+hLVK5iY8nCLDdRCO9dOb4k1ruzV3Hq+u2wzh5jyvHjHnaiTyjVHi51PEUN160sy
	P4lp60EUjEkOSNm+HYWTn//SxzqvcfenNagaQMzSSgt8J2v0d3zbeYAtm2iEnoPTq+OL1NjYxlf
	NPkN9H/PQuvDkRHqj+pAdiKXuOFgTbGtpRbEPtad9lIyWDKToDcZ9rxQ/E9fW2yX1WxlvqjM3D6
	Q73xtpiYIEihIRdRfvclHDHPr9O52cTVNq6Ttdtdogl+5gGvR8iv9Xy4EFYvoDUdP+VtP8NwLg5
	mF4OEi+62KnoQLohGUL6r1DVSQEYdBI7EUPZkYd4RYPnoua5onwRgxEpJRqmrgyKok17eO2HoJk
	e6GQEcWDxfr06HVyFRli4qiqus9UI8aLAMp9a5WDfpvyCGvnkz6p27vcDduOmnf08Bm03emyLUN
	QArpn8gIPp7iViLFoOL1vgpc/Q6aq3n8SPSQY/BSugeiSYcSXh9N3Pj0eX/MxIum7JmiAOoeqga
	BcDteht+Fnk8dInq+RDsMIgqIbHmKcKI8ELKKlBjzsiwwWsPjhKCvl2mBW2ONBNKNRCsLqs=
X-Received: by 2002:a05:7022:f90b:b0:18d:5ef2:1644 with SMTP id a92af1059eb24-1b5568ebfaamr12146790c88.30.1795483941534;
        Mon, 23 Nov 2026 17:32:21 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm34017451c88.6.2026.11.23.17.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:32:20 -0800 (PST)
Date: Mon, 23 Nov 2026 17:32:18 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: xen-kbdfront - bound the backend-supplied
 keycode
Message-ID: <awTpHuucnYYCHdx7@google.com>
References: <20261106014957.4130059-1-guozh23@xiaopeng.com>
 <20261106020217.48481-1-guozh23@xiaopeng.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106020217.48481-1-guozh23@xiaopeng.com>

On Fri, Nov 06, 2026 at 10:02:17AM +0800, Guo Zihao wrote:
> Keycodes arrive from the shared ring the backend writes:
> 
> 	if (test_bit(key->keycode, info->ptr->keybit)) {
> 		dev = info->ptr;
> 	} else if (test_bit(key->keycode, info->kbd->keybit)) {
> 		...
> 	} else {
> 		pr_warn("unhandled keycode 0x%x\n", key->keycode);
> 		return;
> 	}
> 
> The keycode is a plain u32 from the ring page, while the keybit
> bitmaps it is tested against are sized for the KEY_CNT keycode bits
> declared to the input core. A backend that sends a keycode at or
> above KEY_CNT makes test_bit() read past the bitmap to decide which
> device gets the event, and no keycode at or above KEY_MAX is a valid
> EV_KEY code in the first place.
> 
> Since the event sits in memory the backend keeps writing access to,
> the keycode must also be fetched exactly once: re-reading key->keycode
> after the bounds check would let a concurrent backend write feed an
> unchecked value to test_bit() and input_event(). Snapshot the keycode
> into a local variable with READ_ONCE() before validating it, and use
> the snapshot (as well as the already snapshotted pressed value)
> throughout.
> 
> Ignore keycodes the bitmaps cannot hold.
> 
> Fixes: 4ee36dc08e5c ("xen pvfb: Para-virtual framebuffer, keyboard and pointer driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>

Applied, thank you.

-- 
Dmitry
