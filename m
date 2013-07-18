From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [RFC 6/8] HID: uhid: use generic hidinput_input_event()
Date: Thu, 18 Jul 2013 22:49:20 +0200
Message-ID: <CANq1E4T6KnzXpoq2PEA4KLroViDpdJVidNFCWN1mg1vYwjm4dw@mail.gmail.com>
References: <1373908217-16748-1-git-send-email-dh.herrmann@gmail.com>
	<1373908217-16748-7-git-send-email-dh.herrmann@gmail.com>
	<20130718195324.GA570@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:56694 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929Ab3GRUtV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Jul 2013 16:49:21 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so7751582ief.26
        for <linux-input@vger.kernel.org>; Thu, 18 Jul 2013 13:49:20 -0700 (PDT)
In-Reply-To: <20130718195324.GA570@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Oliver Neukum <oliver@neukum.org>

Hi

On Thu, Jul 18, 2013 at 9:53 PM,  <rydberg@euromail.se> wrote:
> Hi David,
>
>> HID core provides the same functionality and can convert the input event
>> to a raw output report. We can thus drop UHID_OUTPUT_EV and rely on the
>> mandatory UHID_OUTPUT.
>>
>> User-space wasn't able to do anything with UHID_OUTPUT_EV, anyway. They
>> don't have access to the report fields.
>
> I like your patchset overall, but this looks like userspace breakage?

Not really. UHID_OUTPUT_EV provides input_event data to user-space,
which user-space converts into raw output events. With this patch, we
do the conversion in the kernel itself and just send the raw output
event (which user-space supported even before this).

This breaks user-space only if the conversion was done differently in
user-space. But this sounds highly unlikely to me. All uhid
applications I am aware of ignored UHID_OUTPUT_EV so far as they don't
have any report-information. So we actually *fix* all available users
with that.

If there is an uhid user I am not aware of, we can easily revert that.
I doubt that, though.

Cheers
David
