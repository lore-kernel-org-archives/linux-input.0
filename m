From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH] Input: cyapa: remove variable overwriting
Date: Mon, 12 Oct 2015 02:20:45 +0000
Message-ID: <CY1PR06MB1817A4C99B5A4FB808C7CEC6D1310@CY1PR06MB1817.namprd06.prod.outlook.com>
References: <1442311587-24458-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAKdAkRRBH04vTVYhrLa0XLfnujsV=JJoY4PY36vg1B=1KaaBWw@mail.gmail.com>
 <20150929064749.GA23662@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1on0146.outbound.protection.outlook.com ([157.56.110.146]:8064
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752722AbbJLCgi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Oct 2015 22:36:38 -0400
In-Reply-To: <20150929064749.GA23662@sudip-pc>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>



> -----Original Message-----
> From: Sudip Mukherjee [mailto:sudipm.mukherjee@gmail.com]
> Sent: 2015?9?29? 14:48
> To: Dmitry Torokhov
> Cc: Dudley Du; lkml; linux-input@vger.kernel.org
> Subject: Re: [PATCH] Input: cyapa: remove variable overwriting
>
> On Mon, Sep 28, 2015 at 03:43:04PM -0700, Dmitry Torokhov wrote:
> > Hi Sudip,
> >
> > On Tue, Sep 15, 2015 at 3:06 AM, Sudip Mukherjee
> > <sudipm.mukherjee@gmail.com> wrote:
> > > Even if rotat_align is true or false the final value of
> > > cyapa->electrodes_rx is always cyapa->electrodes_y. remove the variable
> > > overwriting and in the process remove the variable rotat_align which is
> > > not required any more.
> > >
> > > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > > ---
> > >  drivers/input/mouse/cyapa_gen6.c | 10 +---------
> > >  1 file changed, 1 insertion(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/input/mouse/cyapa_gen6.c
> b/drivers/input/mouse/cyapa_gen6.c
> > > index 5f19107..f0c614b 100644
> > > --- a/drivers/input/mouse/cyapa_gen6.c
> > > +++ b/drivers/input/mouse/cyapa_gen6.c
> > > @@ -196,7 +196,6 @@ static int cyapa_gen6_read_sys_info(struct cyapa
> *cyapa)
> > >         u8 resp_data[PIP_READ_SYS_INFO_RESP_LENGTH];
> > >         int resp_len;
> > >         u16 product_family;
> > > -       u8 rotat_align;
> > >         int error;
> > >
> > >         /* Get App System Information to determine Gen5 or Gen6. */
> > > @@ -241,14 +240,7 @@ static int cyapa_gen6_read_sys_info(struct cyapa
> *cyapa)
> > >         memcpy(&cyapa->product_id[13], &resp_data[62], 2);
> > >         cyapa->product_id[15] = '\0';
> > >
> > > -       rotat_align = resp_data[68];
> > > -       if (rotat_align) {
> > > -               cyapa->electrodes_rx = cyapa->electrodes_y;
> > > -               cyapa->electrodes_rx = cyapa->electrodes_y;
> > > -       } else {
> > > -               cyapa->electrodes_rx = cyapa->electrodes_x;
> > > -               cyapa->electrodes_rx = cyapa->electrodes_y;
> > > -       }
> > > +       cyapa->electrodes_rx = cyapa->electrodes_y;
> >
> > II think it was probably a typo rather than rotat_align being not
> > needed. Dudley?
> maybe some copy paste error. I thought it might have been
> cyapa->electrodes_ry but there is nothing like that.

Thanks for the correction. It should be my copy issue.
The variable cyapa->electrodes_rx was used to store the real physical Rx electrode direction.
Because the Rx direction in the signal data map may direction for the physical Rx electrode direction.
so it must be rotated when read and use the signal data map data.
This variable was currently used in for read the baseline of the Gen5 trackpad device.
And also it was used by the application to help display the real signal map on the trackpad device.

Following is the correction of this code, I will submit the patch to fix this thanks.
-if (rotat_align) {
+if (rotat_align)
cyapa->electrodes_rx = cyapa->electrodes_y;
-cyapa->electrodes_rx = cyapa->electrodes_y;
-       } else {
+else
cyapa->electrodes_rx = cyapa->electrodes_x;
-cyapa->electrodes_rx = cyapa->electrodes_y;
-       }

>
> regards
> sudip

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
