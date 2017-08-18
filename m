From: Adam Goode <adam@spicenitz.org>
Subject: successful intertouch support: PNP: LEN2014 PNP0f13
Date: Thu, 17 Aug 2017 23:55:20 -0400
Message-ID: <CACuduqo7g9fJbjR3d0DStKMaRCc8H5W39yjqUDXWV+Nb6FiXSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:59963 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753828AbdHRDzm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 17 Aug 2017 23:55:42 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7288720DF0
        for <linux-input@vger.kernel.org>; Thu, 17 Aug 2017 23:55:41 -0400 (EDT)
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com [209.85.218.46])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1FD587FA84
        for <linux-input@vger.kernel.org>; Thu, 17 Aug 2017 23:55:41 -0400 (EDT)
Received: by mail-oi0-f46.google.com with SMTP id g131so85551649oic.3
        for <linux-input@vger.kernel.org>; Thu, 17 Aug 2017 20:55:41 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Aug 17 23:36:24 localhost kernel: psmouse serio1: synaptics: Your
touchpad (PNP: LEN2014 PNP0f13) says it can support a different bus.
If i2c-hid and hid-rmi are not used, you might want to try setting
psmouse.synaptics_intertouch to 1 and report this to
linux-input@vger.kernel.org.

It does work with the kernel setting. Please add this to the whitelist.


Thanks,

Adam
