From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: Wacom: switch Dell canvas into highres mode
Date: Fri, 03 Nov 2017 17:12:08 -0700
Message-ID: <DE35351F-500C-41C5-90E2-18BC2B48A803@gmail.com>
References: <20171103172947.15156-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:45371 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751970AbdKDAMP (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 3 Nov 2017 20:12:15 -0400
In-Reply-To: <20171103172947.15156-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On November 3, 2017 10:29:47 AM PDT, Benjamin Tissoires <benjamin=2Etissoir=
es@redhat=2Ecom> wrote:
>The Dell Canvas exports 2 collections for the Pen part=2E The only
>difference between the 2 is that the default one has half the
>resolution
>of the second one=2E
>
>The Windows driver switches the tablet into the second mode, so we
>should
>behave the same=2E
>
>Signed-off-by: Benjamin Tissoires <benjamin=2Etissoires@redhat=2Ecom>
>---
>
>Hi,
>
>well, this is not the cleanest way of handling this mode set, but it is
>the
>less intrusive AFAICT=2E
>
>I was thinking that we might want to add a new field in struct
>wacom_feature,
>but then it wouldn't make sense to keep the set mode specifics in
>_wacom_query_tablet_data()=2E
>
>So I am open to any better suggestion, but this one works and the
>impact on
>other HID generic tablets is null=2E
>

Hmm=2E Agreed that this isn't ideal=2E I'd like to take a look at the desc=
riptor, if you wouldn't mind sharing it=2E The hardware should be similar t=
o other devices of ours and it might be possible to piggyback on existing c=
ode=2E

Jason

>Cheers,
>Benjamin
>
> drivers/hid/wacom_sys=2Ec | 7 +++++++
> 1 file changed, 7 insertions(+)
>
>diff --git a/drivers/hid/wacom_sys=2Ec b/drivers/hid/wacom_sys=2Ec
>index 906e654fb0ba=2E=2Eee71ad9b6cc1 100644
>--- a/drivers/hid/wacom_sys=2Ec
>+++ b/drivers/hid/wacom_sys=2Ec
>@@ -196,6 +196,13 @@ static void wacom_feature_mapping(struct
>hid_device *hdev,
> 		kfree(data);
> 		break;
> 	}
>+
>+	if (hdev->vendor =3D=3D USB_VENDOR_ID_WACOM &&
>+	    hdev->product =3D=3D 0x4200 /* Dell Canvas 27 */ &&
>+	    field->application =3D=3D HID_UP_MSVENDOR) {
>+		wacom->wacom_wac=2Emode_report =3D field->report->id;
>+		wacom->wacom_wac=2Emode_value =3D 2;
>+	}
> }
>=20
> /*


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
