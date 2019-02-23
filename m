From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: input: sitronix-st1232: add compatible
 string for ST1633
Date: Fri, 22 Feb 2019 18:43:48 -0600
Message-ID: <20190223004348.GA6783@bogus>
References: <20190128084449.16070-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190128084449.16070-1-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-input@vger.kernel.org

On Mon, 28 Jan 2019 09:44:47 +0100, Martin Kepplinger wrote:
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> The st1232 driver gains support for the ST1633 controller too; update
> the bindings doc accordingly.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  .../bindings/input/touchscreen/sitronix-st1232.txt          | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
