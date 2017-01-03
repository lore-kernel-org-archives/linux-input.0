From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] input: touchscreen: add driver for Zeitec ZET6223
Date: Tue, 3 Jan 2017 09:24:59 -0600
Message-ID: <20170103152459.fjkkwjrhliui4jlf@rob-hp-laptop>
References: <20161223163214.7716-1-jelle@vdwaa.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161223163214.7716-1-jelle-oJJ1AqDjjO4@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jelle van der Waa <jelle-oJJ1AqDjjO4@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Dec 23, 2016 at 05:32:13PM +0100, Jelle van der Waa wrote:
> This is a basic driver for the Zeitec ZET6223 I2C touchscreen
> controllers. The driver does not support firmware loading, which is not
> required for all tablets which contain this chip.
> 
> Signed-off-by: Jelle van der Waa <jelle-oJJ1AqDjjO4@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/zet6223.txt         |  29 +++

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/input/touchscreen/Kconfig                  |  11 ++
>  drivers/input/touchscreen/Makefile                 |   1 +
>  drivers/input/touchscreen/zet6223.c                | 198 +++++++++++++++++++++
>  4 files changed, 239 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
>  create mode 100644 drivers/input/touchscreen/zet6223.c
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
