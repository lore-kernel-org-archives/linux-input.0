Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AACAC2D0E4
	for <linux-input@archiver.kernel.org>; Thu, 19 Nov 2020 05:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F2C246EF
	for <linux-input@archiver.kernel.org>; Thu, 19 Nov 2020 05:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fourwalledcubicle-com.20150623.gappssmtp.com header.i=@fourwalledcubicle-com.20150623.gappssmtp.com header.b="Lz//a52Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgKSFzo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 19 Nov 2020 00:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKSFzo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Nov 2020 00:55:44 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5B2C0613D4
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2020 21:55:44 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 34so3225758pgp.10
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2020 21:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fourwalledcubicle-com.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+JPnm8GKC4NaaJXg8vIcLPd12LO4cKqUHmOn0ptDmCE=;
        b=Lz//a52Y8ye/dxstAVh1GeA1CkOsDQd/WH8zYbDowchvKfu6idGPalcBp+AVunbOsG
         qNOJVsWMw11P5RI3Lk8PMLFQuBXBUNUDiZiSUhCxaWhTCTbH3PivnvXn4yQyAelJ2BFy
         /DO23xedKl0VWMl8zgT/Bzst9W2Fa9iVHowgsV+a343jX/qwlOWj4nNtMDOUhGRqWfpx
         YnBPL+rX/qJslQd0DkOgWHI/52YiK+J1b39rFy40lI7YHw43zGPM8IN+TMHqA4c+Fiu4
         KwTB3AHrfrhgnaF1erxtOyeqRFDyhXuGUiQPH/4dkvYHz0v/DWiFu13DOukdC3/aVEhQ
         MF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+JPnm8GKC4NaaJXg8vIcLPd12LO4cKqUHmOn0ptDmCE=;
        b=snBdlutEs9lcxKNa7LcEHEm9+wzx5PZJCWmg0YShEwrofltl0ytchLcABmFZMQj6LT
         tPVuHtr7umMyl3wi9Byh5HlQxelOkkofWq/PvyFyfRVI1a4SwtvGUm3dSH1c8vdASBOG
         8gStgVWsMwwISsA7dQqATXVXDkY+34tCGkEyHHFilOq5NWJ/gYj9g9sM4+nxfdbMYybc
         0rFGRHYCRzJ+LN3IFhehAPrEEHj+Cb2qtDWAWf9zRgVz8u7bptzjVpCtByh2KQmcUD1K
         rQL2fv+GoyW75Sze6tHPMKcIT4vPHK25pNDasfKJmLy0uQ+ozaPLel9Z82xIxeK1nPJl
         93Qg==
X-Gm-Message-State: AOAM530Uu1VlTAxFyZ4YSr92D1hSYlCDMfwGbLpdrOVzCwPGGBUrHazg
        CL4x86fKceoSBjgvCdXOdip9wnt8Oy/sZQ==
X-Google-Smtp-Source: ABdhPJyGk/9TNW96Dw9opwVmtsb40uPQj0UmAhsEKO+Gd3LMBOwlBZq36GRT8MrOgLNCSsykl2mKzg==
X-Received: by 2002:a17:90b:3781:: with SMTP id mz1mr2648337pjb.229.1605765343388;
        Wed, 18 Nov 2020 21:55:43 -0800 (PST)
Received: from [10.0.0.4] (203-123-108-233.ip4.superloop.com. [203.123.108.233])
        by smtp.gmail.com with ESMTPSA id h11sm6092433pfr.25.2020.11.18.21.55.41
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 21:55:42 -0800 (PST)
To:     linux-input@vger.kernel.org
From:   Dean Camera <dean@fourwalledcubicle.com>
Subject: [PATCH 1/2] Increase HID_MAX_BUFFER_SIZE to 8KB to support
 additional, devices.
Message-ID: <1079ed64-4cfe-93dc-edda-bc6a01503659@fourwalledcubicle.com>
Date:   Thu, 19 Nov 2020 16:55:38 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Currently the maximum HID report size which can be buffered by the
kernel is 8KB. This is sufficient for the vast majority of HID
devices on the market, as most HID reports are fairly small.

However, some unusual devices such as the Elgate Stream Deck exist
which use a report size slightly over 8KB for the image data that
is sent to the device. Reports these large cannot be buffered by
the regular HID subsystem currently, thus the only way to use such
device is to bypass the HID subsystem entirely.

This increases the maximum HID report size to 16KB, which should
cover all sanely designed HID devices.

Signed-off-by: Dean Camera <dean@fourwalledcubicle.com>
---
  include/linux/hid.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 58684657960b..2faa7aba67ed 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -494,7 +494,7 @@ struct hid_report_enum {
  };

  #define HID_MIN_BUFFER_SIZE	64		/* make sure there is at least a 
packet size of space */
-#define HID_MAX_BUFFER_SIZE	8192		/* 8kb */
+#define HID_MAX_BUFFER_SIZE	16384		/* 16kb */
  #define HID_CONTROL_FIFO_SIZE	256		/* to init devices with >100 reports */
  #define HID_OUTPUT_FIFO_SIZE	64

-- 
2.25.1
