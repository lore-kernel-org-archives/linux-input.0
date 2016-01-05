From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v11 0/8] Goodix touchscreen enhancements
Date: Tue, 5 Jan 2016 14:07:47 -0800
Message-ID: <CAKdAkRQRJTONwakthxKDyG-=2CeaBjANiew6jpGc_1+ustSmGQ@mail.gmail.com>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
	<20151218011318.GB16016@dtor-ws>
	<20160105200343.GA3425@excalibur.cnev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f193.google.com ([209.85.214.193]:33475 "EHLO
	mail-ob0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbcAEWHs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jan 2016 17:07:48 -0500
In-Reply-To: <20160105200343.GA3425@excalibur.cnev.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karsten Merker <merker@debian.org>
Cc: Irina Tirdea <irina.tirdea@intel.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Octavian Purdila <octavian.purdila@intel.com>, lkml <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Karsten,

On Tue, Jan 5, 2016 at 12:03 PM, Karsten Merker <merker@debian.org> wrote:
> On Thu, Dec 17, 2015 at 05:13:18PM -0800, Dmitry Torokhov wrote:
>> On Thu, Nov 19, 2015 at 02:26:33PM +0200, Irina Tirdea wrote:
>> > This patchset depends on Dmitry's patch that fixes the
>> > GPIO ACPI API[1], so devm_gpiod_get_optional can be properly
>> > used in the code.
>> >
>> > [1] https://lkml.org/lkml/2015/11/11/465
>>
>> Applied 1 through 5 (see my goodix branch), looking at the rest.
>
> Hello,
>
> as we are getting near to the next merge window, I wanted to
> kindly ask whether there is any news on this.  It would be really
> nice if the complete stack of goodix patches could go into kernel
> 4.5.

There is goodix branch at
git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git that we
should be able to merge in 4.5. It has your patches and half of
Irina's (with config dump and ESD support missing at the moment). If
you could give ti a quick spin I'd appreciate it.

Thanks.

-- 
Dmitry
