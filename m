From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: [PATCH] Input: gpio_keys - add ack_irq callback for HW that needs ACK
Date: Fri, 29 Nov 2013 15:57:55 +0100
Message-ID: <CACna6rwwsUmY1NbvVVDbpQ+SANDBtvBzOR=P4kZOG9q4EZXdEw@mail.gmail.com>
References: <1385650800-8908-1-git-send-email-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:55947 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755363Ab3K2O5z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Nov 2013 09:57:55 -0500
Received: by mail-oa0-f51.google.com with SMTP id i7so10548315oag.10
        for <linux-input@vger.kernel.org>; Fri, 29 Nov 2013 06:57:55 -0800 (PST)
In-Reply-To: <1385650800-8908-1-git-send-email-zajec5@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>

2013/11/28 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>:
> On bcm47xx arch we have GPIO keys with interrupts, but after every IR=
Q
> we have to change GPIO interrupt polarity. This is necessary to stop
> hardware from generating IRQs all the time and set it into state that
> will generate another IRQ on button release.
> This is not exactly an ACK, but I think it makes sense to use this mo=
re
> generic name.
> With this patch we can easily implement GPIO keys support for bcm47xx
> just using gpio_keys.

I think I missed quite important kernel feature: irq_domain... I'll
just try to use it.

Please ignore this patch.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
