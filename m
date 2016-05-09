From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Input: add Atmel Atmegaxx captouch driver
Date: Mon, 9 May 2016 09:29:48 -0700
Message-ID: <20160509162948.GA15535@dtor-ws>
References: <1462295611-49684-1-git-send-email-grundler@chromium.org>
 <20160504135123.GA4567@rob-hp-laptop>
 <CANEJEGt1Ri7Q-g25U8_KTAb9Z8MfVWH0N5QLaLcdnDuF_wwrtw@mail.gmail.com>
 <572C61B1.2040508@atmel.com>
 <CAHHoo-j7145vPFNmJH=CvPu-BRCgRe0WNKH8QDkSc+c3koxHAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHHoo-j7145vPFNmJH=CvPu-BRCgRe0WNKH8QDkSc+c3koxHAQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, May 06, 2016 at 11:14:12PM +0800, Daniel Hung-yu Wu wrote:
> The register set is different, and this chip does not support calibration.
> The I2C protocol is not the same as well; there is an additional byte
> indicating data length.
> 
> Atmega88PA is a general-purpose MCU. In the future, we will add more
> functionalities, such as firmware upgrade through I2C.

Is it Google who will be maintaining and extending the protocol or
Atmel? If it is Google then maybe we should switch compat string to
"google,captouch" or similar.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
