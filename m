From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] Input: add STMicroelectronics FingerTip
 touchscreen driver
Date: Wed, 15 Feb 2017 20:13:57 -0600
Message-ID: <20170216021357.ma22e33y6253n3iq@rob-hp-laptop>
References: <20170210021721.12218-1-andi.shyti@samsung.com>
 <CGME20170210021728epcas5p46d0256d507157cd4387b707ec616c1d1@epcas5p4.samsung.com>
 <20170210021721.12218-2-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170210021721.12218-2-andi.shyti@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

On Fri, Feb 10, 2017 at 11:17:19AM +0900, Andi Shyti wrote:
> Add binding for the STMicroelectronics FingerTip (stmfts)
> touchscreen driver.
> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  .../bindings/input/touchscreen/st,stmfts.txt       | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt

Acked-by: Rob Herring <robh@kernel.org> 
