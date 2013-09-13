From: Yunkang Tang <tommywill2011@gmail.com>
Subject: [PATCH v2 0/2] Improve the performance of alps v5-protocol's touchpad
Date: Fri, 13 Sep 2013 12:03:28 +0800
Message-ID: <1379045010-3347-1-git-send-email-yunkang.tang@cn.alps.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:62052 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab3IMEEH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Sep 2013 00:04:07 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so700500pdj.18
        for <linux-input@vger.kernel.org>; Thu, 12 Sep 2013 21:04:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: yunkang.tang@cn.alps.com, linux-input@vger.kernel.org

Hi all,

Here is the v2 of improving ALPS v5 protocol device.

Change since v1:
- fix the issue that previous patches were broken by mail system.
- split the modification to 2 patches.
- Change dev2's name to "ALPS PS/2 Device"

Best Regards,
Tommy

