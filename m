From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH] cyttsp: Fix swap of mfg_stat and mfg_cmd registers
Date: Wed, 5 Jun 2013 11:21:54 +0200
Message-ID: <CABxcv=m91Q51vYQ-EMCfjTrvinOij_=bTg_vjXrYf7=nYhUbdA@mail.gmail.com>
References: <20130604211930.GF3618@raspi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:50278 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab3FEJV4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Jun 2013 05:21:56 -0400
Received: by mail-wi0-f176.google.com with SMTP id ey16so41455wid.9
        for <linux-input@vger.kernel.org>; Wed, 05 Jun 2013 02:21:54 -0700 (PDT)
In-Reply-To: <20130604211930.GF3618@raspi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthias Kaehlcke <matthias.list@kaehlcke.net>, Javier Martinez Canillas <javier@dowhile0.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 4, 2013 at 11:19 PM, Matthias Kaehlcke
<matthias.list@kaehlcke.net> wrote:
> The command and status register in the driver were swapped with
> respect to the order specified in the datasheet (CY8CTMA140).
> Confirmed with Cypress that the order in the datasheet is correct.
>
> Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
> ---

Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
