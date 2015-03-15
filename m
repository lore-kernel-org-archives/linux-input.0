From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/5] i8042: intel-8042 DT documentation
Date: Sat, 14 Mar 2015 20:20:38 -0700
Message-ID: <20150315032038.GA13064@dtor-ws>
References: <1423857173-16432-6-git-send-email-v1ron@v1ros.org>
 <1424034707-15723-1-git-send-email-v1ron@v1ros.org>
 <1424034707-15723-2-git-send-email-v1ron@v1ros.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1424034707-15723-2-git-send-email-v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roman Volkov <v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Roman,

On Mon, Feb 16, 2015 at 12:11:43AM +0300, Roman Volkov wrote:
> Documentation for 'intel,8042' DT compatible node.
> 
> Signed-off-by: Tony Prisk <linux-ci5G2KO2hbZ+pU9mqzGVBQ@public.gmane.org>
> Signed-off-by: Roman Volkov <v1ron-oLhuKTjYqW/YtjvyW6yDsg@public.gmane.org>
> ---
>  .../devicetree/bindings/input/intel-8042.txt       | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/intel-8042.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/intel-8042.txt b/Documentation/devicetree/bindings/input/intel-8042.txt
> new file mode 100644
> index 0000000..ab8a3e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/intel-8042.txt
> @@ -0,0 +1,26 @@
> +Intel 8042 Keyboard Controller
> +
> +Required properties:
> +- compatible: should be "intel,8042"
> +- regs: memory for keyboard controller
> +- interrupts: usually, two interrupts should be specified (keyboard and aux).
> +	However, only one interrupt is also allowed in case of absence of the
> +	physical port in the controller. The i8042 driver must be loaded with
> +	nokbd/noaux option in this case.
> +- interrupt-names: interrupt names corresponding to numbers in the list.
> +	"kbd" is the keyboard interrupt and "aux" is the auxiliary (mouse)
> +	interrupt.
> +- command-reg: offset in memory for command register
> +- status-reg: offset in memory for status register
> +- data-reg: offset in memory for data register
> +
> +Example:
> +	i8042@d8008800 {
> +		compatible = "intel,8042";
> +		regs = <0xd8008800 0x100>;
> +		interrupts = <23>, <4>;
> +		interrupt-names = "kbd", "aux";
> +		command-reg = <0x04>;
> +		status-reg = <0x04>;
> +		data-reg = <0x00>;
> +	};

No, we already have existing OF bindings for i8042 on sparc and powerpc,
I do not think we need to invent a brand new one.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
