From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/7] Input: dt-bindings: tm2-touchkey: Document new
 keycodes property
Date: Fri, 28 Dec 2018 16:47:07 -0600
Message-ID: <20181228224707.GA7218@bogus>
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228154609.14846-6-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181228154609.14846-6-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, simon@lineageos.org
List-Id: linux-input@vger.kernel.org

On Fri, 28 Dec 2018 16:46:07 +0100, =?UTF-8?q?Pawe=C5=82=20Chmiel?= wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Document new optional property for setting custom keycodes.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>   - Because key codes could be bigger than 255, use ints for keycodes
> ---
>  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
