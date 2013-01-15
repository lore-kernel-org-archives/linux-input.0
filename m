From: Fernando Luis Vazquez Cao <fernando_b1@lab.ntt.co.jp>
Subject: Re: [PATCH] HID: add support for Sony RF receiver with USB product
 id 0x0374
Date: Tue, 15 Jan 2013 19:03:50 +0900
Message-ID: <50F52986.2080002@lab.ntt.co.jp>
References: <1358221428.9926.1.camel@nexus.lab.ntt.co.jp> <20130115103638.be566e39f0f5ad7186362dd8@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tama50.ecl.ntt.co.jp ([129.60.39.147]:52068 "EHLO
	tama50.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab3AOKEn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jan 2013 05:04:43 -0500
In-Reply-To: <20130115103638.be566e39f0f5ad7186362dd8@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Antonio,

On 2013/01/15 18:36, Antonio Ospite wrote:
> On Tue, 15 Jan 2013 12:43:48 +0900 Fernando Luis V=E1zquez Cao  <fern=
ando_b1@lab.ntt.co.jp> wrote:
>> diff -urNp linux-3.8-rc3-orig/drivers/hid/hid-sony.c linux-3.8-rc3/d=
rivers/hid/hid-sony.c
>> --- linux-3.8-rc3-orig/drivers/hid/hid-sony.c	2012-12-11 12:30:57.00=
0000000 +0900
>> +++ linux-3.8-rc3/drivers/hid/hid-sony.c	2013-01-13 18:21:19.9013473=
27 +0900
>> @@ -44,19 +44,21 @@ static __u8 *sony_report_fixup(struct hi
>>   	struct sony_sc *sc =3D hid_get_drvdata(hdev);
>>  =20
>>   	if ((sc->quirks & VAIO_RDESC_CONSTANT) &&
>> -			*rsize >=3D 56 && rdesc[54] =3D=3D 0x81 && rdesc[55] =3D=3D 0x07=
) {
>> -		hid_info(hdev, "Fixing up Sony Vaio VGX report descriptor\n");
>> +	    *rsize >=3D 56 && rdesc[54] =3D=3D 0x81 && rdesc[55] =3D=3D 0x=
07) {
>> +		hid_info(hdev,
>> +		         "Fixing up Sony RF Receiver report descriptor\n");
> Changing the message does make sense, but try to avoid mixing
> functional changes with style changes (I am referring to the change o=
f
> indentation here).

Oops, that was unintended. I will be replying to this email with an=20
updated version.

Thanks,
=46ernando
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
