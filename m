From: Ellen Wang <ellen@cumulusnetworks.com>
Subject: Re: [PATCH] HID: cp2112: fix to force single data-report reply
Date: Wed, 01 Jul 2015 01:05:18 -0700
Message-ID: <55939F3E.7070505@cumulusnetworks.com>
References: <1434867625-3062-1-git-send-email-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33552 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbbGAIFW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jul 2015 04:05:22 -0400
Received: by pdjd13 with SMTP id d13so21594637pdj.0
        for <linux-input@vger.kernel.org>; Wed, 01 Jul 2015 01:05:21 -0700 (PDT)
In-Reply-To: <1434867625-3062-1-git-send-email-borneo.antonio@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Borneo <borneo.antonio@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org

Works as described.  Thank you!

By the way, I tested the code with and without your fix on my rev 2 
chip, and it behaved the same way as you describe on your rev 1 chip.

On 06/20/2015 11:20 PM, Antonio Borneo wrote:
> Current implementation of cp2112_raw_event() only accepts one data
> report at a time. If last received data report is not fully handled
> yet, a new incoming data report will overwrite it. In such case we
> don't guaranteed to propagate the correct incoming data.
>
> The trivial fix implemented here forces a single report at a time
> by requesting in cp2112_read() no more than 61 byte of data, which
> is the payload size of a single data report.
>
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> ---
>
> Hi Jiri,
>
> I think this should go through linux-stable.
>
> Thanks,
> Antonio
>
>   drivers/hid/hid-cp2112.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
> index 3318de6..a2dbbbe 100644
> --- a/drivers/hid/hid-cp2112.c
> +++ b/drivers/hid/hid-cp2112.c
> @@ -356,6 +356,8 @@ static int cp2112_read(struct cp2112_device *dev, u8 *data, size_t size)
>   	struct cp2112_force_read_report report;
>   	int ret;
>
> +	if (size > sizeof(dev->read_data))
> +		size = sizeof(dev->read_data);
>   	report.report = CP2112_DATA_READ_FORCE_SEND;
>   	report.length = cpu_to_be16(size);
>
>
