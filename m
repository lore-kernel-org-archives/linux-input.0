Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5180AC433F5
	for <linux-input@archiver.kernel.org>; Thu, 24 Feb 2022 11:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbiBXLDb (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 24 Feb 2022 06:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiBXLD2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 24 Feb 2022 06:03:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 422E928F94A
        for <linux-input@vger.kernel.org>; Thu, 24 Feb 2022 03:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645700578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MSPfmoOzJUMcBzRlalcicBEMDTNz1Ggdh9kgWGb6v0U=;
        b=UbW6g8CCnBMP7HYzMO+seUKDMCfYEei9zCOUQyjzQ65WKm5fGvt4SXBH0NppjIrGPt/hqG
        TjsV6dm/JB2BUrh+hfelSbQKnz4owcGh/uZYrzbmcYEVL5kebcFWL4KapnxYGPebX7/3mE
        tZJdBWaJbwf94gfULLRLozuZdJs7f/M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-2CJGrd4IPFuSOoAjxRoMfQ-1; Thu, 24 Feb 2022 06:02:53 -0500
X-MC-Unique: 2CJGrd4IPFuSOoAjxRoMfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B194651D5;
        Thu, 24 Feb 2022 11:02:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.195.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6E047B6FD;
        Thu, 24 Feb 2022 11:02:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/2] Input: Replace surface3_button code with soc_button_array
Date:   Thu, 24 Feb 2022 12:02:39 +0100
Message-Id: <20220224110241.9613-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi All,

I noticed that the surface3_button code was pretty much a 1:1 copy of
soc_button_array. This series adds support to soc_button_array for the
MSHW0028 device on the Microsoft Surface 3 (non pro) and removes the
now no longer needed surface3_button driver.

Rafael, this includes an addition to ignore_serial_bus_ids[] in
drivers/apci/scan.c, may we have your ack for merging this through
the input or pdx86 tree please ?

Dmitry, I believe it would be best to keep these 2 patches together
and merge both through either the input or the pdx86 tree. If you
are ok with me merging this through the pdx86 tree may I have your
Ack for that ?

If you prefer merging this through the input tree please consider
this my ack for also merge 2/2 through the input tree.

Note both patches can also be merged through separate trees without
issues but keeping them together seems better to me.

Regards,

Hans


Hans de Goede (2):
  Input: soc_button_array - add support for Microsoft Surface 3
    (MSHW0028) buttons
  platform/surface: Remove Surface 3 Button driver

 drivers/acpi/scan.c                        |   5 +
 drivers/input/misc/soc_button_array.c      |  24 +-
 drivers/platform/surface/Kconfig           |   7 -
 drivers/platform/surface/Makefile          |   1 -
 drivers/platform/surface/surface3_button.c | 247 ---------------------
 5 files changed, 28 insertions(+), 256 deletions(-)
 delete mode 100644 drivers/platform/surface/surface3_button.c

-- 
2.35.1

