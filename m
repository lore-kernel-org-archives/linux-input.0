From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: Input: synaptics - Lenovo X1 Carbon 5 devices should use SMBUS/RMI
Date: Thu,  5 Oct 2017 20:43:13 +0300
Message-ID: <20171005174315.2863-1-yiannis.marangos@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:50102 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdJERoP (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 13:44:15 -0400
Received: by mail-wr0-f170.google.com with SMTP id p10so9611862wrc.6
        for <linux-input@vger.kernel.org>; Thu, 05 Oct 2017 10:44:14 -0700 (PDT)
Received: from localhost ([216.241.151.191])
        by smtp.gmail.com with ESMTPSA id 76sm455229wmj.37.2017.10.05.10.44.13
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 10:44:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

Part of these patches were found at:
https://gist.github.com/ursm/6d1007f44a1d6beeb670b3c3a6a78ea4

They were tested in 4.12.8 for almost a month, in 4.13.2 for almost a month
and in 4.14-rc3. No problems were found.

Regards,
Yiannis.

