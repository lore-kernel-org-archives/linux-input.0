From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Use TipSwitch for Touch
Date: Tue, 13 Apr 2010 23:32:43 -0700
Message-ID: <20100414063242.GB9428@core.coreip.homeip.net>
References: <alpine.LNX.2.00.1004131530460.8345@pobox.suse.cz>
 <1271221494-14846-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:57853 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753365Ab0DNGcs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Apr 2010 02:32:48 -0400
Received: by ywh36 with SMTP id 36so3537106ywh.4
        for <linux-input@vger.kernel.org>; Tue, 13 Apr 2010 23:32:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1271221494-14846-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, micki@n-trig.com, chatty@enac.fr

On Wed, Apr 14, 2010 at 01:04:54AM -0400, Rafi Rubin wrote:
> TipSwitch is a better match for touch.  Confidence and InRange work
> for more current firmwares, but with some older versions only
> TipSwitch is appropriate.
> 
> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
> ---
>  drivers/hid/hid-ntrig.c |   27 +++++++++++++++++++--------
>  1 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index 58ba0d3..071f86d 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -31,10 +31,12 @@ struct ntrig_data {
>  	/* Incoming raw values for a single contact */
>  	__u16 x, y, w, h;
>  	__u16 id;
> -	__u8 confidence;
> +
> +	bool tipswitch;
> +	bool confidence;
> +	bool first_contact_touch;
>  
>  	bool reading_mt;
> -	__u8 first_contact_confidence;
>  
>  	__u8 mt_footer[4];
>  	__u8 mt_foot_count;
> @@ -141,9 +143,10 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  		case 0xff000001:
>  			/* Tag indicating the start of a multitouch group */
>  			nd->reading_mt = 1;
> -			nd->first_contact_confidence = 0;
> +			nd->first_contact_touch = 0;
>  			break;
>  		case HID_DG_TIPSWITCH:
> +			nd->tipswitch = value;
>  			/* Prevent emission of touch until validated */
>  			return 1;
>  		case HID_DG_CONFIDENCE:
> @@ -171,10 +174,17 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  			 * to emit a normal (X, Y) position
>  			 */
>  			if (!nd->reading_mt) {
> -				input_report_key(input, BTN_TOOL_DOUBLETAP,
> -						 (nd->confidence != 0));
> +				/*
> +				 * TipSwitch indicates the presence of a
> +				 * finger.  Touch is the preferred event for
> +				 * downstream support.  DoubleTap is also
> +				 * emitted to support proper operation with
> +				 * the wacom X driver (for now).
> +				 */

I am not sure if we want to propagate unfortunate event selection in
wacom drievr into other drivers. Any chance you could lend Ping hand in
adding proper multitouch support to wacom X driver instead?

-- 
Dmitry
