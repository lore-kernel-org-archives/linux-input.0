From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] doc: specify that ABS_MT_SLOT must have a minimum of 0
Date: Wed, 12 Jun 2013 10:51:56 +0200
Message-ID: <CAN+gG=FpioeuX_VJauhHAyB_rHdMbh_Zic7H-M8Pz-k6xV=O0w@mail.gmail.com>
References: <20130531062944.GA915@yabbi.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:64103 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab3FLIv6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jun 2013 04:51:58 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so5663039lbi.12
        for <linux-input@vger.kernel.org>; Wed, 12 Jun 2013 01:51:57 -0700 (PDT)
In-Reply-To: <20130531062944.GA915@yabbi.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri, May 31, 2013 at 8:29 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> This is effectively already in force through input_mt_init_slots, and uinput
> too ignores the actual minimum.
>
> Since slots are a kernel-genenerated axis only, non-zero minimums make
> little sense and are likely to cause errors. Better to treat a non-zero
> minimum as kernel bug if it ever happens.
>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>

Acked-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>

Adding Dmitry in CC.

Cheers,
Benjamin
