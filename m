From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] ntrig tool separation and pen usages
Date: Tue, 23 Jun 2009 14:01:49 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0906231138400.31685@twin.jikos.cz>
References: <1245278886-11659-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1747641777-1866813014-1245749980=:31685"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40562 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbZFWMBt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 08:01:49 -0400
In-Reply-To: <1245278886-11659-1-git-send-email-rafi@seas.upenn.edu>
Content-ID: <alpine.LRH.2.00.0906231401440.31685@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, chatty@enac.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1747641777-1866813014-1245749980=:31685
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.00.0906231401441.31685@twin.jikos.cz>

On Wed, 17 Jun 2009, Rafi Rubin wrote:

> When both touch and pen are active send a tool announcement before
> sending any status changes so that event users may differentiate
> which tool is changing.
> 
> Restored three usage codes used by the pen.
> 
> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
> ---
>  drivers/hid/hid-ntrig.c |   31 ++++++++++++++++++++++++++++---
>  1 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index 75ed9d2..7765970 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -27,6 +27,9 @@
>  struct ntrig_data {
>  	__s32 x, y, id, w, h;
>  	char reading_a_point, found_contact_id;
> +	char pen_active;
> +	char finger_active;
> +	char inverted;
>  };
>  
>  /*
> @@ -63,10 +66,7 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  	case HID_UP_DIGITIZER:
>  		switch (usage->hid) {
>  		/* we do not want to map these for now */
> -		case HID_DG_INVERT: /* value is always 0 */
> -		case HID_DG_ERASER: /* value is always 0 */
>  		case HID_DG_CONTACTID: /* value is useless */
> -		case HID_DG_BARRELSWITCH:  /* doubtful */
>  		case HID_DG_INPUTMODE:
>  		case HID_DG_DEVICEINDEX:
>  		case HID_DG_CONTACTCOUNT:
> @@ -125,6 +125,18 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  
>          if (hid->claimed & HID_CLAIMED_INPUT) {
>  		switch (usage->hid) {
> +
> +		case HID_DG_INRANGE:
> +			if(field->application & 0x3)
> +				nd->pen_active = value!=0;
> +			else
> +				nd->finger_active = value!=0;

Maybe putting brackets around the comparsion and putting spaces around 
'!=' would make the code more readable and easy to understand on a first 
sight?

> +			return 0;
> +
> +		case HID_DG_INVERT:
> +			nd->inverted = value;
> +			return 0;
> +
>  		case HID_GD_X:
>  			nd->x = value;
>  			nd->reading_a_point = 1;
> @@ -148,6 +160,10 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  			 * to emit a normal (X, Y) position
>  			 */
>  			if (! nd->found_contact_id) {

While at it, could you please remove the space after '!' to be compatible 
with the kernel coding style?

> +				if(nd->pen_active && nd->finger_active) {

And insert a space after 'if' here.

> +					input_report_key(input, BTN_TOOL_DOUBLETAP, 0);
> +					input_report_key(input, BTN_TOOL_DOUBLETAP, 1);
> +				}
>  				input_event(input, EV_ABS, ABS_X, nd->x);
>  				input_event(input, EV_ABS, ABS_Y, nd->y);
>  			}
> @@ -159,6 +175,14 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  			 * to emit a normal (X, Y) position
>  			 */
>  			if (! nd->found_contact_id) {
> +				if(nd->pen_active && nd->finger_active) {

And the same here.



Stéphane, did you have chance to verify with your device, that everything 
works as expected with this version of Rafi's patch?

Thanks,

-- 
Jiri Kosina
SUSE Labs
---1747641777-1866813014-1245749980=:31685--
