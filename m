From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] HID: microsoft, do not use compound literal
Date: Mon, 12 Nov 2012 13:35:21 +0100
Message-ID: <50A0ED09.6010106@suse.cz>
References: <1352711769-28911-1-git-send-email-jslaby@suse.cz> <CAMuHMdUEW9K6cfpcUNphte_VzBCL_Oa_od3892DQ3QbX5xMMnA@mail.gmail.com> <alpine.LNX.2.00.1211121314270.27271@pobox.suse.cz> <CAMuHMdWq9S9oO+2OH6oiAogFR+JJxnxrtGoMp+uMm-qXCLr55A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47425 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab2KLMfZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Nov 2012 07:35:25 -0500
In-Reply-To: <CAMuHMdWq9S9oO+2OH6oiAogFR+JJxnxrtGoMp+uMm-qXCLr55A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com

On 11/12/2012 01:30 PM, Geert Uytterhoeven wrote:
> My comment was purely cosmetic, as it applies to the quoted compiler error
> messages only.

Ah, I see. When you are applying the patch Jiri, could you remove errors
about line 50 from the commit log? What I wanted to have there
apparently was only "hid-microsoft.c:51:18: error: macro "memcmp" passed
6 arguments, but takes just 3".

> Your latest version doesn't use memcmp() anymore, so I think there's no need to
> include <linux/string.h> anymore.

s/Your/His/ perhaps :). Otherwise I'd be confused -- did Jiri send some
other version?

thanks,
-- 
js
suse labs
