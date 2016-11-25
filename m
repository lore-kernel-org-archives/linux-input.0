From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 0/2] small fixes for soc_button_array
Date: Fri, 25 Nov 2016 17:36:40 +0100
Message-ID: <1480091802-14482-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932635AbcKYQgq (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Nov 2016 11:36:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

I am currently trying to clean up my local tree.
These 2 patches are IMO acceptable, so I am sending them with the hope
of being able to remove them from my local tree :)

Cheers,
Benjamin

Benjamin Tissoires (2):
  Input - soc_button_array: use gpio_is_valid()
  Input - soc_button_array: bail out earlier if gpiod_count is null

 drivers/input/misc/soc_button_array.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.7.4

