From: Antonio Borneo <borneo.antonio@gmail.com>
Subject: Re: [PATCH v2] HID: cp2112: support i2c write-read transfers in hid-cp2112
Date: Tue, 14 Jul 2015 18:09:57 +0800
Message-ID: <CAAj6DX39n2kg67uG0uwVeKRGK20M33NtF+dH-_Fi2BBOkFq4pQ@mail.gmail.com>
References: <1436504106-31740-1-git-send-email-ellen@cumulusnetworks.com>
	<alpine.LNX.2.00.1507101120570.14897@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35689 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbbGNKJ5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2015 06:09:57 -0400
In-Reply-To: <alpine.LNX.2.00.1507101120570.14897@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Ellen Wang <ellen@cumulusnetworks.com>, David Barksdale <dbarksdale@uplogix.com>, linux-input <linux-input@vger.kernel.org>, linux-i2c@vger.kernel.org

On Fri, Jul 10, 2015 at 5:21 PM, Jiri Kosina <jkosina@suse.com> wrote:
> On Thu, 9 Jul 2015, Ellen Wang wrote:
>
>> cp2112_i2c_xfer() only supports a single i2c_msg.  More than
>> one message at a time just returns EIO.  This breaks certain
>> important cases.  For example, the at24 eeprom driver generates
>> paired write and read messages (for eeprom address and data).
>>
>> Since the device doesn't support i2c repeated starts in general,
>> but does support a single write-repeated-start-read pair
>> (since hardware rev 1), we recognize the latter case and
>> implement only that.
>>
>> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
>
> Applied to for-4.3/cp2112.
>

Good!

Either
Tested-by: Antonio Borneo <borneo.antonio@gmail.com>
and/or
Reviewed-by: Antonio Borneo <borneo.antonio@gmail.com>

By the way, while this patch extends the i2c functionality, it makes
clear that repeated start is always broken on HW rev 1, also for
SMBUS!
I'm testing a patch to restrict SMBUS on rev 1 to only those
transactions that don't require repeated start.
Will post it shortly.

Regards,
Antonio
