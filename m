Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA6AC63798
	for <linux-input@archiver.kernel.org>; Tue, 24 Nov 2020 00:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A67D20757
	for <linux-input@archiver.kernel.org>; Tue, 24 Nov 2020 00:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MN+DbKJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgKXASN (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 23 Nov 2020 19:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgKXASN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 23 Nov 2020 19:18:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90EC0613CF;
        Mon, 23 Nov 2020 16:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=IRwT8ni4gQXs83Ie8xeNO7BaW1j7eb1OWQoAOh02zS8=; b=MN+DbKJrhCQVYC9Ov3p2kOCx0n
        DY1lVaa9NXneHBLrLzDqKpBsOcoCCCdkFbUs/FJ4eLygZkuxzZOvMHxWK0F0HDB7PqURtRU3ItH0a
        WTCyyFJcNluHBKBvp76qMLOCMlQHRIh0FKkLDClTcJLrStxjgI4UmPpbnrX1Xs3tBWIEoBDh/S+Nb
        KHbkF7titRCxXkMZ4YDYiWo7vMrFkPvYVTf7a8a5b1502DFqUerV8t5YdQ+Ej17bQBu5i3GraIg01
        ScapyiBucWzHq7dGhDnuz7rZaFapdisiQ6BsIEaNuFDibG2QTIWvLO+l1yb/G/XQl95wwGaDtkyXs
        fkCJgk/Q==;
Received: from [2601:1c0:6280:3f0::cc1f] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khM25-00024B-H3; Tue, 24 Nov 2020 00:18:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH] input: soc_button_array: fix IRQ-related build errors
Date:   Mon, 23 Nov 2020 16:18:02 -0800
Message-Id: <20201124001802.10094-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Fix these new build errors by adding <linux/irq.h>:

../drivers/input/misc/soc_button_array.c: In function ‘soc_button_device_create’:
../drivers/input/misc/soc_button_array.c:156:4: error: implicit declaration of function ‘irq_set_irq_type’; did you mean ‘acpi_dev_get_irq_type’? [-Werror=implicit-function-declaration]
    irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);
  CC [M]  drivers/rtc/rtc-ds1343.o
../drivers/input/misc/soc_button_array.c:156:26: error: ‘IRQ_TYPE_LEVEL_LOW’ undeclared (first use in this function)
    irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);

Fixes: 78a5b53e9fb4 ("Input: soc_button_array - work around DSDTs which modify the irqflags")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
---
 drivers/input/misc/soc_button_array.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20201123.orig/drivers/input/misc/soc_button_array.c
+++ linux-next-20201123/drivers/input/misc/soc_button_array.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/input.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/dmi.h>
