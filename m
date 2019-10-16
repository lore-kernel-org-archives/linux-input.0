Return-Path: <SRS0=zBm3=YJ=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB72FA372A
	for <linux-input@archiver.kernel.org>; Wed, 16 Oct 2019 18:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CBA218DE
	for <linux-input@archiver.kernel.org>; Wed, 16 Oct 2019 18:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKzCYocP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394201AbfJPS3y (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 16 Oct 2019 14:29:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43446 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390895AbfJPS3y (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Oct 2019 14:29:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so14771166pgl.10;
        Wed, 16 Oct 2019 11:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvifzWDCQhUAdf6h8IzSX/VKb7zxn2Dze8xNDgtcfPM=;
        b=gKzCYocPVCKnm+FvmCUAADMmF0VsWh8n5b1UtNBfvgU/WbTsu1dHUqbnrXWQnaNXAF
         toPg+REa5MGrXOKsEwDDCgWqlR0Jr2UU0HtDdc2x6e3p/juwTIohDED2B6AtgUktvaz+
         oafStIuP+YkSc7APfXPLVoFc9uUl0qO4QbfeOiKLKUGa0OHG056e8ff4lEr3+t8q1258
         PeuI8+gdmi4tIZ3qNoAaSquW1tgmveJMCrnYpC0g1r4TInggfQWEqokKcZbOZ65tqkBv
         qrcTHOZ9XRzY1lBmxuGRWLtDHrFOB5JgROXpLRXnW+MXsPmGbwsm8DIsSKbXSCjOXk1l
         Ia+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvifzWDCQhUAdf6h8IzSX/VKb7zxn2Dze8xNDgtcfPM=;
        b=B5oL8v4ihF4JT4WVGKh5K6D/QkWPqbz0ANCe/tPEObBk92/+p/PqISB27Ubh/QCuxF
         VsrVNxdgbI+Y9dxg3RdkFPe977EjtTuNjq7Rulrxb/A9Vyn4Y75lxw4QFMrbcCI/4PoO
         zR5ODzR8S5WuZTQhnFAJaRq9pYPnEJFbgavGFJrczhdoMYWTgYETq+Xkqs75ooOYDlfI
         DxBE69aspxElnegAmxW9nkhHQtR6FyOOpodnTnDhmBe5EdCRsRsNyG3KiIvqbTgdo4Fb
         se/a/05/ipsAGeTQSd/Jwa4YkY/HiDI96RIoGGAybXRYEvDPkFYWwOHCk8wpjB2GKHOJ
         Bipw==
X-Gm-Message-State: APjAAAUBhGCETodjuIxbWIMLxNdRfqIBQU26jgbpWtw3YxZ8FNaWz2Gy
        JmI2nof7qxVRBybQIjq6cely9QPqg0Q=
X-Google-Smtp-Source: APXvYqxNTSFB7y4syFh0kOZ7D08togPiliMAIevR/iWBx9cCsqkifPDRYHEq+NUmxCMyxLywjQqe/w==
X-Received: by 2002:a63:c748:: with SMTP id v8mr46661697pgg.348.1571250593106;
        Wed, 16 Oct 2019 11:29:53 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:8061:1b46:c3ff:7f12:48ed:6323])
        by smtp.gmail.com with ESMTPSA id z4sm2980127pjt.17.2019.10.16.11.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 11:29:51 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Sam Bazely <sambazley@fastmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Austin Palmer <austinp@valvesoftware.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Logitech G920 fixes
Date:   Wed, 16 Oct 2019 11:29:32 -0700
Message-Id: <20191016182935.5616-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Everyone:

This series contains patches to fix a couple of regressions in G920
wheel support by hid-logitech-hidpp driver. Without the patches the
wheel remains stuck in autocentering mode ("resisting" any attempt to
trun) as well as missing support for any FF action.

Thanks,
Andrey Smirnov

Changes since [v1]:

     - "HID: logitech-hidpp: split g920_get_config()" is changed to
       not rely on devres and be a self contained patch

     - Quirk driven behaviour of "HID: logitech-hidpp: add G920 device
       validation quirk" is replaced with generic validation algorithm
       of "HID: logitech-hidpp: rework device validation"

     - Fix for a poteintial race condition is added in
       "HID: logitech-hidpp: do all FF cleanup in hidpp_ff_destroy()"
       as per suggestion by Benjamin Tissoires

     - Collected Tested-by from Sam Bazely for "HID: logitech-hidpp:
       split g920_get_config()" since that patch didn't change
       significantly since [v1]

     - Specified stable kernel versions I think the patches should
       apply to (hopefully I got that right)

[v1] lore.kernel.org/lkml/20191007051240.4410-1-andrew.smirnov@gmail.com

Andrey Smirnov (3):
  HID: logitech-hidpp: split g920_get_config()
  HID: logitech-hidpp: rework device validation
  HID: logitech-hidpp: do all FF cleanup in hidpp_ff_destroy()

 drivers/hid/hid-logitech-hidpp.c | 237 +++++++++++++++++--------------
 1 file changed, 131 insertions(+), 106 deletions(-)

-- 
2.21.0

