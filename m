From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v5 0/3] Input: Cypress TTSP device driver
Date: Thu, 13 Oct 2011 16:06:33 +0200
Message-ID: <CAAwP0s0iQtsmf6=2H17o_k6UagTdHeTffkaFWuB4UMPgb=WdxA@mail.gmail.com>
References: <1318099080-26227-1-git-send-email-martinez.javier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56901 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632Ab1JMOGy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 10:06:54 -0400
In-Reply-To: <1318099080-26227-1-git-send-email-martinez.javier@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Oct 8, 2011 at 8:37 PM, Javier Martinez Canillas
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
> This is a fifth version of the driver that fixes issues called out by
> Dmitry Torokhov, Henrik Rydberg and Mohan Pallaka and Kevin McNeely.
>
> The patchset is composed of the patches:
>
> [PATCH v5 1/3] Input: cyttsp - Cypress TTSP capacitive multi-touch sc=
reen support
> [PATCH v5 2/3] Input: cyttsp - add support for Cypress TTSP touchscre=
en I2C bus interface
> [PATCH v5 3/3] Input: cyttsp - add support for Cypress TTSP touchscre=
en SPI bus interface
>

Hi Henrik,

Any feedback from this patch-set?

Thank you and best regards,

--=20
Javier Mart=C3=ADnez Canillas
(+34) 682 39 81 69
Barcelona, Spain
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
