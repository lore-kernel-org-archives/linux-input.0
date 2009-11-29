From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: usbtouchscreen - add support for ET&T TC5UH
	touchscreen controller
Date: Sat, 28 Nov 2009 21:30:21 -0800
Message-ID: <20091129053020.GT6936@core.coreip.homeip.net>
References: <1259405677-9416-1-git-send-email-ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:52745 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbZK2FaU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 00:30:20 -0500
Received: by yxe26 with SMTP id 26so2243570yxe.4
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2009 21:30:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1259405677-9416-1-git-send-email-ynezz@true.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@novell.com>

Hi Petr,

On Sat, Nov 28, 2009 at 11:54:37AM +0100, Petr =C5=A0tetiar wrote:
> This patch adds support for the ET&T TC5UH 5-wire USB touchscreen con=
troller.
> More info at http://www.etandt.com.tw/board_solution.html

Hmm, this looks like Panjit protocol, just report size is different, 5
vs. 8...

The link abouve mentions HID compliance? Does it not wok properly with
HID driver? Do we need to blacklist it in HID?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
