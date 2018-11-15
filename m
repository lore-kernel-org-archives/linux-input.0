From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/6] OLPC 1.75 Keyboard/Touchpad fixes
Date: Thu, 15 Nov 2018 11:15:30 -0800
Message-ID: <20181115191530.GB212221@dtor-ws>
References: <20181112023029.648408-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112023029.648408-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 12, 2018 at 03:30:23AM +0100, Lubomir Rintel wrote:
> This makes keyboard/touchpad work on a DT MMP2 platform.
> 
> Changes since v1:
> - Collected Acks
> - Replaced "Input: olpc_apsp: depend on CONFIG_OF" patch with "Input:
>   olpc_apsp: drop CONFIG_OLPC dependency", since it was correctly
>   pointed out that the driver doesn't actually depend on OF.
> - Dropped "Input: olpc_apsp: allocate the GPIOs used" and "dt-bindings:
>   olpc,ap-sp: add GPIO lines" since at the moment they are not useful
>   for much more than documenting the lines the SP uses and actually
>   claiming them was deemed not to be a good idea.
> - Fixed error handling in the "enable the SP clock" patch.

Applied the series, thank you.

-- 
Dmitry
