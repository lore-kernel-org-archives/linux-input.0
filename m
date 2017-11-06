From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3 1/2] Input: synaptics-rmi4 - RMI4 can also use SMBUS
 version 3
Date: Mon, 6 Nov 2017 08:56:16 +0100
Message-ID: <CAN+gG=EAHa88ZMgZ4TB5WUgNwoLW9B6+BWsewkcXSVkEChdShg@mail.gmail.com>
References: <20171105170951.20261-1-yiannis.marangos@gmail.com> <20171105170951.20261-2-yiannis.marangos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:52587 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751461AbdKFH4S (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 6 Nov 2017 02:56:18 -0500
Received: by mail-pg0-f65.google.com with SMTP id a192so7588976pge.9
        for <linux-input@vger.kernel.org>; Sun, 05 Nov 2017 23:56:17 -0800 (PST)
In-Reply-To: <20171105170951.20261-2-yiannis.marangos@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yiannis Marangos <yiannis.marangos@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sun, Nov 5, 2017 at 6:09 PM, Yiannis Marangos
<yiannis.marangos@gmail.com> wrote:
> Some synaptics devices such as LEN0073 use SMBUS version 3.
>
> Signed-off-by: Yiannis Marangos <yiannis.marangos@gmail.com>
> ---

In the same way v2 was:
Acked-by: Benjamin Tissoires <benjamion.tissoires@redhat.com>

This also applies to 2/2.

Yiannis, please next time keep the various acked-by, rev-by already
provided by reviewers, this is less work for the maintainer to gather
them if they are already there.

Cheers,
Benjamin

>  drivers/input/rmi4/rmi_smbus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
> index 225025a0940c..b6ccf39c6a7b 100644
> --- a/drivers/input/rmi4/rmi_smbus.c
> +++ b/drivers/input/rmi4/rmi_smbus.c
> @@ -312,7 +312,7 @@ static int rmi_smb_probe(struct i2c_client *client,
>         rmi_smb->xport.dev = &client->dev;
>         rmi_smb->xport.pdata = *pdata;
>         rmi_smb->xport.pdata.irq = client->irq;
> -       rmi_smb->xport.proto_name = "smb2";
> +       rmi_smb->xport.proto_name = "smb";
>         rmi_smb->xport.ops = &rmi_smb_ops;
>
>         smbus_version = rmi_smb_get_version(rmi_smb);
> @@ -322,7 +322,7 @@ static int rmi_smb_probe(struct i2c_client *client,
>         rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
>                 smbus_version);
>
> -       if (smbus_version != 2) {
> +       if (smbus_version != 2 && smbus_version != 3) {
>                 dev_err(&client->dev, "Unrecognized SMB version %d\n",
>                                 smbus_version);
>                 return -ENODEV;
> --
> 2.14.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
