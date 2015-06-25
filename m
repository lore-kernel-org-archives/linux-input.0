From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] i8042: Add debug_kbd option
Date: Thu, 25 Jun 2015 13:32:38 -0700
Message-ID: <20150625203238.GA27620@dtor-ws>
References: <1435260310-10074-1-git-send-email-cpaul@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36248 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751551AbbFYUcn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Jun 2015 16:32:43 -0400
Content-Disposition: inline
In-Reply-To: <1435260310-10074-1-git-send-email-cpaul@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: cpaul@redhat.com
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

On Thu, Jun 25, 2015 at 03:25:10PM -0400, cpaul@redhat.com wrote:
> From: Stephen Chandler Paul <cpaul@redhat.com>
> 
> A big problem with the current i8042 debugging option is that it outputs
> data going to and from the keyboard by default. As a result, many dmesg
> logs uploaded by users will unintentionally contain sensitive information
> such as their password, as such it's probably a good idea not to output
> data coming from the keyboard unless specifically enabled by the user.
> 
> Signed-off-by: Stephen Chandler Paul <cpaul@redhat.com>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  Documentation/kernel-parameters.txt |  7 +++++++
>  drivers/input/serio/i8042.c         | 25 +++++++++++++++++++++----
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index ae44749..9e00234 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1304,6 +1304,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			     <bus_id>,<clkrate>
>  
>  	i8042.debug	[HW] Toggle i8042 debug mode
> +	i8042.debug_kbd [HW] Enable printing of interrupt data from the KBD port
> +			     As a side effect, this option will mask some of the
> +			     interrupts sent back from the keyboard during the
> +			     initialization of the KBD port on the i8042, if you
> +			     need to see this, you will need to enable this
> +			     option.

Hmm, can we maybe use the bus notifier and react to
BUS_NOTIFY_BOUND_DRIVER/BUS_NOTIFY_UNBIND_DRIVER to decide if we want to
see keyboard data stream?

Thanks.

-- 
Dmitry
