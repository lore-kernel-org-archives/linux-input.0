From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 1/4] Input: goodix - Restructure cfg checksum function
Date: Thu, 27 Oct 2016 12:32:50 +0200
Message-ID: <1477564370.2458.8.camel@hadess.net>
References: <20161020195917.20051-1-fcooper@ti.com>
         <20161020195917.20051-2-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161020195917.20051-2-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, 2016-10-20 at 14:59 -0500, Franklin S Cooper Jr wrote:
> Split generation of checksum into is own function. Currently it is used

"its own".

> only to determine if the checksum for the user provided configuration file
> is valid or not. However, support to dynamically alter the configuration
> file will be supported and needs a way to calculate the updated file's
> checksum. Therefore, by splitting calculating checksum into its own
> function the code can be reused.
> 

After the fixup above:

Reviewed-by: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
