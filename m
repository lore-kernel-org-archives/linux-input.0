From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] Input: enable i8042-level wakeup control
Date: Fri, 11 Mar 2011 08:42:03 +0000
Message-ID: <AANLkTimFUeB_pUjTVRQ9zcdgrP6i_CZCXkBHLaZ2fkzx@mail.gmail.com>
References: <20110210171607.D0D419D401D@zog.reactivated.net>
	<20110310203602.114944c0@debxo>
	<20110311083129.GG10807@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56702 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab1CKImE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Mar 2011 03:42:04 -0500
Received: by bwz15 with SMTP id 15so2506047bwz.19
        for <linux-input@vger.kernel.org>; Fri, 11 Mar 2011 00:42:03 -0800 (PST)
In-Reply-To: <20110311083129.GG10807@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andres Salomon <dilinger@queued.net>, linux-input@vger.kernel.org, rjw@sisk.pl

On 11 March 2011 08:31, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> I must say I am very wary about this patch. I know that there are a few
> boxes that will get very confused if we do not reset their
> mice/touchpads to the bare PS/2 protocol and I also do not believe that
> we can rely on devices keeping their protocol settings after s2r and
> especially s2d even if they are marked as wakeup sources.
>
> I understand that that may be the case with OLPC but not with other
> boxes...

I agree. Thats why the whole thing is hidden behind
i8042_enable_wakeup - so that it only happens on OLPC and not other
platforms. I don't see i8042-based wakeup being possible in any other
scenario.

If you prefer I could drop the module_param access to that variable so
that it can't even be enabled except when appropriate platforms are
detected.

Daniel
