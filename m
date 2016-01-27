From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: touchscreen: ad7879: move header to input
 subdirectory
Date: Wed, 27 Jan 2016 15:35:05 -0800
Message-ID: <20160127233505.GC28687@dtor-ws>
References: <1453777477-29706-1-git-send-email-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453777477-29706-1-git-send-email-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: michael.hennerich@analog.com, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, realmz6@gmail.com, broonie@kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 25, 2016 at 07:04:35PM -0800, Stefan Agner wrote:
> The header file is used by the SPI and I2C variant of the driver.
> Therefore, move it to a more generic place under input.

Even better place would be include/linux/platform_data/ad7879.h

Thanks.

-- 
Dmitry
