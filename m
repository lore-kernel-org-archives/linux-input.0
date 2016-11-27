From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation: sample averaging for imx6ul_tsc
Date: Sun, 27 Nov 2016 10:38:26 -0200
Message-ID: <CAOMZO5Acpz_Y-MYcDmhDGg0eX=+d=mjruXAE+kZhK04rGgsG5Q@mail.gmail.com>
References: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480232698-23075-1-git-send-email-guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Sun, Nov 27, 2016 at 5:44 AM, Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org> wrote:
> The i.MX6UL internal touchscreen controller contains an option to
> average upon samples. This feature reduces noise from the produced
> touch locations.
>
> This patch introduces a new device tree optional property for this
> feature. It provides control over the amount of averaged samples per
> touch event.
>
> The property was inspired by a similar property on the
> "brcm,iproc-touchscreen" binding.
>
> Signed-off-by: Guy Shapiro <guy.shapiro-2HKgp+mgmS5l57MIdRCFDg@public.gmane.org>

Reviewed-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
