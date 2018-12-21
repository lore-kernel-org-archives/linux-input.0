From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/8] dt-bindings: stmpe: reformatting parameter list
 and use tabs only
Date: Fri, 21 Dec 2018 12:23:29 -0600
Message-ID: <20181221182329.GA5726@bogus>
References: <20181221134638.20600-1-dev@pschenker.ch>
 <20181221134638.20600-2-dev@pschenker.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181221134638.20600-2-dev@pschenker.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Philippe Schenker <dev@pschenker.ch>
Cc: jic23@kernel.org, marcel.ziswiler@toradex.com, stefan@agner.ch, robh@kernel.org, alexandre.torgue@st.com, shawnguo@kernel.org, dmitry.torokhov@gmail.com, thierry.reding@gmail.com, digetx@gmail.com, lee.jones@linaro.org, coquelin.stm32@gmail.com, Philippe Schenker <philippe.schenker@toradex.com>, devicetree@vger.kernel.org, Max Krummenacher <max.krummenacher@toradex.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Fri, 21 Dec 2018 14:46:30 +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> This patch reformats the parameter list for stmpe device in a
> table-style so it is more clear to read.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> ---
> 
> Changes in v5:
>  - Made a one column list
>  - Added lee's Acked-for-MFD
>  - Changed author of commit to use correct email.
> 
> Changes in v4:
>  - New separate precursor patch for holding reformatting
> 
> Changes in v3: None
> Changes in v2: None
> 
>  .../bindings/input/touchscreen/stmpe.txt      | 64 +++++++++++++------
>  .../devicetree/bindings/mfd/stmpe.txt         | 14 ++--
>  2 files changed, 53 insertions(+), 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
