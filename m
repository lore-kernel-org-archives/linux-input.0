From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V5 2/3] dt-bindings: input: Add document bindings for
 DA7280
Date: Tue, 28 Aug 2018 17:20:15 -0500
Message-ID: <20180828222015.GA26211@bogus>
References: <cover.1535358095.git.Roy.Im@diasemi.com>
 <a0aba6fe0b63f5a685743c88e192701731e289ab.1535358095.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a0aba6fe0b63f5a685743c88e192701731e289ab.1535358095.git.Roy.Im@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Support Opensource <support.opensource@diasemi.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 27 Aug 2018 17:21:35 +0900, Roy Im wrote:
> 
> Add device tree binding information for DA7280 haptic driver.
> Example bindings for DA7280 are added.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> 
> ---
> v5: Updated descriptions and fixed errors.
> v4: Fixed commit message, properties.
> v3: Fixed subject format.
> v2: No changes
> 
> 
>  .../devicetree/bindings/input/dlg,da7280.txt       |  105 ++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
