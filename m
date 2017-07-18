From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] mfd: axp20x: use correct platform device id for many
 PEK
Date: Tue, 18 Jul 2017 11:28:48 +0100
Message-ID: <20170718102848.6lppphur2grc3alh@dell>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <20170717095307.15986-3-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170717095307.15986-3-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com, maxime.ripard@free-electrons.com
List-Id: linux-input@vger.kernel.org

On Mon, 17 Jul 2017, Quentin Schulz wrote:

> According to their datasheets, the AXP221, AXP223, AXP288, AXP803,
> AXP809 and AXP813 PEK have different values for startup time bits from
> the AXP20X, let's use the platform device id with the correct values.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  drivers/mfd/axp20x.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
  
-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
