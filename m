From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Trackpoint on Thinkpad X1 Carbon (5th gen)
Date: Tue, 6 Jun 2017 23:36:44 -0700
Message-ID: <20170607063644.GD23434@dtor-ws>
References: <CAEk1YH5dPPQfMEq650cUX1p4QrOUzR0oSSBombtFQLKV--ix2A@mail.gmail.com>
 <CAEk1YH7589yXnMJkmn+NMr45KZruGdW58xXVm-r47uy_W=ynwg@mail.gmail.com>
 <CAKdAkRTcgg2g2mmN3PTKf1ZhKHJ5nsE4z_LDjZ=tOqcoUoZ8Mg@mail.gmail.com>
 <CAEk1YH54DWWonBcMKaz17+O_UOaWFSm-FWZchUpkT+czVwS93Q@mail.gmail.com>
 <KAWPR01MB1092B90F0C1C12D5E3C40DB5C7CA0@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <20170606074909.GU1293@mail.corp.redhat.com>
 <20170606174154.GA19288@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34290 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdFGGgs (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 02:36:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id v14so582397pgn.1
        for <linux-input@vger.kernel.org>; Tue, 06 Jun 2017 23:36:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170606174154.GA19288@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, Damjan Georgievski <gdamjan@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, Jun 06, 2017 at 10:41:54AM -0700, Dmitry Torokhov wrote:
> On Tue, Jun 06, 2017 at 09:49:09AM +0200, Benjamin Tissoires wrote:
> > Damjan, would you mind trying the following change:
> > diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
> > index 77dad04..ad71a5e 100644
> > --- a/drivers/input/rmi4/rmi_f03.c
> > +++ b/drivers/input/rmi4/rmi_f03.c
> > @@ -146,7 +146,7 @@ static int rmi_f03_register_pt(struct f03_data *f03)
> >         if (!serio)
> >                 return -ENOMEM;
> >  
> > -       serio->id.type = SERIO_8042;
> > +       serio->id.type = SERIO_PS_PSTHRU;
> 
> No, you do not want to do this. psmouse-base has more logic than just
> selecting protocols to probe keyed off SERIO_PS_PSTHRU.

Actually, you are right, it will work, since psmouse-base.c also checks
if serio has a parent before activating/deactivating passthrough logic,
and F03-backed serio port will not have a serio parent.

Thanks.

-- 
Dmitry
