From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH RFC 1/4] input: add an EV_REL event for high-res vertical
 wheel
Date: Mon, 27 Mar 2017 11:40:59 +1000
Message-ID: <20170327014059.GD21915@jelly>
References: <cover.1490481944.git.mchehab@s-opensource.com>
 <cf7b2e1587f2986abfa7252f9e8d2799b20911cc.1490481944.git.mchehab@s-opensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:61898 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbdC0BlL (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 26 Mar 2017 21:41:11 -0400
Content-Disposition: inline
In-Reply-To: <cf7b2e1587f2986abfa7252f9e8d2799b20911cc.1490481944.git.mchehab@s-opensource.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Douglas Anderson <dianders@chromium.org>, Kamil Debski <kamil@wypas.org>, Ping Cheng <pinglinux@gmail.com>

On Sat, Mar 25, 2017 at 07:49:39PM -0300, Mauro Carvalho Chehab wrote:
> As some devices can produce either low-res or high-res
> vertical wheel EV_REL events, add a new event to allow
> userspace to distinguish between them.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

Just replied to the other email, but this one is a nak until we have the
Documentation/input/event-codes.txt patch with it explaining how this code
should be used, what these codes represent, what the interaction is with
other codes (e.g. can a device send wheel and hires wheel at the same time?)
etc. There are a lot of questions left to be answered.

Cheers,
   Peter

> ---
>  include/uapi/linux/input-event-codes.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 3af60ee69053..23b2d377af59 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -703,6 +703,7 @@
>  #define REL_DIAL		0x07
>  #define REL_WHEEL		0x08
>  #define REL_MISC		0x09
> +#define REL_HIRES_WHEEL		0x0a
>  #define REL_MAX			0x0f
>  #define REL_CNT			(REL_MAX+1)
>  
> -- 
> 2.9.3
> 
> 
