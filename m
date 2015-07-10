From: Ellen Wang <ellen@cumulusnetworks.com>
Subject: Re: [PATCH v1] HID: cp2112: support i2c write-read transfers in hid-cp2112
Date: Fri, 10 Jul 2015 00:03:29 -0700
Message-ID: <559F6E41.1040501@cumulusnetworks.com>
References: <1434621340-10422-1-git-send-email-ellen@cumulusnetworks.com> <CAAj6DX03vzNHVLE2gx+zOCud-3WWUnewYCc2-z-wXKhDPHRYQg@mail.gmail.com> <alpine.LNX.2.00.1507081133350.10183@pobox.suse.cz> <559CFC61.6000303@cumulusnetworks.com> <alpine.LNX.2.00.1507091420510.10183@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35565 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbbGJHDc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2015 03:03:32 -0400
Received: by pdrg1 with SMTP id g1so47419044pdr.2
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2015 00:03:31 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1507091420510.10183@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Antonio Borneo <borneo.antonio@gmail.com>, David Barksdale <dbarksdale@uplogix.com>, linux-input <linux-input@vger.kernel.org>, linux-i2c@vger.kernel.org

On 07/09/2015 05:22 AM, Jiri Kosina wrote:
> On Wed, 8 Jul 2015, Ellen Wang wrote:
> ...
>> This patch should be applied after my other patch:
>> https://patchwork.ozlabs.org/patch/492842/
>
> Well, it actually conflicts with it :) The conflict is easy to resolve,
> but as you might be sending v2 anyway, please rebase it on top of
> for-4.3/cp2112 when doing so.
>
> Thanks,

v2 sent, based on for-4.3/cp2112.
