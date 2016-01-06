From: rajeev kumar <rajeevkumar.linux@gmail.com>
Subject: Re: Add support(re-using) for Cypress CY8CTMA884 part in exiting
 cypress touch controller driver(drivers/input/touchscreen/cyttsp4_core.c)
Date: Wed, 6 Jan 2016 15:43:13 +0530
Message-ID: <CAA7nrthvojGcUr0E+VRzYKVg=a7MuHxc5_NdwY8r3wgr17H-QQ@mail.gmail.com>
References: <CAA7nrthgTKF0z=T98hA2wsEuvzMbpyNe3Ck0TDpbWuqYSEs+jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35097 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbcAFKNP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jan 2016 05:13:15 -0500
Received: by mail-lf0-f52.google.com with SMTP id c192so133863548lfe.2
        for <linux-input@vger.kernel.org>; Wed, 06 Jan 2016 02:13:14 -0800 (PST)
In-Reply-To: <CAA7nrthgTKF0z=T98hA2wsEuvzMbpyNe3Ck0TDpbWuqYSEs+jg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: fery@cypress.com
Cc: linux-input@vger.kernel.org, javier@dowhile0.org

Hello Ferruh

On Mon, Jan 4, 2016 at 12:46 PM, rajeev kumar
<rajeevkumar.linux@gmail.com> wrote:
> Hello Ferruh,
>
>   I was going through exiting cypress touch screen  driver
> (drivers/input/touchscreen/cyttsp4_core.c). Driver copy write suggest
> that it supports TMA4XX and TMA1036 cypress touch part. Is there any
> planning to extend the support for tma884 part ?
> In fact , support for tma884 part exit in android version of the code
> for v3.0.31 Linux kernel. I've gone ahead and tried to review the
> current version of the `cyttsp4*` sources in v4.3 relative to the
> version present in
> Android(https://android.googlesource.com/kernel/omap) and there are a
> lot of similarities between these two versions of the drivers. It
> looks to me that the version in v4.3 is a cleaned up fork of the older
> version contained in Android. I understand that these two versions of
> the driver may have both been targeted at different Cypress touch
> screen controller part numbers. But based on what I've been reading,
> both of these parts appear to be more closely related/in the same
> product family than not and so should use a common driver.
> So my question is:
> 1. Is there any planning to extend support for cypress tma884 part in
> existing cypress touch screen driver i.e in
> drivers/input/touchscreen/cyttsp4_core.c ? or
> 2. may be with minor changes, can I re-use the same driver for tma884
> part ? Please suggest.

Continuation to the last mail, doing more post-mortem analysis for the
code base,  drivers/input/touchscreen/cyttsp4_core.c ( v4.3 kernel:
support TMA4XX and TMA1036 cypress touch part) and android
code base, https://android.googlesource.com/kernel/omap ( Supports
CY8CTMA398 and CY8CTMA884 cypress touch part). I don't have the
specification for TMA4XX device families but by looking/comparing
code, my analysis suggest that I can use
drivers/input/touchscreen/cyttsp4_core.c (v4.3 kernel) also for
cypress touch part CY8CTMA884 as it is.
Could you please strengthen my understanding ?

TIA
Best Regards
Rajeev

>
> TIA
>
> Best Regards
> Rajeev
