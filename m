From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: [PATCH v2 0/2] Input: synaptics - Lenovo X1 Carbon 5 should use SMBUS/RMI
Date: Fri,  6 Oct 2017 17:06:28 +0300
Message-ID: <20171006140630.6398-1-yiannis.marangos@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:48431 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbdJFOG3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 6 Oct 2017 10:06:29 -0400
Received: by mail-wr0-f181.google.com with SMTP id u5so12950756wrc.5
        for <linux-input@vger.kernel.org>; Fri, 06 Oct 2017 07:06:28 -0700 (PDT)
Received: from localhost ([216.241.151.191])
        by smtp.gmail.com with ESMTPSA id w75sm1347694wmw.17.2017.10.06.07.06.26
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Oct 2017 07:06:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

In this version I removed LEN0072 from the list since some people reported
problems.

These patches are tested with LEN0073 in 4.12.8 for almost a month, in 4.13.2
for almost a month and in 4.14-rc3. No problems were found.

Regards,
Yiannis.
