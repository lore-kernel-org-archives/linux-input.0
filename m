From: Ellen Wang <ellen@cumulusnetworks.com>
Subject: Re: [PATCH v2] HID: cp2112: fix I2C_SMBUS_BYTE write
Date: Tue, 14 Jul 2015 15:51:19 -0700
Message-ID: <55A59267.2020803@cumulusnetworks.com>
References: <1436826234-2447-1-git-send-email-ellen@cumulusnetworks.com> <20150714114917.GG1517@katana> <alpine.LNX.2.00.1507141452140.7522@pobox.suse.cz> <CAAj6DX2_ZwFqpKD5JjbWuJw7SJv3G+DhpnD6tZAoDcF32GQ=0Q@mail.gmail.com> <20150714154939.GA20875@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34519 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbbGNWvZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2015 18:51:25 -0400
Received: by pdbep18 with SMTP id ep18so13455139pdb.1
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2015 15:51:25 -0700 (PDT)
In-Reply-To: <20150714154939.GA20875@katana>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Antonio Borneo <borneo.antonio@gmail.com>
Cc: Jiri Kosina <jkosina@suse.com>, David Barksdale <dbarksdale@uplogix.com>, linux-input <linux-input@vger.kernel.org>, linux-i2c@vger.kernel.org

On 07/14/2015 08:49 AM, Wolfram Sang wrote:
>
>> This is a MFD; should be split in GPIO and I2C, then each part moved
>> in its respective tree.
>
> Yes, this is the conclusion we drew last time, too. It might seem
> overkill for such simple devices, still this case shows how much drivers
> can suffer if missing the expertise of the apropriate subsystem. That
> being said, world is full of cornercases, I agree.

This driver is a good example of that (missing expertise).  It seems to 
be a fine HID driver but a lot of the I2C details were just wrong.  At 
the same time, I have no idea whether the GPIO part works at all.

>> Anyone already working in this direction?
>
> I'd be very surprised :)

I could and would but I'm really not in a good position to do it.  My 
only sample hardware is in a network switch.
