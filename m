From: rajeev kumar <rajeevkumar.linux@gmail.com>
Subject: Add support(re-using) for Cypress CY8CTMA884 part in exiting cypress
 touch controller driver(drivers/input/touchscreen/cyttsp4_core.c)
Date: Mon, 4 Jan 2016 12:46:30 +0530
Message-ID: <CAA7nrthgTKF0z=T98hA2wsEuvzMbpyNe3Ck0TDpbWuqYSEs+jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36167 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbcADHQc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jan 2016 02:16:32 -0500
Received: by mail-lb0-f173.google.com with SMTP id oh2so154104012lbb.3
        for <linux-input@vger.kernel.org>; Sun, 03 Jan 2016 23:16:31 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: fery@cypress.com
Cc: linux-input@vger.kernel.org

Hello Ferruh,

  I was going through exiting cypress touch screen  driver
(drivers/input/touchscreen/cyttsp4_core.c). Driver copy write suggest
that it supports TMA4XX and TMA1036 cypress touch part. Is there any
planning to extend the support for tma884 part ?
In fact , support for tma884 part exit in android version of the code
for v3.0.31 Linux kernel. I've gone ahead and tried to review the
current version of the `cyttsp4*` sources in v4.3 relative to the
version present in
Android(https://android.googlesource.com/kernel/omap) and there are a
lot of similarities between these two versions of the drivers. It
looks to me that the version in v4.3 is a cleaned up fork of the older
version contained in Android. I understand that these two versions of
the driver may have both been targeted at different Cypress touch
screen controller part numbers. But based on what I've been reading,
both of these parts appear to be more closely related/in the same
product family than not and so should use a common driver.
So my question is:
1. Is there any planning to extend support for cypress tma884 part in
existing cypress touch screen driver i.e in
drivers/input/touchscreen/cyttsp4_core.c ? or
2. may be with minor changes, can I re-use the same driver for tma884
part ? Please suggest.

TIA

Best Regards
Rajeev
