From: Andrew Drake <adrake@adrake.org>
Subject: Re: [PATCH] input: bcm5974: Add support for newer MacBookPro8,2
Date: Tue, 16 Aug 2011 02:46:03 -0700
Message-ID: <4E4A3C5B.30504@adrake.org>
References: <4E4A0C26.1060307@adrake.org> <4E4A1894.4070802@cn.fujitsu.com> <4E4A24CC.6000909@adrake.org> <4E4A2886.8080805@cn.fujitsu.com> <4E4A2AF3.3030400@adrake.org> <4E4A3011.3090706@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:38686
	"EHLO DB3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751236Ab1HPJqN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 05:46:13 -0400
In-Reply-To: <4E4A3011.3090706@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: linux-input@vger.kernel.org, rydberg@euromail.se, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On 08/16/2011 01:53 AM, Wanlong Gao wrote:
> On 08/16/2011 04:31 PM, Andrew Drake wrote:
>> On 08/16/2011 01:21 AM, Wanlong Gao wrote:
>>> On 08/16/2011 04:05 PM, Andrew Drake wrote:
>>>> On 08/16/2011 12:13 AM, Wanlong Gao wrote:
>>>>> On 08/16/2011 02:20 PM, Andrew Drake wrote:
>>>>>> I just received a new MacBook Pro, product name MacBookPro8,2. It 
>>>>>> came
>>>>>> with a newer/higher resolution touchpad than others with the same
>>>>>> product name with USB ID 05ac:0252. The following patch (which 
>>>>>> applies
>>>>>> on top of 3.1-rc2) adds support for this device.
>>>>>>
>>>>>> <snip>
>>>>> I wonder that why can't I apply this patch?
>>>>> #git am<[path]>
>>>>> Applying: input: bcm5974: Add support for newer MacBookPro8,2
>>>>> fatal: corrupt patch at line 32
>>>>> Patch failed at 0001 input: bcm5974: Add support for newer
>>>>> MacBookPro8,2
>>>>>
>>>>
>>>> Sorry, my mailer wrapped some of the lines. Try this:
>>>>
>>>> <snip>
>>>>
>>> Applying: input: bcm5974: Add support for newer MacBookPro8,2
>>> error: patch failed: drivers/input/mouse/bcm5974.c:67
>>> error: drivers/input/mouse/bcm5974.c: patch does not apply
>>> Patch failed at 0001 input: bcm5974: Add support for newer MacBookPro8,2
>>>
>>>
>>
>> Now I'm confused. I tried applying at commit
>> b5ddbf465f3675b19c8f5528b4064cbf278a5c6f, the HEAD of linux.git at the
>> time of writing and got:
>>
>> $ git am <path.eml>:
>> Applying: input: bcm5974: Add support for newer MacBookPro8,2
>> $
>>
>> The email above was just git format-patch -s. Should I make a patch
>> against a different tree?
> http://git.kernel.org/?p=linux/kernel/git/dtor/input.git;a=commitdiff;h=db0b34b07438d92c4c190998c42a502fbf90064e 
> 
> 
> May this conflict yours. It add the *MacBookAir4,2*. You can make patch 
> based this patch applied, right?
> 

Good catch! I had the wrong tree. Rebased:

Signed-off-by: Andrew Drake <adrake@adrake.org>
---
 drivers/input/mouse/bcm5974.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 48d9ec1..da28018 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -71,6 +71,10 @@
 #define USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI	0x024c
 #define USB_DEVICE_ID_APPLE_WELLSPRING6_ISO	0x024d
 #define USB_DEVICE_ID_APPLE_WELLSPRING6_JIS	0x024e
+/* Macbook8,2 (unibody) */
+#define USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI	0x0252
+#define USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO	0x0253
+#define USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS	0x0254
  #define BCM5974_DEVICE(prod) {					\
 	.match_flags = (USB_DEVICE_ID_MATCH_DEVICE |		\
@@ -112,6 +116,10 @@ static const struct usb_device_id bcm5974_table[] = {
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING6_ANSI),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING6_ISO),
 	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING6_JIS),
+	/* MacbookPro8,2 */
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO),
+	BCM5974_DEVICE(USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS),
 	/* Terminating entry */
 	{}
 };
@@ -314,6 +322,18 @@ static const struct bcm5974_config bcm5974_config_table[] = {
 		{ DIM_X, DIM_X / SN_COORD, -4620, 5140 },
 		{ DIM_Y, DIM_Y / SN_COORD, -150, 6600 }
 	},
+	{
+		USB_DEVICE_ID_APPLE_WELLSPRING5A_ANSI,
+		USB_DEVICE_ID_APPLE_WELLSPRING5A_ISO,
+		USB_DEVICE_ID_APPLE_WELLSPRING5A_JIS,
+		HAS_INTEGRATED_BUTTON,
+		0x84, sizeof(struct bt_data),
+		0x81, TYPE2, FINGER_TYPE2, FINGER_TYPE2 + SIZEOF_ALL_FINGERS,
+		{ DIM_PRESSURE, DIM_PRESSURE / SN_PRESSURE, 0, 300 },
+		{ DIM_WIDTH, DIM_WIDTH / SN_WIDTH, 0, 2048 },
+		{ DIM_X, DIM_X / SN_COORD, -4750, 5280 },
+		{ DIM_Y, DIM_Y / SN_COORD, -150, 6730 }
+	},
 	{}
 };
 -- 1.7.6



