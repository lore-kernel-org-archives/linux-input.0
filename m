From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH v3] Input: add touchscreen driver for MELFAS MCS-5000
	controller
Date: Tue, 14 Jul 2009 08:47:48 +0200
Message-ID: <001901ca044f$0314e930$093ebb90$%szyprowski@samsung.com>
References: <4A56A304.3050009@samsung.com>
 <20090714060403.GE2822@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout5.samsung.com ([203.254.224.35]:49380 "EHLO
	mailout5.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbZGNGsk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 02:48:40 -0400
Received: from epmmp1 (mailout5.samsung.com [203.254.224.35])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KMR008FKEWK4J@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 14 Jul 2009 15:48:20 +0900 (KST)
Received: from AMDC159 ([106.116.37.153])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KMR0051MEW6SV@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 14 Jul 2009 15:48:20 +0900 (KST)
In-reply-to: <20090714060403.GE2822@dtor-d630.eng.vmware.com>
Content-language: pl
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Joonyoung Shim' <jy0922.shim@samsung.com>
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com, Tomasz Fujak <t.fujak@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>

Hello,

On Tuesday, July 14, 2009 8:04 AM, Dmitry Torokhov wrote:

> Hi Joonyoung,
> 
> On Fri, Jul 10, 2009 at 11:10:12AM +0900, Joonyoung Shim wrote:
> > The MELPAS MCS-5000 is the touchscreen controller. The overview of this
> > controller can see at the following website:
> >
> > http://www.melfas.com/product/product01.asp?k_r=eng_
> >
> > This driver is tested on s3c6410 NCP board and supports only the i2c
> > interface.
> >
> > Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> > ---
> > Dear Dmitry,
> >
> > I sent the patch v2, but couldn't get any response.
> > This patch v3 is updated a little bit from v2.
> >
> 
> While I was sittign on the patch mainline acquired threaded IRQ support
> which fits the bill here and simplifies logic quite a bit, could you
> please try the patch below and tell me if the touchscreen still works?

I have no idea what I do wrong, but this patch also does not apply here:

$ git apply touchscreen-update.diff
error: patch failed: drivers/input/touchscreen/mcs5000_ts.c:259
error: drivers/input/touchscreen/mcs5000_ts.c: patch does not apply

$ patch -p1 < touchscreen-update.diff
patching file drivers/input/touchscreen/mcs5000_ts.c
Hunk #6 FAILED at 196.
1 out of 7 hunks FAILED -- saving rejects to file drivers/input/touchscreen/mcs5000_ts.c.rej

I've tried it on clean 'v3' patch posted in '[PATCH v3] Input: add
touchscreen driver for MELFAS MCS-5000 controller' mail on Friday 
2009-07-10 04:10.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center



