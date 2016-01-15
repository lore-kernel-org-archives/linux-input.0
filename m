From: Andrey Gusakov <andrey.gusakov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 03/10] Input: synaptics-rmi4: Add device tree support
 for RMI4 I2C devices
Date: Fri, 15 Jan 2016 14:24:15 +0300
Message-ID: <CAFmnZc3Ce40CT9V8X223aPxfbRXUcRX5RvK=0GitQ5yrPVXhOg@mail.gmail.com>
References: <1452815059-22980-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1452815059-22980-1-git-send-email-aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Duggan <aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Christopher Heiny <cheiny-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>, Stephen Chandler Paul <cpaul-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vincent Huang <vincent.huang-8LB1SX4YFO85ffrT631h+Q@public.gmane.org>, Chris Healy <cphealy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 15, 2016 at 2:44 AM, Andrew Duggan <aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org> wrote:
>
> Add devicetree binding for I2C devices and add bindings for optional
> parameters in the function drivers. Parameters for function drivers are
> defined in child nodes for each of the functions.
>
> Signed-off-by: Andrew Duggan <aduggan-Gq53QDLGkWKakBO8gow8eQ@public.gmane.org>
...
> +#ifdef CONFIG_OF
> +static void rmi_function_of_probe(struct rmi_function *fn)
> +{
> +       char of_name[8];
> +
> +       snprintf(of_name, sizeof(of_name), "rmi4-f%02x",
> +               fn->fd.function_number);
> +       fn->dev.of_node = of_find_node_by_name(
> +                               fn->rmi_dev->xport->dev->of_node, of_name);
> +}
>
Name like "rmi4-f11" including 0 terminator does not fit in 8 chars.
This leads to the inability to find the correct OF node and get settings.

Sorry for previous HTML noise.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
