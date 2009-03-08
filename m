From: Richard Hughes <hughsient@gmail.com>
Subject: Re: suspend / hibernate nomenclature
Date: Sun, 8 Mar 2009 08:45:59 +0000
Message-ID: <15e53e180903080045x5874f05cv5ea836d73e3855b1@mail.gmail.com>
References: <1235992429.3858.58.camel@hughsie-work.lan>
	 <20090307154842.GA3947@srcf.ucam.org>
	 <20090307164151.GB24668@khazad-dum.debian.net>
	 <20090307164840.GA4800@srcf.ucam.org>
	 <15e53e180903071225h47bcdbaj83986b50f06135c3@mail.gmail.com>
	 <20090307203946.GA9942@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:15191 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZCHIqD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Mar 2009 04:46:03 -0400
In-Reply-To: <20090307203946.GA9942@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input <linux-input@vger.kernel.org>, Matthias Clasen <mclasen@redhat.com>

On Sat, Mar 7, 2009 at 8:39 PM, Matthew Garrett <mjg@redhat.com> wrote:
> We don't have to at all - as far as I've been able to tell, the kerne=
l
> is utterly consistent in its current usage. The only drivers that emi=
t
> KEY_SLEEP are either embedded-specific (where it's clearly suspend to
> RAM and not hibernate), the ACPI driver (where usage in other operati=
ng
> systems is consistent with it being suspent to RAM) and the panasonic
> and thinkpad drivers which use it consistently. If there's any
> confusion, it's over the fact that KEY_SUSPEND is is used for suspend=
 to
> RAM in a (smaller) number of places.

The fact that we're mapping x->y and y->x is the reason people keep
getting it wrong.

> I'd suggest reverting these current patches and doing something like =
the
> following and then changing any drivers where it's worth clarifying
> things. This has exactly the same effect with the advantage that no
> userspace needs to be changed.

So how do we specify a sleep button where policy is to be decided by
userspace? For instance, the sleep button on a remote control? Do we
hardcode policy in the kernel?

> -#define KEY_SLEEP =A0 =A0 =A0 =A0 =A0 =A0 =A0142 =A0 =A0 /* SC Syste=
m Sleep */
> +#define KEY_SUSPEND_TO_RAM =A0 =A0 142 =A0 =A0 /* SC System Sleep */

I deliberately avoided using the terms DISK and RAM in the key defines
used in my patch.

> +/* Deprecated - use KEY_SUSPEND_TO_RAM and KEY_HIBERNATE instead */
> +#define KEY_SLEEP =A0 =A0 =A0 =A0 =A0 =A0 =A0KEY_SUSPEND_TO_RAM
> +#define KEY_SUSPEND =A0 =A0 =A0 =A0 =A0 =A0KEY_HIBERNATE

Yet more confusion. Can't we sort this mess out once and for all? If
you're that bothered about userspace using the bodged mappings, I
would suggest changing my patch so that KEY_SLEEP is 247,
KEY_HIBERNATE is 205 and KEY_SUSPEND is 142.

Richard.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
