From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Fri, 16 May 2014 17:21:26 +0100
Message-ID: <53763B06.7020100@itdev.co.uk>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org> <536BAA5A.1010809@itdev.co.uk> <536BB3C9.8070908@wwwdotorg.org> <536BDFFD.4080009@itdev.co.uk> <537128D0.3060005@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:11171 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757846AbaEPQVb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 May 2014 12:21:31 -0400
In-Reply-To: <537128D0.3060005@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

Stephen Warren wrote:
> On 05/08/2014 01:50 PM, Nick Dyer wrote:
>> The patches I posted at the end of March are the first 22 out of this tag:
>>
>> https://github.com/ndyer/linux/tree/for-next-20140316-v8
> 
> I took those 22 patches, applied them on top of next-20150507 (which is
> just what I happened to be developing on top of right now), and rebased
> my patches which add DT support. You can find the result here if you want:
> 
> git://github.com/swarren/linux-tegra.git tegra_dev

Thanks for this. Would you be happy for me to pick these changes up and
include them along with the other work I am sending to Dmitry? I am just
beginning to do various updates to the whole series, one of the things I
need to sort out is the device tree support.

I will need to add device tree parameters for the touchscreen as well as
the touchpad, of course.

By the way, the driver should work without any firmware file and just use
the firmware and configuration from NVRAM - request_firmware() returns a
failure and it continues through mxt_initialize().

In a later patch in my long series, I make the MXT_CFG_NAME configurable
from platform data (because you may have multiple devices needing different
configs), and leaving it null means the call to request_firmware() is skipped.
