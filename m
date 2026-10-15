Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D098637267A
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792051075; cv=pass; b=gwt6mFMOWbpyrckMK6u2a1ydGf+SD++2lkavhs/mKCCvOhaGASVTiGWJRPqpnPXiURlGz3hLS8RWba2/TKzAU67pb1+4MA5bWD/r/7JZ0aiohs932k0/K+u3PMEJYuacW/cpR8vhG6eifuu6oybc4KA21lUTLB70qYjmaWLZ4jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792051075; c=relaxed/simple;
	bh=+CP0VyKP++8KzrG+egnIu/uYUo2YQKKTOM2sPrza3ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aoSjNKH5TGabfvuU5x+ok1seBm9vdlQ8z88t5aTmm80Q8P51B+bIWhSIwRztFYBQc627pc1lkRiKpxvR+KSzTObok+BAXuco2VHWcup6FSMzJipiHP7f8MzA+wfr3XNpEEltJAjGiB/FKQEvhm3wYLoPpbyjAm4SOOdRi0LQI58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7lDU/1k; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7lDU/1k"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6ae27f06c2fso3355468a12.3
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 00:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792051072; cv=none;
        d=google.com; s=arc-20260327;
        b=KmN1pUXyt2rQXn+rJALd+njLsx8Zg5ocevpLToa6dW+GLmHCWkjopbGSLT/6/rWfPD
         joerTeWjFBl6TwYDzBKhIEm1PPuQIEv8lT8abmHP0lLD1+RKC7WbOE2Qnu25EFGiuTBt
         ofbE1oblM/BRIee7ESyBmNvR9gcdYlKwk5USgfoB4OVOVfnNb+JnFX/SuMwowCRLpPnD
         xgAKdajewzgFyABgNi55NG9pHu4G07qAxQ+urQz+oD8N4sGZ1XviH5f7wSi81TOMDUv6
         pCmJ/gfqSBV6zi4GXX7MhXtqb5vkdCsLM2Y4LiiRLPYRsMO8CodAMNxT0V7REmrajqv5
         0How==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C5+V64ZjXSQ1A98PRNqx2K8k7nNvu3c8BbnG8cd1zcY=;
        fh=jzdBPPAJ/gocARjfMP6+NBfrlWxKNl4J1wMlPng4Lx4=;
        b=s+GxhAGSQVxIadskVL88z0fGhHTc3lfGGN8Qs3sWZnO4iQS8IuYYYPel1Wh6T8qsMi
         f5zH5437+Eao6ovi81efQkaTyo5T1RhjUf48uY8e2R6k7u+lSaWPdjwGsnTlCs0u/g7e
         ygaNGAGEaLFLtm2vY09pflnS1lsUgbFkFwUt5Z7jPv49cLX2Ga3XUweYwSbRDV8wwUVS
         Rh8nRKF+oLtEWNIgkJ6ylfCV7R8zSlyFtqFz0r3nlXl/3EM3He0ndj4biA3n+eEXKnLj
         xLG5/YV7L7qM9shxryj5bdsnZZw4pvtUQcT+kRmp+aHC5Jl3xkONLSA9164SSgRMwgED
         obRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792051072; x=1792655872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C5+V64ZjXSQ1A98PRNqx2K8k7nNvu3c8BbnG8cd1zcY=;
        b=r7lDU/1kx34VbVa1ei/BJwt+VaXnHPRRRXio5CpH4ceCHGRESHvaHmyQL/utCFWrEB
         aeWO7HssrzsnPx06IN5roCDELGaPD+s0AJAJXCCXWNYDzQFNCol0idFew8nTgZts2oJC
         8J1aKL3/+Jkk4csRbtoF1lRJa/QUP4ZZsrrVDU+m9H4CIIC6ZkKEB6saQsdMVwg8Ir1E
         F+/mpFok3Asa0IXTr3bsIMF6lUxHjpnKjroQh9MdH32Q9juhG97IoS8bYgmpJdgp999z
         Q2zRXhIKtl/S84utZFi+LqK61lejElR9eVrx9Eqeqy0k1nPESSRu3FusI7IMXviwY10q
         EUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792051072; x=1792655872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C5+V64ZjXSQ1A98PRNqx2K8k7nNvu3c8BbnG8cd1zcY=;
        b=GrLhf3FzrTgqLdSIGPpr8bC0Bcxf0mz3YJrY6Nw8ELot0bZPRrcTAaMbKqkrSccNtH
         ba0R+HwRKdZev/sfIXmicNGLa3zP92N2CUdG54hIkxFwvLZDglL+hr41xBRUrG2mzUgN
         tcd7P3TqCTVVnWqhZFYRYL7IYwqcBKTUYViOC2aqXWT0oUgtZN4QJ35AncLw7LXaWgE6
         7DjAJRXaIJLpbpLn9Jsli2xGnZIW4MEwAGeOniC+2j0g4gbO/v4VdnVHzdtrpufti2BL
         bO3saK5d2xg2Hre7zU36srJrJS2cZ5WmhiiK0l6mDQX7i7WFW1ARSsrXvGRbfoBUZq5d
         /HaQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+CBZJ5oBvpP7xXnesOalgM9UpXgMorKBUD5q8Hw6YWDHM9m636BTgIyQafbx41IPFHThi3ADkWQ3lrQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKYdq2tBNXOZim5FMXuc3tBsKuTrSzk2veVF2n/mCFWx3Y7X/bE
	mn/iWOx1cI+VbTncVJDIVFgTxg41nWhZDQcpsx3MJNYnG+ke38nzW7bFa3wEVPD60Dv84pXOXrS
	ny980ymHqL1zhOEW+DiDMmjQ516kPSB4=
X-Gm-Gg: AYBFou3BxD2dX6lUwXRrjp+275l4KchS1UT252wC0BOFEzjERkp6/hxWwLAvvu9C9i8
	IXiPNAIGXcVmohDDhQMVz2pXVTgBdgsKTEuUqH1Wy/cY8DC8Vf946rn/Dofu089TcUGMDrkdG4Y
	gN5CWHW6u7Hyh+QeWfEzGxs+dm4oh/ukd0ZwvPBAAtuuvaB0ZnYCs4oHKuv7leitkfdLpigNcZv
	AY2kbCWUDjiUvEN7e2/wDJSS6RFsqfE9fPCvH+09eSN6SN8++IVXyIHApGt14p8FI5paCTN+LQT
	YeuF0abYvys0BMa+nu7ToFqAof0MPLLxrqv4MtGsvwjZeYV9KPPc1nOVj4ybjW+q7uOBGoeF5K6
	KlibKQpMNkn78
X-Received: by 2002:a05:6938:a093:20b0:c34:cf13:a930 with SMTP id
 a640c23a62f3a-c34cf13b375mr709472966b.34.1792051071921; Thu, 15 Oct 2026
 00:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013173504.451391-1-clamor95@gmail.com> <20261013173504.451391-5-clamor95@gmail.com>
 <4c7d0796862cb8258ec5357efb10db99@gmail.com>
In-Reply-To: <4c7d0796862cb8258ec5357efb10db99@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 15 Oct 2026 10:57:37 +0300
X-Gm-Features: AclHuK_zOU0vGqHHfQFSlQf47ESHJT_TdqyRFvC8Vv1ThZJQbI7OZw4q7U0ciY0
Message-ID: <CAPVz0n1U_C0ZvNCP+1ZQ53jOwoy56Fx+9+4PSyYkUBpSQjEhAg@mail.gmail.com>
Subject: Re: [PATCH v11 4/7] input: keyboard: Add driver for ASUS Transformer
 dock multimedia keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Florian Krischer <florian.krischer@fkr.dev>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 15 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 04:3=
3 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> On Tue, Oct 13, 2026 at 08:35:00PM +0300, Svyatoslav Ryhel wrote:
> > Add support for multimedia top button row of ASUS Transformer's Mobile
> > Dock keyboard. Driver is made that function keys (F1-F12) are used by
> > default which suits average Linux use better and with pressing
> > ScreenLock + AltGr function keys layout is switched to multimedia keys.
> > Only Dock keyboard input events are tracked for AltGr pressing.
>
> I still think registering a global input_handler just to observe Right Al=
t
> state on the dock keyboard is heavier than necessary, and because the
> handler is a passive observer rather than a filter, pressing AltGr+Screen=
Lock
> or AltGr+F1..F12 still leaks the KEY_RIGHTALT press and release events fr=
om
> atkbd to userspace alongside the mode switch or media key event.
>
> Since asus-transformer-ec-kbc already inspects and remaps 0xe0-prefixed
> scancodes on the keyboard port before passing them to serio, we can track
> and delay AltGr (0xe0 0x11) there when the extension keys driver is activ=
e,
> and coordinate with asus-transformer-ec-keys via struct asusec_core:
>
> - When AltGr is pressed on the dock keyboard, asus-transformer-ec-kbc
>   delays emitting the 0xe0 0x11 make sequence and sets
>   ec->right_alt_pressed.
> - If an extension key is pressed while right_alt_pressed is set,
>   asus-transformer-ec-keys sets ec->special_combo_triggered (either
>   toggling special_key_mode on ScreenLock or reporting the shifted key fo=
r
>   other top-row keys), and asus-transformer-ec-kbc suppresses both the
>   delayed AltGr make and the subsequent AltGr break (0xe0 0xf0 0x11).
> - If any regular key make event arrives on the primary keyboard port firs=
t,
>   or if AltGr is released without triggering an extension key combo,
>   asus-transformer-ec-kbc flushes the delayed 0xe0 0x11 make sequence
>   before forwarding the event.
>
> This avoids registering an input_handler altogether and drops about 100
> lines of boilerplate from asus-transformer-ec-keys.c.
>
> What do you think about folding the change below into patches 2, 3, and 4=
?
>
> (Also, a minor typo in patch 3/7 in drivers/input/serio/Kconfig:
> "Asus Transformed's Mobile Dock" -> "Asus Transformer's Mobile Dock".)
>
> diff --git a/drivers/input/keyboard/asus-transformer-ec-keys.c b/drivers/=
input/keyboard/asus-transformer-ec-keys.c
> index 8e83b27ce60e..ec72c38d7653 100644
> --- a/drivers/input/keyboard/asus-transformer-ec-keys.c
> +++ b/drivers/input/keyboard/asus-transformer-ec-keys.c
> @@ -7,7 +7,6 @@
>  #include <linux/mfd/asus-transformer-ec.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/slab.h>
>
>  #define ASUSEC_EXT_KEY_CODES           0x20
>
> @@ -15,74 +14,8 @@ struct asus_ec_keys_data {
>         struct notifier_block nb;
>         struct asusec_core *ec;
>         struct input_dev *xidev;
> -       struct input_handler input_handler;
> -       unsigned short keymap[ASUSEC_EXT_KEY_CODES * 2];
> -       const char *kbc_phys;
> -       bool special_key_pressed;
>         bool special_key_mode;
> -};
> -
> -static void asus_ec_input_event(struct input_handle *handle,
> -                               unsigned int event_type,
> -                               unsigned int event_code, int value)
> -{
> -       struct asus_ec_keys_data *priv =3D handle->handler->private;
> -
> -       /* Store special key state */
> -       if (event_type =3D=3D EV_KEY && event_code =3D=3D KEY_RIGHTALT)
> -               WRITE_ONCE(priv->special_key_pressed, !!value);
> -}
> -
> -static int asus_ec_input_connect(struct input_handler *handler,
> -                                struct input_dev *dev,
> -                                const struct input_device_id *id)
> -{
> -       struct asus_ec_keys_data *priv =3D handler->private;
> -       struct input_handle *handle;
> -       int error;
> -
> -       if (!dev->phys || !strstr(dev->phys, priv->kbc_phys))
> -               return -ENODEV;
> -
> -       handle =3D kzalloc_obj(*handle);
> -       if (!handle)
> -               return -ENOMEM;
> -
> -       handle->dev =3D dev;
> -       handle->handler =3D handler;
> -       handle->name =3D handler->name;
> -
> -       error =3D input_register_handle(handle);
> -       if (error)
> -               goto err_free_handle;
> -
> -       error =3D input_open_device(handle);
> -       if (error)
> -               goto err_unregister_handle;
> -
> -       return 0;
> -
> - err_unregister_handle:
> -       input_unregister_handle(handle);
> - err_free_handle:
> -       kfree(handle);
> -
> -       return error;
> -}
> -
> -static void asus_ec_input_disconnect(struct input_handle *handle)
> -{
> -       input_close_device(handle);
> -       input_unregister_handle(handle);
> -       kfree(handle);
> -}
> -
> -static const struct input_device_id asus_ec_input_ids[] =3D {
> -       {
> -               .flags =3D INPUT_DEVICE_ID_MATCH_EVBIT,
> -               .evbit =3D { BIT_MASK(EV_KEY) },
> -       },
> -       { }
> +       unsigned short keymap[ASUSEC_EXT_KEY_CODES * 2];
>  };
>
>  static const unsigned short asus_ec_dock_ext_keys[] =3D {
> @@ -138,17 +71,21 @@ static int asus_ec_keys_process_key(struct input_dev=
 *dev, u8 code)
>         if (code =3D=3D 0)
>                 return NOTIFY_DONE;
>
> -       /* Flip special key mode state when pressing SCREEN LOCK + R ALT =
*/
> -       if (READ_ONCE(priv->special_key_pressed) && code =3D=3D 1) {
> -               priv->special_key_mode =3D !priv->special_key_mode;
> -               return NOTIFY_DONE;
> +       if (priv->ec->right_alt_pressed) {
> +               priv->ec->special_combo_triggered =3D true;
> +
> +               /* Flip special key mode state when pressing SCREEN LOCK =
+ R ALT */
> +               if (code =3D=3D 1) {
> +                       priv->special_key_mode =3D !priv->special_key_mod=
e;
> +                       return NOTIFY_OK;
> +               }
>         }
>
>         /*
>          * Relocate code to second "page" if pressed state XOR's mode sta=
te
>          * This way special key will invert the current mode
>          */
> -       if (priv->special_key_mode ^ READ_ONCE(priv->special_key_pressed)=
)
> +       if (priv->special_key_mode ^ priv->ec->right_alt_pressed)
>                 code +=3D ASUSEC_EXT_KEY_CODES;
>
>         if (code < dev->keycodemax) {
> @@ -207,37 +144,6 @@ static void asus_ec_keys_setup_keymap(struct asus_ec=
_keys_data *priv)
>         }
>  }
>
> -static int asus_ec_keys_register_handler(struct device *dev,
> -                                        struct asus_ec_keys_data *priv)
> -{
> -       struct i2c_client *parent =3D to_i2c_client(dev->parent);
> -       int error;
> -
> -       priv->input_handler.event =3D asus_ec_input_event;
> -       priv->input_handler.connect =3D asus_ec_input_connect;
> -       priv->input_handler.disconnect =3D asus_ec_input_disconnect;
> -       priv->input_handler.id_table =3D asus_ec_input_ids;
> -       priv->input_handler.passive_observer =3D true;
> -       priv->input_handler.private =3D priv;
> -       priv->input_handler.name =3D devm_kasprintf(dev, GFP_KERNEL,
> -                                                 "%s-media-handler",
> -                                                 priv->ec->name);
> -       if (!priv->input_handler.name)
> -               return -ENOMEM;
> -
> -       priv->kbc_phys =3D devm_kasprintf(dev, GFP_KERNEL, "i2c-%u-%04x/s=
erio0",
> -                                       i2c_adapter_id(parent->adapter),
> -                                       parent->addr);
> -       if (!priv->kbc_phys)
> -               return -ENOMEM;
> -
> -       error =3D input_register_handler(&priv->input_handler);
> -       if (error)
> -               return error;
> -
> -       return 0;
> -}
> -
>  static int asus_ec_keys_probe(struct platform_device *pdev)
>  {
>         struct i2c_client *parent =3D to_i2c_client(pdev->dev.parent);
> @@ -273,17 +179,13 @@ static int asus_ec_keys_probe(struct platform_devic=
e *pdev)
>                 return dev_err_probe(dev, error,
>                                      "failed to register extension keys\n=
");
>
> -       error =3D asus_ec_keys_register_handler(dev, priv);
> -       if (error)
> -               return error;
> -
>         priv->nb.notifier_call =3D asus_ec_keys_notify;
>
>         error =3D blocking_notifier_chain_register(&ec->notify_list, &pri=
v->nb);
> -       if (error) {
> -               input_unregister_handler(&priv->input_handler);
> +       if (error)
>                 return error;
> -       }
> +
> +       ec->ext_keys_enabled =3D true;
>
>         return 0;
>  }
> @@ -293,8 +195,8 @@ static void asus_ec_keys_remove(struct platform_devic=
e *pdev)
>         struct asus_ec_keys_data *priv =3D platform_get_drvdata(pdev);
>         struct asusec_core *ec =3D priv->ec;
>
> +       ec->ext_keys_enabled =3D false;
>         blocking_notifier_chain_unregister(&ec->notify_list, &priv->nb);
> -       input_unregister_handler(&priv->input_handler);
>  }
>
>  static struct platform_driver asus_ec_keys_driver =3D {
> diff --git a/drivers/input/serio/asus-transformer-ec-kbc.c b/drivers/inpu=
t/serio/asus-transformer-ec-kbc.c
> index 62ffaf4d4371..0842158f13da 100644
> --- a/drivers/input/serio/asus-transformer-ec-kbc.c
> +++ b/drivers/input/serio/asus-transformer-ec-kbc.c
> @@ -13,8 +13,85 @@ struct asus_ec_kbc_data {
>         struct asusec_core *ec;
>         struct i2c_client *parent;
>         struct serio *sdev[2];
> +       bool altgr_delayed;
> +       bool altgr_suppressed;
>  };
>
> +static bool asus_ec_kbc_altgr_active(struct asus_ec_kbc_data *priv)
> +{
> +       return IS_ENABLED(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC) &&
> +              (priv->ec->ext_keys_enabled ||
> +               priv->altgr_delayed || priv->altgr_suppressed);
> +}
> +
> +static void asus_ec_kbc_reset_altgr(struct asus_ec_kbc_data *priv)
> +{
> +       if (!IS_ENABLED(CONFIG_KEYBOARD_ASUS_TRANSFORMER_EC))
> +               return;
> +
> +       priv->ec->right_alt_pressed =3D false;
> +       priv->ec->special_combo_triggered =3D false;
> +       priv->altgr_delayed =3D false;
> +       priv->altgr_suppressed =3D false;
> +}
> +
> +static void asus_ec_kbc_sync_altgr_combo(struct asus_ec_kbc_data *priv)
> +{
> +       if (priv->ec->special_combo_triggered) {
> +               priv->ec->special_combo_triggered =3D false;
> +               if (priv->altgr_delayed) {
> +                       priv->altgr_delayed =3D false;
> +                       priv->altgr_suppressed =3D true;
> +               }
> +       }
> +}
> +
> +static void asus_ec_kbc_flush_altgr(struct asus_ec_kbc_data *priv)
> +{
> +       if (!asus_ec_kbc_altgr_active(priv))
> +               return;
> +
> +       asus_ec_kbc_sync_altgr_combo(priv);
> +
> +       if (!priv->altgr_delayed)
> +               return;
> +
> +       serio_interrupt(priv->sdev[0], 0xe0, 0);
> +       serio_interrupt(priv->sdev[0], 0x11, 0);
> +
> +       priv->altgr_delayed =3D false;
> +}
> +
> +static bool asus_ec_kbc_handle_altgr(struct asus_ec_kbc_data *priv, bool=
 is_release)
> +{
> +       bool suppressed;
> +
> +       if (!asus_ec_kbc_altgr_active(priv)) {
> +               asus_ec_kbc_reset_altgr(priv);
> +               return false;
> +       }
> +
> +       asus_ec_kbc_sync_altgr_combo(priv);
> +
> +       if (!is_release) {
> +               if (!priv->ec->right_alt_pressed) {
> +                       asus_ec_kbc_reset_altgr(priv);
> +                       priv->ec->right_alt_pressed =3D true;
> +                       priv->altgr_delayed =3D true;
> +                       return true;
> +               }
> +
> +               return priv->altgr_delayed || priv->altgr_suppressed;
> +       }
> +
> +       suppressed =3D priv->altgr_suppressed;
> +       if (!suppressed)
> +               asus_ec_kbc_flush_altgr(priv);
> +
> +       asus_ec_kbc_reset_altgr(priv);
> +       return suppressed;
> +}
> +
>  static int asus_ec_kbc_notify(struct notifier_block *nb,
>                               unsigned long action, void *data_)
>  {
> @@ -22,14 +99,18 @@ static int asus_ec_kbc_notify(struct notifier_block *=
nb,
>         unsigned int port_idx, n;
>         u8 *data =3D data_;
>
> -       if (action & (ASUSEC_SMI_MASK | ASUSEC_SCI_MASK))
> +       if (action & (ASUSEC_SMI_MASK | ASUSEC_SCI_MASK)) {
> +               if (action =3D=3D ASUSEC_SMI_ACTION(HANDSHAKE) ||
> +                   action =3D=3D ASUSEC_SMI_ACTION(RESET))
> +                       asus_ec_kbc_reset_altgr(priv);
>                 return NOTIFY_DONE;
> -       else if (action & ASUSEC_AUX_MASK)
> +       } else if (action & ASUSEC_AUX_MASK) {
>                 port_idx =3D 1;
> -       else if (action & priv->ec->keyboard_mask)
> +       } else if (action & priv->ec->keyboard_mask) {
>                 port_idx =3D 0;
> -       else
> +       } else {
>                 return NOTIFY_DONE;
> +       }
>
>         /*
>          * The data[0] is the number of bytes following the count byte: o=
ne
> @@ -46,6 +127,7 @@ static int asus_ec_kbc_notify(struct notifier_block *n=
b,
>         if (port_idx =3D=3D 0) {
>                 /*
>                  * Remap keyboard key codes to match AT layout:
> +                * ALTGR:  RIGHT-ALT  [E0 11] -> delayed / suppressed
>                  * SEARCH: RIGHT-META [E0 27] -> LEFT-ALT   [11]
>                  * MENU:   COMPOSE    [E0 2F] -> RIGHT-META [E0 27]
>                  */
> @@ -53,6 +135,10 @@ static int asus_ec_kbc_notify(struct notifier_block *=
nb,
>                         u8 *keycode =3D &data[n - 1];
>
>                         switch (*keycode) {
> +                       case 0x11:
> +                               if (asus_ec_kbc_handle_altgr(priv, n =3D=
=3D 3))
> +                                       return NOTIFY_OK;
> +                               break;
>                         case 0x27:
>                                 *keycode =3D 0x11;
>                                 ++data;
> @@ -63,6 +149,15 @@ static int asus_ec_kbc_notify(struct notifier_block *=
nb,
>                                 break;
>                         }
>                 }
> +
> +               /*
> +                * Only flush delayed AltGr on key make events, ignoring
> +                * key break codes and PS/2 command responses (ACK, BAT, =
etc.).
> +                */
> +               if ((n =3D=3D 2 && data[0] =3D=3D 0xe0) ||
> +                   (n =3D=3D 1 && data[0] > 0 && data[0] < 0x84) ||
> +                   data[0] =3D=3D 0xe1)
> +                       asus_ec_kbc_flush_altgr(priv);
>         }
>
>         while (n--)
> diff --git a/include/linux/mfd/asus-transformer-ec.h b/include/linux/mfd/=
asus-transformer-ec.h
> index d09d3b70171e..fda6fb08cc41 100644
> --- a/include/linux/mfd/asus-transformer-ec.h
> +++ b/include/linux/mfd/asus-transformer-ec.h
> @@ -19,6 +19,9 @@ struct i2c_client;
>   * @dockram: pointer to Dockram's i2c_client
>   * @notify_list: notify list used by cells
>   * @keyboard_mask: mask of keyboard packets
> + * @ext_keys_enabled: true if extension keys driver is active
> + * @right_alt_pressed: state of Right Alt (AltGr) key
> + * @special_combo_triggered: true if AltGr + extension key combo was tri=
ggered
>   */
>  struct asusec_core {
>         const char *model;
> @@ -26,6 +29,9 @@ struct asusec_core {
>         struct i2c_client *dockram;
>         struct blocking_notifier_head notify_list;
>         u8 keyboard_mask;
> +       bool ext_keys_enabled;
> +       bool right_alt_pressed;
> +       bool special_combo_triggered;
>  };
>
>  /* interrupt sources */
>
> Thanks.
>
> --
> Dmitry

This looks very promising. Thank you for taking time and modelling
this code. I will test it thoroughly and if all goes well, incorporate
it into v12. If you want me to add any of your credentials let me know
or you can add them later on while v12 review.
