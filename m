From: Oscar Campos <damnwidget@gmail.com>
Subject: Re: Input: mouse: Trackpoint middle button not recognized on
 Thinkpad E470
Date: Wed, 31 May 2017 22:02:35 +0100
Message-ID: <20170531210234.GA4820@ArchStation>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34290 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751056AbdEaVCj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 31 May 2017 17:02:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so6481032wmf.1
        for <linux-input@vger.kernel.org>; Wed, 31 May 2017 14:02:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ulrik.debie-os@e2big.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, aduggan@synaptics.com, Peter Hutterer <peter.hutterer@who-t.net>, Julian Exner <jexner@techfak.uni-bielefeld.de>

"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
aduggan@synaptics.com, Peter Hutterer <peter.hutterer@who-t.net>
Bcc:
Subject: Re: Input: mouse: Trackpoint middle button not recognized on
 Thinkpad E470
Reply-To:
In-Reply-To: <20170531191305.u4hkksajll4q7o5l@beacon.debie>

Hi guys.

I was a bit confused when I received this email as I did not knwow about
the previous thread, I did took a look at the mailing list as well as
the most up to date commits in the input branch to see if someone was
already working in a patch for this but I missed this one, sorry about
that.

I used 0x33 as it is described as one of the four valid responses from
the device (being them 0x22, 0x23, 0x32 and 0x33) the byte contains a
pair of nibbles, the most significant bits indicates how many hardware
buttons are present in the device while the lower ones indicates the
number of buttons that must be presented to the host. Looks like the
Linux kernel just takes care of the lower so 0x23 could had been used as
well but I think 0x33 that indicates three hardware buttons present and
all of them should be exposed was more appropiate.

I can confirm that I wrote the code (after all is just two lines of
code) I do not really care which patch goes into the mainline as soon as
one of them does, I got a Lenovo E570 a couple of months ago and I've been
manually patching my Manjaro kernel since then, it would be really nice
to don't have to do it anymore.

Regards.
Oscar

On Wed, May 31, 2017 at 09:13:05PM +0200, ulrik.debie-os@e2big.org wrote:
> Hi Julian, Oscar,
>
> Peter, you are right and it was even for Lenovo !
> Oscar, I reviewed the exact same patch proposed by Julian one month, as
> you can read below.
>
> Since he was missing some formalities in the way of submission I pointed
> him to submitting-patches.rst .
>
> I was kind of surprised at first that the value was 0x33 instead of 0x3
> until I read the documentation pointers Julian provided.
>
> I really would like this patch to become part of the linux kernel and
> I hope that Julian will go through the formalities for patch submission.
>
> Or alternatively, Oscar, can you confirm that you fully wrote the patch
> yourself and just happened to have the same diff as Julian.
>
> Dmitry, what do you suggest as the best way forward?
>
> Thanks,
> Kind regards,
> Ulrik
>
>
>
>
>
>
>
> On Fri, Apr 28, 2017 at 11:05:32PM +0200, ulrik.debie-os@e2big.org wrote:
> > Date:   Fri, 28 Apr 2017 23:05:32 +0200
> > From: ulrik.debie-os@e2big.org
> > To: Julian Exner <jexner@techfak.uni-bielefeld.de>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
> >  "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
> >  aduggan@synaptics.com
> > Subject: Re: Input: mouse: Trackpoint middle button not recognized on
> >  Thinkpad E470
> > X-Mailing-List: linux-input@vger.kernel.org
> >
> > Hi Julian,
> >
> > See below ..
> >
> > On Wed, Apr 26, 2017 at 11:18:44PM +0200, Julian Exner wrote:
> > > On 26/04/17 00:10, Dmitry Torokhov wrote:
> > > > Hmm.. I do not recall seeing real trackpoints with only 2 buttons. Let's
> > > > try defaulting to 3 and see what happens.
> > >
> > > This patch assumes three buttons when the trackpoint_read command failed.
> > > This is just a quick fix. trackpoint_read may fail for other reasons than
> > > the extended-button-data command not being available, e.g. errors in the ps2
> > > communication. A more narrow solution should check if a resend request was
> > > received, resend, and if the resend failed assume three buttons.
> >
> > > diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> > > index 354d47e..70c3a48 100644
> > > --- a/drivers/input/mouse/trackpoint.c
> > > +++ b/drivers/input/mouse/trackpoint.c
> > > @@ -380,8 +380,8 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
> > >  		return 0;
> > >
> > >  	if (trackpoint_read(&psmouse->ps2dev, TP_EXT_BTN, &button_info)) {
> > > -		psmouse_warn(psmouse, "failed to get extended button data\n");
> > > -		button_info = 0;
> > > +		psmouse_warn(psmouse, "failed to get extended button data, assuming 3 buttons are present\n");
> > > +		button_info = 0x33;
> > >  	}
> > >
> > >  	psmouse->private = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);
> >
> > Good, this patch is confirmed to make the trackpoint middle button work on
> > Thinkpad e570 when applied to vanilla 4.10 kernel.
> >
> > Now in order to submit the patch for inclusion to the linux kernel,
> > and before I'll grant a Reviewed-by: tag, it would be best when you
> > follow the guidelines in Documentation/SubmittingPatches
> > (recently moved to : Documentation/process/submitting-patches.rst )
> >
> > Attention points there are:
> > 2) Describe your changes
> > 6) No MIME
> > 11) Sign your work (Signed-off: line)
> > 14) The canonical patch format
> >
> > Thanks,
> > Kind regards,
> > Ulrik
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
