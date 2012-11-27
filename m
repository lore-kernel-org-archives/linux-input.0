From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] Input: bu21013_ts - Request a regulator that
 actually exists
Date: Tue, 27 Nov 2012 13:34:04 +0000
Message-ID: <20121127133404.GA13065@sirena.org.uk>
References: <1354021990-16978-1-git-send-email-lee.jones@linaro.org>
 <1354021990-16978-2-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1354021990-16978-2-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, arnd@arndb.de, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Nov 27, 2012 at 01:13:08PM +0000, Lee Jones wrote:
> Currently the BU21013 Touch Screen driver requests a regulator by the
> name of 'V-TOUCH', which doesn't exist anywhere in the kernel. The
> correct name, as referenced in platform regulator code is 'avdd'. Here,
> when we request a regulator, we use the correct name instead.

The regulator should be requested using whatever the name for the supply
in the datasheet - AVDD does sound very pluasible but it'd be good to
check.
