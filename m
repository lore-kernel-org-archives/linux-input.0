From: "Jussi Kivilinna" <jussi.kivilinna-E01nCVcF24I@public.gmane.org>
Subject: Re: [PATCH] hid: add force feedback support for SmartJoy PLUS
	PS2/USB adapter
Date: Fri, 08 May 2009 11:37:16 +0300
Message-ID: <20090508113716.10603mzp3jmcfry8@hayate.sektori.org>
References: <20090508074636.16912.55839.stgit@fate.lan>
	<200905081002.56647.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200905081002.56647.oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Quoting "Oliver Neukum" <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>:

> Am Freitag, 8. Mai 2009 09:46:36 schrieb Jussi Kivilinna:
>> +static int sj_probe(struct hid_device *hdev, const struct hid_devic=
e_id
>> *id) +{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D hid_parse(hdev);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_err(&hdev->dev, "parse failed\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto err;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D hid_hw_start(hdev=
, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0dev_err(&hdev->dev, "hw start failed\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0goto err;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sjoyff_init(hdev);
>
> Do you really want to ignore errors this returns?
>
> 	Regards
> 		Oliver
>

It's done same in hid-pl.c & hid-gaff.c which I used base for this =20
driver. I'd say yes, ignoring return sjoyff_init is ok. If ff-setup =20
fails adapter will still be usable (but without ff). This is actually =20
what happened when I tried this driver with other Wisegroup adapter.

-Jussi

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
