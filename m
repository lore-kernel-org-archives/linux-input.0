From: "STenyaK (Bruno Gonzalez)" <stenyak@gmail.com>
Subject: Re: [PATCH] Added device to hid-ff
Date: Thu, 15 Feb 2007 20:40:59 +0100
Message-ID: <op.tns2alf2a64tfs@localhost>
References: <38b3b7c0702151056m7c396952j81199783f654bf7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: Quoted-Printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <38b3b7c0702151056m7c396952j81199783f654bf7a@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: johann deneux <johann.deneux@gmail.com>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, dmitry <dmitry.torokhov@gmail.com>
Cc: Valentin Zagura <puthre@gmail.com>
List-Id: linux-input@vger.kernel.org

Sorry for not providing a proper patch, could you please also add
         {0x46d, 0xc294, hid_lgff_init}, // Logitech G25 wheel
to the list? I tested it here and that wheel is also working.

On Thu, 15 Feb 2007 19:56:18 +0100, johann deneux  =

<johann.deneux@gmail.com> wrote:

> This patch (initially submitted by Valentin Zagura) adds the Logitech
> Formula Force EX to the list of devices handled by hid-lgff.
> Also updated the text of the Kconfig entry.
>
> Signed-off-by: Johann Deneux <johann.deneux@gmail.com>
>
> --- linux-2.6.20.orig/drivers/usb/input/Kconfig    2007-02-04 19:44:
> 54.000000000 +0100
> +++ linux-2.6.20/drivers/usb/input/Kconfig    2007-02-15  =

> 12:27:42.000000000+0100
> @@ -56,17 +56,21 @@ config HID_PID
>        Say Y here if you have a PID-compliant device and wish to enabl=
e
> force
>        feedback for it. Microsoft Sidewinder Force Feedback 2 is one o=
f  =

> such
>        devices.
>
>  config LOGITECH_FF
> -    bool "Logitech WingMan *3D support"
> +    bool "Logitech devices support"
>      depends on HID_FF
>      select INPUT_FF_MEMLESS if USB_HID
>      help
>        Say Y here if you have one of these devices:
>        - Logitech WingMan Cordless RumblePad
> +      - Logitech WingMan Cordless RumblePad 2
>        - Logitech WingMan Force 3D
> +      - Logitech Formula Force EX
> +      - Logitech MOMO Force wheel
> +
>        and if you want to enable force feedback for them.
>        Note: if you say N here, this device will still be supported, b=
ut
> without
>        force feedback.
>
>  config THRUSTMASTER_FF
> --- linux-2.6.20.orig/drivers/usb/input/hid-ff.c    2007-02-04 19:44:
> 54.000000000 +0100
> +++ linux-2.6.20/drivers/usb/input/hid-ff.c    2007-02-15
> 12:16:53.000000000+0100
> @@ -53,10 +53,11 @@ struct hid_ff_initializer {
>   */
>  static struct hid_ff_initializer inits[] =3D {
>  #ifdef CONFIG_LOGITECH_FF
>      { 0x46d, 0xc211, hid_lgff_init }, /* Logitech Cordless rumble pad=
 */
>      { 0x46d, 0xc283, hid_lgff_init }, /* Logitech Wingman Force 3d */=

> +    { 0x46d, 0xc294, hid_lgff_init }, /* Logitech Formula Force EX */=

>      { 0x46d, 0xc295, hid_lgff_init }, /* Logitech MOMO force wheel */=

>      { 0x46d, 0xc219, hid_lgff_init }, /* Logitech Cordless rumble pad=
 2  =

> */
>  #endif
>  #ifdef CONFIG_THRUSTMASTER_FF
>      { 0x44f, 0xb304, hid_tmff_init },



-- =

Saludos,
     STenyaK

_______________________________________________
Site:   http://1ksurvivor.homeip.net  <1kSurvivor>
         http://motorsport-sim.org     <Motorsport>
         http://kwh.iespana.es         <KuantikalWareHouse>
         http://emuletutorial.info     <EmuleTutorial>
ICQ:    153709484
Mail:   stenyak AT gmail DOT net
