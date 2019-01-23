From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Revert "Input: olpc_apsp - enable the SP clock"
Date: Wed, 23 Jan 2019 14:05:45 -0800
Message-ID: <20190123220545.GD179701@dtor-ws>
References: <20190121062255.551587-1-lkundrak@v3.sk>
 <20190121062255.551587-2-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190121062255.551587-2-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 21, 2019 at 07:22:54AM +0100, Lubomir Rintel wrote:
> Turns out this is not such a great idea. Once the SP clock is disabled,
> it's not sufficient to just enable in order to bring the SP core back up.
> 
> It seems that the kernel has no business managing this clock. Just let
> the firmware keep it enabled.
> 
> This reverts commit ed22cee91a88c47e564478b012fdbcb079653499.
> 
> Link: https://lore.kernel.org/lkml/154783267051.169631.3197836544646625747@swboyd.mtv.corp.google.com/
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

OK, as clock folks say it is a bad idea it must be so. Merge though clk
tree?

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
