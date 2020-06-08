Return-Path: <SRS0=8jYR=7V=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6C8C433E0
	for <linux-input@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD64720884
	for <linux-input@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658289;
	bh=PWB2t7f58OTgQdOQWXKpGzdge1XV4v+1OvpmDWYEvUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1/jZ/ZIdZMksGW7x+oGGnIsvscXzRPoKT4Sev6Rdpw/aeygmNQmTe0L4dGDd3qF6T
	 nIuNpTrIPxsYe9GBBjXjYGoLExbUzajYbX9/dgRsvp++G1cEQw7IHiOx5KpGjFuu5R
	 fRuj98sLakrEYIyPVeO5jXD8vWpMJOoTXySJ489Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgFHXSF (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgFHXSE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 8 Jun 2020 19:18:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0046E2089D;
        Mon,  8 Jun 2020 23:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658284;
        bh=PWB2t7f58OTgQdOQWXKpGzdge1XV4v+1OvpmDWYEvUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N4fmsvgenQuY2IoUcE/sRJdhBQSSdd3l3VCjLGuYM7X2dga0Ima3QD+AEiLz6K0av
         ILzZG4u6YYnuP03eaFc2MwPHRgnXHfuCUpNOyTclZnvYQT4r8xAZ1x+XMoWPwS0m+i
         Aw9UAoeF/nNlZtpqITG/AyY3s0LTcFLHqb/KySN8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 289/606] Input: usbtouchscreen - add support for BonXeon TP
Date:   Mon,  8 Jun 2020 19:06:54 -0400
Message-Id: <20200608231211.3363633-289-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

From: James Hilliard <james.hilliard1@gmail.com>

[ Upstream commit e3b4f94ef52ae1592cbe199bd38dbdc0d58b2217 ]

Based on available information this uses the singletouch irtouch
protocol. This is tested and confirmed to be fully functional on
the BonXeon TP hardware I have.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Link: https://lore.kernel.org/r/20200413184217.55700-1-james.hilliard1@gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/usbtouchscreen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 16d70201de4a..397cb1d3f481 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -182,6 +182,7 @@ static const struct usb_device_id usbtouch_devices[] = {
 #endif
 
 #ifdef CONFIG_TOUCHSCREEN_USB_IRTOUCH
+	{USB_DEVICE(0x255e, 0x0001), .driver_info = DEVTYPE_IRTOUCH},
 	{USB_DEVICE(0x595a, 0x0001), .driver_info = DEVTYPE_IRTOUCH},
 	{USB_DEVICE(0x6615, 0x0001), .driver_info = DEVTYPE_IRTOUCH},
 	{USB_DEVICE(0x6615, 0x0012), .driver_info = DEVTYPE_IRTOUCH_HIRES},
-- 
2.25.1

