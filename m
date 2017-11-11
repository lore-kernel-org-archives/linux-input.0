From: Andi Shyti <andi@etezian.org>
Subject: [PATCH 0/2] managed resources for ili210x
Date: Sat, 11 Nov 2017 07:02:29 +0200
Message-ID: <20171111050231.29047-1-andi@etezian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 14.mo3.mail-out.ovh.net ([188.165.43.98]:52189 "EHLO
        14.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbdKKFIc (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 11 Nov 2017 00:08:32 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
        by mo3.mail-out.ovh.net (Postfix) with ESMTP id 3152E16F816
        for <linux-input@vger.kernel.org>; Sat, 11 Nov 2017 06:02:44 +0100 (CET)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>, Andi Shyti <andi.shyti@gmail.com>

Hi Dmitry,

this is another patch of my series for switching the
touchscreen drivers to to the managed resource allocators.

The second patch is very trivial and perhaps bothering only me,
feel free to ignore.

Thanks,
Andi

Andi Shyti (2):
  Input: ili210x - use managed allocated resources
  Input: ili210x - use separate error handling for different allocators

 drivers/input/touchscreen/ili210x.c | 39 +++++++++++++------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

-- 
2.15.0

