From: =?big5?B?vEK5xcJA?= <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
Subject: RE: [PATCH v1] Support Elan Touchscreen eKTF product.
Date: Tue, 23 Oct 2012 16:30:18 +0800
Message-ID: <7BC14E6A36624121B78375F1425F9C32@elan.corp>
References: <87pq4aq6if.fsf@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87pq4aq6if.fsf-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Jian-Jhong Ding' <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, 'Dmitry Torokhov' <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Benjamin Tissoires' <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Jesse' <jesse-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, 'Vincent Wang' <vincent.wang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, 'Paul' <paul.liang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry:
	This driver is not related to Tom's driver. This driver is ELAN
standard I2C driver for touch panel and its packets is defined by ELAN own
format and not related to HID over I2C.

Thanks,
Scott

> -----Original Message-----
> From: Jian-Jhong Ding [mailto:jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org]
> Sent: Tuesday, October 23, 2012 10:15 AM
> To: Dmitry Torokhov
> Cc: Scott Liu; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Benjamin Tissoires; Jesse; Vincent Wang;
Paul
> Subject: Re: [PATCH v1] Support Elan Touchscreen eKTF product.
> 
> Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> > On Mon, Oct 22, 2012 at 11:47:42AM +0800, Jian-Jhong Ding wrote:
> >> With Benjamin's i2c-hid implimentation, is it possible to make
> >> hid-multitouch not depend on USBHID and reuse it to drive this device?
> >
> > Exactly. Before looking any further - is this the same part that Tom Lin
> > posted a driver for earlier this summer?
> 
> No.  Tom's driver was only for trackpads, this is probably for some
> touch panel.  The controller ICs may have some similarities, but the
> firmware is developed independently, though both somewhat conform to the
> HID over I2C protocol.
> 
> Thanks,
> -JJ
> > Thanks.
> >
> > --
> > Dmitry
