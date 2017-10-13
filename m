From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] dt-bindings: Add I2C attached EETI EXC3000 bindings
Date: Fri, 13 Oct 2017 13:58:22 -0500
Message-ID: <20171013185822.ib4wegqdn5masfzi@rob-hp-laptop>
References: <20171006073728.14724-1-inan@distec.de>
 <20171006073728.14724-2-inan@distec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171006073728.14724-2-inan-T/gOFcTbiWqzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ahmet Inan <inan-T/gOFcTbiWqzQB+pC5nmwQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ahmet Inan <xdsopl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 06, 2017 at 09:37:28AM +0200, Ahmet Inan wrote:
> This documents the use of the dt-bindings for the EETI EXC3000 driver
> with the following example configuration:
> 
> Using the I2C address 0x2a of the touch controller in the driver.
> 
> Using pin 9 as low level-sensitive interrupt to signal the driver.
> 
> Using a 4096x4096 touch screen resolution.
> 
> Inverting the x-axis and swapping the result with the y-axis.
> 
> Signed-off-by: Ahmet Inan <inan-T/gOFcTbiWqzQB+pC5nmwQ@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/exc3000.txt         | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/exc3000.txt

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
