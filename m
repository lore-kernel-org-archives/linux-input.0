From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 0/1] input: goodix: Poll the 'buffer status' bit before reading
Date: Fri, 22 Sep 2017 20:51:25 +0200
Message-ID: <20170922185126.11262-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbdIVSvd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Sep 2017 14:51:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Bastien Nocera <hadess@hadess.net>
Cc: Hans de Goede <hdegoede@redhat.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-input@vger.kernel.org

Hi All,

Here is a v2 of Paul Cercueil's patch to fix sometimes fingers getting
stuck (seen as present while already lifted) on goodix screens.

As this patch seems to be sorta stuck and some users have been asking
about getting this fixed, I've done a v2 addressing Bastien's review
comments on v1.

Regards,

Hans
