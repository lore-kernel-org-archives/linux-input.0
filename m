From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH v3 7/7] input: wacom - add 0xE5 (MT device) support
Date: Mon, 20 Feb 2012 13:30:37 -0600
Message-ID: <CAGzDe_bJ1-9qqrNeOt-6-7s++JLQ-x-xpLcrVWTJNWQ95W-P+g@mail.gmail.com>
References: <1328997334-24140-1-git-send-email-chris@cnpbagwell.com>
	<20120220082415.GA6525@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33408 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753016Ab2BTTai (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Feb 2012 14:30:38 -0500
Received: by lagu2 with SMTP id u2so6666501lag.19
        for <linux-input@vger.kernel.org>; Mon, 20 Feb 2012 11:30:37 -0800 (PST)
In-Reply-To: <20120220082415.GA6525@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Ping Cheng <pingc@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Mon, Feb 20, 2012 at 2:24 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> Hi Chris,
>
> The input_mt_report_slot_state should be used instead of directly
> setting the tracking id. If the id reported by the hardware is not
> bounded by some small number (so that it maps to slots), you will have
> to keep the translation table in the driver.
>
> Also, the commit message could need some love.
>
> Thanks,
> Henrik

Thank you for review, Henrik.

Makes sense.  hid-multitouch has an example find_slot_from_contactid()
that could be used as reference here if the ID's are not bound.

I'll have to table patches 6 and 7 until either Ping is available to
update them or can provide me some more details on tracking ID
behavior.

Anyone have comments on patches 1-5 that are for Wireless Bamboo support?

Thanks again,
Chris
