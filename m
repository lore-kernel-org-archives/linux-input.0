From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] add backlight level quirk for Asus ROG laptops
Date: Thu, 9 Nov 2017 12:50:05 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711091249440.32604@cbobk.fhfr.pm>
References: <20171028073140.12807-1-mustafakuscu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47345 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752747AbdKILuH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Nov 2017 06:50:07 -0500
In-Reply-To: <20171028073140.12807-1-mustafakuscu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mustafa Kuscu <mustafakuscu@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, linux-kernel@vger.kernel.org

On Sat, 28 Oct 2017, Mustafa Kuscu wrote:

> On laptops such as Asus GL553VD, setting keyboard backlight levels 
> does not work. This change enables F3/F4 keys to set backlight levels 
> (from 0 to 3, total 4 levels) on such laptops. 
> 
> It is intended only to the following device: 0x0b05 1854:
> P: Vendor=0b05 ProdID=1854 Rev=03.02
> S: Manufacturer=ITE Tech. Inc.
> S: Product=ITE Device(8910)
> 
> Note: Just reloading the hid_asus module would not suffice, reload 
> the whole thing or reboot, you know.
> 
> Signed-off-by: Mustafa C Kuscu <mustafakuscu@gmail.com>

I've reformatted the changelog/shortlog a little bit and applied to 
for-4.15/asus. Thanks,

-- 
Jiri Kosina
SUSE Labs

