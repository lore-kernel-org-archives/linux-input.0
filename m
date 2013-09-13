From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] Input: gpio_keys - wakeup_trigger
Date: Fri, 13 Sep 2013 16:56:00 -0700
Message-ID: <CAD=FV=VeVYNAQMrGHdQFubeQOFqA0TQirDTMagYLw5u5pTkbMg@mail.gmail.com>
References: <1379109160-32437-1-git-send-email-bleung@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379109160-32437-1-git-send-email-bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-/Q/L1SwJa3aEVqv0pETR8A@public.gmane.org
List-Id: linux-input@vger.kernel.org

Benson,

On Fri, Sep 13, 2013 at 2:52 PM, Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> Allow wakeup_trigger to be defined per gpio button. Currently, all
> gpio buttons are set up as IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING.
> It may be more appropriate to only wake the system on one edge, for example
> if the gpio is for a Lid Switch.
>
> Signed-off-by: Benson Leung <bleung-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

As discussed out of band, I'd tend to put the masking/error checking
in gpio_keys_get_devtree_pdata() then just rely on non-DT users not to
pass in nonsense, but I don't feel that strongly about it, so:

Reviewed-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
