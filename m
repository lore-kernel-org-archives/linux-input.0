From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: add touchscreen driver for MELFAS MCS-5000
	controller
Date: Wed, 15 Jul 2009 08:30:02 -0700
Message-ID: <20090715153001.GD21611@dtor-d630.eng.vmware.com>
References: <4A56A304.3050009@samsung.com> <20090714060403.GE2822@dtor-d630.eng.vmware.com> <4A5D8A73.4040707@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:63002 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755483AbZGOPaG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jul 2009 11:30:06 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2044308rvb.5
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2009 08:30:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A5D8A73.4040707@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.fujak@samsung.com

On Wed, Jul 15, 2009 at 04:51:15PM +0900, Joonyoung Shim wrote:
> On 7/14/2009 3:04 PM, Dmitry Torokhov wrote:
> > Hi Joonyoung,
> > 
> > On Fri, Jul 10, 2009 at 11:10:12AM +0900, Joonyoung Shim wrote:
> >> The MELPAS MCS-5000 is the touchscreen controller. The overview of this
> >> controller can see at the following website:
> >>
> >> http://www.melfas.com/product/product01.asp?k_r=eng_
> >>
> >> This driver is tested on s3c6410 NCP board and supports only the i2c
> >> interface.
> >>
> >> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> >> ---
> >> Dear Dmitry,
> >>
> >> I sent the patch v2, but couldn't get any response.
> >> This patch v3 is updated a little bit from v2.
> >>
> > 
> > While I was sittign on the patch mainline acquired threaded IRQ support
> > which fits the bill here and simplifies logic quite a bit, could you
> > please try the patch below and tell me if the touchscreen still works?
> > 
> 
> I've tested your patch, but it does not work. If i touch the pannel,
> mcs5000_ts_hardirq is called once, but mcs5000_ts_interrupt is not
> called, so the interrupt is not occurred any longer.
> 

Hmm, wierd... I guess since threaded IRQs are pretty new there could be
some issues there.

-- 
Dmitry
