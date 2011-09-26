From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH V3 0/3] Input: Cypress TTSP device driver
Date: Mon, 26 Sep 2011 23:06:25 +0200
Message-ID: <CAAwP0s2SKzkc-bMzv+MJRBYXmwDyA+ubkmP4fMvi9FpmgitF8w@mail.gmail.com>
References: <1316311297-12765-1-git-send-email-martinez.javier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47023 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab1IZVGm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Sep 2011 17:06:42 -0400
In-Reply-To: <1316311297-12765-1-git-send-email-martinez.javier@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Sep 18, 2011 at 4:01 AM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
> Cypress TrueTouch(tm) Standard Product controllers are found in
> a wide range of embedded devices. This patch-set adds support for a
> variety of TTSP controllers.
>
> The original author of the driver is Kevin McNeely <kev@cypress.com>
>
> Since the hardware is capable of tracking identifiable contacts and t=
he
> original driver used multi-touch protocol type A (stateless), I've ad=
ded
> multi-touch protocol type B (stateful) support.
>
> The driver is composed of a core driver that process the data sent by
> the contacts (fingers) and two bus specific interface modules (I2C an=
d SPI).
>
> This is a third version of the driver that fixes issues called out by
> Dmitry Torokhov, Henrik Rydberg and Mohan Pallaka
>
> The patchset is composed of the patches:
>
> [PATCH V3 1/3] Input: cyttsp - Cypress TTSP capacitive multi-touch sc=
reen support
> [PATCH V3 2/3] Input: cyttsp - add support for Cypress TTSP touchscre=
en I2C bus interface
> [PATCH V3 3/3] Input: cyttsp - add support for Cypress TTSP touchscre=
en SPI bus interface
>

Hello,

Any feedback for this patch-set?

Best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
