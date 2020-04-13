Return-Path: <SRS0=iUnu=55=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A10FC2BBFD
	for <linux-input@archiver.kernel.org>; Mon, 13 Apr 2020 18:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADC320737
	for <linux-input@archiver.kernel.org>; Mon, 13 Apr 2020 18:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msaOcQ77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbgDMSme (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733067AbgDMSmc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Apr 2020 14:42:32 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A915C0A3BDC;
        Mon, 13 Apr 2020 11:42:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f3so10483388ioj.1;
        Mon, 13 Apr 2020 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUwpLr7H3CWr7Gx8F04TUo2T/8suj5UNrxDHjUUZvKg=;
        b=msaOcQ77WoCp08XUHtZBYXn+v79SNgrmzk5f9WkKnriOsGUpFtv2thcgRlpZNsKxh6
         QmQI+GzrTKcamSbRgBicUxDhx+Kn9y9X753/EAcBW5Et5eVBmgmCmmPwTco7zy12cr0J
         Ia9jdXLHKOLrE3xZuSpRjK7Q5PciG0tOu3ohkxYYoENjLScDDkYV1yF5FFw1H/rMTucm
         4UW6oJOY5y0mow2FFVb/nT3JFuo6aACxKYZnuXlS48nN4o4Zwx0arG7FeOt1xw1pzRQo
         iiptZlkihflts5Vd5bYFraDdAqp13255vB4EWJCynIVGSEh3TP4Rhsx/bqTYnNNTzSod
         wJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uUwpLr7H3CWr7Gx8F04TUo2T/8suj5UNrxDHjUUZvKg=;
        b=PKuBNveFoXyEJahw6HwZQb2P/29EPV+aDi//ZMi08VvlJjAMPSihQMxzT+tObr8TBW
         Bh6AGq6Zl3Hyo7aHrbYhmh2o6hJVc5FJ1vW+SSN8txBaZMaWSnaeZTqva0NZWTEfcQp3
         zOQcf3k2mMZKMzS6OK82iI/TN5u6TpK0pWK9i0vkwt4BhjcdIwkYBXlA/tor6BkEUg5Y
         4QOXy1JaREfMO3pG2cvC2WjoM8xglLvG/rV0f9gUgs59WODI5R+l2m5oYd1ge7u40BSx
         rKeLA7PXKrDMRAkubjcGLE1RcLNDutqPPmK+qkMdYiMi7rRw0UPc//Ne/Cw+Gd6fGmrS
         S+Zw==
X-Gm-Message-State: AGi0PuZ9dBoj/Oq2TONU5Vt6Usk1Pp/xypeBXjqVkPM35um0u/pCq2rt
        VA1sGuaKdqZMQvWf5TgznZDKTxYD
X-Google-Smtp-Source: APiQypJPohEk9ESmF09tf/pWvi+u3JpBQ8Yr2dx6KqgK8CgXgnXXQk6KO2enx6eyA6Uw6lhmIDSH2A==
X-Received: by 2002:a05:6602:5db:: with SMTP id w27mr5680022iox.152.1586803351007;
        Mon, 13 Apr 2020 11:42:31 -0700 (PDT)
Received: from james-x399.localdomain (97-118-146-253.hlrn.qwest.net. [97.118.146.253])
        by smtp.gmail.com with ESMTPSA id 79sm4111565ila.54.2020.04.13.11.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 11:42:30 -0700 (PDT)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        James Hilliard <james.hilliard1@gmail.com>
Subject: [RESEND PATCH] Input: usbtouchscreen - add support for BonXeon TP
Date:   Mon, 13 Apr 2020 12:42:17 -0600
Message-Id: <20200413184217.55700-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Based on available information this uses the singletouch irtouch
protocol. This is tested and confirmed to be fully functional on
the BonXeon TP hardware I have.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
no response in over 2 weeks
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
2.20.1

