From: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: Input: add Atmel Atmegaxx captouch driver
Date: Fri, 6 May 2016 11:29:14 -0700
Message-ID: <CANEJEGtDSGL0gWVsHP8Dyy5n8s7juYhTVLJUmHq8Mn8Xf67_xA@mail.gmail.com>
References: <1462295611-49684-1-git-send-email-grundler@chromium.org>
	<20160504135123.GA4567@rob-hp-laptop>
	<CANEJEGt1Ri7Q-g25U8_KTAb9Z8MfVWH0N5QLaLcdnDuF_wwrtw@mail.gmail.com>
	<572C61B1.2040508@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <572C61B1.2040508-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hung-yu Wu <hywu-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, May 6, 2016 at 2:19 AM, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
...
> Is it different from the Atmel QT1070 or QT2160 which have drivers
> already available in Linux:  drivers/input/keyboard/qt1070.c

Yes.  What Daniel said.  I would describe it as "probe code and
interrupt handling protocol are different" from both qt1070 and
qt2160.

I'll add qt2160 is quite a bit more complex by adding LED driver
support in a separate work handler and can handle a matrix of key
codes. So very different protocol and linux device driver.

cheers,
grant
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
