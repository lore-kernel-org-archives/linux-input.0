From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/4] input: touchscreen: Add generic touchscreen
 softbutton handling code
Date: Mon, 1 Aug 2016 11:54:30 -0500
Message-ID: <20160801165430.GA30345@rob-hp-laptop>
References: <1469978590-14081-1-git-send-email-hdegoede@redhat.com>
 <1469978590-14081-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1469978590-14081-2-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Sun, Jul 31, 2016 at 05:23:07PM +0200, Hans de Goede wrote:
> Some touchscreens extend over the display they cover and have a number
> of capacative softbuttons outside of the display the cover.
> 
> With some hardware these softbuttons simply report touches with
> coordinates outside of the normal coordinate space for touches on the
> display.
> 
> This commit adds a devicetree binding for describing such buttons in
> devicetree and a bunch of helper functions to easily add support for
> these to existing touchscreen drivers.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../bindings/input/touchscreen/softbuttons.txt     |  58 +++++++++
>  drivers/input/touchscreen/Makefile                 |   2 +-
>  drivers/input/touchscreen/softbuttons.c            | 145 +++++++++++++++++++++
>  include/linux/input/touchscreen.h                  |   9 ++
>  4 files changed, 213 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
>  create mode 100644 drivers/input/touchscreen/softbuttons.c
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
> new file mode 100644
> index 0000000..3eb6f4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/softbuttons.txt
> @@ -0,0 +1,58 @@
> +General Touchscreen Softbutton Properties:
> +
> +Some touchscreens extend over the display they cover and have a number
> +of capacative softbuttons outside of the display the cover.
> +
> +Some of these softbuttons simply report touches with coordinates outside of
> +the normal coordinate space for touches on the display. This binding is for
> +describing such buttons in devicetree.
> +
> +Each softkey is represented as a sub-node of the touchscreen node.
> +
> +Required subnode-properties:
> + - label			: Descriptive name of the key.
> + - linux,code			: Keycode to emit.
> + - softbutton-min-x		: X start of the area the softbutton area covers
> + - softbutton-max-x		: X end of the area the softbutton area covers
> + - softbutton-min-y		: Y start of the area the softbutton area covers
> + - softbutton-max-y		: Y end of the area the softbutton area covers

This generally looks fine to me, but I am wondering one thing. If the 
buttons are located at the origin of an axis, can we handle that case? I 
don't think you can unless you assume softbutton-max-? is 0 for the 
touchscreen. To put it another way, you have a gap from 1024 to 1084 
which you can't express for buttons at the origin unless you do negative 
numbers.

Rob
