From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 0/4] Pegatron Lucid tablet acceleromter/ALS
Date: Tue, 25 Jan 2011 08:30:00 +0100
Message-ID: <AANLkTinfDR4TnVC-NPLsCqXsc9nP+UWXKO6n8jXuT7ne@mail.gmail.com>
References: <1295909288-32650-1-git-send-email-andy.ross@windriver.com>
	<20110124230557.GA18135@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:60031 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab1AYHaC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 02:30:02 -0500
In-Reply-To: <20110124230557.GA18135@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Ross <andy.ross@windriver.com>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org

On Tue, Jan 25, 2011 at 12:05 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Mon, Jan 24, 2011 at 02:48:04PM -0800, Andy Ross wrote:
>> Resubmission and update of the Pegatron Lucid tablet accelerometer and
>> ambient light sensor drivers.
>>
>> Patches 1-3 are against asus-laptop, and apply in order.
>>
>> Patch 4 is against input, and can be commited separately (obviously
>> relies on the detection code in asus-laptop at runtime, but will build
>> and load independently).
>>
>
> I am happy with the input part but I wonder if it really needs to be
> separate? If you roll it up into asus-laptop you would not need a new
> platform device and then it would be what - 20 lines of code?
>
> Corentin, what do you think?

I think that it should be consistent, if there is already some code
for pegatron tablet in asus-laptop, then why a new platform device
only for the accelerometer ?

On the other side, having to load "asus-laptop" on a pegatron tablet
(or on a lenovo laptop) isn't very intuitive.

The real name of this module should be atk010x_acpi, but it's not
really better, and it's probably too late for that.

Andy, what is shared with asus-laptop exactly ? What sysfs files are
working and enabled ?
Are backlight and led classes working ?

Thanks,
-- 
Corentin Chary
http://xf.iksaif.net
