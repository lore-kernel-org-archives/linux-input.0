From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [1/3] Input: wacom - allow both MT and pen data to be reported
Date: Wed, 03 Nov 2010 10:44:43 +0100
Message-ID: <4CD12F0B.9090901@euromail.se>
References: <1288741079-4993-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:49406 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754152Ab0KCJrQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Nov 2010 05:47:16 -0400
In-Reply-To: <1288741079-4993-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chris@cnpbagwell.com, Ping Cheng <pingc@wacom.com>

On 11/03/2010 12:37 AM, Ping Cheng wrote:

> It was suggested by app and X server developers that both MT and pen data
> should be reported to the userland if the data is valid. Bamboo series are
> among these devices that both data are valid from the hardware perspective.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> 
> ---
> drivers/input/tablet/wacom_wac.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index b3252ef..b9534a1 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -868,13 +868,14 @@ static int wacom_bpt_touch(struct wacom_wac *wacom)
>  	for (i = 0; i < 2; i++) {
>  		int p = data[9 * i + 2];
>  		input_mt_slot(input, i);
> -		/*
> -		 * Touch events need to be disabled while stylus is
> -		 * in proximity because user's hand is resting on touchpad
> -		 * and sending unwanted events.  User expects tablet buttons
> -		 * to continue working though.
> +
> +		/* We send touch events even a stylus is in proximity. Apps or
> +		 * userland clients have the opportunity to arbitrate these events
> +		 * when pen is in proximity.
> +		 * Wacom X server driver arbitrates the events for all apps that
> +		 * are based on X server.
>  		 */
> -		if (p && !wacom->shared->stylus_in_proximity) {
> +		if (p) {
>  			int x = get_unaligned_be16(&data[9 * i + 3]) & 0x7ff;
>  			int y = get_unaligned_be16(&data[9 * i + 5]) & 0x7ff;
>  			if (features->quirks & WACOM_QUIRK_BBTOUCH_LOWRES) {


This seems to be an exact revert of 33d5f713a, minus the comments. Perhaps a
revert with the comment in the commit message instead?

Thanks,
Henrik

