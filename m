From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 0/2] HID: wacom: patches for 4.11
Date: Mon,  6 Mar 2017 10:54:56 -0800
Message-ID: <1488826498-8578-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35720 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754199AbdCFTDq (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Mar 2017 14:03:46 -0500
Received: by mail-pf0-f196.google.com with SMTP id 67so14031901pfg.2
        for <linux-input@vger.kernel.org>; Mon, 06 Mar 2017 11:02:57 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, pinglinux@gmail.com, Ping.Cheng@wacom.com, killertofu@gmail.com, benjamin.tissoires@redhat.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>

Two fixes for patches included in 4.11

Aaron Armstrong Skomra (2):
  HID: wacom: Correct Intuos Pro 2 resolution
  HID: wacom: don't manually release resources for the EKR

 drivers/hid/wacom_sys.c | 4 +++-
 drivers/hid/wacom_wac.c | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.7.4

