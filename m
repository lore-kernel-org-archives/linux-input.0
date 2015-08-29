From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] input: ff-memless: Change FF_ENVELOPE_INTERVAL to a
 module parameter.
Date: Fri, 28 Aug 2015 17:29:25 -0700
Message-ID: <20150829002925.GA8298@dtor-ws>
References: <1440762993-31329-1-git-send-email-kalle.jokiniemi@jolla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32896 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbbH2A32 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Aug 2015 20:29:28 -0400
Received: by pacgr6 with SMTP id gr6so4543074pac.0
        for <linux-input@vger.kernel.org>; Fri, 28 Aug 2015 17:29:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1440762993-31329-1-git-send-email-kalle.jokiniemi@jolla.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@jolla.com>
Cc: linux-input@vger.kernel.org

Hi Kalle,

On Fri, Aug 28, 2015 at 02:56:33PM +0300, Kalle Jokiniemi wrote:
> Sometimes you need to have tighter control over the ff-memless
> effects. E.g. when creating short button / VKB press effects,
> the effect duration is typically <= 40ms, and you want to have
> a short acceleration period in beginning and fade out the end
> to avoid "electric tooth brush" effect. With 50ms envelope
> interval this control is not possible.
> 
> To allow this control without patching over ff-memless, change the
> FF_ENVELOPE_INTERVAL macro to a module parameter that can be modified
> via kernel command line or during runtime from
> /sys/module/ff_memless/parameters/ff_envelope_interval sysfs file.

How would users know that they need to change this parameter? Could we
maybe adjust sampling time dynamically, based on the attack length of
the envelope?

Thanks.

-- 
Dmitry
