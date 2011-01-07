From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC v2 01/10] hid: add feature_mapping callback
Date: Fri, 7 Jan 2011 11:18:39 +0100
Message-ID: <20110107101839.GA2312@polaris.bitmath.org>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
 <1294248468-19979-2-git-send-email-benjamin.tissoires@enac.fr>
 <20110106162223.GB1790@polaris.bitmath.org>
 <AANLkTi=xdPJP9okhRL8q-0vL5cVPKniAjve6BQHmB=+p@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=xdPJP9okhRL8q-0vL5cVPKniAjve6BQHmB=+p@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> >> =A0 =A0 =A0 struct input_dev *input_dev;
> >> =A0 =A0 =A0 int i, j, k;
> >> - =A0 =A0 int max_report_type =3D HID_OUTPUT_REPORT;
> >> + =A0 =A0 int max_report_type =3D HID_FEATURE_REPORT;
> >
> > Doing it this way conflicts with the HID_QUIRK_SKIP_OUTPUT_REPORTS =
quirk.
>=20
>=20
> Do you agree on this way? (will send the patch in the next version)
>=20
> @@ -834,11 +842,10 @@ int hidinput_connect(struct hid_device *hid,
> unsigned int force)
>  {
>  	struct hid_report *report;
>  	struct hid_input *hidinput =3D NULL;
>  	struct input_dev *input_dev;
>  	int i, j, k;
> -	int max_report_type =3D HID_OUTPUT_REPORT;
>=20
>  	INIT_LIST_HEAD(&hid->inputs);
>=20
>  	if (!force) {
>  		for (i =3D 0; i < hid->maxcollection; i++) {
> @@ -851,14 +858,14 @@ int hidinput_connect(struct hid_device *hid,
> unsigned int force)
>=20
>  		if (i =3D=3D hid->maxcollection)
>  			return -1;
>  	}
>=20
> -	if (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORTS)
> -		max_report_type =3D HID_INPUT_REPORT;
> +	for (k =3D HID_INPUT_REPORT; k <=3D HID_FEATURE_REPORT; k++)
> +		if (hid->quirks & HID_QUIRK_SKIP_OUTPUT_REPORTS)
> +			continue;
>=20
> -	for (k =3D HID_INPUT_REPORT; k <=3D max_report_type; k++)
>  		list_for_each_entry(report, &hid->report_enum[k].report_list, list=
) {
>=20
>  			if (!report->maxfield)
>  				continue;

Perfect.

Thanks,
Henrik
