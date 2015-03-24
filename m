From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/2] Qualcomm PM8941 power key driver
Date: Tue, 24 Mar 2015 11:42:22 -0700
Message-ID: <20150324184222.GB27693@dtor-ws>
References: <1422058747-13486-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1424080516.2328.1.camel@mm-sol.com>
 <CAJAp7Oi0YbrTcJ1+ziWk0J02_qB=syQV=stLnXy2+txA2ZWQpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJAp7Oi0YbrTcJ1+ziWk0J02_qB=syQV=stLnXy2+txA2ZWQpw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bjorn Andersson <bjorn-UYDU3/A3LUY@public.gmane.org>
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Mar 20, 2015 at 02:54:33AM +0100, Bjorn Andersson wrote:
> On Mon, Feb 16, 2015 at 10:55 AM, Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org> wrote:
> >
> > On Fri, 2015-01-23 at 16:19 -0800, Bjorn Andersson wrote:
> >> These patches add dt bindings and a device driver for the power key block in
> >> the Qualcomm PM8941 pmic.
> >>
> >> Changes since v1:
> >>  * Use a reboot_notifier to set power off/reboot mode
> >>  * Use irq flags from devicetree
> >>  * Some style fixes
> >>
> >> Courtney Cavin (2):
> >>   input: Add Qualcomm PM8941 power key driver
> >>   input: pm8941-pwrkey: Add DT binding documentation
> >
> > Tested-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> >
> 
> Thanks for your testing Ivan.
> 
> Dmitry, can you apply this? (It still applies cleanly to linux-next)
> 

Queued for 4.1, thank you.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
