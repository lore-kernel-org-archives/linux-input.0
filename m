Return-Path: <SRS0=yABA=YB=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E0C10F14
	for <linux-input@archiver.kernel.org>; Tue,  8 Oct 2019 22:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB15206BB
	for <linux-input@archiver.kernel.org>; Tue,  8 Oct 2019 22:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CzDAXewQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfJHWhZ (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 8 Oct 2019 18:37:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37967 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHWhZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Oct 2019 18:37:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so265202pfe.5
        for <linux-input@vger.kernel.org>; Tue, 08 Oct 2019 15:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VC4mv5XGXFruUlsFXW0NMhXbbPQw/AuYeawaNDJPGzY=;
        b=CzDAXewQ/uqRQSI/BP3FF11jEUDkE2OG4DlXubxjf9hE0jRUkIjqtwa9rzyJvPHRzN
         gElY4mMMN9fKegzA4yKqmZQVgnUjTGcQjkV3VMgYyF/8uZFntijtBWPWy2pkOHPRlPiv
         0TjdJ5pvEWIvM6QbQDQdLz14P0gYPaLsp7Obk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VC4mv5XGXFruUlsFXW0NMhXbbPQw/AuYeawaNDJPGzY=;
        b=Ln3wEUdSt5vuwyhIlFlnADwv6lALjMA7n+wpuzslVaETJSfsSd1TKyz7EacCdARv6J
         lUWTKK3CT6kDM01okBPsmcBZf+o6RAurk4PXJudHXJtjgY/4JK1jG8WUYnX0UOOcgO7w
         YKpghbHIpsYilJUCTFYXNb/eo4IU/emxq8SLLrK/DmR1B2GpixgGt0l7XxWsY+GwPv9z
         M+R53dk+lXI28rzEDiKIahvK8iNmI6kqo9b9O9qd/bqDaZCTYBU0Y1COPmkvfxz5aJbq
         aIxA2mG+olvCTpEKORvQY8ogRTd0dmthPBhbNlfzgM0Ug49ys1RRLR/wq5pEhZjL+YAW
         HTvw==
X-Gm-Message-State: APjAAAXnDIiR7uosECN31coU+1ZmqNolJKHyjxmMVml7R0YIym1GorCK
        APjKIgw1S+Ci/ZL1ZMttiz9DJw==
X-Google-Smtp-Source: APXvYqyvaJMeZH6ePWzFr5kVaFOzZKJbJs8zMQFzVdOdIeH5Wqei8ceB+YRil6sz2ZBr/2TdtbWKvw==
X-Received: by 2002:a63:27c1:: with SMTP id n184mr771895pgn.193.1570574243485;
        Tue, 08 Oct 2019 15:37:23 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id p11sm183106pgb.1.2019.10.08.15.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 08 Oct 2019 15:37:22 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Evan Green <evgreen@chromium.org>, Pan Bian <bianpan2016@163.com>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-input@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] Input: synaptics-rmi4 - Avoid processing unknown IRQs
Date:   Tue,  8 Oct 2019 15:36:57 -0700
Message-Id: <20191008223657.163366-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20191008223657.iw-Ch5BFwP_2nQbaYYPEXwiyJq9xg6jt-O7tu9zLrVc@z>

rmi_process_interrupt_requests() calls handle_nested_irq() for
each interrupt status bit it finds. If the irq domain mapping for
this bit had not yet been set up, then it ends up calling
handle_nested_irq(0), which causes a NULL pointer dereference.

There's already code that masks the irq_status bits coming out of the
hardware with current_irq_mask, presumably to avoid this situation.
However current_irq_mask seems to more reflect the actual mask set
in the hardware rather than the IRQs software has set up and registered
for. For example, in rmi_driver_reset_handler(), the current_irq_mask
is initialized based on what is read from the hardware. If the reset
value of this mask enables IRQs that Linux has not set up yet, then
we end up in this situation.

There appears to be a third unused bitmask that used to serve this
purpose, fn_irq_bits. Use that bitmask instead of current_irq_mask
to avoid calling handle_nested_irq() on IRQs that have not yet been
set up.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 drivers/input/rmi4/rmi_driver.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 772493b1f665..190b9974526b 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -146,7 +146,7 @@ static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
 	}
 
 	mutex_lock(&data->irq_mutex);
-	bitmap_and(data->irq_status, data->irq_status, data->current_irq_mask,
+	bitmap_and(data->irq_status, data->irq_status, data->fn_irq_bits,
 	       data->irq_count);
 	/*
 	 * At this point, irq_status has all bits that are set in the
@@ -385,6 +385,8 @@ static int rmi_driver_set_irq_bits(struct rmi_device *rmi_dev,
 	bitmap_copy(data->current_irq_mask, data->new_irq_mask,
 		    data->num_of_irq_regs);
 
+	bitmap_or(data->fn_irq_bits, data->fn_irq_bits, mask, data->irq_count);
+
 error_unlock:
 	mutex_unlock(&data->irq_mutex);
 	return error;
@@ -398,6 +400,8 @@ static int rmi_driver_clear_irq_bits(struct rmi_device *rmi_dev,
 	struct device *dev = &rmi_dev->dev;
 
 	mutex_lock(&data->irq_mutex);
+	bitmap_andnot(data->fn_irq_bits,
+		      data->fn_irq_bits, mask, data->irq_count);
 	bitmap_andnot(data->new_irq_mask,
 		  data->current_irq_mask, mask, data->irq_count);
 
-- 
2.21.0

