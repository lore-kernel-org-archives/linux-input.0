From: Gregor Riepl <onitake@gmail.com>
Subject: Re: [PATCH 2/4] Input: silead_gsl1680: gpiod_get returning -EBUSY is
 not an error
Date: Sat, 31 Dec 2016 18:06:59 +0100
Message-ID: <8aae51ca-34fa-3f75-423a-aacbfb60eef2@gmail.com>
References: <20161209103522.3833-1-hdegoede@redhat.com>
 <20161209103522.3833-2-hdegoede@redhat.com> <20161227221457.GC28140@dtor-ws>
 <77a85e17-b47f-8d01-1fe3-53ed07002768@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36270 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754633AbcLaRHD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 31 Dec 2016 12:07:03 -0500
Received: by mail-wj0-f196.google.com with SMTP id j10so64203923wjb.3
        for <linux-input@vger.kernel.org>; Sat, 31 Dec 2016 09:07:02 -0800 (PST)
In-Reply-To: <77a85e17-b47f-8d01-1fe3-53ed07002768@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-input@vger.kernel.org

> We could simply make the gpio completely optional by doing:
>
> Then we don't end up ugly-fying the silead.c code...

I remember vaguely that this will make the driver useless in many cases.

Some DSDTs I've seen have ACPI PM functions that handle the GPIO lines, and I 
tried calling them instead of managing the GPIO directly. This did not appear 
to work, but maybe I did it wrong.

See here: 
https://github.com/onitake/gslx680-acpi/blob/master/gslx680_ts_acpi.c#L571
And this is what's supposed to be called: 
https://github.com/onitake/gslx680-acpi/blob/master/acpi/gsl-dsdt.aml#L12
