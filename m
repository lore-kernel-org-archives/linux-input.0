Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6C830E851
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783809490; cv=none; b=dLf0VyT0u1FexWnyIQP22aHHJGunB5DNXA64cQyGst9uPsbwH65sgZhtlIfGqWLWsRdP5+H1r0JvNWbJUi4Vcs0hteIOJuFFcRHjLydyjaPJrIZ8nIKz8OOhyF0qWyOIFmn8OcIr2Fk8V4m3wq6tgn1QylL+jPchD4vdxHx5Ylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783809490; c=relaxed/simple;
	bh=gFJIFfZC74dTnQhStAtZ40JhdQJB8P2mLxpqJV/R7JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3nRt5o/r0oVYuWKFRF5A5ruroEsTC4c4CnXcgxldxj9Grk8HDGD3ztyNSLxr95FsozN6cXaEYp8yhY4+CmfzwwDvp914nup6q1XvE6Ni43aQV5A1BlBWkkhdFZqX7zjZEDqaw9UZ22mATGWTfng3Fqr9wJNazF5cIFoqrWWpYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC4MxzzP; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC4MxzzP"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca12086c06eso1685670a12.0
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783809489; x=1784414289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LK/eR0dn8wsRcSyjgbh8eBn+ks5A4wiJWyj0VcjPLy0=;
        b=mC4MxzzPWVw/3dHbG/yH7bUg/NJ/kW7/SppUabZ5DCD51DvpPKEIYigSUeYdgYICLq
         l1yAKiiCpfVqw+FUHv2mTMlbpgygUOUT/vayctOuYmeyv8v1rscibA+/a4pgCm+jmj0W
         3bZFeOFunHZwweDUtbKAjQDpQViedFU1PS76+JBsdoJqF4fJzG/TON5tE6FSbBDqV0/s
         VH0UzDJyFUu7lGJyMVixtt5fjH0HltWiNbZHO2sUsM7+yolbRHPWOUUcjeqf9nUKcDGV
         mSRzGglnxVDNt6uAmjkZIQ3uUJUF6IWvocHYNntcQD+tTSKhC/e5wGAkZNVkxe7Y9UQt
         AZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783809489; x=1784414289;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LK/eR0dn8wsRcSyjgbh8eBn+ks5A4wiJWyj0VcjPLy0=;
        b=DJ00W2W1PBHTxI3BBgCdwFP+1KgoN++i3xV4qBuzNFV+vcAaH+98zA1/fOCn5I3jEz
         41TaJtZsitXQecN4YgGYakmUkq/nw/mxNRUHzGjldfIkJyDudMQ/mcJJDteq07e4apXv
         qmTqFGoEZ2Jj1zatX6GUsxETPLGj+Lfj+HbQF+HCt16ybJNQRVae9PDKUn2biQ10GxLD
         S5NBb7Y9FuIiUd6Bl1yVF7zXx4kY3klosNL7vax6eGSiAhYQ6jxrlPyKwNVmrOe1hSle
         h3oiwq6xm6P6tAiK0RupUnp+Eih0KpwhYrwldYYDiPkOFm5rAY0FEO6PnsFuVEtsmSi1
         VbAg==
X-Forwarded-Encrypted: i=1; AHgh+RqfP/B4jLvg1Naoy2/kxinYJKTv/6sBIcNwzc+asMjNMrc071qw1bVA+IB2FAeNo6nJnOMqxdzZwK3fUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpvIZXg0P0XGZZf56wTCUCPQkHIrpnnWSzT8eUnWtYFUznyHRg
	Cr9hm6gq7tuNb4+cEMfDyuhqE2OxW9wjcfHkZLiHLcHQPOi95Oq8oLbv
X-Gm-Gg: AfdE7clhhXMystb+oVXedBATEuAamKMKk0Mys2J2ob2y1kUB2wB1UxWRW75iupzbdTq
	qflSkOHXDp8qhQChWaHwsqMtuAvVwI/hwSSHDDkfjFBcZRRi0PzuLFIU+Fr9rtvkmTO5SpY8wtX
	/h3IOc4qyktpDZhtz0guR9fHQoo8PYCYMDcW0CCeBbzaE/YczX38rYjsfDoOnT0S2nTzKvW5lzo
	A5R2vZpJSpSVZEGZ/jtOhcfh76g4tuoSH8DqkNNWNKKPLYFTYA4BLRkRDUtvmkBwg/YuJmsVHvB
	B0u1DaXAl7lbjsJfFwOOxQ8HJ5go6dqQVLqAWT90YnZEOzNAQinBmaYbHVVGWrPUA7/ArJi1k3E
	iJV/FkgtHYkNVNzPkvyzjHnVF4HWCJ8Af9aCgFIeVGRZQzyQgWddOsJbzQtHSR1kyru8++0EJev
	qfdy+hWjclFRHPlHCH82pFdUqHKBoxMS8ts+roXQPYXLlJwgswlfcSm8gAiLsYns4=
X-Received: by 2002:a05:6a20:6f87:b0:3b4:6cae:4a50 with SMTP id adf61e73a8af0-3c11018d8bfmr4787107637.20.1783809488862;
        Sat, 11 Jul 2026 15:38:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c63e:9756:a95c:c75])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm36008593eec.24.2026.07.11.15.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 15:38:08 -0700 (PDT)
Date: Sat, 11 Jul 2026 15:38:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: fix bracket
Message-ID: <alLFySs8e5s4DGvt@google.com>
References: <20260710090153.431170-2-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710090153.431170-2-manuelebner@mailbox.org>

On Fri, Jul 10, 2026 at 11:01:53AM +0200, Manuel Ebner wrote:
> Add missing '('.
> 
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>

Applied, thank you.

-- 
Dmitry
