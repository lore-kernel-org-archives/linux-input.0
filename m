From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 1/2] Input: synaptics-rmi4 - RMI4 can also use SMBUS
 version 3
Date: Tue, 7 Nov 2017 16:24:11 -0800
Message-ID: <20171108002411.cijgtx7gigpa6ijn@dtor-ws>
References: <20171105170951.20261-1-yiannis.marangos@gmail.com>
 <20171105170951.20261-2-yiannis.marangos@gmail.com>
 <CAN+gG=EAHa88ZMgZ4TB5WUgNwoLW9B6+BWsewkcXSVkEChdShg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:48173 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbdKHAYP (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Nov 2017 19:24:15 -0500
Received: by mail-io0-f194.google.com with SMTP id d66so4115003ioe.5
        for <linux-input@vger.kernel.org>; Tue, 07 Nov 2017 16:24:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAN+gG=EAHa88ZMgZ4TB5WUgNwoLW9B6+BWsewkcXSVkEChdShg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>, linux-input <linux-input@vger.kernel.org>

On Mon, Nov 06, 2017 at 08:56:16AM +0100, Benjamin Tissoires wrote:
> On Sun, Nov 5, 2017 at 6:09 PM, Yiannis Marangos
> <yiannis.marangos@gmail.com> wrote:
> > Some synaptics devices such as LEN0073 use SMBUS version 3.
> >
> > Signed-off-by: Yiannis Marangos <yiannis.marangos@gmail.com>
> > ---
> 
> In the same way v2 was:
> Acked-by: Benjamin Tissoires <benjamion.tissoires@redhat.com>

Applied, thank you.

> 
> This also applies to 2/2.
> 
> Yiannis, please next time keep the various acked-by, rev-by already
> provided by reviewers, this is less work for the maintainer to gather
> them if they are already there.
> 
> Cheers,
> Benjamin
> 
> >  drivers/input/rmi4/rmi_smbus.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
> > index 225025a0940c..b6ccf39c6a7b 100644
> > --- a/drivers/input/rmi4/rmi_smbus.c
> > +++ b/drivers/input/rmi4/rmi_smbus.c
> > @@ -312,7 +312,7 @@ static int rmi_smb_probe(struct i2c_client *client,
> >         rmi_smb->xport.dev = &client->dev;
> >         rmi_smb->xport.pdata = *pdata;
> >         rmi_smb->xport.pdata.irq = client->irq;
> > -       rmi_smb->xport.proto_name = "smb2";
> > +       rmi_smb->xport.proto_name = "smb";
> >         rmi_smb->xport.ops = &rmi_smb_ops;
> >
> >         smbus_version = rmi_smb_get_version(rmi_smb);
> > @@ -322,7 +322,7 @@ static int rmi_smb_probe(struct i2c_client *client,
> >         rmi_dbg(RMI_DEBUG_XPORT, &client->dev, "Smbus version is %d",
> >                 smbus_version);
> >
> > -       if (smbus_version != 2) {
> > +       if (smbus_version != 2 && smbus_version != 3) {
> >                 dev_err(&client->dev, "Unrecognized SMB version %d\n",
> >                                 smbus_version);
> >                 return -ENODEV;
> > --
> > 2.14.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Dmitry
