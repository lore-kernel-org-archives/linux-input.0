Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818E617DFFA
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785580235; cv=none; b=q0ixbCUlMUKcc9/8f72G/l4egXikSebQmXfClzQ7Z6jqbDSNYtMBs0S0Kc/EeKZPvfLqVZ73RN7fqO7BlC35yzpsLAV9OLEb9LCnIE3ehtORDTiIjik9In11Va3Vq5gEBcvQNe4HDJHxn+weZhdIphPkT9OemHax2IVpn0QxD4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785580235; c=relaxed/simple;
	bh=ohlnl419En7WmpkldBcnOODjFe4MOBH6dlQrHo9uFdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmJYr8V3wCGy/aqzso1S0mPPc62lsxKehwTwov9WcerV1b7vvV8wSY5cBdGYHJ5UkRP1UURvtA8QgIztt5byBFeuiTH025L3sujir1IC96P9fI/N8lXES30Zk4QDW92ZMmOrdYPdCVw4KNjl51ilG9+570bTfcL8gjtNmEaH1Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAQWKoQH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAQWKoQH"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb662575d3so1029956a12.0
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 03:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785580234; x=1786185034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ohlnl419En7WmpkldBcnOODjFe4MOBH6dlQrHo9uFdE=;
        b=TAQWKoQHDPZbJvSi5CIJ5mey6UL9q3lD9SvvGH6ydLJ2tx/3FCgjmkUEPhN9dmEPPd
         tIKQ0lTjnl5deDEi++z6Lo2qNAIC05KcZOTaCeuSCQxIXKfCjwJlG006Aybc7BSeizES
         mI1j0eBGI7lNTwkG7HAuIA68egVqRktvmf0clADYmRQn2IEH14JqLlQhiOYqbQf6VFo9
         dHse9Vj4D+40Y7qOgnTPORWg2YtxS5X/lwrmhXuSRvIaewsXU5DM/DBqxaBaesUS3Pqq
         eV4GMzKA3dOAipnrz1ljLZgY0aNcFKmF7wV4ljxzzwIC0CjOHcYnfLvXh1dKSPX3y/jF
         lKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785580234; x=1786185034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ohlnl419En7WmpkldBcnOODjFe4MOBH6dlQrHo9uFdE=;
        b=mT02s/ELNz78vetxJcVfLaZ3v7QOVFwYGsivUBvSS6G5Tcl48uZrHkC8sNaZsX5IKE
         onWegkHaQ5izfkRmLa9m0Wy2THZAv+h7m63r6/7lMwulpjAI2LUhXKS7fuDzGEnN3/o+
         XF8VBthT1KhVNf6TdiHkZsT+FTw74K40ruTmSMvib5L1BmZ/hX5XYlZLWhq+WezQMwS4
         6W80OPcmFtABDrx/LUhRkO4K5BTt+p3Km2PKYl4VvyR2i0drDjU62BKuql+vFrV9miOV
         RxAdGlF+8ST/yMLKxh1NfGatIWpdEAfaTl3JFOUk253UhcZrd5kb6zWHhZwmaoAms8NP
         lQ0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq/eG1ctL2cVQdu32Z/O4YPn/u3kgYw5QSUFkm3NlW9kWluHh42Sr9O1Kkr4cHnBEZuQ6mGP7b9WlWSPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7nfhbo1RVuvDx4bn9gAm2F6gwByywQiuVN5cqGecDA5z3FTa
	dWaDwv5xEj7GM7sDp5lGadFHPFgdT4GI6PsmzG/auVCxiKf2Vwwd2y51
X-Gm-Gg: AR+sD11KhJPQBC5vRGf5NFqtVdDKCS/79jtUXfNfbk7eHew/8ly2Ztl0Ie6/rby4P7n
	Il30f4Z0gpp+8m06a9WVACVMF3rrX4SH9f3O4sRp7PzA9HKoivxOHUS4cklyMmrtdnjR5cOGf6e
	bDVkDXK1TiIcOXa5fS/F+gdenjJk/sBasdUza3MuV7JKdGB9gU9r3TCqmDkQ3fNM1K+/MnwzDRq
	KFtqAnVEdHREaNXbkgAHnjVILH6GrAm5+/zMdGQHAGRZ4OlgL/qFXAUhehAMYjm0Qqf5byPqTnj
	zyhtpRbOkTGqXI3+HSMMg1866uROQ5SIv7HCE/a9+t2HJXc+NJn7d4B+RqnPCa2gPojP+LKfYx1
	XMRMhS5sYZW8eQcCGGqDIiFFTBdUaDSPqDBAJZAUKOCwDU3L1dNKHxvgODr71C4Ni+PPcf0nLvW
	5AR2CSaoTxbRk/EFma7B8pbuYd3aKMcC3XWzoze+2pp4R2hqkzw2RtfbR0FCLFeQ==
X-Received: by 2002:a05:6a20:914a:b0:3c3:a17c:1f77 with SMTP id adf61e73a8af0-3c92aa2ada0mr2878840637.51.1785580233796;
        Sat, 01 Aug 2026 03:30:33 -0700 (PDT)
Received: from xiaomibookpro-14 ([149.19.17.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18e114sm27560090eec.28.2026.08.01.03.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 03:30:33 -0700 (PDT)
From: Zhefu Zhang <a723356@gmail.com>
To: Andrew Zhou <zhoulol888@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhefu Zhang <a723356@gmail.com>
Subject: Re: [PATCH] Input: i8042 - add Xiaomi Book Pro 14 to dumbkbd quirk list
Date: Sat,  1 Aug 2026 22:30:12 +1200
Message-ID: <20260801103012.4142-1-a723356@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718122437.11112-1-zhoulol888@gmail.com>
References: <20260718122437.11112-1-zhoulol888@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

I have the same machine and sent an alternative fix today, "Input: atkbd -
skip deactivate for Xiaomi Book Pro 14's internal keyboard".

On this machine atkbd deactivates the keyboard at the end of atkbd_probe();
the EC acknowledges the ATKBD_CMD_ENABLE issued afterwards but never resumes
scanning, so no key is ever reported. Setting the existing
atkbd_deactivate_fixup quirk avoids the deactivation and the internal
keyboard works.

Compared to SERIO_QUIRK_DUMBKBD this also keeps the keyboard LED working:
with dumbkbd the driver never writes to the keyboard at all, so the Caps Lock
LED is not available.

Tested on Xiaomi Book Pro 14, board TM2424.

Thanks,
Zhefu Zhang
