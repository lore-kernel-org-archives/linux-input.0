From: Dimitar Petrovski <dimeptr@gmail.com>
Subject: add Fujitsu Lifebook E546 to force crc_enabled
Date: Sun, 14 May 2017 11:36:56 +0200
Message-ID: <CAKtuzf7M0oGPA=vny7fO6dTiKcPiSTZ3Xn=_TqBuEp6hvu4DTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:36706 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751047AbdENJhS (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 14 May 2017 05:37:18 -0400
Received: by mail-qk0-f178.google.com with SMTP id u75so75013539qka.3
        for <linux-input@vger.kernel.org>; Sun, 14 May 2017 02:37:17 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have seen this messages https://patchwork.kernel.org/patch/9645671/
about adding Fujitsu Lifebook E547 to force crc_enabled.
I own Fujitsu Lifebook E546 and I have the same problem, I currently
force crc_enabled through rc.local, but I think it should also be
included in the kernel.

Regards,
Dimitar
