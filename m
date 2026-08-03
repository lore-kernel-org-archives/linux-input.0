Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6763267B07;
	Mon,  3 Aug 2026 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769652; cv=none; b=a1ufU++QPRAApPAGv/lOp8jcrO0X5DFvcLbsMn2ekbOquDJok3n9E4oIrZtLr90Cd8ljXcEg+MOUGk0Ve1Dai5ou+WikLGRowAy9UuRraB3cD/MMetV+coF8Pff93OOBNrCAN18Q4o4/gppax0gOKsapNbMVhKEzMY96L1FYVH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769652; c=relaxed/simple;
	bh=9Z9BeC2TmEgWz2CTHQ3w5ZT6IX3U6Dx9JEK3kUhxVig=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=efi9vnH/6sh00zeD2MC6Ll6L5ulfGiorpVyHTV2O3KdiZDORuT3lHmds2yau7JNL5SKCR/UOCODVLTGAgPfAOTM22b5SX09UmrA3OSDgzQi/Cdwhu6OiDXDsf+mt2mUc/PD7zOCosP4Ysq28vXaakRCP+nSEfNZcpO03mYsojtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=YnVhG1Ro; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TMpbTQlG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="YnVhG1Ro";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TMpbTQlG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0546C1400045;
	Mon,  3 Aug 2026 11:07:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 03 Aug 2026 11:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1785769650; x=1785856050; bh=Qg
	x0l6DeEwG2EmA54rMfVRCL0Ozw8gtmOrSQ3FlpszE=; b=YnVhG1Rox36qHsc/lp
	DtH8G45Uw5JJdzaAntdeJI5Liz0rutfHDAEtvLrD2nTZQm43N01q0COOrppSOAjI
	qhr/hBkuDbsvfTNvWfofW43vuVllS21cCnr4RRRedCEH3pXtdIjV3hSFgnDAKybL
	pxMmbUZIcP/RwH/XIrc0TPsCE7Ovea040picw6/MpWOOMBZpfBxfF9hW06ubCFjT
	iT9nxIfZ+t1WcO0YKDpBGBB6Gj8HRjicOUJSC5iOTAVf6ZuIU4EC3PNI9DnmbK+U
	5s+opY72tkgWm5xp1FwvSWMrVWDf/nUQlBjCnEZL0VJTyj/j+AhyyLuR8W80o5V0
	nmVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1785769650; x=1785856050; bh=Qgx0l6DeEwG2EmA54rMfVRCL0Ozw
	8gtmOrSQ3FlpszE=; b=TMpbTQlGkxyOVFQgpXP0r4NutNrEP2EOwJZuBbA+N7Nj
	nxUPUGyovPlTY61qlyKybtF+odVBHSF57ld0lo7STzBpzZmLaYv2GImjHLZ0O5Mw
	DhF7MF7EzfSYig+QXVjvILlpt+ln8Prs9kbZhLpGXuhluKtWY213NGbk3vSl+qfH
	VvOwtObMkx5wXZ54xRHkDaSZp8SkM+CGniM77GQ1sEsgz0eQeYQHr3mXSXzw8BtL
	Yw631lQpdgvnfwDjacsNgcjowsFdbDWf9ZviKYiL7NEdse9ZNrHxM/Z5C6XT8Gdp
	HMfQeSAALWBhBx/Er6DOutALgacyZkR2MLugXsnQpw==
X-ME-Sender: <xms:sa5wajQsix1oegw6uaB1j0KqHl6uSHA7rpna2W5sBq3pWXr4MaZ5yQ>
    <xme:sa5wauH51VlF-KkWZvCPmti7Vm6fG1vznFfuLA7rnvUQXNtPt3zI1u-YSSNp0uGJJ
    4eDRkm5KyIVCKwhImgHdSa3_vpZ5T26OQLRlRQZrD5y0JzH8ZE>
X-ME-Received: <xmr:sa5wagFafV5TgTMZf3BY1senYZQUJysVfzS9dN0hQJtdndqBYq6lbc5P14GZzp-YwUwDG7BVBgpBHrF4nSKppEWDaAyU8IqZILbWieothHjCDPKOuzk>
X-ME-Proxy-Cause: dmFkZTGJ1qsNrjx6n8JFo5JhEOFdjTZox+Es45Uel/wceffw/PpI4ryiyH8Yjnhe14Lwtt
    F8PgEKO43G1kbhO8uEvZO1VmicJPb1YzXjVq/BSisPYSaVM89rLRr+eODOCyZpJ5fp+yt9
    kmhrDIvlpVk/3zc+d4Kt9/E6LdM8Mlz797X06H2MtrPZEgoLj972wGyxAywxG5C7I3yPlI
    DfAoTXSHGBWG8/9sKTMeQfaKw/+myWtJMjeBzJbpIhWFuDioOrSzaNt8TJDVMYkyCFw4BM
    OlacRlCT5rOKMwbiAxfnrFuYek3i90a3lUijWZqGrP2XKFwh019AIdtD0uSgT5ccGIUQGn
    fW+21G+grjkluwLifmoGtS5rr924pQc3/aG8shdIb+uD3bUsoL8Wp/fEJL9dqNYihxcYDV
    EAuTaVS1PCmMec+wxWN4RwNIAUJjXevhdxfbL7M8k1yr39jyvJnxBD7OaKdsq1qg4vthbV
    UCVqMmSst1K246aUEp/iic3sc0zYSsnsZynQFbd3MEbKdKwphg8TlpWj9/wDTpu2Txk+WJ
    vRcBgfXTAEFMl5mdFARt64RU9D+WsaWf9SbvkhX8dDZW4h9xzibZuucUTcrFMDX1aayLW5
    M8CgcrOZXlbQnVKpBkVdcpsolu77Mr5tYzL0M3kWle8bPbt+CwXB/pjvQPdA
X-ME-Proxy: <xmx:sa5wakRXWEB1WRThG-OB8DJYKy6CvOdhL5QQZ3lEmwJTjszHUuoptA>
    <xmx:sa5wapK2vDwqkVNXtkdknYdvlXLObzjF9kZrR4wAOtEnso4G21mwig>
    <xmx:sa5wanbsxlGa0A2msDzm1bNi9BlSNR43LVVN7FqcgibVShVQ0-yyqw>
    <xmx:sa5waj-OMMZJj7Jiu3SBmS7yn4PEYOBUuvGPDgX0xEI7YflCbxkyjw>
    <xmx:sq5waom5-QSZGZAUMojBlnVX6RcLWbSv71p-XfOACdrNGsdvBO3wAqFV>
Feedback-ID: i1d2843be:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 11:07:28 -0400 (EDT)
From: Griffin Kroah-Hartman <griffin@kroah.com>
Subject: [PATCH 0/3] XPAD safety strengthening
Date: Mon, 03 Aug 2026 17:07:23 +0200
Message-Id: <20260803-xpadone_packet_fix-v1-0-280da203f15c@kroah.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPhuwKdjaqxSRuJnUVYgh0SKId
 ze2j9/A/DslREGiV7FTxFeSzD7jVhbEg/EfKLHZpCtdVw/dqC0YO3t0wfCEpXOyqTtbRl87fjp
 H+Rgi8vyLvtu/09qP4OUq0XGcQH6xNHYAAAA=
X-Change-ID: 20260729-xpadone_packet_fix-3cdceb6fc8ff
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin@kroah.com>, Ingo Molnar <mingo@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785769647; l=678;
 i=griffin@kroah.com; s=20260706; h=from:subject:message-id;
 bh=9Z9BeC2TmEgWz2CTHQ3w5ZT6IX3U6Dx9JEK3kUhxVig=;
 b=sEpU66s7ecV4KfjI3+JxUXRgN0Cl7hc+WWdm6HMpXz0eju+ZPT/LUkfPcvdIKjkOUmXmRZp8m
 te6X8V6J7TPDRaBfG7N8/kaXcetd51bE1JQ1ee4yCetLNB8e/eF1gKk
X-Developer-Key: i=griffin@kroah.com; a=ed25519;
 pk=Hy1TuVHERdQhLAWwjmxLFNtGj7eEEjaZWPXehAlic5M=

A patch series dedicated to increasing the security of the Xbox
controller family input signals.

Signed-off-by: Griffin Kroah-Hartman <griffin@kroah.com>
---
Griffin Kroah-Hartman (3):
      Input: xpad - add safer data access framework
      Input: xpad - add sdata_check() to xpad controllers
      Input: xpad - add sdata_check() to xpad360 branches

 drivers/input/joystick/xpad.c | 240 +++++++++++++++++++++++++-----------------
 1 file changed, 142 insertions(+), 98 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260729-xpadone_packet_fix-3cdceb6fc8ff

Best regards,
--  
Griffin Kroah-Hartman <griffin@kroah.com>

