From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 2/2] input: goodix: Add device tree support for 5-finger
 chips
Date: Wed, 04 Mar 2015 10:19:08 +0100
Message-ID: <1425460748.9384.2.camel@hadess.net>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
	 <1425458053-4559-1-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1425458053-4559-1-git-send-email-mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, 2015-03-04 at 11:34 +0300, Aleksei Mamlin wrote:
> This patch adds device tree support for 5-finger chips, like GT911 
> and GT912.

You should add the same support to the ACPI matching.

<snip>
>  #ifdef CONFIG_OF
>  static struct of_device_id goodix_of_match[] = {
> -       { .compatible = "goodix,gt9110" },
> -       { .compatible = "goodix,gt927" },
> -       { .compatible = "goodix,gt9271" },
> -       { .compatible = "goodix,gt928" },
> -       { .compatible = "goodix,gt967" },
> +       { .compatible = "goodix,gt911",  .data = (void *) 5 },
> +       { .compatible = "goodix,gt9110", .data = (void *) 10 },

There's no need to add "10" for these tablets as it's already the 
GOODIX_MAX_CONTACTS value. Or you need to add it to every instance.

I would also like a link to the spec sheets in the commit message.

> +       { .compatible = "goodix,gt912",  .data = (void *) 5 },
> +       { .compatible = "goodix,gt927",  .data = (void *) 10 },
> +       { .compatible = "goodix,gt9271", .data = (void *) 10 },
> +       { .compatible = "goodix,gt928",  .data = (void *) 10 },
> +       { .compatible = "goodix,gt967",  .data = (void *) 10 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, goodix_of_match);
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
