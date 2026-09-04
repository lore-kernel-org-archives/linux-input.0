Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FC133939D;
	Fri,  4 Sep 2026 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788523628; cv=none; b=nuoqdqSr43sudEkEWaHEwOX9rc/A/s6J3gGD03t5dWNPNYNrY/6Z+tPtzkH1rPZ/4TQz13149+j+VnFsAppKSt3DUaC3hlMwZ5sYFqeu9Ok9twWPhQ2Dg628+D/s8DZ5oOVAMS8HmtXbBphY2JCaUusF+DjhSrRIdVu+1NwmOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788523628; c=relaxed/simple;
	bh=zVWklnk+Grcb+0xhPQGQrIydxn5IKT4cx7o8GrONzfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXpQfpslgXUAZxcZCys93KdmNV6jUnmJdmkDakiXT3gKWkEwVCX9XumCWX6S+aZQcy/Wj7Nl0TWSJwOKnEoqU9egYBtAWdYltLSY17RY/atUed9mOpk4ValMQ4wbrdt0j5Lza/2JZCyO2ymRXdWI3pf3fXKhBPYpm8Y56T+V5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 356C83E9B1;
	Fri,  4 Sep 2026 12:06:56 +0000 (UTC)
Message-ID: <4110b6590ad1dbff92e28539d99376d2ea99c50b.camel@hadess.net>
Subject: Re: [PATCH] hid: fix typos in comments
From: Bastien Nocera <hadess@hadess.net>
To: Hemanth Selam <hemanth.selam@gmail.com>, Jiri Kosina <jikos@kernel.org>,
  Benjamin Tissoires	 <bentiss@kernel.org>, Filipe =?ISO-8859-1?Q?La=EDns?=
 <lains@riseup.net>,  Stefan Achatz <erazor_de@users.sourceforge.net>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,  Tomasz
 =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>, Oleg Makarenko
 <oleg@makarenk.ooo>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-usb@vger.kernel.org
Date: Fri, 04 Sep 2026 14:06:55 +0200
In-Reply-To: <20260904114444.28585-1-hemanth.selam@gmail.com>
References: <20260904114444.28585-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-Cause: dmFkZTEdbG1du2wOYpkyYV6TLObUzaT+slakAi6EoGPaLqL2NxkRMTP6LsEUTT+zO6QCSJM99bKppv9KVC007mvmOV9KZodSpVU63ONoJ3A/6R5mbnLzO2Gi+6DInXRi3C60DMGZ9emNoZ9NxGsV623M8ihgUTvUOv22TowEzwnLxfEkGhFPLq6yBBitajHmGZJlMw2VxUzDezf5UN550DHUDjrBdwB5ALf4Kt2wkwG+CpunCgcUoZtr2bSujn9KJqUSfn5aciCU66M/kevFpWGXoARjK3DcyMO0GZCVi0D/LjTexIF9Rur8H2UTDA5RkdjNH4GTmlkG7KUvxW2oL9ezPVxuiOopzoCXaNxyvF625D98Vy3m61ocKGUb5SQKabdUfn42fGOEUhA/JmymmlmlVE6/BXMA7UudtEecmIcz6sqLiMWiysAIZfynYFQoV4fdgjeRJFgxJdCc9g1Zt8cr0ylnwBAgp9gYvoqgqjSIi7j4cdfbT8mkRbq7H+9Wmk/QMgJjhIxlr83PcQXySLCcRx/l8FjRkmHaG5UquM8d8VbCn3J6JaSY3YaH0XBYPfi1njv6EOIIT8u0I3Y81Z0htIxR4E4v1rtiQSV2pGq6uDLS+ealXeAGY82Jm1/5fUE4Ratj8gTw0RqU2DqijqaVhwqgFRJGkskvNsO1dWwX1EsTIQ
X-GND-State: clean
X-GND-Score: -100

On Fri, 2026-09-04 at 17:14 +0530, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.=C2=A0 Only touches comments, no
> code
> changes.
>=20
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
> =C2=A0drivers/hid/hid-appleir.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/hid/hid-logitech-dj.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 +-
> =C2=A0drivers/hid/hid-logitech-hidpp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--

For those 3 files above:

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> =C2=A0drivers/hid/hid-roccat-kone.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 +-
> =C2=A0drivers/hid/hid-roccat-kone.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 +-
> =C2=A0drivers/hid/hid-speedlink.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/hid/intel-ish-hid/ishtp-hid-client.c=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 +-
> =C2=A0drivers/hid/intel-ish-hid/ishtp/client-buffers.c | 2 +-
> =C2=A0drivers/hid/usbhid/hid-pidff.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
2 +-
> =C2=A09 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/hid/hid-appleir.c b/drivers/hid/hid-appleir.c
> index adaa44a858ed..649ee5d8fe1e 100644
> --- a/drivers/hid/hid-appleir.c
> +++ b/drivers/hid/hid-appleir.c
> @@ -118,7 +118,7 @@ struct appleir {
> =C2=A0static int get_key(int data)
> =C2=A0{
> =C2=A0	/*
> -	 * The key is coded accross bits 2..9:
> +	 * The key is coded across bits 2..9:
> =C2=A0	 *
> =C2=A0	 * 0x00 or 0x01 (=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )	key:=
=C2=A0 0		->
> KEY_RESERVED
> =C2=A0	 * 0x02 or 0x03 (=C2=A0 menu=C2=A0 )	key:=C2=A0 1		->
> KEY_MENU
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-
> logitech-dj.c
> index 1d619d2345e1..51aaee2e29e3 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -620,7 +620,7 @@ static const char hidpp_descriptor[] =3D {
> =C2=A0 *
> =C2=A0 * Right now, RF report types have the same report types (or report
> id's)
> =C2=A0 * than the hid report created from those RF reports. In the future
> - * this doesnt have to be true.
> + * this doesn't have to be true.
> =C2=A0 *
> =C2=A0 * For instance, RF report type 0x01 which has a size of 8 bytes,
> corresponds
> =C2=A0 * to hid report id 0x01, this is standard keyboard. Same thing
> applies to mice
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 1504de32b1c8..5273a5a7e7a0 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -110,7 +110,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
> =C2=A0 * where as most newer devices use the FAP protocol. Both protocols
> are
> =C2=A0 * compatible with the underlying transport, which could be usb,
> Unifiying, or
> =C2=A0 * bluetooth. The message lengths are defined by the hid vendor
> specific report
> - * descriptor for the HIDPP_SHORT report type (total message lenth 7
> bytes) and
> + * descriptor for the HIDPP_SHORT report type (total message length
> 7 bytes) and
> =C2=A0 * the HIDPP_LONG report type (total message length 20 bytes)
> =C2=A0 *
> =C2=A0 * The RAP protocol uses both report types, whereas the FAP only
> uses HIDPP_LONG
> @@ -3354,7 +3354,7 @@ static int m560_input_mapping(struct hid_device
> *hdev, struct hid_input *hi,
> =C2=A0/*
> =C2=A0 * The Logitech K400 keyboard has an embedded touchpad which is see=
n
> =C2=A0 * as a mouse from the OS point of view. There is a hardware
> shortcut to disable
> - * tap-to-click but the setting is not remembered accross reset,
> annoying some
> + * tap-to-click but the setting is not remembered across reset,
> annoying some
> =C2=A0 * users.
> =C2=A0 *
> =C2=A0 * We can toggle this feature from the host by using the feature
> 0x6010:
> diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-
> kone.c
> index 3dae9eaa0b6f..5b84435cbe8f 100644
> --- a/drivers/hid/hid-roccat-kone.c
> +++ b/drivers/hid/hid-roccat-kone.c
> @@ -842,7 +842,7 @@ static void kone_report_to_chrdev(struct
> kone_device const *kone,
> =C2=A0
> =C2=A0/*
> =C2=A0 * Is called for keyboard- and mousepart.
> - * Only mousepart gets informations about special events in its
> extended event
> + * Only mousepart gets information about special events in its
> extended event
> =C2=A0 * structure.
> =C2=A0 */
> =C2=A0static int kone_raw_event(struct hid_device *hdev, struct hid_repor=
t
> *report,
> diff --git a/drivers/hid/hid-roccat-kone.h b/drivers/hid/hid-roccat-
> kone.h
> index 65c800e3addc..13de9f14dc1e 100644
> --- a/drivers/hid/hid-roccat-kone.h
> +++ b/drivers/hid/hid-roccat-kone.h
> @@ -165,7 +165,7 @@ enum kone_mouse_events {
> =C2=A0	/* osd events are thought to be display on screen */
> =C2=A0	kone_mouse_event_osd_dpi =3D 0xa0,
> =C2=A0	kone_mouse_event_osd_profile =3D 0xb0,
> -	/* TODO clarify meaning and occurence of
> kone_mouse_event_calibration */
> +	/* TODO clarify meaning and occurrence of
> kone_mouse_event_calibration */
> =C2=A0	kone_mouse_event_calibration =3D 0xc0,
> =C2=A0	kone_mouse_event_call_overlong_macro =3D 0xe0,
> =C2=A0	kone_mouse_event_multimedia =3D 0xe1,
> diff --git a/drivers/hid/hid-speedlink.c b/drivers/hid/hid-
> speedlink.c
> index 22ee078c42c6..3196bb85ccc2 100644
> --- a/drivers/hid/hid-speedlink.c
> +++ b/drivers/hid/hid-speedlink.c
> @@ -44,7 +44,7 @@ static int speedlink_event(struct hid_device *hdev,
> struct hid_field *field,
> =C2=A0{
> =C2=A0	/* No other conditions due to usage_table. */
> =C2=A0
> -	/* This fixes the "jumpy" cursor occuring due to invalid
> events sent
> +	/* This fixes the "jumpy" cursor occurring due to invalid
> events sent
> =C2=A0	 * by the device. Some devices only send them with
> value=3D=3D+256, others
> =C2=A0	 * don't. However, catching abs(value)>=3D256 is restrictive
> enough not
> =C2=A0	 * to interfere with devices that were bug-free (has been
> tested).
> diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> index ec5e8afe77bd..acfe25fd8b23 100644
> --- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> +++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
> @@ -631,7 +631,7 @@ static int ishtp_get_report_descriptor(struct
> ishtp_cl *hid_ishtp_cl,
> =C2=A0 * @hid_ishtp_cl:	ISHTP client instance
> =C2=A0 * @reset:		true if called for init after reset
> =C2=A0 *
> - * This function complete the initializtion of the client. The
> summary of
> + * This function complete the initialization of the client. The
> summary of
> =C2=A0 * processing:
> =C2=A0 * - Send request to enumerate the hid clients
> =C2=A0 *	Get the HID descriptor for each enumearated device
> diff --git a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
> b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
> index 45ddc9a047bc..6bac76249437 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
> @@ -177,7 +177,7 @@ void ishtp_io_rb_free(struct ishtp_cl_rb *rb)
> =C2=A0 *
> =C2=A0 * Allocate and initialize request block
> =C2=A0 *
> - * Return: Allocted IO request block pointer
> + * Return: Allocated IO request block pointer
> =C2=A0 */
> =C2=A0struct ishtp_cl_rb *ishtp_io_rb_init(struct ishtp_cl *cl)
> =C2=A0{
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-
> pidff.c
> index 22951b7ecd17..82150a72506b 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c
> @@ -20,7 +20,7 @@
> =C2=A0#define	PID_EFFECTS_MAX		64
> =C2=A0#define	PID_INFINITE		U16_MAX
> =C2=A0
> -/* Linux Force Feedback API uses miliseconds as time unit */
> +/* Linux Force Feedback API uses milliseconds as time unit */
> =C2=A0#define FF_TIME_EXPONENT	-3
> =C2=A0#define FF_INFINITE		0
> =C2=A0
