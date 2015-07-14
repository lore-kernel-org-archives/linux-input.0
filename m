From: Ellen Wang <ellen@cumulusnetworks.com>
Subject: Re: [PATCH v2] HID: cp2112: fix I2C_SMBUS_BYTE write
Date: Tue, 14 Jul 2015 15:54:39 -0700
Message-ID: <55A5932F.90505@cumulusnetworks.com>
References: <1436826234-2447-1-git-send-email-ellen@cumulusnetworks.com> <20150714114917.GG1517@katana> <alpine.LNX.2.00.1507141452140.7522@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33615 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbbGNWyl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2015 18:54:41 -0400
Received: by pdbqm3 with SMTP id qm3so13062272pdb.0
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2015 15:54:41 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1507141452140.7522@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: borneo.antonio@gmail.com, dbarksdale@uplogix.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On 07/14/2015 05:54 AM, Jiri Kosina wrote:
> On Mon, 13 Jul 2015, Ellen Wang wrote:
>
>> When doing an I2C_SMBUS_BYTE write (one byte write, no address),
>> the data to be written is in "command" not "data->byte".
>>
>> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>
>> ---
>> Forgot signed-off-by tag last time, sorry.
>
> Applied to for-4.3/cp2112.

Would it be possible to consider it for stable, as well as the other 
recent commits (6debce6f4e787a8eb4cec94e7afa85fb4f40db27 and 
5ddfb12e90c73cf86881345be422e09c367f6981)?

Thanks!
