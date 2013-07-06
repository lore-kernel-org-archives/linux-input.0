From: Matteo Delfino <kendatsuba@gmail.com>
Subject: Re: [PATCH] elantech: fix for newer hardware versions (v7)
Date: Sat, 06 Jul 2013 09:20:34 +0200
Message-ID: <51D7C542.6040705@gmail.com>
References: <51D74638.1020305@gmail.com> <20130706043029.GA8212@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:34605 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905Ab3GFHUi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Jul 2013 03:20:38 -0400
Received: by mail-ea0-f182.google.com with SMTP id d10so1859746eaj.27
        for <linux-input@vger.kernel.org>; Sat, 06 Jul 2013 00:20:37 -0700 (PDT)
In-Reply-To: <20130706043029.GA8212@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alessandro Rubini <rubini@ipvvis.unipv.it>

Hi Dmitry,

On 07/06/2013 06:30 AM, Dmitry Torokhov wrote:
> Thank you for the patch, unfortunately your mailer line-wrapped it and
> it can't be applied. Could you please resend it using MUA that does not
> perform line-wrapping?
>

Of course, sorry about that.

> Also, now that you only use (packet[3] & 0x03) to determine packet type,
> could you turn series of 'if' statements in elantech_packet_check_v4()
> into a 'switch'?

Sure, i will.

Best regards,
Matteo

