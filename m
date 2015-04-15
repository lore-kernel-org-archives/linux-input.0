From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] alps: Document separate pointstick button bits for V2
 alps devices
Date: Wed, 15 Apr 2015 10:49:12 -0700
Message-ID: <20150415174912.GD27779@dtor-ws>
References: <1429106927-7443-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35541 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbbDORtQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Apr 2015 13:49:16 -0400
Received: by oign205 with SMTP id n205so33033524oig.2
        for <linux-input@vger.kernel.org>; Wed, 15 Apr 2015 10:49:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1429106927-7443-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Hans de Bruin <jmdebruin@xmsnet.nl>, linux-input@vger.kernel.org

On Wed, Apr 15, 2015 at 04:08:47PM +0200, Hans de Goede wrote:
> Non interleaved dualpoint v2 devices have separate pointstick button bits,
> document this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied, thank you.

> ---
> Changes in v2:
> -Document that the pointingstick packet button bits give the combined
>  button status of both the stick and the touchpad buttons
> ---
>  Documentation/input/alps.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/input/alps.txt b/Documentation/input/alps.txt
> index 92ae734..e301887d 100644
> --- a/Documentation/input/alps.txt
> +++ b/Documentation/input/alps.txt
> @@ -94,6 +94,10 @@ PS/2 packet format
>  
>  Note that the device never signals overflow condition.
>  
> +For protocol version 2 devices when the trackpoint is used, and no fingers
> +are on the touchpad, the M R L bits signal the combined status of both the
> +pointingstick and touchpad buttons.
> +
>  ALPS Absolute Mode - Protocol Version 1
>  --------------------------------------
>  
> @@ -107,7 +111,7 @@ ALPS Absolute Mode - Protocol Version 1
>  ALPS Absolute Mode - Protocol Version 2
>  ---------------------------------------
>  
> - byte 0:  1    ?    ?    ?    1    ?    ?    ?
> + byte 0:  1    ?    ?    ?    1  PSM  PSR  PSL
>   byte 1:  0   x6   x5   x4   x3   x2   x1   x0
>   byte 2:  0  x10   x9   x8   x7    ?  fin  ges
>   byte 3:  0   y9   y8   y7    1    M    R    L
> @@ -115,7 +119,8 @@ ALPS Absolute Mode - Protocol Version 2
>   byte 5:  0   z6   z5   z4   z3   z2   z1   z0
>  
>  Protocol Version 2 DualPoint devices send standard PS/2 mouse packets for
> -the DualPoint Stick.
> +the DualPoint Stick. For non interleaved dualpoint devices the pointingstick
> +buttons get reported separately in the PSM, PSR and PSL bits.
>  
>  Dualpoint device -- interleaved packet format
>  ---------------------------------------------
> -- 
> 2.3.5
> 

-- 
Dmitry
