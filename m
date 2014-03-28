From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCHv6 2/5] Input: edt-ft5x06: Add DT support
Date: Fri, 28 Mar 2014 09:26:57 -0700
Message-ID: <20140328162657.GD22658@core.coreip.homeip.net>
References: <1395323075-12146-1-git-send-email-LW@KARO-electronics.de>
 <1395673870-29435-1-git-send-email-LW@KARO-electronics.de>
 <1395673870-29435-3-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1395673870-29435-3-git-send-email-LW@KARO-electronics.de>
Sender: linux-doc-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Fugang Duan <B38611@freescale.com>, Grant Likely <grant.likely@linaro.org>, Henrik Rydberg <rydberg@euromail.se>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jg1.han@samsung.com>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Rob Landley <rob@landley.net>, Sachin Kamat <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, Daniel Wagener <daniel.wagener@kernelconcepts.de>
List-Id: linux-input@vger.kernel.org

Hi Lothar,

On Mon, Mar 24, 2014 at 04:11:07PM +0100, Lothar Wa=DFmann wrote:
> +#else
> +static inline int edt_ft5x06_i2c_ts_probe_dt(struct device *dev,
> +					struct edt_ft5x06_i2c_ts_data *tsdata)

This is wrong (not-existant) type for tsdata, I fixed it up.

Thanks.

--=20
Dmitry
