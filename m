From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 0/2 v2] Add drivers necessary to support PS/2 port on
 TQM85xx boards
Date: Tue, 31 Aug 2010 14:49:29 +0400
Message-ID: <AANLkTimFCcKH1x-coA4Ug291B2PYA6KjnJj_Fem5oGY9@mail.gmail.com>
References: <1281957997-12959-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36044 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756973Ab0HaKta convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 06:49:30 -0400
Received: by qyk33 with SMTP id 33so6456786qyk.19
        for <linux-input@vger.kernel.org>; Tue, 31 Aug 2010 03:49:29 -0700 (PDT)
In-Reply-To: <1281957997-12959-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hello,

On Mon, Aug 16, 2010 at 3:26 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> On tqm85xx boards (and several others) keyboard and mice are connecte=
d to CPU via
> special controller multiplexing KBD and MS traffic into single UART.

What about this two patches? Are they going to be included for 2.6.37?
Thank you for your answer.

> Changes since v1:
>
> * Rewrote serio to use iterative algorithms instead of recursion for =
serio
> =A0tree traversal
>
> * Changed ps2mult to register as SERIO_8042, not it's own special typ=
e
>
> * Small cleanup in ps2mult
>
> --
> With best wishes
> Dmitry
>
>



--=20
With best wishes
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
