From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 22/25] sony-laptop: forward Hybrid GFX notifications to
 userspace
Date: Sat, 4 Jun 2011 17:48:20 +0900
Message-ID: <20110604084820.GE7194@kamineko.org>
References: <4DE8FC4A.9010401@absence.it>
 <4DE93584.3070205@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:55380 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab1FDIsR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 Jun 2011 04:48:17 -0400
Content-Disposition: inline
In-Reply-To: <4DE93584.3070205@absence.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, Jun 03, 2011 at 09:27:00PM +0200, Marco Chiappero wrote:
> Some Vaios come with both integrated and discrete graphics, plus a
> switch for choosing one of the two. When the switch position is
> changed, a notification is generated, now forwarded to userspace for
> example for visual notifications, user scripts, and so on.
> 
> Signed-off-by: Marco Chiappero <marco@absence.it>
> ---
> 
> --- a/drivers/platform/x86/sony-laptop.c
> +++ b/drivers/platform/x86/sony-laptop.c
> @@ -3118,6 +3118,14 @@ static void sony_nc_notify(struct acpi_d
> 
>  	dprintk("sony_nc_notify, event: 0x%.2x\n", event);
> 
> +	/* events codes list
> +	 * 1    Hotkeys
> +	 * 2    RFKILL
> +	 * 3    ALS
> +	 * 4    HDD protection
> +	 * 5	Hybrid GFX
> +	 */

how about some #defines instead of a comment?

>  	/* handles related events */
>  	if (event >= 0x90) {
>  		unsigned int result = 0, handle = 0;
> @@ -3169,6 +3177,23 @@ static void sony_nc_notify(struct acpi_d
>  			/* hdd protection event, notify userspace */
>  			break;
> 
> +		case 0x0128:
> +		case 0x0146:
> +			/* Hybrid GFX switching, 1 */
> +			sony_call_snc_handle(handle, 0x0000, &result);
> +			dprintk("sony_nc_notify, Hybrid GFX event received "
> +					"(reason: %s)\n", (result & 0x01) ?
> +					"switch position change" : "unknown");
> +
> +			/* verify the switch state
> +			   (1: discrete GFX, 0: integrated GFX)*/
> +			result = 0;
> +			sony_call_snc_handle(handle, 0x0100, &result);
> +
> +			ev = 5;
> +			value = result & 0xff;
> +			break;

shouldn't this be reported as an input event rather than just an acpi
one?
also, I am trying to recall how the speed/stamina switch was handled in
older SZ and other models. I think we are already notifying the
switching event as an input key (PROG4? PROG5?)
I didn't see a better option in input.h, maybe time to add one?

>  		default:
>  			value = event;
>  			dprintk("Unknowk event for handle: 0x%x\n", handle);
-- 
mattia
:wq!
