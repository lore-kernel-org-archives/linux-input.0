From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: PROBLEM: Touchpad works just like a mouse
Date: Thu, 30 Apr 2015 10:38:09 +0200
Message-ID: <5541E9F1.5090902@redhat.com>
References: <552C4E6C.4070102@klo.es>	<552F6AC9.6020005@klo.es>	<CAN+gG=ENP5Uf06S1cdXKsGNmLDfGKOt3mP9iOeoxyqSzuDMoKA@mail.gmail.com>	<55320164.5010905@klo.es>	<553D5E91.2080704@klo.es> <CAN+gG=EUXJzCoPzPji0Uv_WMO0rKznHU6qcbTqtcksAOADFTjw@mail.gmail.com> <553F2EF1.9000106@redhat.com> <553FFB10.6010005@klo.es> <554089DF.7040803@redhat.com> <5541BEEC.70905@klo.es>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060301040102020804080006"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44192 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbbD3Iic (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Apr 2015 04:38:32 -0400
In-Reply-To: <5541BEEC.70905@klo.es>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?RGF2aWQgWmFmcmEgR8OzbWV6?= <dezeta@klo.es>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Duson Lin <dusonlin@emc.com.tw>, Jiri Kosina <jkosina@suse.cz>

This is a multi-part message in MIME format.
--------------060301040102020804080006
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 30-04-15 07:34, David Zafra Gómez wrote:
> Hi everyone
>
> El 29/04/15 a las 09:35, Hans de Goede escribió:
>> Hi,
>>
>> On 28-04-15 23:26, David Zafra Gómez wrote:
>>> [    0.257439] pnp 00:06: Plug and Play ACPI device, IDs ETD0108
>>> SYN0a00 SYN0002 PNP0f03 PNP0f13 PNP0f12 (active)
>>
>> Ok, so the "ETD0108" here means that you have an elantech ps/2 touchpad.
> Great! You got it.
>>
>> This also stands out in the log:
>>
>> > [    0.958323] i8042: [49] MUX error, status is 75, data is fe
>>
>> So the first thing to try is to boot with i8042.nomux=1 on the kernel
>> commandline.
> I have done it. The touchpad issue hasn't been solved. Do you want me to send dmesg output?

I've taken another look at the traces you've posted before and I think that
I've found the problem. Can you build a kernel with the attached patch
and let us know if that fixes things ?

Regards,

Hans

--------------060301040102020804080006
Content-Type: text/x-patch;
 name="0001-elantech-Fix-detection-of-touchpads-where-the-revisi.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-elantech-Fix-detection-of-touchpads-where-the-revisi.pa";
 filename*1="tch"

>From 0b0bf8fd125b0925166470cf8cf9f7b2f310efd4 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 30 Apr 2015 10:29:38 +0200
Subject: [PATCH] elantech: Fix detection of touchpads where the revision
 matches a known rate
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make the check to skip the rate check more lax, so that it applies
to all hw_version 4 models.

This fixes the touchpad not being detected properly on Asus PU551LA
laptops.

Reported-and-tested-by: David Zafra Gómez <dezeta@klo.es>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/elantech.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 991dc6b..e30286f 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1379,7 +1379,8 @@ static bool elantech_is_signature_valid(const unsigned char *param)
 	 * Some models have a revision higher then 20. Meaning param[2] may
 	 * be 10 or 20, skip the rates check for these.
 	 */
-	if (param[0] == 0x46 && (param[1] & 0xef) == 0x0f && param[2] < 40)
+	if ((param[0] & 0x0f) >= 0x06 && (param[1] & 0xaf) == 0x0f &&
+	    param[2] < 40)
 		return true;
 
 	for (i = 0; i < ARRAY_SIZE(rates); i++)
-- 
2.3.6


--------------060301040102020804080006--
