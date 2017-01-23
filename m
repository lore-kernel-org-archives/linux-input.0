From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] input: pwm-beeper: add documentation for volume
 devicetree bindings
Date: Mon, 23 Jan 2017 08:40:19 -0600
Message-ID: <20170123144019.ij7lalvgeekpcdmv@rob-hp-laptop>
References: <cover.1484838551.git.frieder.schrempf@exceet.de>
 <48a18fbdabcce57ee8efa57b9b6033d1462ab492.1484838551.git.frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <48a18fbdabcce57ee8efa57b9b6033d1462ab492.1484838551.git.frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, luis-HiykPkW1eAzzDCI4PIEvbQC/G2K4zDHf@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Thu, Jan 19, 2017 at 04:24:09PM +0100, Frieder Schrempf wrote:
> This patch adds the documentation for the devicetree bindings to set
> the volume levels.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf-wPoT/lNZgHizQB+pC5nmwQ@public.gmane.org>
> ---
> Changes in v3:
>  - change description of volume-levels to be used for linear levels
>  
>  .../devicetree/bindings/input/pwm-beeper.txt         | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
