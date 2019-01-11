From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 5/7] Input: dt-bindings: tm2-touchkey: Document new
 keycodes property
Date: Fri, 11 Jan 2019 08:30:43 -0600
Message-ID: <20190111143043.GA4914@bogus>
References: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
 <20190107185346.30184-6-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190107185346.30184-6-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, xc-racer2@live.ca, simon@lineageos.org
List-Id: linux-input@vger.kernel.org

On Mon, Jan 07, 2019 at 07:53:44PM +0100, Paweł Chmiel wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Document new optional property for setting custom keycodes.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v2:
>   - Change property name from keycodes to linux,keycodes
> 
> Changes from v1:
>   - Because key codes could be bigger than 255, use ints for keycodes
> ---
>  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
