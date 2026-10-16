Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20FB4A5ED0;
	Fri, 16 Oct 2026 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157643; cv=none; b=EUT593h/ae++x4p1CjupyIoJLU9DJohuLO2YaTvutPgkJb6EPLNS0fFouTb1w7d70cmpXvQ6y3ekyhOmLXJAMNLQrkJACn5eHAcwNXWjhdj/Uy8vqL2tRPKQuQB/AJDc5mtzl2abEYmH4RA8I73+sLuCIIVlaKFqya32xp/t1jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157643; c=relaxed/simple;
	bh=cppukj+e14o6hDJof5FUuIWGdycDArei4ahBv0cAlBw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=SJVFchxaaO4MirDWL69VvO7wz/CdRcfwSye9rTeOKZ1k4DwwdHwuaFGQZFIBEBX6UUuZY2GItnkpwVzOIn/oR0ccuaVFkXXYkQfkE9jn1qVPR/9n1TLnE12N0cbP9WZ4QLrbOlyhzct/H3rETSaojuhWf/maGEQqWXzuWAMfj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSp0DMBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSp0DMBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5091F000C4;
	Fri, 16 Oct 2026 13:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792157642;
	bh=acG3c8C8tYtd1Vdd8mBCHAX5G/JVl9rS4yJU55g+HEk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=RSp0DMBsbCCkDPKSaD2MnjUsFOD5c3t6bBeOiWzoX6Nb6zg2jlSGRyGUzPrwYGCKo
	 qO6WEJqTw7v2Q/bJUli9GZ1HE7ugx0G0YZ2R1LqBB/ls9wEtzCbDZGxh8+LIlfjLKV
	 KLdNhfLODTb0e4glkJQfvmbspTqPhInKUBMGuXHEmDP8+eLMerBIQ4C97a+jRgUhHy
	 9rGJtow+zBRWOPvh5PXn8K4CN7wUc1NSuJAISUdlPDSxm+E38aCXtfPYvug7u42b9y
	 sqFkMoHAs0aH1mgUKMzZr5rJeVeOux+Rx79crb6LQ+arMv9zZ799vbGY+YLl9cY5bG
	 dvFsssPp9L7Gw==
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/9] HID: Hardening report validation and unnumbered
 report handling
From: bentiss@kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, 
 Frank Praznik <frank.praznik@oh.rr.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Even Xu <even.xu@intel.com>, 
 Xinpeng Sun <xinpeng.sun@intel.com>, 
 Roderick Colenbrander <roderick.colenbrander@sony.com>, 
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Shashikirana H K <shashikiranah@chromium.org>
In-Reply-To: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
Date: Fri, 16 Oct 2026 15:33:55 +0200
Message-Id: <179215763590.1109876.9153659846218614238.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792157639; l=1247;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=cppukj+e14o6hDJof5FUuIWGdycDArei4ahBv0cAlBw=;
 b=YLWrMRK1Vt2C1RbRF9OGMARRido3qPVIsY0TybF9KUkWmr5sTu11NMp0/TSFEN1rvH9qetXpO
 NeEwJup2xLjApgqFwFZmwXlrbSwN26Jp5Tk9V+XdDTitBRayMyt6Q7V
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

> This series improves validation and consistency across HID core,
> transport drivers, and individual device drivers for numbered and
> unnumbered reports.
> 
> Bluetooth HIDP and HID core report retrieval handling are updated to
> properly respect the kernel convention where raw report request buffers
> reserve the first byte for the report ID, using 0 for unnumbered
> reports.
> 
> Report descriptors mixing numbered and unnumbered reports within the
> same report enumeration are rejected in accordance with the HID
> specification.
> 
> Report ID verification for successful report retrieval transfers is
> centralized in the HID core, with a new device quirk to accommodate
> buggy firmware (such as the ASUS ROG Flow Z13 touchpad). Redundant
> report ID checks are removed across the I2C-HID, Goodix SPI, Intel
> QuickI2C, multitouch, and PlayStation drivers.
> 

Hi Dmitry,

I'm fine with the series. Sashiko has valid concerns on all patches it
replied to except the first one, which is a pre-existing issue.

Could you fix the uhid case (by making the internal API similar to what
you did in hidp), and address the other Sashiko remarks?

Cheers,
Benjamin

-- 
Benjamin Tissoires <bentiss@kernel.org>
