Received: from mail-107171.simplelogin.co (mail-107171.simplelogin.co [79.135.107.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B801E51CF51
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=79.135.107.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777787; cv=pass; b=MxvYNqfAavCLO5tLRdiiEo64r5pmDbrIryrp6VUD8C3qNrc2X5a00CNh4u6tr9ogYknsH25ocqqmu4iT6t+QWOVrd+oA7rrDLcJcd9fXQKuJR4d6E5w6nHXXPzioWJiwh3Isa1DnP+WP2D/1eAIbRbrugloWru802Js2yD4t+0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777787; c=relaxed/simple;
	bh=C2mlMAIbo6xPodeE0BMdBKhRoMWt8XP4RJBcZT7wcmQ=;
	h=Date:Subject:MIME-Version:Content-Type:From:To:Message-ID; b=GH3a4ML0w8WoNAz0KJ+iGOV7yIeaPsprDA6E7usFLIOxW3IYHbpZDAEK5k9ofUxvw3eKxyi7vigNL+ZAs3l18tH1F8IkaMN+snZdB0fbdyTeeBpTj6qAwL37Kw2ITM9XXbeRP66kelwUkArYl4BDTnmmNzmMsYPLOyP8xJT9PEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=passmail.net; spf=pass smtp.mailfrom=passmail.net; dkim=pass (1024-bit key) header.d=passmail.net header.i=@passmail.net header.b=oAmUoiqx; arc=pass smtp.client-ip=79.135.107.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=passmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=passmail.net header.i=@passmail.net header.b="oAmUoiqx"
ARC-Seal: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626; t=1790777761;
	cv=none; b=p2FZYkwKT7a1isx0W3LkW53hKstX9z5d9ldNCLmCmJ/dBmzin7q2ce4GdMlb46Ra1U/sG9c/mFIUA2+Cb4CkNhrRe7BG4OzWwBk+XMYQZP7TEunIduoTxuelaWxTL2IEqDYkJC4kWtXQwAYmH2AQcdVPsxAfrBTLIEzsfymHBjWO+D8v4sgK/8vSNYuQEByEyI8r0mVqT0akolyxqpEgvklbP2hCsDGE1CKYhVm/fMgTFnGIM7qsHGPnVJGhmP6pD8fcHsA3yPNiI0+UZEZ0sw4SR1E6F8T2lwWCMQpMpzT4caLmATYlvDnV508x5fn+hFThfC4qpW+tYLn8I8Uc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=simplelogin.co; s=arc-20230626;
	t=1790777761; c=relaxed/simple;
	bh=C2mlMAIbo6xPodeE0BMdBKhRoMWt8XP4RJBcZT7wcmQ=;
	h=Date:Subject:From:To; b=KB91z1h70XWTqj853BTASB01gqOXgdqjqK0NQf5KP41ImmQkIDd1/YSMbHFs4dq2AAYJGbLrLCTpi1y5Dj9oEyjKDF+PCPfg9K/7S6XlTKycV46JEshuF5nxypwmNWw3ev+OkAW+YN1Y02xLcLsIzILbDPJvscz2CEGYpfeOO8QWh7z9aJaDC3c4YkB/6Mc3P2f9rto6R8nnT6FLEQzGzKqv/T2ZrKgYSFSL3vA46GJQxkFu7bHvHKilUAuWe3xx5e2zeYdWJV0wExM7BhF/PgxUVybcNOvzFPBYiwA3JnpsERO06ep8vWqOU2tzeDIaQ4gZefLXOF2kE2tf1nqFDw==
ARC-Authentication-Results: i=1; mail.protonmail.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=passmail.net;
	s=dkim; t=1790777761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C2mlMAIbo6xPodeE0BMdBKhRoMWt8XP4RJBcZT7wcmQ=;
	b=oAmUoiqxDe4JEIoYqOSbYjw7Fc5E2k3mFWV4ffJcUz5SZSenEyeQ2BKiaOtmxNZ34nzkKq
	tNXj2jxtCLK7URUDvJ6JuFhzqrTzfPedQJtqIGclUZ7YE/kGNt1huRjwdQy1QIPESGnEjm
	FkdoVZhpc8OdHE9oMYfX+wql43jSG80=
Date: Wed, 30 Sep 2026 14:15:55 +0000
Subject: Asus proart p16 laptop hid device 0b05:19b6,
 kernel 6.18.54 logs: Asus handshake 5e failed to receive ack: -32
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: alpine.skilled126@passmail.net
To: linux-input@vger.kernel.org
Message-ID: <179077776166.7.1365097403107284994.1658308371@passmail.net>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 1658308371
X-SimpleLogin-Want-Signing: yes

The keyboard works, including in initramfs. I am just reporting in case it =
is useful.
lsusb:=C2=A0Bus 003 Device 002: ID 0b05:19b6 ITE Tech. Inc. ITE Device(8910=
)

Commit=C2=A036981ba106d9 resolved my previous issue in which the keyboard d=
id not work in initramfs:
https://lore.kernel.org/linux-input/178997243101.6.12274125017298403957.163=
5411565@passmail.net/



