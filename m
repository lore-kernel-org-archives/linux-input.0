From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Fri, 12 Jun 2009 18:31:53 +0530
Message-ID: <5d5443650906120601g2e0a563eq270095d5a001d0a1@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <f17812d70906022324x160dfcf2x5c89830341abff15@mail.gmail.com>
	 <f17812d70906070704s10f8eac6ybc353041e2db5a03@mail.gmail.com>
	 <200906112103.54043.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:25375 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759386AbZFLNZa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jun 2009 09:25:30 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1417191qwd.37
        for <linux-input@vger.kernel.org>; Fri, 12 Jun 2009 06:25:32 -0700 (PDT)
In-Reply-To: <200906112103.54043.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

Hi Dmitry,

>
> Input: add support for generic GPIO-based matrix keypad
>
> From: Eric Miao <eric.y.miao@gmail.com>
>
> Original patch by Marek Vasut, modified by Eric in:
>
> 1. use delayed work to simplify the debouncing
> 2. combine col_polarity/row_polarity into a single active_low field
> 3. use a generic bit array based XOR algorithm to detect key
> =A0 press/release, which should make the column assertion time
> =A0 shorter and code a bit cleaner
> 4. remove the ALT_FN handling, which is no way generic, the ALT_FN
> =A0 key should be treated as no different from other keys, and
> =A0 translation will be done by user space by commands like 'loadkeys=
'.
>
> [dtor@mail.ru: fix error unwinding path, support changing keymap
> =A0from userspace]
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Signed-off-by: Eric Miao <eric.miao@marvell.com>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---

Did you took latest patch submitted from Eric? Because it had more
signed-off and acked-by lines, like this.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
Reviewed-by: Trilok Soni <soni.trilok@gmail.com>
Reviewed-by: Uli Luckas <u.luckas@road.de>
Reviewed-by: Russell King <linux@arm.linux.org.uk>
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Eric Miao <eric.miao@marvell.com>

http://markmail.org/message/2wrr2b6mr6qsd4xs#query:+page:1+mid:fkkfxlum=
fm4mjhk4+state:results

Eric can confirm otherwise.

>
> =A0config KEYBOARD_HIL_OLD
> =A0 =A0 =A0 =A0tristate "HP HIL keyboard support (simple driver)"
> @@ -254,7 +263,7 @@ config KEYBOARD_PXA27x
> =A0 =A0 =A0 =A0tristate "PXA27x/PXA3xx keypad support"
> =A0 =A0 =A0 =A0depends on PXA27x || PXA3xx
> =A0 =A0 =A0 =A0help
> - =A0 =A0 =A0 =A0 Enable support for PXA27x/PXA3xx keypad controller
> + =A0 =A0 =A0 =A0 Enable support for PXA27x/PXA3xx keypad controller.

Why this change in this patch?

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D (row << 4) + c=
ol;

<< 4 logic will break once MAX_ROWS increased, right?


--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
