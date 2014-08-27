From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 2/2] HID: picolcd: sanity check report size in
 raw_event() callback
Date: Wed, 27 Aug 2014 10:13:11 +0200
Message-ID: <20140827101311.098f3fd1@pluto>
References: <alpine.LNX.2.00.1408270911130.2992@pobox.suse.cz>
	<alpine.LNX.2.00.1408270912310.2992@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1408270912310.2992@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 27 Aug 2014 09:13:15 +0200 (CEST) Jiri Kosina wrote:
> The report passed to us from transport driver could potentially be=20
> arbitrarily large, therefore we better sanity-check it so that raw_da=
ta=20
> that we hold in picolcd_pending structure are always kept within prop=
er=20
> bounds.
>=20
> Cc: stable@vger.kernel.org
> Reported-by: Steven Vittitoe <scvitti@google.com>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Acked-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>

> ---
>  drivers/hid/hid-picolcd_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/hid/hid-picolcd_core.c b/drivers/hid/hid-picolcd=
_core.c
> index acbb0210..020df3c 100644
> --- a/drivers/hid/hid-picolcd_core.c
> +++ b/drivers/hid/hid-picolcd_core.c
> @@ -350,6 +350,12 @@ static int picolcd_raw_event(struct hid_device *=
hdev,
>  	if (!data)
>  		return 1;
> =20
> +	if (size > 64) {
> +		hid_warn(hdev, "invalid size value (%d) for picolcd raw event\n",
> +				size);

Is it worth adding report->id to this hid_warn()?

A valid device is not expected to ever send >64 bytes reports but in
case a firmware update would do so it would help to know for which
report it was.

> +		return 0;
> +	}
> +
>  	if (report->id =3D=3D REPORT_KEY_STATE) {
>  		if (data->input_keys)
>  			ret =3D picolcd_raw_keypad(data, report, raw_data+1, size-1);
