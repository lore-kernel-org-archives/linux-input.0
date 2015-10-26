From: Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH 1/2] input: misc: e3x0-button: Fix typo in module name
Date: Mon, 26 Oct 2015 11:04:08 -0700
Message-ID: <CAAtXAHcT63vLUi9uP5bw0Odp6OTbfq87BEqL6S_WwnrWr+dL5Q@mail.gmail.com>
References: <1445803567-8511-1-git-send-email-moritz.fischer@ettus.com>
	<20151025204923.GA23656@dtor-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151025204923.GA23656@dtor-pixel>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: jaewon02.kim@samsung.com, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, dmurphy@ti.com, geert@linux-m68k.org, Courtney Cavin <courtney.cavin@sonymobile.com>, carlo@caione.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Oct 25, 2015 at 1:49 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Moritz,
>
> On Sun, Oct 25, 2015 at 01:06:06PM -0700, Moritz Fischer wrote:
>> The produced module will be called e3x0-button, not
>> e3x0_button.
>
> This is not entirely correct. The file name is e3x0-button.ko, but the
> module name is e3x0_button: when we construct KBUILD_MODNAME we
> substitute commas and dashes for underscores - see scripts/Makefile.lib

Thanks for the clarification. Good to know it wasn't broken in the first place.

Cheers,

Moritz
