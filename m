From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 3/6] hid: egalax: Correct for device resolution report
 error
Date: Wed, 13 Oct 2010 22:13:37 +0200
Message-ID: <4CB612F1.1080704@euromail.se>
References: <1286978302-30034-1-git-send-email-rydberg@euromail.se> <1286978302-30034-4-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:39539 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752730Ab0JMUPY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 16:15:24 -0400
In-Reply-To: <1286978302-30034-4-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Philipp Merkel <mail@philmerk.de>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/13/2010 03:58 PM, Henrik Rydberg wrote:

> The firmware of both supported devices report a X/Y maximum of 4096,
> whereas in reality, it is eight times larger. Fixed with this patch.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/hid/hid-egalax.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-egalax.c b/drivers/hid/hid-egalax.c
> index 23f832b..3b490a3 100644
> --- a/drivers/hid/hid-egalax.c
> +++ b/drivers/hid/hid-egalax.c
> @@ -56,6 +56,7 @@ static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  	case HID_UP_GENDESK:
>  		switch (usage->hid) {
>  		case HID_GD_X:
> +			field->logical_maximum <<= 3;


This makes the logical maximum increase by a factor of eight every time the
module is loaded.

>  			hid_map_usage(hi, usage, bit, max,
>  					EV_ABS, ABS_MT_POSITION_X);
>  			set_abs(input, ABS_MT_POSITION_X, field, 0);
> @@ -63,6 +64,7 @@ static int egalax_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  			set_abs(input, ABS_X, field, 0);
>  			return 1;
>  		case HID_GD_Y:
> +			field->logical_maximum <<= 3;


Same here.

>  			hid_map_usage(hi, usage, bit, max,
>  					EV_ABS, ABS_MT_POSITION_Y);
>  			set_abs(input, ABS_MT_POSITION_Y, field, 0);


Will send new revisions of patches 3 and 5...

Henrik
