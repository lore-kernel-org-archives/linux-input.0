Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF13909A7;
	Thu, 30 Jul 2026 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785398873; cv=none; b=WUA9o15iQFKf1337xBJ1SL97GeBkGPIk9+RZgZYs6FhQQAYFTEHgNhtZsTOaG4LDKNoTSve4MsRxWG07wg0FNzJMzWx7Bv+IPOwcZfBG2v9wlSy87lMz9Y4hI+MF8UI0NPpvONfOpnhfrICZfYmRTW0a+ScpQL+nsA22w3Pbeqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785398873; c=relaxed/simple;
	bh=I4xhmedLlRP6A1/qQf1becdmotuSjQaXlqypz5pUQNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hG2er3e2V9OYtfXxNm7s5ZAFuaoxoMXC0VV0Zpobtl24ugWe7upq4F42HHtjzTid7h/dp9XBJ9Jm8UL7DCr9+jdTR61CXFQVeR8cnNESO28OaKIdthS2GVhX6xawxYKUDwuRntLxY9EAjKNgMMIbSfBm7kwHuJYtxXruRr/ChJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB0BA3ED0C;
	Thu, 30 Jul 2026 08:07:39 +0000 (UTC)
Message-ID: <a98072328950f6b45a358086cbd6a16c5b645416.camel@hadess.net>
Subject: Re: [PATCH v2 2/2] HID: logitech-hidpp: enable reprogrammable
 buttons on Signature M650
From: Bastien Nocera <hadess@hadess.net>
To: Elliot Douglas <edouglas7358@gmail.com>, linux-input@vger.kernel.org
Cc: lains@riseup.net, jikos@kernel.org, bentiss@kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 30 Jul 2026 10:07:39 +0200
In-Reply-To: <2e719e56029386f148d748a7d555023f4efe3862.1783094954.git.edouglas7358@gmail.com>
References: <cover.1783094954.git.edouglas7358@gmail.com>
				 <2e719e56029386f148d748a7d555023f4efe3862.1783094954.git.edouglas7358@gmail.com>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTEVkGVW81MmovkkhPJd0M6HmgakQCuMhoeVX9rppSfHSC/EgOLJBniv7Ont1roqiPvoJ5X8cixI8jOytNesJ8Mnh3JRw4R67N4kyWpwmHXdCT14OLSc94Slh+ItqVQicKPFWFbIn32omm5ODBcdeKKZmpSaVMiiCNg8XJnELHIgwu7jgCot/NbFC9Qi++Vvc/lcIHh7p+ds4XcHR82BFtFr0GqNDGZsMUd9h2cHuMmaI+SzyVL+kHsEl/wE/9WRviv5ao04hQ93zQjwT4Bo6hvSFf+/56/ARkHUXpFDfSbXGMHqVBZyyn/lw1wXlya5bKoDRFRpyhCikdQ8ztC+SLaIRxxQTlRUMCb+nQ14L9qLr4GOGSEBDVkRw2zTsGmeTvET/hweSuRU9kakKjAfJQzX6ekOqO/66U3Brhx5vtU+PCGksU3zj4IzJCqDo/FFykQ2LY+1/Ftp5hqc8vABvl0OISXalYo7Lk1F3Kigj8zajdJzVgeT6H0i+8g3moMWJiIGKKJ3wo/+2cjlDLVcPaXz6d6T6RWwzCn1YzbXEN4tC3oIhV89BmZDO5sniors6yy6gx23x+5UUl8i1zIFkCr7my7MlC9NRuMKMf4QeIJg2ZKp02TTjM/NF3KhscpsOz2/jGsTEFNPzEsk/0WbdAHqF8cvzIoEHD6jkN3l98Lewg
X-GND-State: clean

On Sat, 2026-07-04 at 16:10 -0700, Elliot Douglas wrote:
> The Bluetooth Signature M650 exposes its side buttons through the
> normal
> mouse report, but the observed events are short click-like events
> emitted
> around release rather than physical press/release state.
>=20
> The device appears to use the held side-button state for its built-in
> gesture and side-button + wheel horizontal-scroll mode. As a result,
> holding a side button long enough

s/long enough/more than approximately 2 seconds/ ?

>  can prevent the normal mouse report from
> emitting a usable button event at all.
>=20
> HID++ REPROG_CONTROLS_V4 diversion for control IDs 0x0053 and 0x0056
> provides real press and release timing for those same controls.
> Logitech
> documents the Signature M650 side buttons as Back/Forward buttons, so
> report the diverted controls as BTN_BACK and BTN_FORWARD.
>=20
> The HID++ 0x1b04 documentation lists those control IDs as Back and
> Forward. The driver still verifies that the controls are present in
> the
> device control table and advertised as divertable before changing
> their
> reporting mode.
>=20
> Link:
> https://support.logi.com/hc/en-nz/articles/4414473810583-Getting-Started-=
Signature-M650
> Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>

Tested with my M650 mouse connected through Bluetooth.

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> =C2=A0drivers/hid/hid-logitech-hidpp.c | 20 +++++++++++++++++++-
> =C2=A01 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index f9189e14fb78..e71dd2457e80 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3624,14 +3624,30 @@ static int
> hidpp10_extra_mouse_buttons_raw_event(struct hidpp_device *hidpp,
> =C2=A0
> =C2=A0#define HIDPP_REPROG_CONTROLS_EVENT_DIVERTED 0x00
> =C2=A0
> +#define HIDPP_REPROG_CONTROL_BACK 0x0053
> +#define HIDPP_REPROG_CONTROL_FORWARD 0x0056
> +
> +#define HIDPP_PRODUCT_SIGNATURE_M650 0xb02a

If you want to add a product ID constant, please do it in hid-ids.h
instead.

> +
> =C2=A0struct hidpp_reprog_control_mapping {
> =C2=A0 u16 control;
> =C2=A0 u16 code;
> =C2=A0};
> =C2=A0
> +static const struct hidpp_reprog_control_mapping
> m650_reprog_control_mappings[] =3D {
> + { HIDPP_REPROG_CONTROL_BACK, BTN_BACK },
> + { HIDPP_REPROG_CONTROL_FORWARD, BTN_FORWARD },
> + { }
> +};
> +
> =C2=A0static const struct hidpp_reprog_control_mapping *
> =C2=A0hidpp20_reprog_controls_get_mappings(struct hidpp_device *hidpp)
> =C2=A0{
> + switch (hidpp->hid_dev->product) {
> + case HIDPP_PRODUCT_SIGNATURE_M650:
> + return m650_reprog_control_mappings;
> + }
> +
> =C2=A0 return NULL;
> =C2=A0}
> =C2=A0
> @@ -4911,7 +4927,9 @@ static const struct hid_device_id
> hidpp_devices[] =3D {
> =C2=A0 { /* MX Vertical mouse over Bluetooth */
> =C2=A0 =C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb020) },
> =C2=A0 { /* Signature M650 over Bluetooth */
> - =C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a) },
> + =C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HIDPP_PRODUCT_SIGNATURE_M650),
> + =C2=A0 .driver_data =3D HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS },
> =C2=A0 { /* MX Master 3 mouse over Bluetooth */
> =C2=A0 =C2=A0 HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
> =C2=A0 { /* MX Anywhere 3 mouse over Bluetooth */
