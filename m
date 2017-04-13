From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [PATCH 0/2] xen/input: add multi-touch support
Date: Thu, 13 Apr 2017 14:38:02 +0300
Message-ID: <1492083484-31786-1-git-send-email-andr2000@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36378 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdDMLiO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Apr 2017 07:38:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: joculator@gmail.com, al1img@gmail.com, vlad.babchuk@gmail.com, andrii.anisov@gmail.com, olekstysh@gmail.com, boris.ostrovsky@oracle.com, dmitry.torokhov@gmail.com, jgross@suse.com, andr2000@gmail.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Hi, all!

This patch series updates existing Xen vkbd frontend driver
to use string constants from the corresponding IO protocol
(kbdif.h) and adds support for virtual multi-touch input device.

This has been tested on a guest running Weston.

This patch series depends on:
https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/commit/?h=linux-next&id=16b3087654b8565ae14c23ac3797e5f60ba0b13d
https://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git/commit/?h=linux-next&id=edd5bdb7b06fd1a0c68b6f39b2c776368eba00c8
https://lkml.org/lkml/2017/4/11/352

Thank you,
Oleksandr Andrushchenko

Oleksandr Andrushchenko (2):
  xen/input: use string constants from PV protocol
  xen/input: add multi-touch support

 drivers/input/misc/xen-kbdfront.c | 164 +++++++++++++++++++++++++++++++++++---
 1 file changed, 153 insertions(+), 11 deletions(-)

-- 
2.7.4

