From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH v7 0/3] Input: Cypress TTSP device driver
Date: Thu, 27 Oct 2011 18:03:26 +0200
Message-ID: <CAAwP0s2gPpC6kar0=-Kg4WPcc34G3rOdjWqamr+R3PQ1PSJ51A@mail.gmail.com>
References: <1319396024-28558-1-git-send-email-martinez.javier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42723 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab1J0QDq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Oct 2011 12:03:46 -0400
In-Reply-To: <1319396024-28558-1-git-send-email-martinez.javier@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Oct 23, 2011 at 8:53 PM, Javier Martinez Canillas
<martinez.javier@gmail.com> wrote:
> Cypress TrueTouch(tm) Standard Product controllers are found in a wid=
e range of
> embedded devices. This patch-set adds support for a variety of TTSP c=
ontrollers.
>
> The original author of the driver is Kevin McNeely <kev@cypress.com>
>
> Since the hardware is capable of tracking identifiable contacts and t=
he original
> driver used multi-touch protocol type A (stateless), I've added multi=
-touch
> protocol type B (stateful) support.
>
> The driver is composed of a core driver that process the data sent by=
 the
> contacts (fingers) and two bus specific interface modules (I2C and SP=
I).
>
> This is version 7 of the driver that fixes issues called out by Dmitr=
y Torokhov,
> Henrik Rydberg, Mohan Pallaka, Kevin McNeely and Shubhrajyoti Datta.
>
> The patchset is composed of the following patches:
>
> [PATCH v7 1/3] Input: cyttsp - Cypress TTSP capacitive multi-touch sc=
reen support
> [PATCH v7 2/3] Input: cyttsp - add support for Cypress TTSP touchscre=
en I2C bus interface
> [PATCH v7 3/3] Input: cyttsp - add support for Cypress TTSP touchscre=
en SPI bus interface
>

Hello,

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
