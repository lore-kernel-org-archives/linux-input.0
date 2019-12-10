Return-Path: <SRS0=db+e=2A=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E44C43603
	for <linux-input@archiver.kernel.org>; Tue, 10 Dec 2019 11:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A4B2073B
	for <linux-input@archiver.kernel.org>; Tue, 10 Dec 2019 11:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575977871;
	bh=jnMJOT8ZUpaiICJBhq1tb7n9Bk7PdqFGIl3ay2GHGMQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=AD+8nnPnDuWeW5GKWeFlk7ZTJaE3Z3igUhSrb3a+4P3/9qkRSTyvAbi2I2I+BkEx0
	 VHJiwHdDdVGx488kGpABd3FK7MrH1bu4bDYTNc33yS8eSy5lJ6mPiyJQP3ZhUfhj8D
	 qPc7dtSInkOpTC9hRK6ZsgPoNgJuzYs2+uBoUafI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLJLhu (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:37:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36585 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfLJLhu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Dec 2019 06:37:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id n12so13449726lfe.3;
        Tue, 10 Dec 2019 03:37:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZNh4wJZKItTijN7b21HY0LHSvrpQd4qo9HGr6Bov0E=;
        b=opQkfcEyqSy+csA1rofEkp47kBDF+RS+7SAIVI79+qe5WO8ojUs0ORHYwePDZDsOzQ
         ZDedP4lG/VtxU6JXvO1HZkQVErAI3YmzE33X4v7E2H/vFW058hQ+9LxPgkQjywiTBV5C
         9UcgjnI8FPWrNiGEfN0z/4K8ndKzt/4hhpDWclwPAZH+0CXpxL4yQv9Q77lrz9DFboUF
         +26NiMEFgCiGfXs90/R1KbedPKFJJb+1TrHSHhc5/MwVVSZsufH1xeU2VtRLZVVmcbFl
         DSuXEKwVHZ6AO6yo1MAOBs/X0G8KXAEvIWN5vTlr1U7176qEjL98wH5uvn5i6w9Wht73
         sKbQ==
X-Gm-Message-State: APjAAAUpKN5ZGiVKyFLM9pbbDqg+u8FV+YQ99RN3yL03KV8P67g1P4nj
        EcOeqg3HD30tdPruYmQwNZM=
X-Google-Smtp-Source: APXvYqyH2sZx4j1DatpQAz63dwGw0x8MR1eQzWOeAfY68uPQNR5xqAk6lAkC2IotvJr0VQ7gi2dqfQ==
X-Received: by 2002:a19:f514:: with SMTP id j20mr17098761lfb.31.1575977868238;
        Tue, 10 Dec 2019 03:37:48 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id q27sm1628548ljc.65.2019.12.10.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 03:37:47 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@xi.terra>)
        id 1iedpt-00013f-Mb; Tue, 10 Dec 2019 12:37:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/7] Input: fix USB alsetting bugs
Date:   Tue, 10 Dec 2019 12:37:30 +0100
Message-Id: <20191210113737.4016-1-johan@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

We had quite a few driver using the first alternate setting instead of
the current one when doing descriptor sanity checks. This is mostly an
issue on kernels with panic_on_warn set due to a WARN() in
usb_submit_urn(). Since we've started backporting such fixes (e.g. as
reported by syzbot), I've marked these for stable as well.

Included are also a couple of related clean ups to prevent future
issues.

Johan


Johan Hovold (7):
  Input: pegasus_notetaker: fix endpoint sanity check
  Input: aiptek: fix endpoint sanity check
  Input: aiptek: use descriptors of current altsetting
  Input: gtco: fix endpoint sanity check
  Input: gtco: fix extra-descriptor debug message
  Input: gtco: drop redundant variable reinit
  Input: sur40: fix interface sanity checks

 drivers/input/tablet/aiptek.c            |  8 ++++----
 drivers/input/tablet/gtco.c              | 13 ++++---------
 drivers/input/tablet/pegasus_notetaker.c |  2 +-
 drivers/input/touchscreen/sur40.c        |  2 +-
 4 files changed, 10 insertions(+), 15 deletions(-)

-- 
2.24.0

