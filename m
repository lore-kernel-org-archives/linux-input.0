From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v5 4/4] ARM: rockchip: Set name of regmap_config
Date: Mon, 12 Mar 2018 11:11:04 +0100
Message-ID: <6419126.t34s1xtZxx@phil>
References: <20180312095142.30854-1-jeffy.chen@rock-chips.com> <20180312095142.30854-5-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180312095142.30854-5-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, broonie@kernel.org, alexandre.belloni@bootlin.com, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Joseph Lo <josephl@nvidia.com>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, lee.jones@linaro.org, Emil Renner Berthing <kernel@esmil.dk>, Brian Norris <briannorris@chromium.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, linux-rockchip@lists.infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Matthias Kaehlcke <mka@chromium.org>, devicetree@vger.kernel.org, stephen lu <lumotuwe@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: linux-input@vger.kernel.org

Am Montag, 12. März 2018, 10:51:42 CET schrieb Jeffy Chen:
> We are now allowing to register debugfs without a valid device, and not
> having a valid name will end up using "dummy*" to create debugfs dir.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

applied for 4.17


Thanks
Heiko
