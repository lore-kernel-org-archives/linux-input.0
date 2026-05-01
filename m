Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751D23BD17
	for <linux-input@vger.kernel.org>; Fri,  1 May 2026 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777602334; cv=none; b=lOYgBeKaNz/d9e4pBIjMe/KmVMB2+pgD0VN2ywBHGorEDC51ik336YYD/aglhM/6sdtmaycFNU3JYBGux3eXbYTRbWoVMW7+X3Py9zvTxij4WiwNzAoiNuiXrKz1OQRSykgAumAAmC/jtLcEWHtRSNuECLWsYRow4sF4y5tNtWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777602334; c=relaxed/simple;
	bh=MFsNY9rjhkkxw/84W2CnIHgI6mhRRCoDddZoNXyMnNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILXp2ave/i7qHXSLzAdMTHxEcCcHgss45/sfl075UykxnlVA1cCVfnnKMIQUxTKmdNLRncMnPjlcNDdtSEuw6O+CnmABEei9D/591wHbXaJvZOeijR3+hF2X73wrPPpGOTTzVDCh8u27JTniNBkZBB0FTecM187KjkCGQ5+dAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsnDZ0QP; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsnDZ0QP"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7de4ed0593fso980503a34.1
        for <linux-input@vger.kernel.org>; Thu, 30 Apr 2026 19:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777602332; x=1778207132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFsNY9rjhkkxw/84W2CnIHgI6mhRRCoDddZoNXyMnNw=;
        b=TsnDZ0QP+CiNsPZeq/US/wWu/fMtnWKS623RPAtQkEU7JYMDarNSe7K1pOWLl3KVav
         lYcZRNgBHqx4EwqKOALj31qeC7rv6KzR2klHJ+/f3wkTn4Ts6or9hJA8eJz2iXNEF+y0
         ocVuYNJ5zSxnYxoxddq5mSBWNHHcWGmdx8MccGvQ+Ce5vQJLjSTzI15JYAQZ4+fTPFWI
         I4zozp5Ix2aM6054HX5fvdzPo/TTrgN021OYkhtOpwDqet7znPa/1peV67WhyJ+HVbJA
         YBn8TvjmB0owrz7Ib2DgjvS9L8XHOe3hpOTPo0blzD5brUbCWqtkxrpATlU5AxA5punD
         qBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777602332; x=1778207132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MFsNY9rjhkkxw/84W2CnIHgI6mhRRCoDddZoNXyMnNw=;
        b=l82C92zKj0tDkPx0thc3TEs80gGAEKZodBv7+lYqfKPrhQ+CHAcOofF5ljHjbtzSOU
         RaLyf7pfFwMNK3v2/bqOed/qgGVvsCH3TcDWtsRyyndH5c9UNnEo0DhvfzhgoQUxfniy
         xnp/4IUI9nEcoqohWxnKApP5zVfLG1AwUc1BMKX2GIz6b11XxWBU79Z00Kc0HHsV+5e9
         waMZlfk4mudC5rJAfXU60FCMPbmcqFWA7+gvS3bPHqlVUXk0UmIn2/3W+z7h5rHWvyp1
         ws3+En592xJmufb9unD/+DgnRlfX5FOjGdhe6IB5MQl+7PIlByt+/wjbYmaMW6/NnC8N
         r9+g==
X-Forwarded-Encrypted: i=1; AFNElJ9Y0BgkEchEuHSziaP9Y+Bx8dRXskBO5F1KdzBFmAHx4SDJKB/VgzFveuPRo9P0SrTZDT41OXiHZ/rJTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCf/SPSv9kf8Ga608oAwHvPbS5iX2uzys+plCv3PG4+JbFbX1g
	p7jOYi4Bs27+Jg3Od2siW353jMgkWIQ+gWzu69rqOgtcWLyMHyJ68/vi
X-Gm-Gg: AeBDiesIjYN0lY9BFK+dWPsc9TwZPt5KoxJcBK0JcLbe+sxmp+j9oH7pgdRRLakug2q
	s3ZUd00Uhh/bfDBCaFZy4h7sjVgHfTbT51DztaL4A50GWulo9ysd1BzG5oKdxPVztoIsjgLZbWK
	vknydKk48P1TAvqhG3+prCMrZVlGFUUU4NgEYEhrm2C0wzJ+5FUOBzuwZubDBbSLxXRhjsk2Uu2
	FdPO8UR9+mMBGL79beHN1a60e8CFapcGSk74RJqkXOiIWAPq7P3wKU3E75b4gPnh6ZC+K+u6I7G
	hUnj9vOcA+zaHTsbuY+Kxq0aphedJS/NA6A/uKApAHVc3JtYtw8RSdvBxtcPABh7WQ6/xY13Ghg
	3ZQZ5gxpJKtjN7Pp7EJvwTlpOhmtsJjXwAgjVJw2l/ekB1vqth2/zwITbJLdB69TGU0Pr+i83II
	mt/cWKcaP4UwwfQUCLaR6uAo1nqSHhpajPjuCL9tDIERpUEkSEMQIIYGZdvr7hL7oA
X-Received: by 2002:a05:6820:1606:b0:696:1abe:a51 with SMTP id 006d021491bc7-6967a6031b1mr2849998eaf.49.1777602332599;
        Thu, 30 Apr 2026 19:25:32 -0700 (PDT)
Received: from Dell.cheetah-searobin.ts.net ([108.243.219.47])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6968945d6d2sm728624eaf.4.2026.04.30.19.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 19:25:31 -0700 (PDT)
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: akash.sukhavasi@gmail.com
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Input: analog: fix coding style violations
Date: Thu, 30 Apr 2026 21:25:29 -0500
Message-ID: <20260501022529.132812-1-akash.sukhavasi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260413221928.21748-1-akash.sukhavasi@gmail.com>
References: <20260413221928.21748-1-akash.sukhavasi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

Gentle ping on this patch series now that the merge window
has closed. Let me know if you need me to rebase it.

Thanks,
Akash Sukhavasi
