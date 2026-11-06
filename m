Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988511;
	b=ihcFIEa9PqOnoRlUKpAKqYjcvxI8wapd+hlK7Lz7a7uAslnvD84r7xecCcoYYXtBa4Kh
	 FFisMygob2PqfWMZZueD4ZpUPtQ5ZJNYE2fXneK39A0q8JXEFlEyaWWbjzGKtBC6wQNpV
	 3k9CfiXC14zZ0dtfT2mnjYx2vb/29XdssEYkOKyAk96erSZ22OqZKKtiFllF64qiQ7M4v
	 5RoKOVCmkeECjRJdvl4nEm9zWc3zOOyHWxpKvA2vacpv7p764bDzSMm8JCqhg9pI2zBe3
	 1F4v0T0u/Ke4XNVVWsk4Uch4blUZbFVg0ao9aavZ2ERA3vXzZQpzlYpwfpxmox9ovWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=TlsbZRohfYY9Acfo1HZrz4sd0DFYcL5H6Bh8ImzlihE=;
	b=yDNxH8bNXdwxDywnniKwCd5Oq7dX/6nm8mM0QMRYC1ygVPFiA0M0I+W9+jGzWVFH8/9G
	 19uPXfxxP27sdi+M5Loph4wheKjgVcIj8+sFeMehPqfKUs8UlwmpxfHsfLhFS1wPl2T28
	 qUuNQWGnZpqv7NyeeMKADPzjjBESa9Un7o+DYMWqJ4N3dS0GchPgkmWwZOetPU1vU8Axx
	 sKLNVNmTNKSqC1lNcdlJW/HTKOMbYyEaqydfSNhq4Cw8d/g3KF0fBGyp1EZ3v93mEUWkK
	 y4pZfGLPEJsbGLFFHbRxgnJRTs3rZNSEkZD090vFAchiASM0EEjJwN6mu3JE171qw+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rl9kRzom;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F90D606D80A
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 18:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F90D606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rl9kRzom
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a3c08d6928so1679416c88.0
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 10:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988510; x=1794593310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TlsbZRohfYY9Acfo1HZrz4sd0DFYcL5H6Bh8ImzlihE=;
        b=Rl9kRzomM0oOp7wdeUPW3WC/r3jSD7fJijNyagohm+2yzcSET8sgMWU/dj2Ag3f6hP
         KP6il2thuDeIjuhEs2wc7Y3FblUJTxFjFihbjbVB1WYfkbBs1acdnMgRBWvQZWlEp6mx
         YR/3oZ0EpGaML4VkCYH7EAgy6OEgLX0sDq6S58wBs8uCEVbkEft36UaTLTxDlJ6J3Gab
         TsBmrqoY1HDT0miyy4um640FxLyIDCitna7S9zjGJqkevEittypG5FOPmBwZIR2kWJvn
         Lw0lRxpM49RPewr2m9yZycwXZfJX/OyfhIJg84yXOsFeNmo4WfUUzFoVsTd5FLvYPF16
         aMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988510; x=1794593310;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TlsbZRohfYY9Acfo1HZrz4sd0DFYcL5H6Bh8ImzlihE=;
        b=MEFNVJb7pgJNJQTW21H9yqMI6FADC+HOavdlHZGZ6FOClFaqAzdWXWEwqxAzukbzCT
         DJ69FosxHsmYMsu1h0bEsbjM0DG4ZSamM3n5gHENoZ4sFGqKxrm23ZgwRL9vlhkd/4Nt
         XP08hH6W43g5gzT9wzwpPdtZGHzRiQNIPordT0CU6Z2nWB65G2OWUGkECUFqkIg4Hifu
         QhPfmuqLq6NScMYS+nEI2oB7IJwIQdXkW+fKR1+/mCqGaqYbpmhTgtu2kscp9tfxA5Py
         2hDx3NThIM7bsaATFnDwEStqv1Ppt4QW9hXgJyry+0z/HQsAXcBAvO4af/CFdP7gof7S
         ZgTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAxJSg4qkBFt0IZLJPGX/cjcqBhz6CwOgsDWuPEx/9AVlljDNyy2Brb6k5vQRSfVpoDXQubnkzx7CcGw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+DaYoIxL7KpY/dXKuXt1HjhKH6LRHhKRZ4GpWtRCeo5E28D3e6
	+YBW+m1qFMssWNQSdhNyXv9xa8HqIlsp2KMsnYL6KIqTsZ/fgYsopM6Y
X-Gm-Gg: AYBFou1/RJe+QQ/uaO+cSHASMymaur/Ly5s5phN28Ii2ssBOAm+OWa5vHxLZ8fnBYiM
	z0Ky0snjHYs3Y2fbW+yw+IPE6MwJbRPOE4w63WH7YeIAs74AnP1KhiyKz/zVAFE8GeeK17xgb1w
	CDICjyLOjfKOIvwVvX00VUos6x55jnh39H3fpsHf4c4t4v7HZHvO6sMcCb8Gvmu/SEK1b+FSilg
	+7rqaZckgsGN5yUL3ECigOJeFdZLJIlSBq3R4W5AHzXkexw9duN2Pq9ido2uNuyKjq7ChzNLhTb
	aG2XgmeTqX+NoBHGn4FWxM12hxBsx5bNOwjEMIhoIQ00iVa8r7SILx8mqz2VFlTzW7I1T876YeS
	IGz8BFl4U9tTgJx2buznwPDbToq4nB5YNZ3bZJ9avPJ/R2QJqFztEZoP6Cs8PbFyluZ+E8N6+2B
	sVyFvOy1Ty3k8PyOVTu3yC1Z5qADnN6xTE868hSb/TKkbQgvdXg/ee5Af/Rhx++lCQ/9rZ491oB
	ZsE2FZ4a4lkh8ka0bDynx0XrX1OfxDne3XiobIyvklew/pwMAOH4Rjp6iekFD30IwOcuuWOUlip
	zeRTVB/YpYejCzukOOtoS51Scgqs+LcfpaTK5o3payBD4JI0zYOfSG4nElZkkC4FWvXK
X-Received: by 2002:a05:7022:5f07:b0:1af:16c4:d06b with SMTP id a92af1059eb24-1b25d31e658mr3453567c88.10.1793988509569;
        Fri, 06 Nov 2026 10:08:29 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:64e:8358:c9cb:c17b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4fd2d6sm7443467c88.23.2026.11.06.10.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:08:29 -0800 (PST)
Date: Fri, 6 Nov 2026 10:08:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: rva333@protonmail.com
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: input: mediatek,mt6779-keypad: add mt6595
Message-ID: <au4Xis7Ei2th7xFZ@google.com>
References: <20261105-6595-dt-keypad-v1-1-f0911f40d3ad@protonmail.com>
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
In-Reply-To: <20261105-6595-dt-keypad-v1-1-f0911f40d3ad@protonmail.com>

On Thu, Nov 05, 2026 at 01:29:12PM +0200, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
> 
> Add a compatible string for the mt6595 keypad, that is compatible with
> mt6779.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Applied, thank you.

-- 
Dmitry
