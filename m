From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ALPS DualPoint double click bug
Date: Thu, 30 Jul 2015 16:17:23 +0200
Message-ID: <55BA31F3.3070807@redhat.com>
References: <CANuv8QyimosOLwtvLpSLjjEk2SemgxTrZDJxWnzQG-M3q20CHg@mail.gmail.com>
 <20150720065446.GA13879@dtor-ws> <20150720072548.GA25910@pali>
 <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
 <20150721071218.GA27290@pali>
 <CANuv8QxKap=K=OoCufcM-Yxujmg+3sUOjWX2D9r7qf==EQoTFQ@mail.gmail.com>
 <20150722072116.GA22138@pali>
 <CAN+gG=Eonx4Fh1HccsLdCL_ONNDXb-QgUvhMPM2B6nAaTVDFLQ@mail.gmail.com>
 <55B0B48D.7010603@redhat.com>
 <CANuv8Qy3FAL0-iWF3usbN2y2VmR4+Si7DqbqwW5aK0ppE8B60Q@mail.gmail.com>
 <55B65EEA.5080404@redhat.com>
 <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070105010406080602090709"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43453 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbbG3OR0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 10:17:26 -0400
In-Reply-To: <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Douglas Christman <douglaschristman@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

This is a multi-part message in MIME format.
--------------070105010406080602090709
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 28-07-15 01:38, Douglas Christman wrote:
> On Mon, Jul 27, 2015 at 12:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> OK, please let me know soon, I would like to get to the bottom
>> of this, and knowing the exact commit causing the problem will
>> help a lot.
>>
>> Regards,
>>
>> hans
>
> I've verified that reverting 92bac83d on a clean v4.1 kernel
> (b953c0d2) resolves the issue.

Thanks,

Can you please apply the attached patch on a clean v4.1 kernel,
and confirm that that fixes this ?

Regards,

Hans

--------------070105010406080602090709
Content-Type: text/x-patch;
 name="0001-alps-Only-Dell-laptops-have-separate-button-bits-for.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alps-Only-Dell-laptops-have-separate-button-bits-for.pa";
 filename*1="tch"

>From ee3d5d5a298b178ae5284b9766ca849665a37670 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 30 Jul 2015 15:49:16 +0200
Subject: [PATCH] alps: Only Dell laptops have separate button bits for v2
 dualpoint sticks

It turns out that only Dell laptops have the separate button bits for
v2 dualpoint sticks and that commit 92bac83dd79e ("Input: alps - non
interleaved V2 dualpoint has separate stick button bits") causes
regressions on Toshiba laptops.

This commit adds a check for Dell laptops to the code for handling these
extra button bits, fixing this regression.

This patch has been tested on a Dell Latitude D620 to make sure that it
does not reintroduce the original problem.

Reported-by: Douglas Christman <douglaschristman@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 113d6f1..889aec1 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -20,6 +20,7 @@
 #include <linux/input/mt.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
+#include <linux/dmi.h>
 
 #include "psmouse.h"
 #include "alps.h"
@@ -251,8 +252,9 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
 		return;
 	}
 
-	/* Non interleaved V2 dualpoint has separate stick button bits */
-	if (priv->proto_version == ALPS_PROTO_V2 &&
+	/* Dell non interleaved V2 dualpoint has separate stick button bits */
+	if (dmi_name_in_vendors("Dell") &&
+	    priv->proto_version == ALPS_PROTO_V2 &&
 	    priv->flags == (ALPS_PASS | ALPS_DUALPOINT)) {
 		left |= packet[0] & 1;
 		right |= packet[0] & 2;
-- 
2.4.3


--------------070105010406080602090709--
