From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] HID: ntrig don't dereference unclaimed hidinput
Date: Fri, 11 Mar 2011 11:37:16 +1000
Message-ID: <20110311013716.GA8970@barra.bne.redhat.com>
References: <1299550408-11457-1-git-send-email-rafi@seas.upenn.edu>
 <1299561869-15165-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:19173 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab1CKBh4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2011 20:37:56 -0500
Content-Disposition: inline
In-Reply-To: <1299561869-15165-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, rydberg@euromail.se, chatty@enac.fr

On Tue, Mar 08, 2011 at 12:24:29AM -0500, Rafi Rubin wrote:
> Check before dereferencing field->hidinput to fix a reported invalid
> deference bug.
> 
> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
> ---
> After additional debugging, I realized I'm seeing a variant of Peter's
> bug.  On unloading and then reloading hid-ntrig I'm seeing calls during
> initialization to ntrig_event where field->hidinput is NULL and the
> claimed input flag is still set.  It seems to me this behavior shouldn't
> happen and the check should be further up the stack.
> 
> Sorry about sending a such a trivial patch repeatedly :/
> ---
>  drivers/hid/hid-ntrig.c |   15 ++++++++++++++-
>  1 files changed, 14 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index beb4034..a93e58c 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -539,8 +539,19 @@ static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
>  static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  			struct hid_usage *usage, __s32 value)
>  {
> -	struct input_dev *input = field->hidinput->input;
>  	struct ntrig_data *nd = hid_get_drvdata(hid);
> +	struct input_dev *input;
> +
> +	/* Skip processing if not a claimed input */
> +	if (!(hid->claimed & HID_CLAIMED_INPUT))
> +		goto not_claimed_input;
> +
> +	/* This function is being called before the structures are fully
> +	 * initialized */
> +	if(!(field->hidinput && field->hidinput->input))
> +		return -EINVAL;
> +
> +	input = field->hidinput->input;
>  
>  	/* No special handling needed for the pen */
>  	if (field->application == HID_DG_PEN)
> @@ -810,6 +821,8 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  		}
>  	}
>  
> +not_claimed_input:
> +
>  	/* we have handled the hidinput part, now remains hiddev */
>  	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_hid_event)
>  		hid->hiddev_hid_event(hid, field, usage, value);
> -- 
> 1.7.2.3

fwiw, Tested-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
  Peter
> 
