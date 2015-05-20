From: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/7] Change snvs rtc and poweroff to use syscon add pwrkey driver
Date: Wed, 20 May 2015 07:46:18 -0700
Message-ID: <6111368.e0EOBSJsmZ@jclayton-pc>
References: <1432055082-28983-1-git-send-email-Frank.Li@freescale.com> <20150520142205.GA24844@dragon> <CAHrpEqSpeMO=zLyii8qZUznP+9EAQqJ-D3O8hbXj99m+UNvpzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHrpEqSpeMO=zLyii8qZUznP+9EAQqJ-D3O8hbXj99m+UNvpzA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Zhi Li <lznuaa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, "Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Frank.Li-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

> 
> +       snvs_np = of_get_parent(pdev->dev.of_node);
> +       if (!snvs_np)
> +               return -ENODEV;
> +
> +       data->snvs = syscon_node_to_regmap(snvs_np);
> +       of_node_put(snvs_np);
> +
> +       if (!data->snvs) {
> +               pr_err("Can't snvs syscon\n");
> +               return -ENODEV;
> +       }
> 
> How about change error message to " Can't snvs syscon, probably use
> old dts file"?
How about simply: "Cannot find snvs syscon node in devicetree."


-- 
~Joshua Clayton
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
