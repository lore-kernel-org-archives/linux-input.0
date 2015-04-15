From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - add support for Google Pixel 2
Date: Wed, 15 Apr 2015 10:35:33 -0700
Message-ID: <20150415173533.GA27779@dtor-ws>
References: <1428452770-20767-1-git-send-email-dmitry.torokhov@gmail.com>
 <552E8A8C.6000900@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:35666 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbbDORfi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 13:35:38 -0400
Content-Disposition: inline
In-Reply-To: <552E8A8C.6000900@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Olof Johansson <olof@lixom.net>

On Wed, Apr 15, 2015 at 05:58:04PM +0200, Javier Martinez Canillas wrote:
> On 04/08/2015 02:26 AM, Dmitry Torokhov wrote:
> > @@ -724,15 +726,15 @@ static void mxt_input_button(struct mxt_data *data, u8 *message)
> >  {
> >  	struct input_dev *input = data->input_dev;
> >  	const struct mxt_platform_data *pdata = data->pdata;
> > -	bool button;
> >  	int i;
> >  
> > -	/* Active-low switch */
> >  	for (i = 0; i < pdata->t19_num_keys; i++) {
> >  		if (pdata->t19_keymap[i] == KEY_RESERVED)
> >  			continue;
> > -		button = !(message[1] & (1 << i));
> > -		input_report_key(input, pdata->t19_keymap[i], button);
> > +
> > +		/* Active-low switch */
> > +		input_report_key(input, pdata->t19_keymap[i],
> > +				 !(message[1] & BIT(i)));
> 
> This is an unrelated cleanup so probably should had been a separate patch?

Fair enough.

-- 
Dmitry


Input: atmel_mxt_ts - use BIT() macro when reporting button state

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This makes the intent a tad more clear.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 0d87ffc..0dcd455 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -726,15 +726,15 @@ static void mxt_input_button(struct mxt_data *data, u8 *message)
 {
 	struct input_dev *input = data->input_dev;
 	const struct mxt_platform_data *pdata = data->pdata;
-	bool button;
 	int i;
 
-	/* Active-low switch */
 	for (i = 0; i < pdata->t19_num_keys; i++) {
 		if (pdata->t19_keymap[i] == KEY_RESERVED)
 			continue;
-		button = !(message[1] & (1 << i));
-		input_report_key(input, pdata->t19_keymap[i], button);
+
+		/* Active-low switch */
+		input_report_key(input, pdata->t19_keymap[i],
+				 !(message[1] & BIT(i)));
 	}
 }
 
