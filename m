From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 2/2] dt-bindings: new binding for ps/2 gpio devices
Date: Fri, 25 Aug 2017 13:03:23 -0500
Message-ID: <20170825180323.g6pbqox5omeyuf4a@rob-hp-laptop>
References: <20170821193142.29688-1-danilokrummrich@dk-develop.de>
 <20170821193142.29688-3-danilokrummrich@dk-develop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170821193142.29688-3-danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Aug 21, 2017 at 09:31:42PM +0200, Danilo Krummrich wrote:
> The PS/2 gpio device binding defines the gpio pins (data and clock)
> as well as the interrupt which should be used to drive the ps/2 bus.
> It is expected to get an interrupt on the falling edge of the clock
> line.
> 
> Also it can be configured whether the host should support writing to
> the device.
> 
> Signed-off-by: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
> ---
>  .../devicetree/bindings/serio/ps2-gpio.txt         | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serio/ps2-gpio.txt

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
