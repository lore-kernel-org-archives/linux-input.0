From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] Support-Alps-Touchpad-SS4-device
Date: Fri, 27 Mar 2015 21:36:39 -0700
Message-ID: <20150328043639.GB9145@dtor-ws>
References: <1427488186-10046-1-git-send-email-masaki.ota@jp.alps.com>
 <551513E5.10101@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34407 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbbC1Egn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Mar 2015 00:36:43 -0400
Received: by iedfl3 with SMTP id fl3so95256386ied.1
        for <linux-input@vger.kernel.org>; Fri, 27 Mar 2015 21:36:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <551513E5.10101@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Masaki Ota <012nexus@gmail.com>, linux-input@vger.kernel.org, masaki.ota@jp.alps.com

On Fri, Mar 27, 2015 at 09:25:09AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 27-03-15 21:29, Masaki Ota wrote:
> >From: Masaki Ota <masaki.ota@jp.alps.com>
> >-Support SS4 device
> >-SS4 device supports 4Finger and real multi-touch.
> >
> >Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
> 
> Thanks looks good now:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> 
> One remark though, you enable: BTN_TOOL_QUINTTAP for v7 touchpads
> in the alps_set_abs_params_v7_v8 changes. This is the right thing
> to do as v7 can indeed report 5 fingers being down, something which I
> missed when I added support for it. But it would be good to have
> a small note about this in the commit message.
> 
> Dmitry, can you amend the commit message for this when merging this?

How about we simply split it out, like below?

-- 
Dmitry


Input: ALPS - V7 devices can report 5-finger taps

From: Masaki Ota <masaki.ota@jp.alps.com>

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/alps.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 029f831..47fbb01 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2461,6 +2461,7 @@ static void alps_set_abs_params_v7(struct alps_data *priv,
 				   struct input_dev *dev1)
 {
 	alps_set_abs_params_mt_common(priv, dev1);
+	set_bit(BTN_TOOL_QUINTTAP, dev1->keybit);
 
 	input_mt_init_slots(dev1, MAX_TOUCHES,
 			    INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED |
