From: Andy Lutomirski <luto@kernel.org>
Subject: Dell XPS 13 9350 touchpad is busted in 4.12-rc
Date: Wed, 24 May 2017 15:04:34 -0700
Message-ID: <CALCETrW3fuwiV82JrFkZ5ytb+VRPwpHDOvWBD4Q5zcWF_1ePcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033616AbdEXWE4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 24 May 2017 18:04:56 -0400
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com [209.85.213.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F8B3239DE
        for <linux-input@vger.kernel.org>; Wed, 24 May 2017 22:04:56 +0000 (UTC)
Received: by mail-vk0-f54.google.com with SMTP id x71so82886335vkd.0
        for <linux-input@vger.kernel.org>; Wed, 24 May 2017 15:04:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <btissoir@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Allen Hung <allen_hung@dell.com>

I just build from Linus' tree from Saturday (ef82f1ad), and touchpad
input is busted on my laptop.  The device is still there and evtest
still shows events, but something is wrong and libinput either thinks
I'm not moving at all or I'm trying to teleport to the edge of the
screen.

Is this a known problem or should I try to track it down?

Thanks,
Andy
