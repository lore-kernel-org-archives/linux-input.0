From: Frank Praznik <frank.praznik@gmail.com>
Subject: [PATCH 0/3] hid: sony: Fix duplicate check logic and other cleanups
Date: Thu, 22 Sep 2016 20:18:07 -0400
Message-ID: <1474589890-7141-1-git-send-email-frank.praznik@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33551 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933536AbcIWASl (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Sep 2016 20:18:41 -0400
Received: by mail-qk0-f176.google.com with SMTP id g67so32401572qkd.0
        for <linux-input@vger.kernel.org>; Thu, 22 Sep 2016 17:18:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, Frank Praznik <frank.praznik@gmail.com>

This set of patches fixes a case where the duplicate check incorrectly
rejects valid devices and cleans up the behavior when a DualShock 3 is
initially connected.  It also adds a bit of documentation regarding the
DualShock 4 reporting rate as there have been a few cases where users
needed to slow it down since the full rate can be too much for some
slow embedded devices.
