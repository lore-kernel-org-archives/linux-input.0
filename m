Return-Path: <SRS0=nOvE=B3=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D94C433E1
	for <linux-input@archiver.kernel.org>; Mon, 17 Aug 2020 13:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA0E20789
	for <linux-input@archiver.kernel.org>; Mon, 17 Aug 2020 13:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgHQN1g (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:27:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44376 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbgHQN1g (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Aug 2020 09:27:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 9DF82297B9C
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@collabora.com
Subject: [PATCH v2 0/2] Add configurable handler to execute a compound action
Date:   Mon, 17 Aug 2020 15:27:25 +0200
Message-Id: <20200817132727.14564-1-andrzej.p@collabora.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This is a follow-up of this thread:

https://www.spinics.net/lists/linux-input/msg68446.html

It only touches DRM (dri-devel) in such a way that it changes the help
message of sysrq_drm_fb_helper_restore_op, otherwise it is unrelated to DRM.

Patch 2/2 adds a configurable handler to execute a compound action.

Userland might want to execute e.g. 'w' (show blocked tasks), followed
by 's' (sync), followed by 1000 ms delay and then followed by 'c' (crash)
upon a single magic SysRq. Or one might want to execute the famous "Raising
Elephants Is So Utterly Boring" action. This patch adds a configurable
handler, triggered with 'C', for this exact purpose. The user specifies the
composition of the compound action using syntax similar to getopt, where
each letter corresponds to an individual action and a colon followed by a
number corresponds to a delay of that many milliseconds, e.g.:

ws:1000c

or

r:100eis:1000ub

An example of userspace that wants to perform a compound action is
Chrome OS, where SysRq-X (pressed for the second time within a certain
time period from the first time) causes showing the locked tasks, syncing,
waiting a 1000 ms delay and crashing the system.

Since all the slots in the sysrq_key_table[] are already taken or reserved,
patch 1/2 extends it to cover also capital letter versions.

v1..v2:
- used toupper() instead of opencoding it (Jiri Slaby)
- updated help message of sysrq_drm_fb_helper_restore_op (Jiri Slaby)
- used unsigned int for specifying delays (Jiri Slaby)
- improved printed messages formatting (Jiri Slaby)

Andrzej Pietrasiewicz (2):
  tty/sysrq: Extend the sysrq_key_table to cover capital letters
  tty/sysrq: Add configurable handler to execute a compound action

 Documentation/admin-guide/sysrq.rst |  11 +++
 drivers/gpu/drm/drm_fb_helper.c     |   2 +-
 drivers/tty/sysrq.c                 | 129 +++++++++++++++++++++++++++-
 include/linux/sysrq.h               |   1 +
 4 files changed, 140 insertions(+), 3 deletions(-)


base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
2.17.1

