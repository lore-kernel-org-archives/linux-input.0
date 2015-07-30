From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ALPS DualPoint double click bug
Date: Thu, 30 Jul 2015 17:00:56 +0200
Message-ID: <55BA3C28.3080506@redhat.com>
References: <CANuv8Qx0QyYg0SCYqx=auVd9__UjHBj0DEuF-xcA4Ar4Ha=aVw@mail.gmail.com>
 <20150721071218.GA27290@pali>
 <CANuv8QxKap=K=OoCufcM-Yxujmg+3sUOjWX2D9r7qf==EQoTFQ@mail.gmail.com>
 <20150722072116.GA22138@pali>
 <CAN+gG=Eonx4Fh1HccsLdCL_ONNDXb-QgUvhMPM2B6nAaTVDFLQ@mail.gmail.com>
 <55B0B48D.7010603@redhat.com>
 <CANuv8Qy3FAL0-iWF3usbN2y2VmR4+Si7DqbqwW5aK0ppE8B60Q@mail.gmail.com>
 <55B65EEA.5080404@redhat.com>
 <CANuv8QwPQ1aLvZkC522vmm+_kv7r+f3rwvc=SmjVOvx5XbQUzw@mail.gmail.com>
 <55BA31F3.3070807@redhat.com> <20150730144643.GG26714@pali>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050607080607070204080000"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59537 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbbG3PA7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 11:00:59 -0400
In-Reply-To: <20150730144643.GG26714@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: Douglas Christman <douglaschristman@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, cpaul@redhat.com

This is a multi-part message in MIME format.
--------------050607080607070204080000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 30-07-15 16:46, Pali Rohár wrote:
> On Thursday 30 July 2015 16:17:23 Hans de Goede wrote:
>> Hi,
>>
>> On 28-07-15 01:38, Douglas Christman wrote:
>>> On Mon, Jul 27, 2015 at 12:40 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> OK, please let me know soon, I would like to get to the bottom
>>>> of this, and knowing the exact commit causing the problem will
>>>> help a lot.
>>>>
>>>> Regards,
>>>>
>>>> hans
>>>
>>> I've verified that reverting 92bac83d on a clean v4.1 kernel
>>> (b953c0d2) resolves the issue.
>>
>> Thanks,
>>
>> Can you please apply the attached patch on a clean v4.1 kernel,
>> and confirm that that fixes this ?
>>
>> Regards,
>>
>> Hans
>
>>  From ee3d5d5a298b178ae5284b9766ca849665a37670 Mon Sep 17 00:00:00 2001
>> From: Hans de Goede <hdegoede@redhat.com>
>> Date: Thu, 30 Jul 2015 15:49:16 +0200
>> Subject: [PATCH] alps: Only Dell laptops have separate button bits for v2
>>   dualpoint sticks
>>
>> It turns out that only Dell laptops have the separate button bits for
>> v2 dualpoint sticks and that commit 92bac83dd79e ("Input: alps - non
>> interleaved V2 dualpoint has separate stick button bits") causes
>> regressions on Toshiba laptops.
>>
>> This commit adds a check for Dell laptops to the code for handling these
>> extra button bits, fixing this regression.
>>
>> This patch has been tested on a Dell Latitude D620 to make sure that it
>> does not reintroduce the original problem.
>>
>> Reported-by: Douglas Christman <douglaschristman@gmail.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/input/mouse/alps.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index 113d6f1..889aec1 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/input/mt.h>
>>   #include <linux/serio.h>
>>   #include <linux/libps2.h>
>> +#include <linux/dmi.h>
>>
>>   #include "psmouse.h"
>>   #include "alps.h"
>> @@ -251,8 +252,9 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
>>   		return;
>>   	}
>>
>> -	/* Non interleaved V2 dualpoint has separate stick button bits */
>> -	if (priv->proto_version == ALPS_PROTO_V2 &&
>> +	/* Dell non interleaved V2 dualpoint has separate stick button bits */
>> +	if (dmi_name_in_vendors("Dell") &&
>> +	    priv->proto_version == ALPS_PROTO_V2 &&
>>   	    priv->flags == (ALPS_PASS | ALPS_DUALPOINT)) {
>>   		left |= packet[0] & 1;
>>   		right |= packet[0] & 2;
>
> What about introducing new flag ALPS_<something> instead calling
> dmi_name_in_vendors() function every time when we need to process
> packet?

That is a good idea. Douglas can you test the attached version
instead of the previous one please ?

Thanks & Regards,

Hans

--------------050607080607070204080000
Content-Type: text/x-patch;
 name="0001-alps-Only-Dell-laptops-have-separate-button-bits-for.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-alps-Only-Dell-laptops-have-separate-button-bits-for.pa";
 filename*1="tch"

>From 93a1852f32ab37b2cbcdb7e797f1ad59eb6bbef4 Mon Sep 17 00:00:00 2001
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
 drivers/input/mouse/alps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 113d6f1..4d24686 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -20,6 +20,7 @@
 #include <linux/input/mt.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
+#include <linux/dmi.h>
 
 #include "psmouse.h"
 #include "alps.h"
@@ -99,6 +100,7 @@ static const struct alps_nibble_commands alps_v6_nibble_commands[] = {
 #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
 #define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved with
 					   6-byte ALPS packet */
+#define ALPS_DELL		0x100	/* device is a Dell laptop */
 #define ALPS_BUTTONPAD		0x200	/* device is a clickpad */
 
 static const struct alps_model_info alps_model_data[] = {
@@ -251,9 +253,9 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
 		return;
 	}
 
-	/* Non interleaved V2 dualpoint has separate stick button bits */
+	/* Dell non interleaved V2 dualpoint has separate stick button bits */
 	if (priv->proto_version == ALPS_PROTO_V2 &&
-	    priv->flags == (ALPS_PASS | ALPS_DUALPOINT)) {
+	    priv->flags == (ALPS_DELL | ALPS_PASS | ALPS_DUALPOINT)) {
 		left |= packet[0] & 1;
 		right |= packet[0] & 2;
 		middle |= packet[0] & 4;
@@ -2550,6 +2552,8 @@ static int alps_set_protocol(struct psmouse *psmouse,
 	priv->byte0 = protocol->byte0;
 	priv->mask0 = protocol->mask0;
 	priv->flags = protocol->flags;
+	if (dmi_name_in_vendors("Dell"))
+		priv->flags |= ALPS_DELL;
 
 	priv->x_max = 2000;
 	priv->y_max = 1400;
-- 
2.4.3


--------------050607080607070204080000--
