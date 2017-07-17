From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: input: ti,drv260x: fix typo in property name
Date: Mon, 17 Jul 2017 12:41:35 -0500
Message-ID: <20170717174135.bj5o4t2vwwsjy47e@rob-hp-laptop>
References: <1499865202-19337-1-git-send-email-andrea.merello@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1499865202-19337-1-git-send-email-andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrea Merello <andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Francesco Diotalevi <francesco.diotalevi-3ZtyIFJ0STI@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Jul 12, 2017 at 03:13:22PM +0200, Andrea Merello wrote:
> The driver looks for "vib-overdrive-mv" property, while in
> documentation we have "vib-overdriver-mv". Fix the doc.
> 
> Cc: Francesco Diotalevi <francesco.diotalevi-3ZtyIFJ0STI@public.gmane.org>
> Signed-off-by: Andrea Merello <andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/input/ti,drv260x.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
