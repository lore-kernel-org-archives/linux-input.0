From: Fredrik Hallenberg <megahallon@gmail.com>
Subject: Backslash repeat bug
Date: Fri, 8 Aug 2014 16:11:56 +0200
Message-ID: <CAMsZVf-Y5202EyYod+ZDfjEd_OS7N2oOFYEMniCc5Z12B14uqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:54989 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662AbaHHOL5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Aug 2014 10:11:57 -0400
Received: by mail-qa0-f43.google.com with SMTP id w8so5615799qac.30
        for <linux-input@vger.kernel.org>; Fri, 08 Aug 2014 07:11:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, nveber@tamariongroup.com

Hi,

On my Corsair K70 keyboard, when pressing some key and then the
backslash key (KEY_BACKSLASH) in rapid succession the backslash
character will be repeated three times. This bug has been mentioned on
this list before (by Norbert Veber on the 24th of februrary) but there
was no responses, also Norbert consider it a problem with Corsair
keyboards but as I describe below I feel it is more of a general
problem in the HID input code.

This bug is discussed on the Corsair forums, but it seems the exact
same thing also happens with Gigabyte Osmium and QPAD MK85, possibly
it is a problem on all keyboards supporting n-key rollover.

I believe the root cause of this is that the keyboard reports all keys
including both HID keys 0x31 and 0x32 which are both mapped to
KEY_BACKSLASH in hid-input.c. I am using a nordic keyboard meaning
KEY_BACKSLASH is labeled "apostrophe" and that HID key 0x32 is
reported. A US keyboard has a backslash key which should report 0x31.

I have added some traces before the input_event call at the end of
hidinput_report_event. When pressing A key and then apostrophe,
something like this is seen (omitting all inactive keys):

VALUE 1 CODE 30 HID 0x4
VALUE 0 CODE 43 HID 0x31
VALUE 0 CODE 43 HID 0x32
Output: a

VALUE 1 CODE 30 HID 0x4
VALUE 0 CODE 43 HID 0x31
VALUE 1 CODE 43 HID 0x32
Output: '

VALUE 0 CODE 30 HID 0x4
VALUE 0 CODE 43 HID 0x31
VALUE 1 CODE 43 HID 0x32
Output: '

VALUE 0 CODE 30 HID 0x4
VALUE 0 CODE 43 HID 0x31
VALUE 1 CODE 43 HID 0x32
Output: '

VALUE 0 CODE 30 HID 0x4
VALUE 0 CODE 43 HID 0x31
VALUE 0 CODE 43 HID 0x32

So the fact that 0x31 is inactive will cause bad release events on key
43 to be sent.

I have made a simple patch that tracks which of the two variants is
active and ignores the other one. It works but I don't have much
knowledge on HID input so before posting it would like to know if
someone has input on how to do a cleaner fix. I am happy to help with
testing or implementation if I am able.

Regards,

Fredrik
