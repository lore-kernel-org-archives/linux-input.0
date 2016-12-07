From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: lpc32xx-keys - fix invalid error handling of a requested irq
Date: Wed, 07 Dec 2016 10:46:41 -0800
Message-ID: <7AAD38C5-E1CF-40EF-8E5B-8BCB9B5897C4@gmail.com>
References: <20161205014753.2092-1-vz@mleia.com> <1481134387.9248.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36109 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932276AbcLGSrJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2016 13:47:09 -0500
Received: by mail-pg0-f67.google.com with SMTP id x23so24238725pgx.3
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2016 10:46:46 -0800 (PST)
In-Reply-To: <1481134387.9248.8.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sylvain Lemieux <slemieux.tyco@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On December 7, 2016 10:13:07 AM PST, Sylvain Lemieux <slemieux.tyco@gmail.com> wrote:
>On Mon, 2016-12-05 at 03:47 +0200, Vladimir Zapolskiy wrote:
>> Semantics of NR_IRQS is different on machines with SPARSE_IRQ option
>> disabled or enabled, in the latter case IRQs are allocated starting
>> at least from the value specified by NR_IRQS and going upwards, so
>> the check of (irq >= NR_IRQ) to decide about an error code returned
>by
>> platform_get_irq() is completely invalid, don't attempt to overrule
>> irq subsystem in the driver.
>> 
>> The change fixes lpc32xx_keys driver initialization on boot:
>> 
>>   lpc32xx_keys 40050000.key: failed to get platform irq
>>   lpc32xx_keys: probe of 40050000.key failed with error -22
>> 
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>>  drivers/input/keyboard/lpc32xx-keys.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>Cosmetic - please update the subject line when doing the commit:
>replace " -" by ":" after lpc32xx-keys

Why? The format on all input patches is "Input: <driver> - <subject>" and had been this for 10+ years.


Thanks.

-- 
Dmitry
