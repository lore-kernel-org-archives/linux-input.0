From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: bad handling of HID input reports for a Delcom foot pedal
Date: Mon, 19 May 2014 15:37:08 -0400
Message-ID: <CAN+gG=GbD-NjJUcSjYfp3rqnG9hHwmxT0ReEYFFDf88v_aS5qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:53930 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbaESThK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 May 2014 15:37:10 -0400
Received: by mail-la0-f42.google.com with SMTP id el20so4497871lab.29
        for <linux-input@vger.kernel.org>; Mon, 19 May 2014 12:37:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, bmills@alumni.cmu.edu

Hi Jiri,

Please have a look at: https://bugzilla.kernel.org/show_bug.cgi?id=76461

To me, this device sends garbage and should not send the modifiers
both in a Var input and in an Array input.

I can fix it either by amending the report descriptor of the device
(one byte to change) or by changing hid-input.c for it to send the
events in the array processing no matter what was the previous state
(see below).

I don't know which one to pick because this seems to be a corner case,
so fixing hid-input might not be the place, but I am afraid of
removing part of the reports coming from the device (what if the
modifiers are actually used for something in the report).

Any thoughts on it?

For the record, fixing hid-input would just remove the test in hid_input_field:

                if (value[n] >= min && value[n] <= max
-                       && field->usage[value[n] - min].hid
-                       && search(field->value, value[n], count))
+                       && field->usage[value[n] - min].hid)
                                hid_process_event(hid, field,
&field->usage[value[n] - min], 1, interrupt);
        }

(Sorry, gmail, whitespace damaged and everything)

Cheers,
Benjamin
