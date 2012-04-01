From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Sun, 01 Apr 2012 22:44:54 +0300
Message-ID: <4F78B036.8070207@gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com>	<alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz>	<CALu8Fe9=itXEMO38vMQ9GsER0s-J=XxQ4+RAxZvMX7gEGuTHrA@mail.gmail.com> <CANq1E4QrSdoEHtJeNH3k4FU7S0WQKRadJB9qMTG+q+khVgqBsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64986 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab2DATo6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Apr 2012 15:44:58 -0400
Received: by bkcik5 with SMTP id ik5so1890226bkc.19
        for <linux-input@vger.kernel.org>; Sun, 01 Apr 2012 12:44:57 -0700 (PDT)
In-Reply-To: <CANq1E4QrSdoEHtJeNH3k4FU7S0WQKRadJB9qMTG+q+khVgqBsg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

Hi David,

On 03/31/2012 02:03 AM, David Herrmann wrote:
> Rebinding works perfectly well for me. I use it all the time when
> testing HID drivers.

Thank you.

I've tried it, but it doesn't work for me, because HID report descriptors
are not re-parsed after rebinding and I rely on report_fixup's a lot. Please
see my reply to Jiri for slightly more details:
http://thread.gmane.org/gmane.linux.kernel.input/23708/focus=24337

> Furthermore, there is a dynid-implementation in the kernel so when hacking
> on something like this I'd recommend using this. It would also remove the
> hard limit that you currently have.

Thanks, but this doesn't suit me currently. I don't implement report parsing
in my drivers, but rather describe every device protocol separately with a
report descriptor and rely on the generic driver for parsing. Thus, I save
in code complexity and maintenance, but loose in portability.

However, I plan to make a non-HID driver for Waltop tablets, using their
proprietary, HID-incompatible protocol and there I will probably use that.

Sincerely,
Nick
