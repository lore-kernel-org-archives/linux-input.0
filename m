From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] Input: wacom - report hardware provided MT_TRACKING_IDs
Date: Mon, 01 Nov 2010 15:25:14 +0100
Message-ID: <4CCECDCA.9040200@euromail.se>
References: <1288497626-25416-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:32861 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756461Ab0KAOZj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Nov 2010 10:25:39 -0400
In-Reply-To: <1288497626-25416-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On 10/31/2010 05:00 AM, Ping Cheng wrote:

> The "Multi-touch (MT) Protocol" says:
> 
> "The slot protocol requires the use of the ABS_MT_TRACKING_ID, either
> provided by the hardware or computed from the raw data".
> 
> We get the IDs from Bamboo touch device. Let's use them instead of
> compute our own.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>


Hi Ping,

I share the same concern as Dmitry here. This patch weakens the semantics of the
current tracking id definition. As it seems, only to allow the tracking id to be
used in a different, undocumented or hardware-specific way. This is not a good
way to go - neither from a kernel maintenance perspective, nor from a user
experience perspective. After all, the kernel is about unifying the experience
of different hardware.

> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index b3252ef..76d4980 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -885,7 +885,7 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
>  			input_report_abs(input, ABS_MT_POSITION_X, x);
>  			input_report_abs(input, ABS_MT_POSITION_Y, y);
>  			if (wacom->id[i] < 0)
> -				wacom->id[i] = wacom->trk_id++ & MAX_TRACKING_ID;
> +				wacom->id[i] = i;


This change will not allow for detection of a new finger between two frames, and
breaks applications that assume a new finger is detected by a new unique
tracking id. Besides, the internal contact ids are already passed on as slot
ids, so this change sends the same information in two different ways.

>  			if (!count++)
>  				sp = p, sx = x, sy = y;
>  		} else {
> @@ -1283,7 +1283,7 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
>  					     0, features->pressure_max,
>  					     features->pressure_fuzz, 0);
>  			input_set_abs_params(input_dev, ABS_MT_TRACKING_ID, 0,
> -					     MAX_TRACKING_ID, 0, 0);
> +					     1, 0, 0);
>  		} else if (features->device_type == BTN_TOOL_PEN) {
>  			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
>  			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
> diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
> index 00ca015..b1310ec 100644
> --- a/drivers/input/tablet/wacom_wac.h
> +++ b/drivers/input/tablet/wacom_wac.h
> @@ -42,9 +42,6 @@
>  #define WACOM_QUIRK_MULTI_INPUT		0x0001
>  #define WACOM_QUIRK_BBTOUCH_LOWRES	0x0002
>  
> -/* largest reported tracking id */
> -#define MAX_TRACKING_ID			0xfff
> -
>  enum {
>  	PENPARTNER = 0,
>  	GRAPHIRE,
> @@ -100,7 +97,6 @@ struct wacom_wac {
>  	int id[3];
>  	__u32 serial[2];
>  	int last_finger;
> -	int trk_id;
>  	struct wacom_features features;
>  	struct wacom_shared *shared;
>  	struct input_dev *input;


Thanks,
Henrik
