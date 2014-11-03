From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] Introduces Plantronics driver to fix errant mouse
 events.
Date: Mon, 3 Nov 2014 14:22:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411031421580.19451@pobox.suse.cz>
References: <512A3191-0BAA-4E92-A863-66AFD2A16422@plantronics.com> <CAN+gG=Ftj41ThcGkBouGK0zC9-RPBXQUf_iSYEGFCSuadQf5JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50381 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbaKCNWk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Nov 2014 08:22:40 -0500
In-Reply-To: <CAN+gG=Ftj41ThcGkBouGK0zC9-RPBXQUf_iSYEGFCSuadQf5JA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: "Cole, JD" <JD.Cole@plantronics.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "bleung@chromium.org" <bleung@chromium.org>, "Junge, Terry" <Terry.Junge@plantronics.com>, "Dsouza, Sunil" <Sunil.Dsouza@plantronics.com>, "Wesselman, Tom" <Tom.Wesselman@plantronics.com>

On Fri, 31 Oct 2014, Benjamin Tissoires wrote:

> > +static int plantronics_probe(struct hid_device *hdev,
> > +                            const struct hid_device_id *id)
> > +{
> > +       int ret;
> > +
> > +       ret = hid_parse(hdev);
> > +       if (ret) {
> > +               hid_err(hdev, "parse failed\n");
> > +               goto err;
> > +       }
> > +
> > +       ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> > +       if (ret) {
> > +               hid_err(hdev, "hw start failed\n");
> > +               goto err;
> > +       }
> > +
> > +       return 0;
> > + err:
> > +       return ret;
> > +}
> 
> Actually, in your case, you can even remove the probe function.
> hid-core will do open the report and start the hardware for you.

Good catch, thanks. I have removed the superfluous .probe() and applied 
(with Dmitry's Reviewed-by: added to patch no .1).

Thanks,

-- 
Jiri Kosina
SUSE Labs
