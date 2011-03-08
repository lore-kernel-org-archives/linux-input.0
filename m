From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: ntrig don't dereference unclaimed hidinput
Date: Tue, 8 Mar 2011 14:35:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103081433320.19969@pobox.suse.cz>
References: <1299550408-11457-1-git-send-email-rafi@seas.upenn.edu> <1299561869-15165-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37515 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633Ab1CHNfH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Mar 2011 08:35:07 -0500
In-Reply-To: <1299561869-15165-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se, chatty@enac.fr, peter.hutterer@who-t.net

On Tue, 8 Mar 2011, Rafi Rubin wrote:

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

Actually after thinking about it a little bit more, I don't think this 
should be handled up the stack (i.e. in hid_process_event()) -- there 
might be HID-bus drivers which would be interested in reports even if not 
claimed by hid-input.

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

But audit of other drivers which rely on HID_CLAIMED_INPUT flag should be 
done, yes.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
