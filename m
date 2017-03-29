From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v8 2/3] dt-bindings: input: touchscreen: Add max11801-ts
 binding
Date: Tue, 28 Mar 2017 20:57:55 -0500
Message-ID: <20170329015755.zi77exu7tpne3g3n@rob-hp-laptop>
References: <1490209518-20790-1-git-send-email-jagan@openedev.com>
 <1490209518-20790-2-git-send-email-jagan@openedev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1490209518-20790-2-git-send-email-jagan-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jagan Teki <jagan-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Mar 23, 2017 at 12:35:17AM +0530, Jagan Teki wrote:
> From: Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
> 
> Add missing documentation of max11801-ts dt-binding details.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
> Signed-off-by: Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
> ---
> Changes for v8:
> - Use IRQ_TYPE_EDGE_FALLING for interrupt trigger type. 
> Changes for v7:
> - add vendor prefix as maxim
> Changes for v6:
> - Replace the lable and name of the node
>    ts: max11801 => max11801: touchscreen@48
> Changes for v5:
> - Newly added patch
> 
>  .../bindings/input/touchscreen/max11801-ts.txt         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
