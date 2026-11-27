Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810258;
	b=cCduF/ZEQMpVG4m3zBgD8pZcFLazUmdTpoRYn/w5krd57UuOL6F49WpRQhmTuLskljlq
	 sRzgf0zOrNpdTyUuNcgMQcJC1zr5zvCshWafVbZNQ3SzgwMdOcr8iXRMycu8dJu8zu96B
	 Xxw3zfuCyMcXlHx0PU10vCFpcfzBJJnka131GeM3zErLIO7dn2d8FNy7wXi//hbk+ffqv
	 GImAUX5etVhfes3lDGe5JPTnsD77WPd+XeNVvoWfVvwH986try2rICvCArgptm2ml4Vre
	 A6v9OsTBFR5Qpb+pJ1UfALtu1DNefybeanCFCmHjAYESoPOoN443PCHxNkXt16v5Syw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810258;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RCjPO13Jg/1eI9KOpBhWyGzhdF76JSGpj17iCwvBrDY=;
	b=o9n94TXkd5MXF8G4JBX5GEXh+5lR4TCSonCL5YPiD6LOWLuPpk2wZDpMiLipfPw6ugpj
	 qvUdNDFu6zB2M7dy5cPzaQDTsj2Dvymj2J8uNIP9gxFSGmjBo5/JI/QozJ6RqY4yeXDR5
	 YivisbyxIcylUd2oprBRMq3vlW+EHkaCsAzvTU2HxY4sgZLFPR2b6KU/JynwbE8QH178H
	 zHWi1nANr3iEhCPqHMTywLwViO9Ks6LSbnY6Gmz+DgtxzAwKdIR6qhS2xOZIU6DbcwJVG
	 Hwtqd5C8X3LVWy3/KuVVzQbIIX5eyesXzT73iYsVz+L8017fc5hXQ6ub7NI6Ai+zv4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dad6wqal;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580C5606A31C;
	Fri, 27 Nov 2026 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dad6wqal
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69EE1F000C1;
	Fri, 27 Nov 2026 20:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810257;
	bh=RCjPO13Jg/1eI9KOpBhWyGzhdF76JSGpj17iCwvBrDY=;
	h=From:To:Cc:Subject:Date;
	b=dad6wqal4qMLI/m3CCqeUPQ3+a7J7Slmk6ZMsKZG7WXyk8TUpHR6wtcPKAUvoymQB
	 4PCsnFPEE+eAy5JHUMo0CIZ2hMcHfmK3ihlMI6C/QYD1pyNMCLmTssqGvkDkHBVuyq
	 PV4UOJnaEXq0tdvxQvypek1O/Zq7Yl/Pa2VLRSpqsi0TkIGzGWseykB7haFl/bnbOj
	 DefCUTJqpsPJq8LzHBYIwrBG+0g/NF2XSVZmpWRn8R5coLIl0FDDgWLyrxj5SabL6p
	 /tZvaAuqns8Sc6DQbstR/sDiVyHPvuBBRb/Q65gOXOWoje+JMM1qE3+AH6Y/9NX7T2
	 U0JeJL1jsYLjg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Adam Buchbinder <adam.buchbinder@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andi Shyti <andi@etezian.org>,
	Anthony Liguori <aliguori@us.ibm.com>,
	Christoph Fritz <chf.fritz@googlemail.com>,
	Dan Murphy <dmurphy@ti.com>,
	David Heidelberg <david@ixit.cz>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dominic Cerquetti <binary1230@yahoo.com>,
	Elliot Tester <elliotctester@gmail.com>,
	Franz Lehner <franz@caos.at>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
	Hans de Goede <hansg@kernel.org>,
	Ivan Hawkes <blackhawk@ivanhawkes.com>,
	Jan Kratochvil <honza@jikos.cz>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Jeff LaBundy <jeff@labundy.com>,
	Jens Reidel <adrian@mainlining.org>,
	Juergen Gross <jgross@suse.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marko Friedemann <mfr@bmx-chemnitz.de>,
	Markus Armbruster <armbru@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
	Oliver Schwartz <Oliver.Schwartz@gmx.de>,
	Pavel Rojtberg <rojtberg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Steven Toth <steve@toth.demon.co.uk>,
	Vojtech Pavlik <vojtech@ucw.cz>
Subject: [PATCH 00/10] Input: Fix OOB writes, UAFs, NULL derefs, and suspend work bugs (batch 2)
Date: Fri, 27 Nov 2026 20:09:54 +0000
Message-ID: <20261127201050.3532488-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These issues were reported by Sashiko.

This is batch 2 of Input bug fixes, based on input/next.  It addresses
out-of-bounds accesses and underflows in adi, probe and unbind work
UAFs in xpad and aw86927, sysfs information disclosure in stmfts,
NULL dereferences in xen-kbdfront and goodix_berlin, SPI transfer size
underflow in goodix_berlin_spi, and suspend work stopping in drv2665
and drv2667.

Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Cc: "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>
Cc: Adam Buchbinder <adam.buchbinder@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Andi Shyti <andi@etezian.org>
Cc: Anthony Liguori <aliguori@us.ibm.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Dan Murphy <dmurphy@ti.com>
Cc: David Heidelberg <david@ixit.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dominic Cerquetti <binary1230@yahoo.com>
Cc: Elliot Tester <elliotctester@gmail.com>
Cc: Franz Lehner <franz@caos.at>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Hans de Goede <hansg@kernel.org>
Cc: Ivan Hawkes <blackhawk@ivanhawkes.com>
Cc: Jan Kratochvil <honza@jikos.cz>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Jeff LaBundy <jeff@labundy.com>
Cc: Jens Reidel <adrian@mainlining.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-input@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: Marko Friedemann <mfr@bmx-chemnitz.de>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Oliver Schwartz <Oliver.Schwartz@gmx.de>
Cc: Pavel Rojtberg <rojtberg@gmail.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Steven Toth <steve@toth.demon.co.uk>
Cc: Vojtech Pavlik <vojtech@ucw.cz>

Lee Jones (10):
  Input: adi - prevent off-by-one write in adi_read_packet()
  Input: adi - validate axis and button counts in adi_id_decode()
  Input: xpad - cancel presence work on xpad360w_start_input() failure
  Input: aw86927 - use devm_work_autocancel() for haptics play work
  Input: stmfts - fix i2c_smbus_read_i2c_block_data() check in status
    sysfs
  Input: xen-kbdfront - check info->ptr and info->kbd before
    dereferencing
  Input: drv2665 - disable haptics work across suspend and resume
  Input: drv2667 - disable haptics work across suspend and resume
  Input: goodix_berlin_i2c - check i2c_get_match_data() for NULL
  Input: goodix_berlin_spi - validate ic_data and SPI max transfer size

 drivers/input/joystick/adi.c                  | 45 ++++++++++++++++++-
 drivers/input/joystick/xpad.c                 |  6 ++-
 drivers/input/misc/aw86927.c                  |  6 ++-
 drivers/input/misc/drv2665.c                  | 15 ++++---
 drivers/input/misc/drv2667.c                  | 15 ++++---
 drivers/input/misc/xen-kbdfront.c             |  7 +--
 drivers/input/touchscreen/goodix_berlin_i2c.c |  3 ++
 drivers/input/touchscreen/goodix_berlin_spi.c |  6 +++
 drivers/input/touchscreen/stmfts.c            |  5 ++-
 9 files changed, 88 insertions(+), 20 deletions(-)

-- 
2.56.1.839.g22a8290db9-goog

