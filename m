From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: Input: synaptics - Lenovo X1 Carbon 5 devices should use SMBUS/RMI
Date: Thu,  5 Oct 2017 21:22:19 +0300
Message-ID: <20171005182221.7138-1-yiannis.marangos@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:46146 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbdJESWJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 14:22:09 -0400
Received: by mail-wr0-f180.google.com with SMTP id z1so2685845wre.3
        for <linux-input@vger.kernel.org>; Thu, 05 Oct 2017 11:22:09 -0700 (PDT)
Received: from localhost ([216.241.151.191])
        by smtp.gmail.com with ESMTPSA id 56sm11412029wrx.2.2017.10.05.11.22.07
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 11:22:07 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

These patches were tested in 4.12.8 for almost a month, in 4.13.2 for almost
a month and in 4.14-rc3. No problems were found.

This is a resend of my previous email because the introductory message didn't
make it to the mailing list.

Regards,
Yiannis.
