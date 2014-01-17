From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH 2/4] HID: sony: Use standard output reports instead of raw
 reports to send data to the Dualshock 4.
Date: Fri, 17 Jan 2014 18:15:51 +0100
Message-ID: <CANq1E4SQWq5Fax3ZsXYzx-8bYatZwsqGJtvoHqaUwrKc+Q7JHw@mail.gmail.com>
References: <alpine.DEB.2.10.1401162134560.15779@franz-virtual-machine>
	<CANq1E4R3ryPDaivJE-TW=zBnOp9yD5+=-vpVP9zy9OACvud1yw@mail.gmail.com>
	<da65806f5e5ea0f18f50f882ca569419.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:43838 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbaAQRPw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 12:15:52 -0500
Received: by mail-ie0-f174.google.com with SMTP id lx4so5606394iec.5
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 09:15:51 -0800 (PST)
In-Reply-To: <da65806f5e5ea0f18f50f882ca569419.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: Frank Praznik <frank.praznik@oh.rr.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Fri, Jan 17, 2014 at 6:10 PM,  <simon@mungewell.org> wrote:
>
>>> Use regular HID output reports instead of raw reports in the
>>> dualshock4_state_worker function.  (Thanks Simon Mungewell)
>>
>> This description is actually wrong. hid_output_raw_report() is used
>> for regular HID output reports. What you do, is using SET_REPORT to
>> synchronously set output-reports. Anyhow, see below for comments.
>
> Hi David,
> Can you please confirm whether it is preferred to control the DS4 via
> 'hid_hw_request()' rather than 'hid_output_raw_report()'? They both appear
> to work OK...

It's fine. I just wanted to point out that your description is
inverted. According to the specs a device must support both, but that
is not always true. Most devices seem to require SET_REPORT like you
do, but the wiimote for instance requires async output reports (that
is, *not* via synchronous SET_REPORT).

> For the BT connected device we will have to use a different packet to a
> different report.

Given that most vendors just implement crappy HID, there's no way to
know which function is right. So as long as it works, it's usually The
Right Way.

But this patch is already merged, so no reason to worry.

Cheers
David
