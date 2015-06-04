From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v0] gpio_keys: fix gpio key driver to proper support GIC
 interrupt
Date: Thu, 4 Jun 2015 10:23:24 -0700
Message-ID: <20150604172324.GA9074@dtor-ws>
References: <1433402712-21399-1-git-send-email-yvo@apm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433402712-21399-1-git-send-email-yvo-qTEPVZfXA3Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Y Vo <yvo-qTEPVZfXA3Y@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Phong Vo <pvo-qTEPVZfXA3Y@public.gmane.org>, Toan Le <toanle-qTEPVZfXA3Y@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, Feng Kan <fkan-qTEPVZfXA3Y@public.gmane.org>, patches-qTEPVZfXA3Y@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Y,
On Thu, Jun 04, 2015 at 02:25:12PM +0700, Y Vo wrote:
> GIC is designed to support two of trigger mechanisms - active level
> high or edge rising. But in the gpio_keys driver, it tries to use both
> edge rising and edge falling trigger. This patch fixes the gpio_keys
> driver to request only the edge rising event when failed to configure the
> interrupt.

How do we get notified of button release if we only get interrupt on
rising edge?

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
