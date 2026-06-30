Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506B72E739D
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862048; cv=pass; b=u42txk4IBvGeXUOpLXcCMiRFTrzFfHwLD81DLgNB0k8pDzoiT9Fw/AnFipeC21R+OA8mcV3cnSYI2BLclSnI7iXyD0V6PxkbreT/yPUuEJEyOaRZx5UBi509NRACXFgX/0GHpzYjIDRWdDKs/YAK09vKeu8AIQXZZDBGnfQEvcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862048; c=relaxed/simple;
	bh=tpubwOyecb4lozfaBc4agd3BhdlByYSOuu/UnImgf3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rIEohZRUa5Fd+Kqw5xRBvrBFPAsQmcU27glGiLfocpmP82hcEt07t2YGBUtI9iIdF/dxw12L4I5LvytN1uCwRJxogtOI8Dk0EUDZgaWoNb8TAX3ihC9ZkckDbDJ+VFk2AqUyJOM5fbNNmotHv0ZCZL0Kcxan/isKuDTh99qgIjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg4hM2dr; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg4hM2dr"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ef7b7651ecso13179976d6.1
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 16:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782862045; cv=none;
        d=google.com; s=arc-20260327;
        b=eBJnaA4souTKk+q25Cn1qwv6tEI6EiY1kmWne7N3930lbPYbF622Jz6/9B3T66CE/e
         Ji0oIHBnwwT208Q+mDkz72UcSsWif+1uvJ7LPtrZY5yDAhk2d5uJe0JKWl2K4Qr4n5cj
         x47aEf1Xbbp+ERRaAunPL/Hjr3V4hxgSMWhbExH+69gAdue8d3fiOT8JKWsVxUOBlm9q
         Ysl9zjwD6Ycc07co7fRqrenh6b8ZVp9AkPhf6dh4nnz83/21t7YG89X0LaS475JDPQQx
         IlNWH4PJcdQjz+IaFyO/w9BS0vVxOHXooCVOcF/MgfIharepoX/+eA0zdjD0pd04yDP1
         4zGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t7uYfJX2fhnOrgnNyrsmaZOyE4hn5UDR0CCwKlV96AM=;
        fh=CdHhzNMNQWWwJMmwE9tKsF2Nk/aym6ccG2+5gNb+mas=;
        b=a6QHNQ2TTua6QRItbfgHqQ6ciGZLJxLxS8ci1G2JIBA1fUyZgZEZJS/ZaeI+i3arrM
         iREWY8WCncr7JwguRCuMo07uEn1eem2r/W2jk+BShFglBaM8/cUxKW/OewQI4/UVl8YQ
         XdJXJgRDxmQ4GthtC21lzYdvvoT3jKclHbudw8N8ZrFbQsoVDriEYKVL/KHqCiF8sXJD
         oOkm9j6vNIQsmqzeJ6NRwRrErG68EMT7oXzOY4BN9dFfGL94nHT6rLs+IguWPNKTwpJv
         kJcjyH6YCllIt6b9NsKF6diSnw4X45pgNkJ85YyGtUJqYnKxcadxEBOiQFax2HS5yvZS
         HP0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782862045; x=1783466845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7uYfJX2fhnOrgnNyrsmaZOyE4hn5UDR0CCwKlV96AM=;
        b=lg4hM2drJK/H8JEcZRM9fXIzmwW1qFMmGbOo9ljCfdSFN8j/iZBheuXyVY6E1x7TfI
         19sFwny6H6CLeeir+pRMnUALYQtaeEI5kdeIn8Iv4otO/0MOB2DXH9Ad7A76Di4UdtjM
         EiSUvtAejkP0o7JXmvG440SwAGR4qlwP8pI3foW354x6ZWkj6FXDHNjxpe0edxT1QENy
         PybKvAO7A9DaT/a2XunV1lWTavoEkXAOROjqp7V8Gp0ZgURhsNm/27zkYDVXucBZrp3r
         wiveCLxnjwwrvIUrHcqv/Z/mDOHzUZxb8U7TUv+S/tKo37zebMISo3m45oK2RmSQKvKK
         vd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782862045; x=1783466845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7uYfJX2fhnOrgnNyrsmaZOyE4hn5UDR0CCwKlV96AM=;
        b=iIZH0ETtliBlR68AeXmQy7ZFAyAMovdm2W5wS+w3D8DTWHjmTqpky5LuGCO9hv3tlj
         qU6aF96KhTR6e3vVublPpY5rQlVdkl80V/CE85jkz87nxr8D8BwEqzvILiQ27Wc5k5Lv
         0JZfYPl2cDk3yqwvFNn6mR04ppOUwY4eSChUkjeJVcrTH2G+to+QtJiuz+FBvNHQfzfF
         Y+czdHrrXaMcez3+BBaLOezAOmUXQJ4vchRferzQtoy875BrnAqAgUaZM7OngbXWEdqU
         F8SdF9NUpo0CxChXK4Fb+zISkyLuH4PbT6huO1dV9e6gEYJz3DC5x53WLQdcBD5ka2R5
         hNWQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+WLY4vnGbwYByFuvhS8hoZw8RfVQMlImkUbzoWCu0f/xWWsvYXQC0/A5TEU+DyiUsDc7wTkCIqWnBdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWAnOLrFh7rABPfXOKZG3qNRUARSgPBqn7M2ZVt7Yue/NFvhRP
	HhsgE3fCPEtopNaljTFOIWyqQUOMK0sDdOb8KZN4EZYWU4C24E+taiY5UZXwioIBVNDpMxOdjwa
	9SXvmxuy4ZGEgepfGIaOHW6kijHWBCvE=
X-Gm-Gg: AfdE7cmxyatPYpgghUazVH/zEOF1/M7geHp2hSNXnBAQMGbvsN/HH1eF1Pi6e9/CSId
	IMCRUuZBTm1b3V0MjrfeYYupDjl3CDBMJC1SG1afVYpP1kvip0Xl5NQxoHH5VUCJA+Dq8HbZmGB
	aceePan7v8EJHiBj60RY5gllD8dyX8nlkDw6dnpSIIexa4w4MXQENm7rv4X3aRbnD028aj8k8Zy
	swxMC3tCCQmtjVz+xwuKkdU/4U4xDCdxWm0lOISmVIjf21T0AM72GetLWm9LN0NGWtVaYwOHw==
X-Received: by 2002:a05:6214:478e:b0:8ef:1840:2bd8 with SMTP id
 6a1803df08f44-8f2551a4c92mr50269016d6.33.1782862045205; Tue, 30 Jun 2026
 16:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616092658.1714548-1-lee@kernel.org>
In-Reply-To: <20260616092658.1714548-1-lee@kernel.org>
From: Jason Gerecke <killertofu@gmail.com>
Date: Tue, 30 Jun 2026 16:27:14 -0700
X-Gm-Features: AVVi8CcDkMTUBMT3DiWgtMCXxQDbsxuWxb-Hh47fRev8O13h8hEBZFk-gGd9-2c
Message-ID: <CANRwn3SCQ58hLg00NU844nNxR2B5+f6UvuOYRgXR3x6q96FSgw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] HID: wacom: Fix Use-After-Free in wacom_intuos_pad
To: Lee Jones <lee@kernel.org>
Cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm still working on testing and reviewing this set as a whole, but I
can provide some immediate feedback on this first patch at least:

On Tue, Jun 16, 2026 at 2:29=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> wacom_intuos_pad() accesses wacom->shared->touch_input locklessly
> inside the interrupt handler context.  If the Touch sibling device
> is disconnected, wacom_remove_shared_data() clears 'touch_input'
> outside any lock, creating a Time-of-Check to Time-of-Use (TOCTOU)
> race condition where a preempted reader in interrupt context
> dereferences the freed pointer, leading to a Use-After-Free.
>
> Resolve this by introducing RCU protection for the touch_input
> pointer:
>
>  - Annotate 'touch_input' in wacom_shared struct with __rcu
>  - Wrap all lockless readers in wacom_wac.c with rcu_read_lock() and
>    rcu_dereference() using a unified wacom_report_touch_mute()
>    helper
>  - Update writers in wacom_sys.c using rcu_assign_pointer()
>  - Call synchronize_rcu() in wacom_remove_shared_data() to ensure
>    all active RCU readers have finished before the input device is
>    freed
>
> Also wrap wacom_set_shared_values() and touch/pen assignments in
> wacom_add_shared_data() inside the wacom_udev_list_lock to serialize
> concurrent probe assignments, and verify that 'shared->touch =3D=3D hdev'
> before setting touch_input to prevent concurrent sibling probe state
> desynchronization.
>
> Finally, advertise the SW_MUTE_DEVICE capability on Touch input
> devices prior to registration in wacom_setup_touch_input_capabilities()
> to prevent invalid post-registration capability modifications.
>

It seems like this patch can be split into at least two different
patches, maybe even three. The changes to
wacom_setup_touch_input_capabilities() especially feel like they could
be seperate from the introduction of RCU for shared->touch_input.

> Fixes: 961794a00eab ("Input: wacom - add reporting of SW_MUTE_DEVICE even=
ts")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>
> v1 -> v2: Split and use RCU as per Dmitry's review
> v2 -> v3: Sashiko fixes
> v3 -> v4: Dmitry's review [redundant check and guard()]
>
>  drivers/hid/wacom_sys.c | 41 ++++++++++++++-----------
>  drivers/hid/wacom_wac.c | 66 +++++++++++++++++++++--------------------
>  drivers/hid/wacom_wac.h |  2 +-
>  3 files changed, 58 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> index 2220168bf116..86895f13dbae 100644
> --- a/drivers/hid/wacom_sys.c
> +++ b/drivers/hid/wacom_sys.c
> @@ -877,10 +877,16 @@ static void wacom_remove_shared_data(void *res)
>                 data =3D container_of(wacom_wac->shared, struct wacom_hde=
v_data,
>                                     shared);
>
> -               if (wacom_wac->shared->touch =3D=3D wacom->hdev)
> -                       wacom_wac->shared->touch =3D NULL;
> -               else if (wacom_wac->shared->pen =3D=3D wacom->hdev)
> -                       wacom_wac->shared->pen =3D NULL;
> +               scoped_guard(mutex, &wacom_udev_list_lock) {
> +                       if (wacom_wac->shared->touch =3D=3D wacom->hdev) =
{
> +                               wacom_wac->shared->touch =3D NULL;
> +                               rcu_assign_pointer(wacom_wac->shared->tou=
ch_input, NULL);
> +                       } else if (wacom_wac->shared->pen =3D=3D wacom->h=
dev) {
> +                               wacom_wac->shared->pen =3D NULL;
> +                       }
> +               }
> +
> +               synchronize_rcu();
>
>                 kref_put(&data->kref, wacom_release_shared_data);
>                 wacom_wac->shared =3D NULL;
> @@ -909,6 +915,11 @@ static int wacom_add_shared_data(struct hid_device *=
hdev)
>                 list_add_tail(&data->list, &wacom_udev_list);
>         }
>
> +       if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
> +               data->shared.touch =3D hdev;
> +       else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
> +               data->shared.pen =3D hdev;
> +
>         mutex_unlock(&wacom_udev_list_lock);
>
>         wacom_wac->shared =3D &data->shared;
> @@ -917,11 +928,6 @@ static int wacom_add_shared_data(struct hid_device *=
hdev)
>         if (retval)
>                 return retval;
>
> -       if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH)
> -               wacom_wac->shared->touch =3D hdev;
> -       else if (wacom_wac->features.device_type & WACOM_DEVICETYPE_PEN)
> -               wacom_wac->shared->pen =3D hdev;
> -
>         return retval;
>  }
>
> @@ -2345,9 +2351,15 @@ static void wacom_release_resources(struct wacom *=
wacom)
>
>  static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
>  {
> +       struct wacom *wacom =3D container_of(wacom_wac, struct wacom, wac=
om_wac);
> +
> +       guard(mutex)(&wacom_udev_list_lock);
> +
>         if (wacom_wac->features.device_type & WACOM_DEVICETYPE_TOUCH) {
> -               wacom_wac->shared->type =3D wacom_wac->features.type;
> -               wacom_wac->shared->touch_input =3D wacom_wac->touch_input=
;
> +               if (wacom_wac->shared->touch =3D=3D wacom->hdev) {
> +                       wacom_wac->shared->type =3D wacom_wac->features.t=
ype;
> +                       rcu_assign_pointer(wacom_wac->shared->touch_input=
, wacom_wac->touch_input);
> +               }
>         }
>
>         if (wacom_wac->has_mute_touch_switch) {
> @@ -2360,13 +2372,6 @@ static void wacom_set_shared_values(struct wacom_w=
ac *wacom_wac)
>                 if (wacom_wac->is_soft_touch_switch)
>                         wacom_wac->shared->is_touch_on =3D true;
>         }
> -
> -       if (wacom_wac->shared->has_mute_touch_switch &&
> -           wacom_wac->shared->touch_input) {
> -               set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> -               input_set_capability(wacom_wac->shared->touch_input, EV_S=
W,
> -                                    SW_MUTE_DEVICE);
> -       }
>  }
>
>  static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index da1f0ea85625..23eaa81cd827 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -510,6 +510,18 @@ static void wacom_intuos_schedule_prox_event(struct =
wacom_wac *wacom_wac)
>         }
>  }
>
> +static void wacom_report_touch_mute(struct wacom_wac *wacom_wac, bool mu=
te)
> +{
> +       struct input_dev *touch_input;
> +
> +       guard(rcu)();
> +       touch_input =3D rcu_dereference(wacom_wac->shared->touch_input);
> +       if (touch_input) {
> +               input_report_switch(touch_input, SW_MUTE_DEVICE, mute);
> +               input_sync(touch_input);
> +       }
> +}
> +
>  static int wacom_intuos_pad(struct wacom_wac *wacom)
>  {
>         struct wacom_features *features =3D &wacom->features;
> @@ -650,12 +662,8 @@ static int wacom_intuos_pad(struct wacom_wac *wacom)
>         input_report_key(input, KEY_CONTROLPANEL, menu);
>         input_report_key(input, KEY_INFO, info);
>
> -       if (wacom->shared && wacom->shared->touch_input) {
> -               input_report_switch(wacom->shared->touch_input,
> -                                   SW_MUTE_DEVICE,
> -                                   !wacom->shared->is_touch_on);
> -               input_sync(wacom->shared->touch_input);
> -       }
> +       if (wacom->shared)
> +               wacom_report_touch_mute(wacom, !wacom->shared->is_touch_o=
n);
>
>         input_report_abs(input, ABS_RX, strip1);
>         input_report_abs(input, ABS_RY, strip2);
> @@ -2153,7 +2161,7 @@ static void wacom_wac_pad_event(struct hid_device *=
hdev, struct hid_field *field
>          */
>         if ((equivalent_usage =3D=3D WACOM_HID_WD_MUTE_DEVICE) ||
>            (equivalent_usage =3D=3D WACOM_HID_WD_TOUCHONOFF)) {
> -               if (wacom_wac->shared->touch_input) {
> +               if (wacom_wac->shared) {
>                         bool *is_touch_on =3D &wacom_wac->shared->is_touc=
h_on;
>
>                         if (equivalent_usage =3D=3D WACOM_HID_WD_MUTE_DEV=
ICE && value)
> @@ -2161,9 +2169,7 @@ static void wacom_wac_pad_event(struct hid_device *=
hdev, struct hid_field *field
>                         else if (equivalent_usage =3D=3D WACOM_HID_WD_TOU=
CHONOFF)
>                                 *is_touch_on =3D value;
>
> -                       input_report_switch(wacom_wac->shared->touch_inpu=
t,
> -                                           SW_MUTE_DEVICE, !(*is_touch_o=
n));
> -                       input_sync(wacom_wac->shared->touch_input);
> +                       wacom_report_touch_mute(wacom_wac, !(*is_touch_on=
));
>                 }
>                 return;
>         }
> @@ -3381,11 +3387,8 @@ static int wacom_wireless_irq(struct wacom_wac *wa=
com, size_t len)
>
>                 if ((wacom->shared->type =3D=3D INTUOSHT ||
>                     wacom->shared->type =3D=3D INTUOSHT2) &&
> -                   wacom->shared->touch_input &&
>                     wacom->shared->touch_max) {
> -                       input_report_switch(wacom->shared->touch_input,
> -                                       SW_MUTE_DEVICE, data[5] & 0x40);
> -                       input_sync(wacom->shared->touch_input);
> +                       wacom_report_touch_mute(wacom, data[5] & 0x40);
>                 }
>
>                 pid =3D get_unaligned_be16(&data[6]);
> @@ -3420,11 +3423,8 @@ static int wacom_status_irq(struct wacom_wac *waco=
m_wac, size_t len)
>
>         if ((features->type =3D=3D INTUOSHT ||
>             features->type =3D=3D INTUOSHT2) &&
> -           wacom_wac->shared->touch_input &&
>             features->touch_max) {
> -               input_report_switch(wacom_wac->shared->touch_input,
> -                                   SW_MUTE_DEVICE, data[8] & 0x40);
> -               input_sync(wacom_wac->shared->touch_input);
> +               wacom_report_touch_mute(wacom_wac, data[8] & 0x40);
>         }
>
>         if (data[9] & 0x02) { /* wireless module is attached */
> @@ -3951,11 +3951,22 @@ int wacom_setup_pen_input_capabilities(struct inp=
ut_dev *input_dev,
>  int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
>                                          struct wacom_wac *wacom_wac)
>  {
> +       struct wacom *wacom =3D container_of(wacom_wac, struct wacom, wac=
om_wac);
> +       struct hid_device *hdev =3D wacom->hdev;
>         struct wacom_features *features =3D &wacom_wac->features;
>
>         if (!(features->device_type & WACOM_DEVICETYPE_TOUCH))
>                 return -ENODEV;
>
> +       if (features->type !=3D TABLETPC &&
> +           features->type !=3D TABLETPC2FG &&
> +           features->type !=3D MTSCREEN &&
> +           features->type !=3D MTTPC &&
> +           features->type !=3D MTTPC_B) {
> +               input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> +               __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> +       }
> +

1. This if statement is missing a number of cases. INTUOS5, for
example (and among others) is missing and would incorrectly gain
SW_MUTE_DEVICE. The list of cases from the big switch below needs to
be consulted again.

2. It seems like this would result in SW_MUTE_DEVICE being given to
all HID_GENERIC touch devices. It should only be added in the case
that `wacom_wac->has_mute_touch_switch` is true, however.

3. I'm not sure why we're even bothering with moving all of the
initialization for SW_MUTE_DEVICE from the individual cases out to a
single awkward if statement. The only thing I can think of is that
HID_GENERIC devices need to have it set (when appropriate) now that
the responsibility has been removed from wacom_set_shared_values(). It
should be much cleaner, however, to simply add the SW_MUTE_DEVICE
setup for HID_GENERIC devices right before the function returns early
for them.

>         if (features->device_type & WACOM_DEVICETYPE_DIRECT)
>                 __set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
>         else
> @@ -3992,22 +4003,17 @@ int wacom_setup_touch_input_capabilities(struct i=
nput_dev *input_dev,
>         switch (features->type) {
>         case INTUOSP2_BT:
>         case INTUOSP2S_BT:
> -               input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> -               __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> -
> -               if (wacom_wac->shared->touch->product =3D=3D 0x361) {
> +               if (hdev->product =3D=3D 0x361) {
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
>                                              0, 12440, 4, 0);
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
>                                              0, 8640, 4, 0);
> -               }
> -               else if (wacom_wac->shared->touch->product =3D=3D 0x360) =
{
> +               } else if (hdev->product =3D=3D 0x360) {
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
>                                              0, 8960, 4, 0);
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
>                                              0, 5920, 4, 0);
> -               }
> -               else if (wacom_wac->shared->touch->product =3D=3D 0x393) =
{
> +               } else if (hdev->product =3D=3D 0x393) {
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_X=
,
>                                              0, 6400, 4, 0);
>                         input_set_abs_params(input_dev, ABS_MT_POSITION_Y=
,
> @@ -4037,10 +4043,8 @@ int wacom_setup_touch_input_capabilities(struct in=
put_dev *input_dev,
>                 fallthrough;
>
>         case WACOM_27QHDT:
> -               if (wacom_wac->shared->touch->product =3D=3D 0x32C ||
> -                   wacom_wac->shared->touch->product =3D=3D 0xF6) {
> -                       input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> -                       __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
> +               if (hdev->product =3D=3D 0x32C ||
> +                   hdev->product =3D=3D 0xF6) {
>                         wacom_wac->has_mute_touch_switch =3D true;
>                         wacom_wac->is_soft_touch_switch =3D true;
>                 }
> @@ -4059,8 +4063,6 @@ int wacom_setup_touch_input_capabilities(struct inp=
ut_dev *input_dev,
>
>         case INTUOSHT:
>         case INTUOSHT2:
> -               input_dev->evbit[0] |=3D BIT_MASK(EV_SW);
> -               __set_bit(SW_MUTE_DEVICE, input_dev->swbit);
>                 fallthrough;
>
>         case BAMBOO_PT:
> diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
> index 126bec6e5c0c..a8bbba4a6f37 100644
> --- a/drivers/hid/wacom_wac.h
> +++ b/drivers/hid/wacom_wac.h
> @@ -285,7 +285,7 @@ struct wacom_shared {
>         /* for wireless device to access USB interfaces */
>         unsigned touch_max;
>         int type;
> -       struct input_dev *touch_input;
> +       struct input_dev __rcu *touch_input;
>         struct hid_device *pen;
>         struct hid_device *touch;
>         bool has_mute_touch_switch;
> --
> 2.54.0.1136.gdb2ca164c4-goog
>
>
