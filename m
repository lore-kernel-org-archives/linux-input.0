From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 0/7] HID: validate report details
Date: Mon, 9 Sep 2013 15:48:38 +0200
Message-ID: <CAN+gG=HrA7LcAS=kyVHjK_TPo83kd80aZJfv78CJ+01a+UFKDA@mail.gmail.com>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:45849 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279Ab3IINsk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 09:48:40 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so4897401lab.18
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 06:48:39 -0700 (PDT)
In-Reply-To: <1378312645-27736-1-git-send-email-keescook@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>

On Wed, Sep 4, 2013 at 6:37 PM, Kees Cook <keescook@chromium.org> wrote:
> These patches introduce a validation function for HID devices that do
> direct report value accesses, solving a number of heap smashing flaws.
>
> This version changes to using an field-index-based checker for the new
> "hid_validate_values()" which requires callers to loop across fields if
> they use more than one field.

I am globally happy with the patch series.
I have some concerns about patches 4 6 and 7, but the other can be
applied right now.

Kees, if you want to switch to something else, I can handle the v3 for
these three patches: I have some logitech-dj devices and a tester for
the lenovo one.

Cheers,
Benjamin

>
> -Kees
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
