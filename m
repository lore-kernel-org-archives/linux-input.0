From: Yuan Chao <yuanchao@gmail.com>
Subject: [PATCH] HID: apple: Fix the '`'/'~' key issue for MacBook Air 6,2.
Date: Wed, 31 Aug 2016 02:26:04 +0800
Message-ID: <CAADKi7kLR=7r9-QDHYERwgvH-PnnB-ZWbE4m5AieyRHn9sGMCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yb0-f177.google.com ([209.85.213.177]:34831 "EHLO
        mail-yb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbcH3S0Z (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 30 Aug 2016 14:26:25 -0400
Received: by mail-yb0-f177.google.com with SMTP id h3so9384044ybi.2
        for <linux-input@vger.kernel.org>; Tue, 30 Aug 2016 11:26:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

The '`'/'~' key delivers '<'/'>' on MacBook Air 6,2. [1] By forcing
the module parameter iso_layout = 0, this issue can be fixed. [2][3]
This patch checks the DMI information and sets the parameter.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=60181#c43
[2] https://bugzilla.redhat.com/show_bug.cgi?id=1025041
[3] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1245081

(Sorry Jiri for duplicated messages)

-- 
Best regards,
Yuan Chao
