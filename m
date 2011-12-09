From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] Input: keyboard: Staticise non-exported symbols
Date: Fri, 9 Dec 2011 13:01:19 +0100
Message-ID: <CACRpkdab4kB8DC_ZxF5za2zW5kFHToSWJC6V6_s72UThTkCekw@mail.gmail.com>
References: <1323394677.3740.2.camel@phoenix>
	<1323394752.3740.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57091 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab1LIMBT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Dec 2011 07:01:19 -0500
In-Reply-To: <1323394752.3740.3.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Michael Hennerich <hennerich@blackfin.uclinux.org>, Naveen Kumar G <naveen.gaddipati@stericsson.com>, Sundar Iyer <sundar.iyer@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, Dec 9, 2011 at 2:39 AM, Axel Lin <axel.lin@gmail.com> wrote:

> These symbols are not used outside it's driver so no need to
> make the symbol global.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
For SKE.

Linus Walleij
