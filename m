From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] elantech: fix for newer hardware versions (v7)
Date: Fri, 5 Jul 2013 21:30:29 -0700
Message-ID: <20130706043029.GA8212@core.coreip.homeip.net>
References: <51D74638.1020305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:33169 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab3GFEad (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Jul 2013 00:30:33 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so2507335pdi.27
        for <linux-input@vger.kernel.org>; Fri, 05 Jul 2013 21:30:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51D74638.1020305@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matteo Delfino <kendatsuba@gmail.com>
Cc: linux-input@vger.kernel.org, Alessandro Rubini <rubini@ipvvis.unipv.it>

Hi Matteo,

On Sat, Jul 06, 2013 at 12:18:32AM +0200, Matteo Delfino wrote:
> * Fix version recognition in elantech_set_properties
> 
>   The new hardware reports itself as v7 but the packets'
>   structure is unaltered.
> 
> * Fix packet type recognition in elantech_packet_check_v4
> 
>   The bitmask used for v6 is too wide, only the last three bits of
>   the third byte in a packet (packet[3] & 0x03) are actually used to
>   distinguish between packet types.
>   Starting from v7, additional information (to be interpreted) is
>   stored in the remaining bits (packets[3] & 0x1c).
>   In addition, the value stored in (packet[0] & 0x0c) is no longer
>   a constant but contains additional information yet to be deciphered.
>   This change should be backwards compatible with v6 hardware.
> 
> Additional-author: Giovanni Frigione <gio.frigione@gmail.com>
> Signed-off-by: Matteo Delfino <kendatsuba@gmail.com>

Thank you for the patch, unfortunately your mailer line-wrapped it and
it can't be applied. Could you please resend it using MUA that does not
perform line-wrapping?

Also, now that you only use (packet[3] & 0x03) to determine packet type,
could you turn series of 'if' statements in elantech_packet_check_v4()
into a 'switch'?

Thanks!

-- 
Dmitry
