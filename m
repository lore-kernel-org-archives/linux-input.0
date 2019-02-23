From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] Input: lpc32xx-key - add clocks property and fix DT
 binding example
Date: Fri, 22 Feb 2019 18:41:58 -0600
Message-ID: <20190223004158.GA3951@bogus>
References: <20190126142921.16041-1-vz@mleia.com>
 <20190126142921.16041-2-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190126142921.16041-2-vz@mleia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, Sylvain Lemieux <slemieux.tyco@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sat, 26 Jan 2019 16:29:19 +0200, Vladimir Zapolskiy wrote:
> The keypad controller on NXP LPC32xx requires its clock gate to be open,
> therefore add description of the requires 'clocks' property.
> 
> In addition adjust the example by adding description of required 'clocks'
> property and by fixing 'interrupts' property.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> ---
>  Documentation/devicetree/bindings/input/lpc32xx-key.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
