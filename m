From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: MT_CLS_WIN_8_DUAL on non-trackpoint Alps touchpad
Date: Wed, 20 Sep 2017 10:18:27 +0800
Message-ID: <CAAd53p4dxncEhoPnxOHc40KMCnT6VM=J+oQ0GbZU_Rhm2cKyZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48021 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdITCS3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Sep 2017 22:18:29 -0400
Received: from mail-oi0-f70.google.com ([209.85.218.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1duUaq-00067E-Sq
        for linux-input@vger.kernel.org; Wed, 20 Sep 2017 02:18:28 +0000
Received: by mail-oi0-f70.google.com with SMTP id p126so782223oih.2
        for <linux-input@vger.kernel.org>; Tue, 19 Sep 2017 19:18:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: masaki.ota@jp.alps.com, linux-input@vger.kernel.org

Hi Masaki,

Support for ALPS 0x120A trackpad got added in patch [1].

The problem is, there are two versions of 0x120A, one comes with a
trackpoint, one does not.

Since there's ".export_all_inputs = true" for the device, the
trackpoint will be incorrectly reported by hid-multitouch for the
non-trackpoint version.
Now userspace tools think the touchpad has a trackpoint, which is
incorrect here.

So is there a way to address the issue?

[1] https://marc.info/?l=linux-kernel&m=150235885718077&w=2
