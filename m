From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 2/3] Documentation: devicetree: input: new binding for
  da7280
Date: Fri, 17 Aug 2018 09:10:00 -0600
Message-ID: <20180817151000.GF20845@rob-hp-laptop>
References: <cover.1534468025.git.Roy.Im@diasemi.com>
 <6fe6130443ab72ef8fa0e95da6a2e0d63c2ec1d7.1534468025.git.Roy.Im@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6fe6130443ab72ef8fa0e95da6a2e0d63c2ec1d7.1534468025.git.Roy.Im@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roy Im <roy.im.opensource@diasemi.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Support Opensource <support.opensource@diasemi.com>, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi, this email is from Rob's (experimental) review bot. I found a couple
of common problems with your patch. Please see below.

On Fri, 17 Aug 2018 10:07:04 +0900, Roy Im wrote:
> 
> from: Roy Im <roy.im.opensource@diasemi.com>
> 
> Add device tree binding information for DA7280 haptic driver.
> Example bindings for DA7280 are added.
> 
> Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>
> 

The preferred subject prefix is "dt-bindings: <binding dir>: ...".

> ---
> v2: No changes
> 
> 
>  .../devicetree/bindings/input/dlg,da7280.txt       |   91 ++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/dlg,da7280.txt
> 
