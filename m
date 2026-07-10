Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7959043B497
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 16:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701661; cv=none; b=V3345ambhAEDwuraLqnB2CpRoyM0sq7tNNievCDnIstIVSwSNIzj/5ZCRpGnEeLtoXtZfzFWamcrQamuU1SiFwz4AiO01Jm44wMKAd8f2gKck7AY1fAvFA6lPQhIfRYwzHuPsZ+rVnY0UnBVP06/aseUaHNXUerSXqH4/Kiai1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701661; c=relaxed/simple;
	bh=e5O2b6C71wcPiCY6rEP1Hn4YORiBBbskyWQJ77IquFs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXV9blYSoZpe2q0MZYemTR9omSLM3+t7MuebI6wKhae3qTLsQei4EF2Baox4/o+YaOFCC4WpiO8S7GHg5pNGlsA+M45QhOeF0Op/KjTr4NTwyKdzwLIpjv8/wVYI9xuj13nRvNodIJD/RklktEJcXHM2YMLZeGH8hJhXhBRsjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aXRyqqNM; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aXRyqqNM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=dn6eigg6gjagdof6gmtc6cy4ba.protonmail; t=1783701643; x=1783960843;
	bh=hhhh8DjR/zv424fGl849UJsyOWnmGvcISGF7g+NM4WU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aXRyqqNMYZPExutX10pO6OIBM6uIuCEZLCCJCt2LCD2cy55f1LdKGMrQl9wFJJniC
	 tprfUJv+H+7/oJHI6gynFdXcsrfy0puyiNf25GkM/QhP3F5+O0U81ZRQK/g0EFxsyg
	 KuCmRcT2gdjCCSqsU7aQ9WbVlczrV+vQZ1LaLXcaEP13+vRFegZk2n0JMjR7b3AGgH
	 AE8mxF/b0OiJRjW16sQITYAOhnpBfN/YS1su+cCWta9FN3fFDitwNVJ52AB3ybOkAj
	 y4WX0TnFAjYfRWE3Cx7WBoXWoxmgGIV95ZVzxbXqcIfumwbmkI77e6vH2WnfQ/NRrc
	 eA4y2DyQvHB0g==
Date: Fri, 10 Jul 2026 16:40:41 +0000
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
From: Aditya Garg <gargaditya08@proton.me>
Cc: Linux Input Mailing List <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 RESEND] HID: appletb-kbd: add option to switch default layer on double pressing fn key
Message-ID: <n48DZhno8kzGymS5ySlQqP5oFf5STmmRMZC8wlY_nEERARZDk5DMe9spbXLyrCbCqBjQ95hb3qr8NeFNH4LZoWwoGwfUiSmG9ifWXmSnzD4=@proton.me>
In-Reply-To: <20260620112635.17246-1-gargaditya08@proton.me>
References: <20260620112635.17246-1-gargaditya08@proton.me>
Feedback-ID: 145777226:user:proton
X-Pm-Message-ID: 86a6e7cee0bd197a88bc20da61cb0c91ab5cad9d
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jiri

Can I have an update on this?

On Saturday, 20 June 2026 at 4:56 PM, Aditya Garg <gargaditya08@proton.me> =
wrote:

> From: Aditya Garg <gargaditya08@proton.me>
>=20
> This patch enables a user to switch the default layer from media to fn
> keys and vice-versa upon double pressing the fn key. This behaviour can
> be configured using the double_press_switch_time module parameter whose
> value depicts the time in milliseconds within which the fn key must be
> pressed again to switch the default layer. If set to 0, it simply
> disables this behaviour.
>=20
> Signed-off-by: Aditya Garg <gargaditya08@proton.me>
> ---
>=20
> v2: added a check to ensure negative fn switch times are ignored.
>=20
>  drivers/hid/hid-appletb-kbd.c | 60 +++++++++++++++++++++++++++++++----
>  1 file changed, 53 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.=
c
> index 462010a75899..34bfc595949d 100644
> --- a/drivers/hid/hid-appletb-kbd.c
> +++ b/drivers/hid/hid-appletb-kbd.c
> @@ -56,6 +56,12 @@ static int appletb_tb_idle_timeout =3D 15;
>  module_param_named(idle_timeout, appletb_tb_idle_timeout, int, 0644);
>  MODULE_PARM_DESC(idle_timeout, "Idle timeout in sec");
> =20
> +static int appletb_tb_double_press_switch_layers;
> +module_param_named(double_press_switch_time,
> +=09=09   appletb_tb_double_press_switch_layers, int, 0644);
> +MODULE_PARM_DESC(double_press_switch_time, "Time in ms within which if f=
n key is double "
> +=09=09=09=09=09   "pressed will switch layers");
> +
>  struct appletb_kbd {
>  =09struct hid_field *mode_field;
>  =09struct input_handler inp_handler;
> @@ -68,6 +74,7 @@ struct appletb_kbd {
>  =09bool has_turned_off;
>  =09u8 saved_mode;
>  =09u8 current_mode;
> +=09unsigned long last_fn_press;
>  };
> =20
>  static const struct key_entry appletb_kbd_keymap[] =3D {
> @@ -243,6 +250,18 @@ static int appletb_kbd_hid_event(struct hid_device *=
hdev, struct hid_field *fiel
>  =09return kbd->current_mode =3D=3D APPLETB_KBD_MODE_OFF;
>  }
> =20
> +static u8 appletb_switch_mode(u8 mode)
> +{
> +=09switch (mode) {
> +=09case APPLETB_KBD_MODE_SPCL:
> +=09=09return APPLETB_KBD_MODE_FN;
> +=09case APPLETB_KBD_MODE_FN:
> +=09=09return APPLETB_KBD_MODE_SPCL;
> +=09default:
> +=09=09return mode;
> +=09}
> +}
> +
>  static void appletb_kbd_inp_event(struct input_handle *handle, unsigned =
int type,
>  =09=09=09      unsigned int code, int value)
>  {
> @@ -250,15 +269,42 @@ static void appletb_kbd_inp_event(struct input_hand=
le *handle, unsigned int type
> =20
>  =09reset_inactivity_timer(kbd);
> =20
> -=09if (type =3D=3D EV_KEY && code =3D=3D KEY_FN && appletb_tb_fn_toggle =
&&
> -=09=09(kbd->current_mode =3D=3D APPLETB_KBD_MODE_SPCL ||
> -=09=09 kbd->current_mode =3D=3D APPLETB_KBD_MODE_FN)) {
> +=09if (type =3D=3D EV_KEY && code =3D=3D KEY_FN &&
> +=09    (kbd->current_mode =3D=3D APPLETB_KBD_MODE_SPCL ||
> +=09     kbd->current_mode =3D=3D APPLETB_KBD_MODE_FN)) {
> +
>  =09=09if (value =3D=3D 1) {
> -=09=09=09kbd->saved_mode =3D kbd->current_mode;
> -=09=09=09appletb_kbd_set_mode(kbd, kbd->current_mode =3D=3D APPLETB_KBD_=
MODE_SPCL
> -=09=09=09=09=09=09? APPLETB_KBD_MODE_FN : APPLETB_KBD_MODE_SPCL);
> +=09=09=09if (appletb_tb_double_press_switch_layers > 0) {
> +=09=09=09=09unsigned long now =3D jiffies;
> +
> +=09=09=09=09if (time_before(now, kbd->last_fn_press +
> +=09=09=09=09=09msecs_to_jiffies(appletb_tb_double_press_switch_layers)))=
 {
> +
> +=09=09=09=09=09appletb_tb_def_mode =3D
> +=09=09=09=09=09=09appletb_switch_mode(
> +=09=09=09=09=09=09=09appletb_tb_def_mode);
> +
> +=09=09=09=09=09appletb_kbd_set_mode(kbd,
> +=09=09=09=09=09=09appletb_tb_def_mode);
> +
> +=09=09=09=09=09kbd->saved_mode =3D appletb_tb_def_mode;
> +=09=09=09=09=09kbd->last_fn_press =3D 0;
> +
> +=09=09=09=09=09return;
> +=09=09=09=09}
> +
> +=09=09=09=09kbd->last_fn_press =3D now;
> +=09=09=09}
> +=09=09=09if (appletb_tb_fn_toggle) {
> +=09=09=09=09kbd->saved_mode =3D kbd->current_mode;
> +
> +=09=09=09=09appletb_kbd_set_mode(kbd,
> +=09=09=09=09=09appletb_switch_mode(kbd->current_mode));
> +=09=09=09}
> +
>  =09=09} else if (value =3D=3D 0) {
> -=09=09=09if (kbd->saved_mode !=3D kbd->current_mode)
> +=09=09=09if (appletb_tb_fn_toggle &&
> +=09=09=09    kbd->saved_mode !=3D kbd->current_mode)
>  =09=09=09=09appletb_kbd_set_mode(kbd, kbd->saved_mode);
>  =09=09}
>  =09}
>=20
> Range-diff against v1:
> 1:  5c9d8c8ba8c0 ! 1:  4f6a818b98b9 HID: appletb-kbd: add option to switc=
h default layer on double pressing fn key
>     @@ drivers/hid/hid-appletb-kbd.c: static void appletb_kbd_inp_event(s=
truct input_ha
>      -=09=09=09kbd->saved_mode =3D kbd->current_mode;
>      -=09=09=09appletb_kbd_set_mode(kbd, kbd->current_mode =3D=3D APPLETB=
_KBD_MODE_SPCL
>      -=09=09=09=09=09=09? APPLETB_KBD_MODE_FN : APPLETB_KBD_MODE_SPCL);
>     -+=09=09=09if (appletb_tb_double_press_switch_layers) {
>     ++=09=09=09if (appletb_tb_double_press_switch_layers > 0) {
>      +=09=09=09=09unsigned long now =3D jiffies;
>      +
>      +=09=09=09=09if (time_before(now, kbd->last_fn_press +
> --=20
> 2.53.0
>=20
> 
