From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/7] HID: validate report details
Date: Mon, 9 Sep 2013 14:48:29 -0700
Message-ID: <CAGXu5j+UvgNyMF8zS_zooqn8ksoETieT=5D=i_SPz5=7fzTAtA@mail.gmail.com>
References: <1378312645-27736-1-git-send-email-keescook@chromium.org>
	<CAN+gG=HrA7LcAS=kyVHjK_TPo83kd80aZJfv78CJ+01a+UFKDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:49253 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806Ab3IIVsa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Sep 2013 17:48:30 -0400
Received: by mail-ob0-f182.google.com with SMTP id wo10so6469496obc.13
        for <linux-input@vger.kernel.org>; Mon, 09 Sep 2013 14:48:29 -0700 (PDT)
In-Reply-To: <CAN+gG=HrA7LcAS=kyVHjK_TPo83kd80aZJfv78CJ+01a+UFKDA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>

On Mon, Sep 9, 2013 at 6:48 AM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> On Wed, Sep 4, 2013 at 6:37 PM, Kees Cook <keescook@chromium.org> wrote:
>> These patches introduce a validation function for HID devices that do
>> direct report value accesses, solving a number of heap smashing flaws.
>>
>> This version changes to using an field-index-based checker for the new
>> "hid_validate_values()" which requires callers to loop across fields if
>> they use more than one field.
>
> I am globally happy with the patch series.
> I have some concerns about patches 4 6 and 7, but the other can be
> applied right now.
>
> Kees, if you want to switch to something else, I can handle the v3 for
> these three patches: I have some logitech-dj devices and a tester for
> the lenovo one.

That would be fantastic, thank you. I don't have any tools to test
these in the "expected" case. :)

-Kees

-- 
Kees Cook
Chrome OS Security
