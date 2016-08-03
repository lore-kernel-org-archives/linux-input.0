From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 1/4] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Wed, 3 Aug 2016 21:13:19 +0200
Message-ID: <d1c121ee-a467-1642-ca75-a9fae90bbfc1@denx.de>
References: <cover.1466769907.git.ksenija.stanojevic@gmail.com>
 <370a02584386944b465deff5ccc48c8919b23dba.1466769907.git.ksenija.stanojevic@gmail.com>
 <20160628162834.GF29166@dell>
 <CAL7P5j+NYvUJfu==xQvncyCiw8JHtizOdfyeY1HL6Lb=-wsrWQ@mail.gmail.com>
 <E1bIyD4-0000Jw-2c@stardust.g4.wien.funkfeuer.at>
 <20160713124935.GC11154@dell> <5bddd461-90e3-3116-8d18-fae51bf39310@denx.de>
 <397621614.8135.5a20a815-9153-4587-9aeb-f2a7fc5a4ff5.open-xchange@email.1und1.de>
 <CAL7P5jJEYUQihe4pynerRUNgVAQzymYbUZEO9BrVdb+-syok-Q@mail.gmail.com>
 <CAL7P5jKG=b0P9T10RX9p0EXR7epTOfKqbMT6nYZkDhnqiAz_jA@mail.gmail.com>
 <CAOMZO5BSUice=2Zioeu9Zrfi5ixhszO9hF1vmFW5FiPKWqkb9w@mail.gmail.com>
 <CAL7P5j+1vOXz8a7zrTN+KDRAJJWr0vPC25o4LcXutagO9wVRNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:44491 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756850AbcHCTO1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Aug 2016 15:14:27 -0400
In-Reply-To: <CAL7P5j+1vOXz8a7zrTN+KDRAJJWr0vPC25o4LcXutagO9wVRNA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Ksenija_Stanojevi=c4=87?= <ksenija.stanojevic@gmail.com>, Fabio Estevam <festevam@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org, Harald Geyer <harald@ccbib.org>

On 08/03/2016 06:45 PM, Ksenija Stanojević wrote:
> Hi Fabio,

Hi,

> On Wed, Aug 3, 2016 at 6:35 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> Hi Ksenija,
>>
>> On Wed, Aug 3, 2016 at 1:32 PM, Ksenija Stanojević
>> <ksenija.stanojevic@gmail.com> wrote:
>>
>>> Can someone with imx23 board send me /proc/interrupts log, I
>>> need irq numbers...
>>
>> Can't you get them from the MX23 Reference Manual (Table 5-1. i.MX23
>> Interrupt Sources)?
> 
> I thought it will be more reliable if I asked someone, since numbers from MX28
> manual don't match with /proc/interrupts log.
> 
What do you mean they don't match ? Please elaborate.

-- 
Best regards,
Marek Vasut
