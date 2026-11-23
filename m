Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416476;
	b=SLw1NnyBTGSPVleEaP9Z+zr3iJi8Ti02/zkSJbF0yjbv+CWKsSOk4eA8mEmxAVnCJkIH
	 WQ4ZyASyz7EfAZ4hxapktEfI0mQ+k9g3SMyBKKl7ABH5hI+W4+Oi3ctIveE2gycOc37c1
	 djaRrCHa/zePSWm/h4suj1+MCEcV9DzN4P6O4Li+O9DiRS4IVQfMtufhHd2qZLQftMZzY
	 Xb8PpXad5sdZCvzKcxzT9HnDApkGYnIvwERpht/D8aLQJs+w4W7Oh540yvekT7l1Smb9K
	 3ZEJOelXVauJ2hzRKWyDPpRwFpZbmZm2J/DG2o6VpSqp2jViC1qiWpct8tK87WutrIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
	b=FvIC++zxMyatuVU96ZCHsA26xvb0/CTwHv+hf78Gga22KBAcsb9f1069CGV+I0bfLfpA
	 ZoRrbhaYWtuJNmepj27WA2+U6n7ZlUg1NvugKEDV4TxyE2R4lV6HHrcixzp3ERuPpgOO0
	 KgWUKlKe4Lnl1wVyaoUgpGR6oQ2uPOtkNdSzic/cEb+ko2fIAIA5Wg3dlSM8l9kBOz8sy
	 Vhqb94yeuyimvHYyUtHFOI62+QAzKt+SsbIXeqwZBUx2zWJdCvkn7KXL0k6AFlNCfvk3z
	 KJ99DV5AwUCAGay9rlMZZptt1cX0uVVTjCoNd14tqaqcX6mvRIXW8Mr8PD8sWn3yJ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sui00Ob7;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 557F1606A32C
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 06:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 557F1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sui00Ob7
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8b2382bf051so1408814b3a.3
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 22:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416475; x=1796021275; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
        b=sui00Ob749YP/4E0URw2ubSzDUQP9KyBjfsmmDw9AzxIDxTYS6M49S1JibeFvPEBVc
         qxmPMlLkjqeHtjjaN7HvIH7fHwsh4z3btvPa519DONCM3a8F31p3NAmeMGSbIBAqhVXw
         5txmr4OBG91xAg91dxl180zBYNgs2sAiXvTgDE7cFJeajijmCEsby493dgeu2NU9qZIe
         AOvHl8i6VREYiO1AJs8bd9Y+u3Wd8mtajSfG6AMj9CMP8bF0uqYgd4Y9TA7w5AXW8uDK
         YQ+QuR6/yknUWT84taqMCfSyX7b6XxC7IIgRv2PGwskSgwLDtlasV+5SLJy7c7g+qSd2
         P3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416476; x=1796021276;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MpdWRQGt7FrCuyLLRBTmUxjIIESLmxZZy2MLy3uKw7k=;
        b=GVZpW5xZOhWlfvywPeg3Llb9EmZ1wbKnt6fQjLkCWTBpI1oGMn0e809vcKglMdC3eg
         AZlcXcJ9OR/c0cLjFxPflf6uIJpkZkVa5I2lX3PcHWB7qvlCNVnGwHkeuUfib7HDBVwS
         5+v+AHXkGFLMxEFdK5Y2jR6LXkAjddWSf7LLvXUSqWLpyRD1G69tj6wYI1BtJNVY/fXS
         m/hItuG2d8m2OoU7CIeuvzsejIbQk67k6+dsKWTd8M0SYYqct4BDjWN6fUIkaUgiTTM5
         vgEfuw+2mgGD11gF2JW6f1b5wf6RFCeJFWJcXE5zuihwnsyUW3Rl8Qze+0eHvPojj6Gk
         XxTA==
X-Forwarded-Encrypted: i=1; AL+hErEizfIVcqB7h4eEQngrGNowutrvlYa9HkC78lCQ5Sdg7QXShwb6j98ZXgh9j2ZQdavPMFDKWyxHjsp+uQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8oWPc4IzqtiBbiFkl/DqhdxW8eewncn5/Iv15GoP3JwVII6ta5
	DnZyjq8Z8b7AzvvZC3vK31+veVpjJdKRYNRlfoXD3gXDFkMeOJRBw10O
X-Gm-Gg: AZFdTZfCS3L8O5lm8r8mN1siE/JFw+BY7pXeaKtHzvKpPZP/wKrwFzj1P9a81SqAjnr
	3XeZzCzJPGACyoco2Ln1/fiXKvSFSF9m1tUSoQuJoE9k+nmy9aVOPetr+kfUYTsKyHhq5lEDr8P
	MEEz4qGiE/zSLi6zD7XSLormJMBRQdzaXjywaons53MYQ+p31FhRm15zxrENn4qwuiiFoSsNZ0n
	tTbosfBtcOvsquKePrIv2u1aCf6tzACc+pJPNMG8RDQvFqRELAPfQq00j9lfHWV95XUSYPny8O0
	v3HJGbFS184osgfvaCCJTHN70UypsOcRbDpnwGzTOq3TcDB3iFyWkhLQ2QN58aEHsuWguh22Lxl
	jD9emAoGUOQW6y/6WehyhZ7LzE4q+eqCisWm2y3RI6d6VU+2kIR2sGi5df968CYEjFwmrQBX8WZ
	eFwZo5yyg8aBvYIilRXxZWhuu85ZfLrOAO0fhCuZKLfx/jpG4kC1tLHfddTbo0OuRy1ey19zd3K
	M4dXNLXrWA0bwj4WFuucWQUiA8KzCK/g/XGaLRtRUcPGa1zMZdQRneYsR0ztWeAjDkFdmTkMXCM
	ngm03Z+/d5/gH3wy0hjeciIC5yJljpFYO3eSqAIfxShv+1btnyjhN/k93iCjipY0iyFT6A==
X-Received: by 2002:a05:6a00:2196:b0:878:3538:8f77 with SMTP id d2e1a72fcca58-8c87c6701c8mr9415691b3a.37.1795416475541;
        Sun, 22 Nov 2026 22:47:55 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077fe3fsm5152686b3a.4.2026.11.22.22.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:47:54 -0800 (PST)
Date: Sun, 22 Nov 2026 22:47:54 -0800
Message-ID: <5ec374e9acccdbb5422291d106bd9ea9@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/8] i2c: docs: update i2c_smbus_read_block_data() prototype in writing-clients
In-Reply-To: <auo-JCn9VES7OwX5@google.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com> <20261024-i2c-smbus-read-block-data-v1-2-19bb97467982@gmail.com> <auI4Qq1KUo7YYVtG@zenone.zhora.eu> <auo-JCn9VES7OwX5@google.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andi,

On Tue, Nov 03, 2026 at 12:04:29PM -0800, Dmitry Torokhov wrote:
> On Wed, Oct 28, 2026 at 07:00:49PM +0100, Andi Shyti wrote:
> > On Sat, Oct 24, 2026 at 07:48:42PM -0700, Dmitry Torokhov wrote:
> > > Update the prototype of i2c_smbus_read_block_data() in the SMBus
> > > protocol function table to include the length parameter.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
>
> Andi, so will you be picking up the patches affecting drivers/i2c?

Gentle ping on patches 1/8 and 2/8. Will you be applying them to the i2c
tree, or do you expect me to queue them through my tree?

Thanks.

-- 
Dmitry
