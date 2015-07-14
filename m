From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: Re: [PATCH v3] HID: cp2112: support large i2c transfers in hid-cp2112
Date: Tue, 14 Jul 2015 17:58:50 +0800
Message-ID: <CAAj6DX3XHNvYjfPw_0pEbUG8pSKxQ4AOYRS6uAssxBXcNiWh+Q@mail.gmail.com>
References: <1436379459-8263-1-git-send-email-ellen@cumulusnetworks.com>
	<alpine.LNX.2.00.1507091416070.10183@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35706 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992AbbGNJ6v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2015 05:58:51 -0400
In-Reply-To: <alpine.LNX.2.00.1507091416070.10183@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Ellen Wang <ellen@cumulusnetworks.com>, David Barksdale <dbarksdale@uplogix.com>, linux-input <linux-input@vger.kernel.org>, linux-i2c@vger.kernel.org

On Thu, Jul 9, 2015 at 8:17 PM, Jiri Kosina <jkosina@suse.com> wrote:
> On Wed, 8 Jul 2015, Ellen Wang wrote:
>
>> cp2112_i2c_xfer() only reads up to 61 bytes, returning EIO
>> on longers reads.  The fix is to wrap a loop around
>> cp2112_read() to pick up all the returned data.
>>
>> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
>> ---
>> This is the updated patch with a check for 0 return from
>> cp2112_read().  I tested it with a suitable delay in the loop
>> to trigger the cp2112_raw_event() overrun bug, which must
>> be fixed before this patch is applied.
>
> Now applied to for-4.3/cp2112 (which is based on for-4.2/upstream-fixes,
> where the overrun in ->raw_event() callback is fixed). So please send any
> potential updates as followups on top of this patch.
>

It works as expected.

Either
Tested-by: Antonio Borneo <borneo.antonio@gmail.com>
and/or
Reviewed-by: Antonio Borneo <borneo.antonio@gmail.com>

Regards,
Antonio
