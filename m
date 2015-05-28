From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] input: elantech.c: add more exceptions to fw version
 signature check
Date: Thu, 28 May 2015 18:37:49 +0200
Message-ID: <5567445D.6070700@redhat.com>
References: <1432830570-31406-1-git-send-email-lachs0r@srsfckn.biz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090508040504010900050302"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35856 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754167AbbE1Qhv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 12:37:51 -0400
In-Reply-To: <1432830570-31406-1-git-send-email-lachs0r@srsfckn.biz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Herkt <lachs0r@srsfckn.biz>, linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ulrik De Bie <ulrik.debie-os@e2big.org>, George Moutsopoulos <gmoutso@yahoo.co.uk>

This is a multi-part message in MIME format.
--------------090508040504010900050302
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 28-05-15 18:29, Martin Herkt wrote:
> This makes the driver work with the ElanTech touchpad of my
> ASUS PU551LD laptop (fw signature 0x480f0a). There may be more
> touchpads with firmware versions in the 0x4? range, so I've added
> those to the exception as well.

I actually send a patch fixing the exact same bug earlier today...

> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 79363b6..cd3e2a3 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1379,7 +1379,8 @@ static bool elantech_is_signature_valid(const unsigned char *param)
>   	 * Some models have a revision higher then 20. Meaning param[2] may
>   	 * be 10 or 20, skip the rates check for these.
>   	 */
> -	if (param[0] == 0x46 && (param[1] & 0xef) == 0x0f && param[2] < 40)
> +	if (param[0] >= 0x40 && param[0] < 0x50 &&

This is wrong, the bits of param[0] which define the hw version of
the touchpads are in the low nibble, so your check will also match
older touchpads where we do not want to skip the rare check.

> +	    (param[1] & 0xef) == 0x0f && param[2] < 40)
>   		return true;
>
>   	for (i = 0; i < ARRAY_SIZE(rates); i++)

I've attached my patch, which actually checks the low nibble of
param[0]. It has already been tested on an Asus PU551LA laptop,
so it should work for your laptop too.

Regards,

Hans


--------------090508040504010900050302
Content-Type: text/x-patch;
 name="0001-elantech-Fix-detection-of-touchpads-where-the-revisi.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename*0="0001-elantech-Fix-detection-of-touchpads-where-the-revisi.pa";
 filename*1="tch"

>From 9778e462805c95ed626290094a22af09ba879fef Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 30 Apr 2015 10:29:38 +0200
Subject: [PATCH 1/3] elantech: Fix detection of touchpads where the revision
 matches a known rate
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make the check to skip the rate check more lax, so that it applies
to all hw_version 4 models.

This fixes the touchpad not being detected properly on Asus PU551LA
laptops.

Cc: stable@vger.kernel.org
Reported-and-tested-by: David Zafra Gómez <dezeta@klo.es>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/elantech.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 79363b6..e605303 100644
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
2.4.1


--------------090508040504010900050302--
