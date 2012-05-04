From: Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [bug?] [powerpc] hid_logitech_dj: Wireless mouse does not work in
 xorg or gpm
Date: Fri, 4 May 2012 12:16:01 +0200
Message-ID: <CAE7qMrpWMJ=U3H3BBkxXGskNnNG7ZURS44Euh0_LZhq6ucBmpA@mail.gmail.com>
References: <20120503052420.GD15205@burratino> <4FA217B7.7070908@osvaldobarrera.com.ar>
 <20120503055051.GA15960@burratino> <CAE7qMrqtmu+bYYYp43s7Ek=UxfUG8HzwQSQBsdCGcVCBzCMQQw@mail.gmail.com>
 <20120503130821.GB16978@burratino> <20120503131356.GC16978@burratino>
 <20120504024054.GA19355@hugoo.com.ar> <20120504074137.GB6451@burratino>
 <20120504081031.GA30509@hugoo.com.ar> <4FA38FFD.6080805@osvaldobarrera.com.ar>
 <20120504083605.GI6451@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:50401 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753256Ab2EDKQc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 4 May 2012 06:16:32 -0400
Received: by pbbro12 with SMTP id ro12so4625727pbb.4
        for <linux-input@vger.kernel.org>; Fri, 04 May 2012 03:16:31 -0700 (PDT)
In-Reply-To: <20120504083605.GI6451@burratino>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Hugo Osvaldo Barrera <hugo@osvaldobarrera.com.ar>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>, 671292@bugs.debian.org

Hi guys,

Thanks for those logs, very helpful.

Would you be able to test the following patch on both systems and let
us know about the result?

Cheers,
Nestor

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-d=
j.c
index 38b12e4..763e4d9 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -215,6 +215,7 @@ static void logi_dj_recv_add_djhid_device(struct
dj_receiver_dev *djrcv_dev,
 	struct usb_device *usbdev =3D interface_to_usbdev(intf);
 	struct hid_device *dj_hiddev;
 	struct dj_device *dj_dev;
+	u32 reports_supported;

 	/* Device index goes from 1 to 6, we need 3 bytes to store the
 	 * semicolon, the index, and a null terminator
@@ -264,9 +265,11 @@ static void logi_dj_recv_add_djhid_device(struct
dj_receiver_dev *djrcv_dev,
 			__func__);
 		goto dj_device_allocate_fail;
 	}
+	memcpy(&reports_supported,
+		&dj_report->report_params[DEVICE_PAIRED_RF_REPORT_TYPE],
+		sizeof(reports_supported));

-	dj_dev->reports_supported =3D le32_to_cpu(
-		dj_report->report_params[DEVICE_PAIRED_RF_REPORT_TYPE]);
+	dj_dev->reports_supported =3D le32_to_cpu(reports_supported);
 	dj_dev->hdev =3D dj_hiddev;
 	dj_dev->dj_receiver_dev =3D djrcv_dev;
 	dj_dev->device_index =3D dj_report->device_index;



On Fri, May 4, 2012 at 10:36 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
> Hugo Osvaldo Barrera wrote:
>
> > Oh, it slipped my mind and I used the other (identical) mouse for t=
his,
> > does that matter? =A0They're the exact same model.
>
> Probably doesn't matter, but thanks for mentioning it.
>
> Sincerely,
> Jonathan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
