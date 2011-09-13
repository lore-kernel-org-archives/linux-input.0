From: Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] HID: usbhid: fix suspend timeout due to RUNNING bits
Date: Mon, 12 Sep 2011 18:29:20 -0700
Message-ID: <CANLzEkto=6itnTXz3cwsjNUS0UR5knMzyut7-m8_Mfw9fNMsMw@mail.gmail.com>
References: <1315008447-11012-1-git-send-email-bleung@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:30226 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094Ab1IMBdd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Sep 2011 21:33:33 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id p8D1XWuP010821
	for <linux-input@vger.kernel.org>; Mon, 12 Sep 2011 18:33:32 -0700
Received: from qyk32 (qyk32.prod.google.com [10.241.83.160])
	by wpaz29.hot.corp.google.com with ESMTP id p8D1XQcJ022751
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-input@vger.kernel.org>; Mon, 12 Sep 2011 18:33:31 -0700
Received: by qyk32 with SMTP id 32so2447074qyk.17
        for <linux-input@vger.kernel.org>; Mon, 12 Sep 2011 18:33:30 -0700 (PDT)
In-Reply-To: <1315008447-11012-1-git-send-email-bleung@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bleung@chromium.org

Ping. Would someone in linux-usb take a look at this fix?

Thanks,
Benson

On Fri, Sep 2, 2011 at 5:07 PM, Benson Leung <bleung@chromium.org> wrot=
e:
> hid_submit_ctrl and hid_submit_out should return error
> codes when HID_REPORTED_IDLE is set by hid_suspend.
> This will allow the output and control completion
> handlers to clear HID_OUT_RUNNING and HID_CTRL_RUNNING
> so hid_suspend succeeds.
>
> Previously, if there were outstanding out messages
> or control messages while hid_suspend was called,
> hid_suspend would fail because usbhid_wait_io would time
> out.
>
> This condition happens with USB keyboards with both capslock and
> numlock leds enabled at suspend time. Control requests
> will come down to the hid-core to disable both leds, with
> hid_suspend being called between the two being submitted.
>
> Signed-off-by: Benson Leung <bleung@chromium.org>
> ---
> =A0drivers/hid/usbhid/hid-core.c | =A0 =A04 ++++
> =A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-c=
ore.c
> index a9fa294..cf5c106 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -326,6 +326,8 @@ static int hid_submit_out(struct hid_device *hid)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usbhid->last_out =3D jiffies;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> @@ -385,6 +387,8 @@ static int hid_submit_ctrl(struct hid_device *hid=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usbhid->last_ctrl =3D jiffies;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> --
> 1.7.1
>
>



--=20
Benson Leung
Software Engineer,=A0Chrom* OS
bleung@chromium.org
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
