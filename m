From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RESEND PATCH V4 2/3] devicetree: Add bindings for DA9063 OnKey
Date: Wed, 20 May 2015 08:44:03 -0500
Message-ID: <CAL_JsqJOqs8Y8MYx9mtBZWo+VGb7cTFqSAr1iq=D6jB293kEfg@mail.gmail.com>
References: <cover.1432031565.git.stwiss.opensource@diasemi.com> <72933a3c053b445e7998c818b7a73317fa1e2d8a.1432031565.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <72933a3c053b445e7998c818b7a73317fa1e2d8a.1432031565.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, May 19, 2015 at 5:32 AM, S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org> wrote:
> From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>
> Add device tree bindings for the DA9063 OnKey driver
>
> Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>

nit: remove blank line here.

I would think a long key press would be a h/w powerdown rather than a
key event as how do you poweroff/reset a hung system? That doesn't
really affect the binding though, so:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Rob

> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>
> ---
> Version History
>
> Changes in V4
>  - No change
>
> Changes in V3
>  - No change
>
> Changes in V2
>  - Remove the circular dependency comment linking patches in the main e-mail
>  - Search and replace 'keyword' with 'property' in onkey sub-node description
>  - Reformat onkey sub-node content to move the description for key-power into
>    a new optional properties sub-section so it has a more promiment position
>
> This patch applies against linux-next and v4.1-rc3
>
>
>  Documentation/devicetree/bindings/mfd/da9063.txt | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/da9063.txt b/Documentation/devicetree/bindings/mfd/da9063.txt
> index 42c6fa6..05b21bc 100644
> --- a/Documentation/devicetree/bindings/mfd/da9063.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9063.txt
> @@ -5,6 +5,7 @@ DA9093 consists of a large and varied group of sub-devices (I2C Only):
>  Device                   Supply Names    Description
>  ------                   ------------    -----------
>  da9063-regulator        :               : LDOs & BUCKs
> +da9063-onkey            :               : On Key
>  da9063-rtc              :               : Real-Time Clock
>  da9063-watchdog         :               : Watchdog
>
> @@ -51,6 +52,18 @@ Sub-nodes:
>    the DA9063. There are currently no entries in this binding, however
>    compatible = "dlg,da9063-rtc" should be added if a node is created.
>
> +- onkey : This node defines the OnKey settings for controlling the key
> +  functionality of the device. The node should contain the compatible property
> +  with the value "dlg,da9063-onkey".
> +
> +  Optional onkey properties:
> +
> +  - dlg,disable-key-power : Disable power-down using a long key-press. If this
> +    entry exists the OnKey driver will remove support for the KEY_POWER key
> +    press. If this entry does not exist then by default the key-press
> +    triggered power down is enabled and the OnKey will support both KEY_POWER
> +    and KEY_SLEEP.
> +
>  - watchdog : This node defines settings for the Watchdog timer associated
>    with the DA9063. There are currently no entries in this binding, however
>    compatible = "dlg,da9063-watchdog" should be added if a node is created.
> @@ -73,6 +86,11 @@ Example:
>                         compatible = "dlg,da9063-watchdog";
>                 };
>
> +               onkey {
> +                       compatible = "dlg,da9063-onkey";
> +                       dlg,disable-key-power;
> +               };
> +
>                 regulators {
>                         DA9063_BCORE1: bcore1 {
>                                 regulator-name = "BCORE1";
> --
> end-of-patch for RESEND PATCH V4
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
