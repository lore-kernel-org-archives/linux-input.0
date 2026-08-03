Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67DA4334CA
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783945; cv=pass; b=W/GfLq1a+4co7FKB7Fu853143XTJJ4xKi5ucvURsVYJJI1b+7QpZdna6J/kAxqBYN6Dj4py5tRvYEJuiSt1VpSN1tU8WplxBWpZipbTqZ3LJRd507hCB+g36m7KI6kLLZwjGUcBmSkFku5lMdijE4jeo8Fy1UacSR9yVpZ+qGvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783945; c=relaxed/simple;
	bh=ZT6pSzYP+H9iL3YSohG1hxop+7t3tC5L5kMbAynAS6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OpHo8IqO4/Tn2+t9ZzE5Eqx9Q3lfwMwBF9YNnWQnVpPBtThfDKmQqPCR83aNs0MKPv/9mxBpjN0GMbk2MT9FWNeyYrjb39ndAYZk+8J3sj96+cozMTAH7POH1/VlOeyExi8ejrzRU8KbyccHhJLNPT21mWkk5tUdeZGf2kv7TuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8Q/yrnQ; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8Q/yrnQ"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c04bf4711so32749461cf.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 12:05:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785783942; cv=none;
        d=google.com; s=arc-20260327;
        b=KtifPWkVWgj7o0a3tm6tgUDKMbf8JoDAihg6flW7Gd31RwS/TzQQCiyHiFnq3fRcnG
         5EnX3SBD4+xHi21dAkHcy0kyJe+9Rsnbmck4QjG6jzwgt7aZ2MFrJh4NkR1m41fp9V07
         Gn/lPDAymUAKIYm2xkT25rdP3uNjRENgD9sHct6EPz+qsO55+k6MJgZdCYmyu/7ZAhK+
         PtN7Orp43X84kEgXO1ANySeuSGE+zT2WpXpAnPmUarGmPaBJRgi6FUDfx/Ob39UdDdnw
         AzPNuv3cjpPa6CGH3JQc+Mk0eHAYocFjoivBiFOC7lu1PyowI9CTQqjYI+91h0pHadcq
         Gn4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EFu014Uo8WD0iEVhGhlmHgrpRKsVtLL3Sq1QhtcnR+0=;
        fh=M80yPEHHPrjD7Z6Mf6Rubf1NjQKUPlJmmA2Oct7xZ8I=;
        b=q1fa0Z0sQVuAggnymynCi2ioxjlsf+rHLzv2+8VMlSiunxr230ygNd6WYBnuJxdKFG
         chbzXgvDJYwrWrkNlUTrh0k1eRy6XRRftg1sO1uEce45ZqCTFTahwvLLfNyCg4ahKuJI
         XNrqz6Tn/PfDFNVlVeX+E/eSFdOtxl57mUWX1vzxR00aa1Rl+x+F//qnt5HSCTKochKH
         K1tBcFV5k9guDcHXZUC0Vyggj0ZQx9lSJvfhpz6P68Iikbzx9nmYFnaTPAedevLaLZUB
         Y8fZbGeHemei2VdZdyCiaPVursSTotrzbRKEezX3lpPai2A/QZQfJhYkNDjh023fOYoL
         cNog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785783942; x=1786388742; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EFu014Uo8WD0iEVhGhlmHgrpRKsVtLL3Sq1QhtcnR+0=;
        b=I8Q/yrnQnfXdj6G8rK0J3ihnRbpR6qr+4oI6aG+MuTKe2Z5+0pj59WL5ASG4NW/dmf
         vf3iu5fakLIxedvInciv05GkZ63bJGcillHcEiEKBWzSVdj2Mra9c2jpHQLWAZ2iIyt5
         bBwl8K/8fJxciYFrQSccRYFfJPG3xwKHixjTgLOSRTeF1azsGW7eZVzfZ1rD4Efkr0kS
         04BOfXvKzGf7dQT04KZT67+cNq5YP1vZCoUM7fJQzjlXT/iFTIB74vS51ROF3BTJSPYX
         qPaI8dZ3dKJPHf9dMSqZ4GqEx6uWUvzsi3S6Wru6R/tzDDJY3oZVv146ah35xPp+dIh+
         FhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785783942; x=1786388742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EFu014Uo8WD0iEVhGhlmHgrpRKsVtLL3Sq1QhtcnR+0=;
        b=CaAYzb5RVKErdoTj2ak1+XXrikRWhqTzbsiKmMyZFs+NHkJeYC3MjUFSkMsOL0rKcC
         SjqFTE5E8UWCRpWjy6LHUpsN8Aiaojv2dEhahp+in3VbkDnZrdOjfGXanCbgMXSWcjLB
         vvSPmez21f7CS5clyw2nlEmSiWJm+UQUzfbpHgG1I4Et70fD/8O5hXEURlD2OKJzl0Ve
         sXxw3J4gD5NDQKjesNjipznu/4HpDc4xCpe5HPQUoXvHw8xF+C6PkjtjxM69YbhIKcfV
         pZH5USNBGyFA+WLpeNEGCeWctYt7w98bDw3sunhTOhoe2HVlR6MF3DNXULmEGvKLGotG
         KXqw==
X-Forwarded-Encrypted: i=1; AHgh+RoKnwgHY95rq9t7b7gR/efyummCxcq6S7TeoO3UOYG93aew3MHcbBgUCJhRtM1EzYLoJ3e2rqh2LKhpwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDITC0qWG1ycyyk3u/dT6oIaRVXk39fy7xXL5ekFWVoGfgBTZi
	cjTFKI7p5m710UUdn71yK1d9XRnwEPyG4/heauhwvdyJeumt0yqemJTwt7eJrH7vkY3F566JxKF
	33hWZtHGu2079pBzrVpwTn3hzE5RaM4h1g/SN
X-Gm-Gg: AR+sD13+K7fI3ntHZW/wgcVBB69o2c9qRQHVrgrPjWdoW1C/P93Byk9tqpF8XXKbNIZ
	sl0HkZSvPlQ9sAoIS7D7ZGCHpfHXo6DezaXeRRl3pkzin6GW4lqBebh631+t/3A509chVK9y+9b
	QV+t26lKFhybZLd+q5CxkFc3thxG4skiXyxE6TVI2Kx0ZA9nuZSBXRdjV0PBpiRJTR+tF3nI8fO
	ihfNLllO3N3OlPhqj6Kqi3SMyLbg4660XvJB44ljolrbA4GmCuZORUI+4PYDD1ASjZUZ5r72Vsb
	UrbuaBnN1bBNJNUM8Qcv1POHQNwElBtRb0BZ/WQurr82hw==
X-Received: by 2002:a05:622a:2b49:b0:52b:4f1a:5fde with SMTP id
 d75a77b69052e-52b566d23d1mr252790571cf.19.1785783942466; Mon, 03 Aug 2026
 12:05:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714180424.70662-1-k8ie@mcld.eu> <20260714184225.84646-1-k8ie@mcld.eu>
In-Reply-To: <20260714184225.84646-1-k8ie@mcld.eu>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Mon, 3 Aug 2026 12:05:31 -0700
X-Gm-Features: AUfX_my9-X3JzS5UwsAhKsgncZYVDT7iXuGLpKbAJpAGkXjcfrhIS_woxAC5sgc
Message-ID: <CAEc3jaD8epAdtS-ZGhH2Yk_82A2fp57LUeLzq3vapGVQX5d7eA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: playstation: Support DualSense player LED
 brightness control
To: k8ie <k8ie@mcld.eu>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kate=C5=99ina,

Thanks for sharing. I had an initial look and it could work (would
need to look in more detail). However, I do have some concerns as this
is a userspace change, though at first glance a minor one, but it has
major impact.

The problem is applications on Android use the LEDs. We did a lot of
work to expose these through the Android Lights framework and many
applications including major ones (e.g. PlayStation RemotePlay) use
it. So if we were to add this, applications would need to be changed
to deal with handling different values depending on the kernel
version, which wouldn't be fun and in practice is close to impossible
unfortunately.

Thanks,
Roderick

On Tue, Jul 14, 2026 at 11:45=E2=80=AFAM k8ie <k8ie@mcld.eu> wrote:
>
> From: Kate=C5=99ina Medv=C4=9Bdov=C3=A1 <k8ie@mcld.eu>
>
> The DualSense's 5 player indicator LEDs are currently only exposed as
> plain on/off LED classdevs (max_brightness =3D 1). The controller
> firmware also supports a global brightness level (high/medium/low)
> for whichever player LEDs are currently lit. The driver already
> defines the brightness byte but never uses it
> (dualsense_output_report_common::led_brightness).
>
> This patch wires up the controls for the brightness byte, allowing
> the player indicator brightness to be adjusted.
>
> Increase max_brightness of each player's LED classdev from 1 to 3.
>
> brightness =3D 0 still turns an LED off, writing brightness =3D 1..3
> turns the LED on and applies the brightness to all lit player LEDs.
> This is a hardware limitation and the driver reflects that by
> keeping the sysfs brightness of player LEDs in sync. The last
> brightness write wins.
>
> The firmware encoding is inverted (lower is brighter), so map LED
> core brightness values to the device-specific encoding before
> sending reports.
>
> Also set DS_OUTPUT_VALID_FLAG2_LED_BRIGHTNESS_CONTROL_ENABLE
> whenever player LED state is updated so firmware applies the
> brightness byte.
>
> Existing userspace that writes brightness=3D1 as a simple "on" value
> continues to work, but LEDs will now be lit at the lowest brightness
> instead of the highest brightness.
>
> Tested on a DualSense controller (product ID 0x0ce6) using Bluetooth
> and USB.
>
> Assisted-by: OpenCode:claude-sonnet-5
> Signed-off-by: Kate=C5=99ina Medv=C4=9Bdov=C3=A1 <k8ie@mcld.eu>
> ---
> First-time contributing a patch.
>
> v1 -> v2: Fixed a data race flagged by the list's automated review bot:
> dualsense_player_led_get_brightness() read player_leds_state and
> player_leds_brightness without holding ds->base.lock, while the setter
> updates both fields together under that lock. Now takes the same lock
> in the getter.
>
> The bot also flagged a pre-existing missing cancel_work_sync() in the
> dualsense_create()/dualshock4_create() error paths. That is unrelated
> to this change (present before this patch) and is intentionally left
> unfixed.
> ---
>  drivers/hid/hid-playstation.c | 50 +++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.=
c
> index f9dc9378cf77..58786117ec01 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -164,11 +164,20 @@ struct ps_led_info {
>  #define DS_OUTPUT_VALID_FLAG1_AUDIO_CONTROL2_ENABLE            BIT(7)
>  #define DS_OUTPUT_VALID_FLAG2_LIGHTBAR_SETUP_CONTROL_ENABLE    BIT(1)
>  #define DS_OUTPUT_VALID_FLAG2_COMPATIBLE_VIBRATION2            BIT(2)
> +#define DS_OUTPUT_VALID_FLAG2_LED_BRIGHTNESS_CONTROL_ENABLE    BIT(0)
>  #define DS_OUTPUT_AUDIO_FLAGS_OUTPUT_PATH_SEL                  GENMASK(5=
, 4)
>  #define DS_OUTPUT_AUDIO_FLAGS2_SP_PREAMP_GAIN                  GENMASK(2=
, 0)
>  #define DS_OUTPUT_POWER_SAVE_CONTROL_MIC_MUTE                  BIT(4)
>  #define DS_OUTPUT_LIGHTBAR_SETUP_LIGHT_OUT                     BIT(1)
>
> +/*
> + * Player LED brightness levels. Lower values are brighter; this is inve=
rted
> + * from the LED subsystem's convention where higher values mean brighter=
.
> + */
> +#define DS_OUTPUT_PLAYER_LED_BRIGHTNESS_HIGH                   0
> +#define DS_OUTPUT_PLAYER_LED_BRIGHTNESS_MEDIUM                 1
> +#define DS_OUTPUT_PLAYER_LED_BRIGHTNESS_LOW                    2
> +
>  /* DualSense hardware limits */
>  #define DS_ACC_RES_PER_G       8192
>  #define DS_ACC_RANGE           (4 * DS_ACC_RES_PER_G)
> @@ -225,6 +234,7 @@ struct dualsense {
>         /* Player leds */
>         bool update_player_leds;
>         u8 player_leds_state;
> +       u8 player_leds_brightness;
>         struct led_classdev player_leds[5];
>
>         struct work_struct output_worker;
> @@ -1219,12 +1229,24 @@ static int dualsense_lightbar_set_brightness(stru=
ct led_classdev *cdev,
>         return 0;
>  }
>
> +/*
> + * The DualSense's player LEDs only support a single, shared brightness =
level
> + * for all lit LEDs -- there is no per-LED brightness control. We still =
expose
> + * per-LED on/off state plus 3 brightness levels through each LED classd=
ev's
> + * max_brightness of 3; the last value written by any player LED classde=
v sets
> + * the shared level for all of them.
> + */
>  static enum led_brightness dualsense_player_led_get_brightness(struct le=
d_classdev *led)
>  {
>         struct hid_device *hdev =3D to_hid_device(led->dev->parent);
>         struct dualsense *ds =3D hid_get_drvdata(hdev);
>
> -       return !!(ds->player_leds_state & BIT(led - ds->player_leds));
> +       guard(spinlock_irqsave)(&ds->base.lock);
> +
> +       if (!(ds->player_leds_state & BIT(led - ds->player_leds)))
> +               return LED_OFF;
> +
> +       return DS_OUTPUT_PLAYER_LED_BRIGHTNESS_LOW + 1 - ds->player_leds_=
brightness;
>  }
>
>  static int dualsense_player_led_set_brightness(struct led_classdev *led,=
 enum led_brightness value)
> @@ -1235,10 +1257,18 @@ static int dualsense_player_led_set_brightness(st=
ruct led_classdev *led, enum le
>
>         scoped_guard(spinlock_irqsave, &ds->base.lock) {
>                 led_index =3D led - ds->player_leds;
> -               if (value =3D=3D LED_OFF)
> +               if (value =3D=3D LED_OFF) {
>                         ds->player_leds_state &=3D ~BIT(led_index);
> -               else
> +               } else {
>                         ds->player_leds_state |=3D BIT(led_index);
> +                       /* Convert Linux brightness (1=3Ddimmest) to firm=
ware
> +                        * scale (0=3Dbrightest), clamping to the valid r=
ange.
> +                        */
> +                       value =3D clamp_t(enum led_brightness, value, 1,
> +                                        DS_OUTPUT_PLAYER_LED_BRIGHTNESS_=
LOW + 1);
> +                       ds->player_leds_brightness =3D
> +                               DS_OUTPUT_PLAYER_LED_BRIGHTNESS_LOW + 1 -=
 value;
> +               }
>
>                 ds->update_player_leds =3D true;
>         }
> @@ -1355,6 +1385,10 @@ static void dualsense_output_worker(struct work_st=
ruct *work)
>                                 DS_OUTPUT_VALID_FLAG1_PLAYER_INDICATOR_CO=
NTROL_ENABLE;
>                         common->player_leds =3D ds->player_leds_state;
>
> +                       common->valid_flag2 |=3D
> +                               DS_OUTPUT_VALID_FLAG2_LED_BRIGHTNESS_CONT=
ROL_ENABLE;
> +                       common->led_brightness =3D ds->player_leds_bright=
ness;
> +
>                         ds->update_player_leds =3D false;
>                 }
>
> @@ -1742,15 +1776,15 @@ static struct ps_device *dualsense_create(struct =
hid_device *hdev)
>         int i, ret;
>
>         static const struct ps_led_info player_leds_info[] =3D {
> -               { LED_FUNCTION_PLAYER1, "white", 1, dualsense_player_led_=
get_brightness,
> +               { LED_FUNCTION_PLAYER1, "white", 3, dualsense_player_led_=
get_brightness,
>                                 dualsense_player_led_set_brightness },
> -               { LED_FUNCTION_PLAYER2, "white", 1, dualsense_player_led_=
get_brightness,
> +               { LED_FUNCTION_PLAYER2, "white", 3, dualsense_player_led_=
get_brightness,
>                                 dualsense_player_led_set_brightness },
> -               { LED_FUNCTION_PLAYER3, "white", 1, dualsense_player_led_=
get_brightness,
> +               { LED_FUNCTION_PLAYER3, "white", 3, dualsense_player_led_=
get_brightness,
>                                 dualsense_player_led_set_brightness },
> -               { LED_FUNCTION_PLAYER4, "white", 1, dualsense_player_led_=
get_brightness,
> +               { LED_FUNCTION_PLAYER4, "white", 3, dualsense_player_led_=
get_brightness,
>                                 dualsense_player_led_set_brightness },
> -               { LED_FUNCTION_PLAYER5, "white", 1, dualsense_player_led_=
get_brightness,
> +               { LED_FUNCTION_PLAYER5, "white", 3, dualsense_player_led_=
get_brightness,
>                                 dualsense_player_led_set_brightness }
>         };
>
> --
> 2.55.0
>
>
