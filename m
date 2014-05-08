From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Thu, 08 May 2014 20:56:04 +0100
Message-ID: <536BE154.2090701@itdev.co.uk>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org> <536BAA5A.1010809@itdev.co.uk> <536BB3C9.8070908@wwwdotorg.org> <20140508172635.GD11672@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kdh-gw.itdev.co.uk ([89.21.227.133]:49194 "EHLO
	hermes.kdh.itdev.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755340AbaEHT4G (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 May 2014 15:56:06 -0400
In-Reply-To: <20140508172635.GD11672@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

Dmitry Torokhov wrote:
>>> Here is a set of patches for atmel_mxt_ts that you've already
>>> signed-off.
>>
>> Surely Dmitry would only have signed off on the patches if he had
>> applied them somewhere. I'm puzzled why he would have applied them but
>> not pushed them out into linux-next.
> 
> I stashed them into a topic branch but never merged it to next because
> there were concerns about the firmware loader interface causing long
> pauses at startup when driver was built into the kernel. I need to go
> over the series again.

Thanks! I had wondered why you had left it, you never communicated this to
me unfortunately. Would it be preferable for me to switch to
request_firmware_nowait() and complete the probe asynchronously after it
returns?
