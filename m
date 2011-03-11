From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] Input: enable i8042-level wakeup control
Date: Fri, 11 Mar 2011 09:33:42 +0000
Message-ID: <AANLkTikpaM2aSUUiVuQExE-Nen=rhsTJUXTEv75bCa-m@mail.gmail.com>
References: <20110210171607.D0D419D401D@zog.reactivated.net>
	<20110311010117.18968941@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53458 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab1CKJdn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 04:33:43 -0500
Received: by bwz15 with SMTP id 15so2530102bwz.19
        for <linux-input@vger.kernel.org>; Fri, 11 Mar 2011 01:33:42 -0800 (PST)
In-Reply-To: <20110311010117.18968941@queued.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org, rjw@sisk.pl

On 11 March 2011 09:01, Andres Salomon <dilinger@queued.net> wrote:
> What exactly is the purpose of this? =A0 I see this allows various
> architectures to provide an override here, but it seems like this
> functionality wasn't previously present (they all just used
> i8042_pm_reset). =A0Do you have a later patch that makes use of this =
or
> something?

Yes, it was mentioned in the original submission:
http://dev.laptop.org/~dsd/20110114/0015-i8042-Enable-OLPC-s-EC-based-i=
8042-wakeup-control.patch

Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
