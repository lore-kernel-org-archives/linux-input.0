Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116AF3C457C;
	Wed,  3 Jun 2026 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472879; cv=none; b=k2HjHQjPIVnfZTXVg8TgK3t4v+d6lupnZAYiOIX5wQIlwucWskCN4U5OBg9Kyo9QyYTQfSQmPukZKP/eIhHqylDWMqbt2nXTb6W3SAqXrIYG1L71O6WdI1aTUTslxaaT9+Z38xAOMuuz0i+VAMaw4MJ+LWN167wsgJooquihnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472879; c=relaxed/simple;
	bh=5J+IZbovpreXkXoINP2NKD2/al0irF0lAFVjc8UfGo0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=uPZMfGoFwKUXWPhraWoUnis+ViaRsryqVaOnF0bhHNzbDzXMWY+3AkpTC20DibVTXmoS4jGGwdVyR4rOrT4p/7HPRiihEJk88xE31uSni3jcUlFJyKtYp9u0QUPTEZyfIDrBx/fFvnFracJgKPG2SXFMETlW01Xxe8NnY5sixB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com; spf=none smtp.mailfrom=joint-cloud.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=HW8L6NoM; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="HW8L6NoM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780472866; bh=Nzfbs86sMc0pUvhp8ZxqINvb2dzs4+/wHKGyetooIkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HW8L6NoMJGXk/kqyEFxsYxXSip2qDtZmtjVEmKHeAA8rUUncbTkiJ/KKZDzMY8wPh
	 nG1b+m7v70N0/16mHmgkohdPq4+3yYNuBMUfGiSvuNRP0cXP2uY9yTtbtPvw4x5WDk
	 oGk2pV50tmfiZSUGbVnKycJS/L0GRZtmmjCDBUtU=
Received: from ASUS.localdomain ([113.65.236.26])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id BDF9EE4C; Wed, 03 Jun 2026 15:47:31 +0800
X-QQ-mid: xmsmtpt1780472851tal7u47gz
Message-ID: <tencent_DDCDBE11DF2F314E80EAA1F9C5A112A5CC05@qq.com>
X-QQ-XMAILINFO: OPDQNGCUQ3qL3HZjiOPnRQjoIwHmD/UbOFOP2ry2Q6urqbZOFwXcYsFaXffqnf
	 okAKosm9B6kOa4rRO+AnjkDl3YM6+15dQzgeTUYaRsEojZD492oW2K7qEqTqFD47JlUPrUEiwU7t
	 hhwXaLwTGEinARb72b8DNSjqC4s3kBKeG73KASLXwpPO/4a9AzOZFlFTRnzKUOlpQkA3y51K5npE
	 L9kwtCE0JgGFxgD9G+ts71Kvtyksf9/dL+zy5VtbL6QhA8sl62cEafw4HCXRnnKP2Dy9AEFh0ua9
	 agRFNYi6YPMXC4kukHGoeAjhmlP1JnwSPkbO5UN/9Px7DgHGSuvvnq7h3q6dYygcAT+PT4UzhpIm
	 8c03kGCQmrNh/g4EDpNMreUDX6D7RQ603O4EtzuAB7+vmGTJQy/Fr0Kn/oVpyMxaVKH3iioVbnaP
	 jZ1/0NBbINobY1kQ1WG10vAmLleWfSCf11074blc1R80Fpgx2CBVxJbREwKKjwgDpFMyv0exljs4
	 GmYo1p00QDc9rBDknV4T0mvP3f3NACtNJ2kKQfZyhDQECaqsyq+DNfCKi7O/5HzC16mh6Uqjvn7V
	 xh1VxKWKqkhrNFakUyEP66Y3BfA67nlr4YHoKP6xxc4KCf5To6/Th+EgR1jwGgUc8vwS/sVM7kwc
	 xEmB3+4w+9WB/4GW/2zt57Z80WToGi4WBvRqCoYNXtWhkmcFJphEeoLFuUVufG1xgjvjZxdNSTce
	 sGuFVSkXNaBgbWRVFACXj2cO1b/PlDlE+xSZN5p+vNDcfRoYuHh+2VGVvGK19mEs4SU9njUqTwvW
	 w5GTK9rmqsNq3NYzTS+G/IvM/dnMBb1ZoTVXhxS4eKBfKrJHdFPOjpEvwj6cdFcdWRt2+OktdDqR
	 BxVLFm2nCPaI4bPM81ehCtO+/Z5kWJfDw04v7WVK0G5sFevTlIF5o02zV6Z4auEqaY0D67B8FhKe
	 Ez2AISbL5Lhz3hoWE2+YHPIPMt7/4LTfXKKsNbUsiOO464kYDWxCitrUDUbY1IBjbr/acUIawnt5
	 7lijOxh1bNrQpEONWnaGz2cFnauIH9VSTLXN82t6rICYnOIwxRwS/5jsR9SJObM+DmLgNMEKPOnW
	 uNo6plGIH1q6cP8N4=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Steven Feng <steven@joint-cloud.com>
To: wens@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Feng <steven@joint-cloud.com>
Subject: [PATCH v4 0/2] Input: axp20x-pek - add AXP313A support
Date: Wed,  3 Jun 2026 15:47:25 +0800
X-OQ-MSGID: <20260603074727.613319-1-steven@joint-cloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAGb2v64PLZn+VD9LdxOQxHC0FUJ=5fMrpwEyJEJHkZnUZkHRRw@mail.gmail.com>
References: <CAGb2v64PLZn+VD9LdxOQxHC0FUJ=5fMrpwEyJEJHkZnUZkHRRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds power button support for the AXP313A PMIC.

The AXP313A lacks the PEK_KEY register used for configuring startup
and shutdown timings. To handle this, the first patch adds an
is_visible callback to hide unsupported sysfs attributes, and the
second patch adds the AXP313A device itself.

Changes in v4:
- Split into two patches 
- First patch adds is_visible infrastructure
- Second patch adds AXP313A device support
- Fixed subject line to show version number

Changes in v3:
- Use is_visible to hide attributes instead of returning -EOPNOTSUPP
- Corrected author name from "steven" to "Steven Feng"

Changes in v2:
- Fixed regmap out-of-bounds access issue reported by Sashiko AI
- Created dedicated axp313a_info with NULL time tables
- AXP313A lacks PEK_KEY (0x36) per datasheet verification

v3: https://lore.kernel.org/all/tencent_81FCC0443B81A3078C17F44AB4B22DFB2E07@qq.com/
v2: https://lore.kernel.org/all/tencent_48A497E0CA81323CFB6C7CB84428019A8707@qq.com/
v1: https://lore.kernel.org/all/tencent_5F1FF80489E702360F352F889570656BF608@qq.com/

Steven Feng (2):
  Input: axp20x-pek - add is_visible callback for sysfs attributes
  Input: axp20x-pek - add support for AXP313A variant

 drivers/input/misc/axp20x-pek.c | 34 ++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

-- 
2.43.0

