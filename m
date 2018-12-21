From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v4 1/8] dt-bindings: stmpe: reformatting parameter list
 and use tabs only
Date: Fri, 21 Dec 2018 10:44:34 +0000
Message-ID: <20181221104434.GN13248@dell>
References: <20181212130649.15146-1-dev@pschenker.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181212130649.15146-1-dev@pschenker.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Schenker <dev@pschenker.ch>
Cc: jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch, thierry.reding@gmail.com, Philippe Schenker <philippe.schenker@toradex.com>, devicetree@vger.kernel.org, Max Krummenacher <max.krummenacher@toradex.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Wed, 12 Dec 2018, Philippe Schenker wrote:

> This patch reformats the parameter list for stmpe device in a
> table-style so it is more clear to read.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> ---
> 
> Changes in v4:
>  - New separate precursor patch for holding reformatting
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../bindings/input/touchscreen/stmpe.txt      | 52 ++++++++++++-------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 ++---
>  2 files changed, 41 insertions(+), 25 deletions(-)

Set looks okay.

Please submit a [RESEND] with all the Acks you've collected.

And next time, please make sure you author a 0th (cover-letter) patch.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
