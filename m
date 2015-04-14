From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] alps: Document separate pointstick button bits for V2
 alps devices
Date: Tue, 14 Apr 2015 09:08:51 -0700
Message-ID: <20150414160851.GA24687@dtor-glaptop>
References: <1428996947-4454-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35078 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045AbbDNQIy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 12:08:54 -0400
Received: by iejt8 with SMTP id t8so18848289iej.2
        for <linux-input@vger.kernel.org>; Tue, 14 Apr 2015 09:08:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1428996947-4454-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Hans de Bruin <jmdebruin@xmsnet.nl>, linux-input@vger.kernel.org

On Tue, Apr 14, 2015 at 09:35:47AM +0200, Hans de Goede wrote:
> Non interleaved dualpoint v2 devices have separate pointstick button bits,
> document this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  Documentation/input/alps.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/input/alps.txt b/Documentation/input/alps.txt
> index 92ae734..776a099 100644
> --- a/Documentation/input/alps.txt
> +++ b/Documentation/input/alps.txt
> @@ -107,7 +107,7 @@ ALPS Absolute Mode - Protocol Version 1
>  ALPS Absolute Mode - Protocol Version 2
>  ---------------------------------------
>  
> - byte 0:  1    ?    ?    ?    1    ?    ?    ?
> + byte 0:  1    ?    ?    ?    1  PSM  PSR  PSL
>   byte 1:  0   x6   x5   x4   x3   x2   x1   x0
>   byte 2:  0  x10   x9   x8   x7    ?  fin  ges
>   byte 3:  0   y9   y8   y7    1    M    R    L
> @@ -115,7 +115,8 @@ ALPS Absolute Mode - Protocol Version 2
>   byte 5:  0   z6   z5   z4   z3   z2   z1   z0
>  
>  Protocol Version 2 DualPoint devices send standard PS/2 mouse packets for
> -the DualPoint Stick.
> +the DualPoint Stick. For non interleaved dualpoint devices the pointingstick
> +buttons get reported separately in the PSM, PSR and PSL bits.

Can you please also add explanation about trackstick still using the mix of both?

Thanks!

-- 
Dmitry
