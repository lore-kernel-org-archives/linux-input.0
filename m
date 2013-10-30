From: Tom Gundersen <teg@jklm.no>
Subject: Re: [PATCH] input: i8042 - add PNP modaliases
Date: Wed, 30 Oct 2013 15:30:07 +0100
Message-ID: <CAG-2HqWKCcFcaWFnLz96YZa=G5mYJg0dMk54jZ7FyNkK-m=PKA@mail.gmail.com>
References: <20130903193547.GA8150@srcf.ucam.org> <1378286856-6384-1-git-send-email-teg@jklm.no>
 <CAG-2HqUhZdYgYcDGJaFUJV-AqgbbFh55HMcw6nRppiUyeHGjcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:43709 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263Ab3J3Oa3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Oct 2013 10:30:29 -0400
Received: by mail-bk0-f43.google.com with SMTP id mz11so493054bkb.30
        for <linux-input@vger.kernel.org>; Wed, 30 Oct 2013 07:30:28 -0700 (PDT)
In-Reply-To: <CAG-2HqUhZdYgYcDGJaFUJV-AqgbbFh55HMcw6nRppiUyeHGjcw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Tom Gundersen <teg@jklm.no>, Matthew Garrett <mjg59@srcf.ucam.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri, Oct 4, 2013 at 2:26 PM, Tom Gundersen <teg@jklm.no> wrote:
> On Wed, Sep 4, 2013 at 11:27 AM, Tom Gundersen <teg@jklm.no> wrote:
>> This allows the module to be autoloaded in the common case.
>>
>> In order to work on non-PnP systems the module should be compiled in or loaded
>> unconditionally at boot (c.f. modules-load.d(5)), as before.
>>
>> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> Signed-off-by: Tom Gundersen <teg@jklm.no>
>> --
>
>
> Hi Dmitry,
>
> Any comments on this? Any chance of having this (and the two patches
> dropping EXPERT=y requirements) included for 3.13 (or even 3.12 if it
> is not too late for this kind of stuff)? Let me know if I should
> resend the three patches.

Ping? Any chance of seeing this in 3.13?

Cheers,

Tom
