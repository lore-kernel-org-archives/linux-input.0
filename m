Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8922DC433DB
	for <linux-input@archiver.kernel.org>; Sun, 28 Feb 2021 01:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DA364DEF
	for <linux-input@archiver.kernel.org>; Sun, 28 Feb 2021 01:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhB1B1f (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 27 Feb 2021 20:27:35 -0500
Received: from chill.innovation.ch ([216.218.245.220]:46722 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhB1B1e (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 27 Feb 2021 20:27:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by chill.innovation.ch (Postfix) with ESMTP id 4C8C96401B7;
        Sat, 27 Feb 2021 17:26:54 -0800 (PST)
X-Virus-Scanned: amavisd-new at innovation.ch
Authentication-Results: chill.innovation.ch (amavisd-new);
        dkim=pass (2048-bit key) header.d=innovation.ch
Received: from chill.innovation.ch ([127.0.0.1])
        by localhost (chill.innovation.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id rLSOAzMsa0yN; Sat, 27 Feb 2021 17:26:52 -0800 (PST)
From:   =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 321036400FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1614475612;
        bh=zURqOMgAiNjXHsgivuo5XODqpjhx+g4GziSUr/52jKo=;
        h=From:To:Cc:Subject:Date:From;
        b=UHaWyzg5zKoyLRKkv+G1Zy/uCIRYwfZYbZpH26dss4kkjvbZ0FIrBS6/5BjkNy4Mq
         SmkP6jPpT4rz3ER9qig3Vho4klXkUr0ul6guFgt6ieALQzaGQWZFNS7IKGlokLPWMX
         qTDpF3NQv7VnBmlv7j+mj6qgGzKYQnpQWlqinoaoBbTLSqeQk2rrYPb/d3mnDpIAjd
         KGnT+pj38vNccwivY6e4nmA6KQbmyigKbGPaffNQaEkak88FIxq2lYxRaVgVkxCS88
         4YV/0pii2uMmqwNhYbgYzCqw6AZ3FQH/ZI9RaJutKX2u2pDL5evDZE62DdNa6osbH4
         gB6habLfQ2U1Q==
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 0/5] Touch Bar and ALS support for MacBook Pro's
Date:   Sat, 27 Feb 2021 17:26:38 -0800
Message-Id: <20210228012643.69944-1-ronald@innovation.ch>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This patch set provides Touch Bar and ALS support on MacBook Pro's
13,*, 14,*, and 15,*.

Some time a go an earlier version of these were posted to the list;
all code comments from there have been incorporated. In addition the
approach has been cleaned up, especially given that we now know how
the 15,* models are implemented, so that the ibridge driver is only
needed for the pre-15,* models and the ALS and Touch Bar drivers work
unchanged for all models.

Ronald Tschalär (5):
  HID: Recognize sensors with application collections too.
  iio: hid-sensor-als: Support change sensitivity in illuminance too.
  HID: core: Export some report item parsing functions.
  HID: apple-ibridge: Add Apple iBridge HID driver for T1 chip.
  HID: apple-touchbar - Add driver for the Touch Bar on MacBook Pro's.

 drivers/hid/Kconfig                |   26 +
 drivers/hid/Makefile               |    2 +
 drivers/hid/apple-ibridge.c        |  682 +++++++++++++
 drivers/hid/apple-ibridge.h        |   15 +
 drivers/hid/apple-touchbar.c       | 1523 ++++++++++++++++++++++++++++
 drivers/hid/hid-core.c             |   57 +-
 drivers/hid/hid-ids.h              |    1 +
 drivers/hid/hid-quirks.c           |    3 +
 drivers/hid/hid-sensor-hub.c       |    6 +-
 drivers/iio/light/hid-sensor-als.c |    8 +
 include/linux/hid.h                |    4 +
 11 files changed, 2302 insertions(+), 25 deletions(-)
 create mode 100644 drivers/hid/apple-ibridge.c
 create mode 100644 drivers/hid/apple-ibridge.h
 create mode 100644 drivers/hid/apple-touchbar.c

-- 
2.26.2

