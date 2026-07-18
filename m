Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA753D0C1D
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386886; cv=none; b=GKnzVCoDmVrx+P8vGESBDfBa1UEnkj+EZjCoPgQI5uYOu6jO76X0oKCCtAZcKeD082Dg36zPlNN6go7JWYq7peqwYPGCWYyrCJ8EP/TDMcC0bRIQn2Iy+8e6ZM2KsLcZwhanymSKwSLdOOkx+3E3X1fC1F5exuQJ4Za9NakiK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386886; c=relaxed/simple;
	bh=rN8BFtBHARb0dX2NtT4PTudCyGxeXi5DQAWKqRCj1V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ilHOcVo+6iYlLE4Ih5j+FMd4EsgQG1z91jxusZyF1v16Kqwgi4gLd8gRhdWq+4/K+HPcb63AxtULqULEgGesZkOHo5sBKS3FwnqL/UPclZOooTbV2t2m+TmHsMcNzxfYZIW3vBNtMZ7PZY4Ml2Ov9RZu99XdQelQzmQqg4uJXBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks; spf=none smtp.mailfrom=deq.rocks; dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b=IlKZh9uH; arc=none smtp.client-ip=91.216.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b="IlKZh9uH"
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: 8acbf68a-ed98-4838-a39b-5cc230160a31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1784386883;
	bh=rN8BFtBHARb0dX2NtT4PTudCyGxeXi5DQAWKqRCj1V4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IlKZh9uHSXsywVVkxf661slRSFY5rO7LMrBmVXHb6Az0i6dMMyOyiEMW69sgT1gbc
	 ANYfwbv3RtfoAB7MzXDd+X64eWJU91PFGWBPeEabuasBlr7IHzpjDvDPkRZzXH6cuJ
	 2DIqdDuQYQHD0fBW/Bz66PT1lBWHqQ/+ziuGRhpSfvFlV8Tghl2myNzsifHMOrdP5V
	 aJryp1C7l6iyCd+lp+qt++eS32PzwGI5aYaKJsiyPgbpYnOdx+i3b/UN9JcAt/ZOPa
	 AK2VQGz4CLWQLF/eW8QSHAetwGJ4mCIHP7STYhiu8g1bljqwYuT1AiYQlG6Tk8ZBSX
	 ecEFcCWw2j3lg==
To: sashiko-reviews@lists.linux.dev
Cc: Andre Eikmeyer <dev@deq.rocks>,
	linux-input@vger.kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	gargaditya08@live.com,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH 2/2] HID: apple: use the standard keyboard backlight LED name
Date: Sat, 18 Jul 2026 17:00:52 +0200
Message-ID: <20260718150106.7774-2-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718123641.DA2FF1F000E9@smtp.kernel.org>
References: <20260718121527.15924-1-dev@deq.rocks> <20260718121527.15924-2-dev@deq.rocks> <20260718123641.DA2FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks. This is a valid pre-existing issue.

The multi-byte fields in these raw HID reports are little-endian. The
backlight configuration values should be converted with le16_to_cpu(), and
the brightness and transition rate should be written with cpu_to_le16().

This predates the LED naming change, so I will address it in a separate
patch rather than mix it into this one.

