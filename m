From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v2 3/4] input: Deprecate real timestamps beyond year 2106
Date: Sat, 29 Oct 2016 21:34:13 -0700
Message-ID: <CABeXuvpZb73gs9Xr-ox4HSXfOuCg1UeYBoMcQok+dWTJNUo55w@mail.gmail.com>
References: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com>
 <CABeXuvoo1N_1wuiWTns9eLvfVbgCa4YfLj6dRBHwFem6ZXSzfw@mail.gmail.com>
 <20161027231254.GA12312@dtor-ws> <3030448.PcHXLsYrel@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:36095 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbcJ3EeO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 30 Oct 2016 00:34:14 -0400
In-Reply-To: <3030448.PcHXLsYrel@wuerfel>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.com>, Hans de Goede <hdegoede@redhat.com>

> I think we should do those two things completely independently.
> We need to do something now to preserve the current interfaces
> for the glibc changes that are coming soon [1], and Deepa's
> patches do that (though I now realize the changelog doesn't
> mention the requirement).

I'll update the changelog in the next version of the series along with
the task check for x32 mode.

> An overhaul of the input_event handling with a new modern
> but incompatible format may or may not be a good idea, but
> this should be decided independently.

Just to clarify, we are going with the plan that Arnd suggested:
leaving the overhaul of the input event protocol alone and proceeding
with the series according to suggested changes.
Are we in agreement over this?

-Deepa
