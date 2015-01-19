From: Dudley Du <dudl@cypress.com>
Subject: RE: [PATCH v18 01/12] input: cyapa: re-design driver to support
 multi-trackpad in one driver
Date: Mon, 19 Jan 2015 01:45:48 +0000
Message-ID: <BN1PR06MB070D0832A48930BFA25C040D14A0@BN1PR06MB070.namprd06.prod.outlook.com>
References: <1421390055-32760-1-git-send-email-dudl@cypress.com>
 <1421390055-32760-2-git-send-email-dudl@cypress.com>
 <20150118082710.GC15720@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150118082710.GC15720@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "jmmahler@gmail.com" <jmmahler@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "bleung@google.com" <bleung@google.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: 2015?1?18? 16:27
> To: Dudley Du
> Cc: jmmahler@gmail.com; rydberg@euromail.se; bleung@google.com;
> linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v18 01/12] input: cyapa: re-design driver to support
> multi-trackpad in one driver
>
> Hi Dudley,
>
> On Fri, Jan 16, 2015 at 02:34:04PM +0800, Dudley Du wrote:
> > In order to support multiple different chipsets and communication protocols
> > trackpad devices in one cyapa driver, the new cyapa driver is re-designed
> > with one cyapa driver core and multiple device specific functions component.
> > The cyapa driver core is contained in this patch, it supplies basic functions
> > that working with kernel and input subsystem, and also supplies the interfaces
> > that the specific devices' component can connect and work together with as
> > one driver.
> > TEST=test on Chromebooks.
> >
> > Signed-off-by: Dudley Du <dudl@cypress.com>
> > ---
> >  drivers/input/mouse/Kconfig      |   10 -
> >  drivers/input/mouse/Makefile     |    3 +-
> >  drivers/input/mouse/cyapa.c      | 1076 +++++++++++++++-----------------------
> >  drivers/input/mouse/cyapa.h      |  296 +++++++++++
> >  drivers/input/mouse/cyapa_gen3.c |  807 ++++++++++++++++++++++++++++
> >  5 files changed, 1516 insertions(+), 676 deletions(-)
> >  create mode 100644 drivers/input/mouse/cyapa.h
> >  create mode 100644 drivers/input/mouse/cyapa_gen3.c
> >
> > diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
> > index 2541bfa..d8b46b0 100644
> > --- a/drivers/input/mouse/Kconfig
> > +++ b/drivers/input/mouse/Kconfig
> > @@ -146,16 +146,6 @@ config MOUSE_PS2_OLPC
> >
> >    If unsure, say N.
> >
> > -config MOUSE_PS2_FOCALTECH
> > -bool "FocalTech PS/2 mouse protocol extension" if EXPERT
> > -default y
> > -depends on MOUSE_PS2
> > -help
> > -  Say Y here if you have a FocalTech PS/2 TouchPad connected to
> > -  your system.
> > -
> > -  If unsure, say Y.
> > -
>
> Hmm, I wonder why you do not like Focaltech ;) I fixed it up locally, no
> need to resubmit.

Sorry, it should be my mistook to do the merge.
I don't want to remove the Focaltech.
I will correct it locally.

>
> Thanks.
>
> --
> Dmitry

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
