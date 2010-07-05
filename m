From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] hid-magicmouse: Correct parsing of large X and Y
 motions.
Date: Mon, 05 Jul 2010 12:28:08 -0400
Message-ID: <1278347288.2425.21.camel@cndougla>
References: <878w5qaspq.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:34557 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab0GEQ2N (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jul 2010 12:28:13 -0400
In-Reply-To: <878w5qaspq.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Mon, 2010-07-05 at 10:50 -0400, Michael Poole wrote:
> The X and Y values have two more significant bits in the same byte
> that contains click status.  Include these in the reported value.
> Thanks to Iain Hibbert of NetBSD for pointing this out.
> 
> Signed-off-by: Michael Poole <mdpoole@troilus.org>
> ---
>  drivers/hid/hid-magicmouse.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 0b89c1c..7cdda23 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -267,8 +267,8 @@ static int magicmouse_raw_event(struct hid_device *hdev,
>  		 * to have the current touch information before
>  		 * generating a click event.
>  		 */
> -		x = (signed char)data[1];
> -		y = (signed char)data[2];
> +		x = (int)(((data[3] & 0x0c) << 28) | (data[1] << 22)) >> 22;
> +		y = (int)(((data[3] & 0x30) << 26) | (data[2] << 22)) >> 22;
>  		clicks = data[3];
>  		break;
>  	case 0x20: /* Theoretically battery status (0-100), but I have

Looks right to me.

Acked-by: Chase Douglas <chase.douglas@canonical.com>

-- Chase

