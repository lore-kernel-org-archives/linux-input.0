From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: Input: joydev - validate axis/button maps before clobbering
 current ones
Date: Tue, 6 Oct 2015 23:49:41 +0200
Message-ID: <561441F5.4070806@osg.samsung.com>
References: <20151006185155.GA8997@mwanda>
 <20151006225726.545f4ce5@heffalump.sk2.org>
 <20151006230150.598b24f0@heffalump.sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:47537 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbbJFVtq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 6 Oct 2015 17:49:46 -0400
In-Reply-To: <20151006230150.598b24f0@heffalump.sk2.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Kitt <steve@sk2.org>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hello Stephen,

On 10/06/2015 11:01 PM, Stephen Kitt wrote:
> On Tue, 6 Oct 2015 22:57:26 +0200, Stephen Kitt <steve@sk2.org> wrote:
>> On Tue, 6 Oct 2015 21:51:55 +0300, Dan Carpenter <dan.carpenter@oracle.com>
>> wrote:
>>> The patch 999b874f4aa3: "Input: joydev - validate axis/button maps
>>> before clobbering current ones" from Aug 25, 2009, leads to the
>>> following static checker warning:
>>>
>>> 	drivers/input/joydev.c:466 joydev_handle_JSIOCSAXMAP()
>>> 	error: 'abspam' dereferencing possible ERR_PTR()
>>>
>>> drivers/input/joydev.c
>>>    437  static int joydev_handle_JSIOCSAXMAP(struct joydev *joydev,
>>>    438                                       void __user *argp, size_t
>>> len) 439  {
>>>    440          __u8 *abspam;
>>>    441          int i;
>>>    442          int retval = 0;
>>>    443  
>>>    444          len = min(len, sizeof(joydev->abspam));
>>>    445  
>>>    446          /* Validate the map. */
>>>    447          abspam = memdup_user(argp, len);
>>>    448          if (IS_ERR(abspam)) {
>>>    449                  retval = PTR_ERR(abspam);
>>>    450                  goto out;
>>>
>>> out labels are error prone.  It's safer to return directly.
>>>
>>> https://plus.google.com/106378716002406849458/posts/dnanfhQ4mHQ
>>>
>>> joydev_handle_JSIOCSBTNMAP() has the same issue.
>>
>> Perhaps I'm missing something here, but that's not the code I wrote, nor is
>> it the code that's currently in the kernel. What I have in my copy of the
>> kernel tree is
>>
>>         /* Validate the map. */
>>         abspam = kmalloc(len, GFP_KERNEL);
>>         if (!abspam)
>>                 return -ENOMEM;
>>
>> which does as you recommend. If you look up the commit you're referring to
>> you'll see that's also the code as I wrote it back in 2009; I'm not sure
>> where your IS_ERR() and PTR_ERR() stuff is coming from.
> 
> After further investigation I'm guessing this is
> https://lkml.org/lkml/2015/10/2/370, so cc'ing Javier and Dmitry.
>

It is indeed a bug introduced by my "cleanup" patch, sorry for the mess :(

I double checked when posting the patch but got confused and used the old
error logic. Following is a fixup patch [0].

I don't know if Dmitry prefers to squash with the other patch since it
didn't hit mainline yet or if not I can post it as a proper patch so he
can pick it on his next branch.

> Regards,
> 
> Stephen
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

[0]:
>From 6b01facd81655276ac9a595d0515b37d9c451d66 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Tue, 6 Oct 2015 23:29:06 +0200
Subject: [PATCH 1/1] Input: joydev - fix possible ERR_PTR() dereferencing

Commit 5702222c9a7a ("Input: joydev - use memdup_user() to duplicate
memory from user-space") changed the kmalloc() and copy_from_user()
with a single call to memdup_user() but wrongly used the same error
path than the old code in which the buffer allocated by kmalloc() was
freed if copy_from_user() failed.

This is of course wrong since if memdup_user() fails, no memory was
allocated and the error in the error-valued pointer should be returned.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Fixes: 5702222c9a7a ("Input: joydev - use memdup_user() to duplicate
memory from user-space")
---
 drivers/input/joydev.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index e3dcd4abae18..5d11fea3c8ec 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -445,10 +445,8 @@ static int joydev_handle_JSIOCSAXMAP(struct joydev *joydev,
 
 	/* Validate the map. */
 	abspam = memdup_user(argp, len);
-	if (IS_ERR(abspam)) {
-		retval = PTR_ERR(abspam);
-		goto out;
-	}
+	if (IS_ERR(abspam))
+		return PTR_ERR(abspam);
 
 	for (i = 0; i < joydev->nabs; i++) {
 		if (abspam[i] > ABS_MAX) {
@@ -478,10 +476,8 @@ static int joydev_handle_JSIOCSBTNMAP(struct joydev *joydev,
 
 	/* Validate the map. */
 	keypam = memdup_user(argp, len);
-	if (IS_ERR(keypam)) {
-		retval = PTR_ERR(keypam);
-		goto out;
-	}
+	if (IS_ERR(keypam))
+		return PTR_ERR(keypam);
 
 	for (i = 0; i < joydev->nkey; i++) {
 		if (keypam[i] > KEY_MAX || keypam[i] < BTN_MISC) {
-- 
2.4.3
