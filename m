From: Fredrik Hallenberg <megahallon@gmail.com>
Subject: Re: [PATCH] HID: input: fix confusion on conflicting mappings
Date: Tue, 6 Jan 2015 13:37:26 +0100
Message-ID: <CAMsZVf_UT+m_8BWqz0+aYGJB+8Z_u6xRU7efLZ-Bd7WNhn4ZYA@mail.gmail.com>
References: <20141230165739.050cc0b9@kruskal.home.chead.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:43270 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbbAFMh1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 07:37:27 -0500
Received: by mail-qa0-f47.google.com with SMTP id n4so15941150qaq.20
        for <linux-input@vger.kernel.org>; Tue, 06 Jan 2015 04:37:26 -0800 (PST)
In-Reply-To: <20141230165739.050cc0b9@kruskal.home.chead.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Head <chead@chead.ca>, David Herrmann <dh.herrmann@gmail.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

I can confirm that the patch breaks things when not using n key
rollover. If using the Corsair K70 in "BIOS mode" or just using a
plain USB-keyboard keys repeat forever as reported.

David, I noticed that in the first version of your patch, where the
ignore check was done in hid-core.c, you only checked events that had
the HID_MAIN_ITEM_VARIABLE flag set. I can see that "plain" keyboards
don't have this bit set on the release event so if I keep this check
in the new patch it works in both cases.

So, the if-clause now looks like this:

...
    if (!(field->flags & (HID_MAIN_ITEM_RELATIVE |
                  HID_MAIN_ITEM_BUFFERED_BYTE)) &&
        (field->flags & HID_MAIN_ITEM_VARIABLE) &&
        usage->usage_index < field->maxusage &&
        value == field->value[usage->usage_index]) {
...

On Wed, Dec 31, 2014 at 1:57 AM, Christopher Head <chead@chead.ca> wrote:
> Hi,
> I tried your patch on my North American Das Keyboard 4. In N-key
> rollover mode the patch fixes the backslash problem. Unfortunately,
> with the patch applied, when in 6-key rollover mode (which, if I
> remember correctly, uses a one-byte DATA VAR ABS for modifiers and a
> six-byte DATA ARRAY ABS for other keys, as usual for keyboards), the
> last typed key repeats forever even after being released.
>
> (Apologies for the lack of In-Reply-To header; I am not subscribed to
> the list so had no message to reply to. Please CC me in replies if
> necessary.)
> --
> Christopher Head
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
