From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/4] Input: silead_gsl1680: gpiod_get returning -EBUSY is
 not an error
Date: Sat, 31 Dec 2016 19:57:33 +0100
Message-ID: <503b1901-a9d3-9171-a358-b61aa435b523@redhat.com>
References: <20161209103522.3833-1-hdegoede@redhat.com>
 <20161209103522.3833-2-hdegoede@redhat.com> <20161227221457.GC28140@dtor-ws>
 <77a85e17-b47f-8d01-1fe3-53ed07002768@redhat.com>
 <8aae51ca-34fa-3f75-423a-aacbfb60eef2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754690AbcLaS5h (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 31 Dec 2016 13:57:37 -0500
In-Reply-To: <8aae51ca-34fa-3f75-423a-aacbfb60eef2@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-input@vger.kernel.org

Hi,

On 31-12-16 18:06, Gregor Riepl wrote:
>> We could simply make the gpio completely optional by doing:
>>
>> Then we don't end up ugly-fying the silead.c code...
>
> I remember vaguely that this will make the driver useless in many cases.
>
> Some DSDTs I've seen have ACPI PM functions that handle the GPIO lines, and I tried calling them instead of managing the GPIO directly. This did not appear to work, but maybe I did it wrong.
>
> See here: https://github.com/onitake/gslx680-acpi/blob/master/gslx680_ts_acpi.c#L571

Hmm, I've just written (and deleted) a blurb about how the platform-bus takes
care of power states for us. But this is an i2c driver, so that is not
relevant. For i2c drivers we should indeed do this ourselves. I'll write
a patch based on the code blurb you pointed to and test that on the
2 different model cherrytrail (x86) tablets I've access to.

Regards,

Hans
