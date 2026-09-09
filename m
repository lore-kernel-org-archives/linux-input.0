Received: from outbound.st.icloud.com (st-2002b-snip4-1.eps.apple.com [57.103.78.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8753568FDF
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 16:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972794; cv=none; b=ayi0f+HkPtrclPBbG2BuQfeQpoj8Hzo4AKD4WVTx5YQrDhrlAGyQsozy7DDKeUTrmROHEaP0S9vEROleNxZctMLga0d6Lyss+ZyeDZtCukPt8zNVniAFvAoILdxZdLEfV7QYSz/6u/n+w47CmC72mMDmoTOU5yt0oQp5N8rW6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972794; c=relaxed/simple;
	bh=ptnBiAv2NdBFV5+zJN+shJVmNWDeNfDQ/lhL3+elnSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLkgWCeSISDR0yMVpfAChk288Mvv7uBMKIyaqxfXlPS+XBMDrB3/86maPV/HNF4Kd+oZBKPntlpTeBXX6yKJs5fZmBgVy2vPKSbsxv2F/MPMOB4QrxORV1kUAPUUksjIzCfYkvHy7fGMVo+WBxyZLgcYNR4RubKz7ey9MU118FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=RLUnFNo0; arc=none smtp.client-ip=57.103.78.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="RLUnFNo0"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id AA3D31800C06;
	Wed, 09 Sep 2026 16:53:09 +0000 (UTC)
X-ICL-RepId: 01a08716-6e5d-714d-8bc7-530779db5456
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQBOHVUZWQdDF0kFWRcOVk1aFV4MTRFdMFAbXwJCDxwTVhUTC1NWWxNVF0YJGQhdHRkKUFAPS1oVVRcOAkIfUB9MFldDRB8cGVoUXBhTRVEfVFhDGUVWaUELTx1dGVscQmRYVwkKAlEcVg1XQ1QEX1BUEVdQC1kCQg9ICl0OWgRFC00EQwReAEUATx5cGghfHVgCSQJ3AlEcVg1XQ1QEX04ZDEodUlZbE1UXRgk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1788972791; x=1791564791; bh=o0EI5/VGxTjC1ih9gnmDdYC5yAH3A6CSU6v73eQ9Jh0=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=RLUnFNo0V6FP9j72byWw2g1p4oUs6QqA+88xEcC/JAKmKnuJ0c+PLTgUgaVdpCDPsfyY8jS5DOZywORRNvir+i2O438AUUZOwM9KWazS4xQSWKDVqUJrQm9FSSFPp7CSF/UIb/4cQnTaHtwoCZpvYt3qBMVfuXeozwLRa2CEzn7BHqGZUs+4UtB6SafFjG2irOLR5drTRMQU//clwasBUYWYlW4b0+1NTp1pdBR5gv8JmmE2SGylbWlbvxm12QDUBRCnThCDCyVKmxcRR6x8nMlG57rRpjG9dZC5YeN0oP3fXZoChqz0ntL5Y3Kl7RnpmnEpB3L4lMmDU2bvOCoz/Q==
Received: from komputa (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id D118818000BD;
	Wed, 09 Sep 2026 16:53:07 +0000 (UTC)
From: Cristian Mazzotta <cmmazzo@icloud.com>
To: aer@tuxedocomputers.com
Cc: W_Armin@gmx.de,
	bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wse@tuxedocomputers.com,
	Cristian Mazzotta <cmmazzo@icloud.com>
Subject: [PATCH 0/4] HID: lamparray: fixes from testing on Acer Predator PT14-52T
Date: Wed,  9 Sep 2026 11:52:53 -0500
Message-ID: <20260909165257.352597-1-cmmazzo@icloud.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a62d1907-73cb-4cfd-98b1-7cdce3b37541@tuxedocomputers.com>
References: <a62d1907-73cb-4cfd-98b1-7cdce3b37541@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: sC1DnytlOZcSSjPLEs1H61qL5SI5fl2Y
X-Authority-Info-Out: v=2.4 cv=G6AR0tk5 c=1 sm=1 tr=0 ts=6aa18ef6
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10
 a=zMoZyIPnO1cA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yDUiu3_GAAAA:8
 a=Zae3AdlcDkO_k8ZRbu8A:9 a=gafEeHOdjwYkg5oUpzAY:22 a=Uh4tPsEYL5Xn7yYgV4Nn:22
 a=djM25Df-3sMe0xqo8c8Q:22
X-Proofpoint-GUID: sC1DnytlOZcSSjPLEs1H61qL5SI5fl2Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE4OCBTYWx0ZWRfX0kFIMB7wMDtI
 Ul1QNSPrLx0pTYLAlby8H4LxlZ33a3mMAqOYPnFzZLvEp2ImP/74JccZmTY+1CDBs3tTiPeWCYc
 Ua+ORABzbXLS005nu4ff17sqXlMpUDy016SuuiDKbIQxK+GIU/GtilGJCE/jeBd1sYMdkv2UcWE
 d6CwVLCjRDZpImbEm/QXf69WRtE9W5Q1NmiygUdfGR2GJ7yHZuOVQNPza6/ZJ7ZSYuU1IGxg5l7
 BDO4jha8qIZ2BtfMgroYLDLmVz/iTiAYXc64jN0ARFyaJlVsqq/ouAXQfL0dyAZFeCrkOjmyESc
 +wCJBLrZyOWS8enAklxM1maeTjAgs5cotUHyze/ITqOaZ7RL4ZF2P7+YPhftag=
X-JNJ: AAAAAAAB9YyaECuQ0LtCgHdRuPq2i/utXx/hMarfRBHDJtvkd1QRt05uOiNP3qrQIAIjv6eRrs1/+JqRoRWOe4pXSyKNTddtYdvtq6FLtscCb94sBJmCl6sYeDav+FQab/BhM/pBcgjC0c+K/oshfKxn26iibeZx+EDLDOL9LBBQFAA5yv4qrqKpfxQIayLYAPHP9eiJdbfW1yhUlD+xo1PQv6vXmIn2qAR4lIeRwGzYynuy823MiImoLf6d95llJTqJntPBUgEOGkL7ZdvFpQ249Bvn9Tc9R91TOYpYIelE3X57nQDBR/ZFPfC8M0FvcN7/FFfxwaZRE5amROG4l5VuGMJo5IwyMMbHOkpE/77pC3L3s+JNuxUmXK8y7x1iYOpgJA3awm53fbq54tTMHt2BBatwpCNyPQvwjZXMks6+oqNdI16y5XBjxsxm9YPOS8rZntGerpN7tqyowt8xt+Qpx7OmGTq+ZtOLiKu7o1w+wbswCeM2UI5ZStwWg5sRsUJYVfQhZNU/8w+xADkg4opirifRX7k1fYnVGXdSBh/LoLtSkQKcbTCRtly2Hv5q3DEK79+waN5/VzhoWbO8msjpvzPVIV3szJ0z1+ZsS4/ZnOrYxbPyjySFkvMA+mQ5hU8S3LQ1KJ2GUIdNzQmzSwZpBcWQ25BdWVtaU/dnvqvQNnWXuhdmKOS0vRKFSqZzZIDU+a30KqpO/PoPq5c15IVcehY0RHOgfu86lIWukNFHT8tIL6FCe0en28o1+oy1YIJKNgV+1i9Z0pGu+w3AMt8Mx1uas+JpMeMOK/KZTExkRkxR7NXRYnbbPJrvhmB5eiYUBNHaZzv7oksgCCSnL3eLEyvdMh81MLxULKemrL4Q4jVIkYmDobP7/FV2jTTtlnvL1PduQYrHsxx3cqNWlHgCHkYzSqotZHLjk9oVqmEkR3M3j2t5gHhkxhDiwpwFjpxZh/e8sDD2cdHVlYnmwoUMz8OesNX
 gbeM8Cjej/mG+J4YEQNX+/a6mkoykHBIT0++dcv0VqfMtOHEsxommYUux9TOdxcMsRFj+ECDd7IkojU6mL/Sf1nIp8waEjjjwKHY2TS8lvYrAVBw6LBm3GXzvdBFoLKJecapItc4mvYy2GGy/umuSn3GcGca6qCUDcZS5YKA1NoGsIlV317qoz8QtotpOZoyJmowF3GcE97hAb93z+qFO7DDs1HPOY/Ajn0MckFHknLcyGvIlJYoEBSJ9bTwmIqe8kRlBaGwrF+PQA6SPLW247Ik6EifS0A/kQFTqcV9qapwthJk/pTH4qAJKxdax4hEUj2C2xms=

These are four fixes on top of the v5 series, posted 2026-09-03:
https://lore.kernel.org/linux-input/20260903073602.3815258-1-aer@tuxedocomputers.com/

Tested on an Acer Predator PT14-52T, which has two LampArray devices: a
USB keyboard (05AF:767A) and an I2C ENE controller (0CF2:5130).

With v5 as posted, the keyboard does not probe. LampCount reads back 0,
and once that is fixed the level counts read back 0 as well, which
divides by zero in led_mc_calc_color_components() during probe and takes
the USB hub worker down with it. Patches 1 and 2 cover the reads and the
validation; this is the same problem Aaron and Werner discussed in this
thread, with a backtrace from hardware that hits it.

Patch 3 makes use_leds_uapi transfer control in both directions.
Autonomous mode is currently only set at probe, so writing 1 re-registers
the LED class device without taking the hardware back, and updates sent
afterwards are ignored.

Patch 4 blanks the lamps across suspend. On this machine, the lighting
accounts for 9.21W of the 12.35W s2idle power draw against 3.14W with
the lamps blanked from this driver, so this is most of the suspend power
on a laptop with RGB. This was also tested with one of the 2 lights on
the ENE controller still on; this patch does not control both zones.

Please treat these as input for v6 rather than a separate series;
squashing them in is fine by me, and I will rebase and retest against v6
when it arrives.

Two things I have not fixed:

- The ENE controller exposes two LampArrayAttributesReport collections.
  lamparray_parse_update_report() has no first-match guard, so the second
  overwrites the first and only one zone is claimed; the other stays in
  firmware control. This is the multi-zone question from Werner's reply.
  I really believe that multi-zone support should exist, but I have not
  included it because I haven't started it; uni is taking away a lot of
  my time currently.

- hid_device_io_start() in lamparray_register() may no longer be needed:
  hid_hw_raw_request() is synchronous and does not go through
  hid_input_report(), so it does not need driver_input_lock released.
  That would also address the second [High] item from the Sashiko review.

Cristian Mazzotta (4):
  HID: lamparray: read attribute reports synchronously
  HID: lamparray: raise log level of fatal probe errors
  HID: lamparray: transfer control when use_leds_uapi changes
  HID: lamparray: blank lamps across suspend and restore on resume

 drivers/hid/hid-generic.c     |  27 ++++++
 drivers/hid/hid-lamparray.c   | 162 +++++++++++++++++++++++++++++-----
 include/linux/hid-lamparray.h |  35 ++++++++
 3 files changed, 200 insertions(+), 24 deletions(-)


base-commit: 9b298109e37e5caf4b6800198c4907a5a6bf00ae
-- 
2.55.0

