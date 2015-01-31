From: Daniel Martin <consume.noise@gmail.com>
Subject: Re: [PATCH v2 3/5] Input: synaptics - Query min dimensions when safe
 firmware
Date: Sat, 31 Jan 2015 09:11:00 +0100
Message-ID: <20150131081100.GA27794@unplugged.fritz.box>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
 <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
 <1422347645-5194-4-git-send-email-daniel.martin@secunet.com>
 <CAN+gG=FqhKf1khX4bhtpsRAm2x62LP1PwkFkGFmu32TBMCd7yA@mail.gmail.com>
 <54CB48CA.60204@redhat.com>
 <CAN+gG=HTLTR_9cJpTsHPuUQ336EV_K6w6M1icOsrj7d6P_8eKg@mail.gmail.com>
 <54CC071B.3070606@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:47144 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbAaIKw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2015 03:10:52 -0500
Received: by mail-we0-f173.google.com with SMTP id w62so30827091wes.4
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2015 00:10:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54CC071B.3070606@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>

On Fri, Jan 30, 2015 at 02:35:07PM -0800, Andrew Duggan wrote:
> On 01/30/2015 07:41 AM, Benjamin Tissoires wrote:
> >On Fri, Jan 30, 2015 at 4:03 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> >>Hi,
> >>
> >>On 01/29/2015 07:48 PM, Benjamin Tissoires wrote:
> >>>Hi Daniel,
> >>>
> >>>in one hand I would like to see that upstream ASAP. But on the other
> >>>hand, I have some concerns here and there regarding this series.
> >>>
> >>>On Tue, Jan 27, 2015 at 3:34 AM, Daniel Martin
> >>><daniel.martin@secunet.com> wrote:
> >>>>From: Daniel Martin <consume.noise@gmail.com>
> >>>>
> >>>>Query the min dimensions even if the check
> >>>>     SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7
> >>>>fails, but we know that the firmware version is safe. Atm. this is
> >>>>version 8.1 only.
> >>>>
> >>>>With that we don't need quirks for post-2013 models anymore as they
> >>>>expose correct min and max dimensions.
> >>>>
> >>>>Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
> >>>>Signed-off-by: Daniel Martin <consume.noise@gmail.com>
> >>>>---
> >>>>  drivers/input/mouse/synaptics.c | 27 ++++++++++++++++++++++++++-
> >>>>  1 file changed, 26 insertions(+), 1 deletion(-)
> >>>>
> >>>>diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> >>>>index 7a78d75..37d4dff 100644
> >>>>--- a/drivers/input/mouse/synaptics.c
> >>>>+++ b/drivers/input/mouse/synaptics.c
> >>>>@@ -333,6 +333,30 @@ static int synaptics_identify(struct psmouse *psmouse)
> >>>>         return -1;
> >>>>  }
> >>>>
> >>>>+struct fw_version {
> >>>>+       unsigned char major;
> >>>>+       unsigned char minor;
> >>>>+};
> >>>>+
> >>>>+static const struct fw_version safe_fw_list[] = {
> >>>>+       {8, 1}, /* safe for SYN_QUE_EXT_MIN_COORDS */
> >>>>+       { }
> >>>>+};
> >>>>+
> >>>>+static bool synaptics_is_safe_fw(struct psmouse *psmouse)
> >>>>+{
> >>>>+       struct synaptics_data *priv = psmouse->private;
> >>>>+       int i;
> >>>>+
> >>>>+       for (i = 0; safe_fw_list[i].major; i++) {
> >>>>+               if (safe_fw_list[i].major == SYN_ID_MAJOR(priv->identity) &&
> >>>>+                   safe_fw_list[i].minor == SYN_ID_MINOR(priv->identity))
> >>>>+                       return true;
> >>>>+       }
> >>>>+
> >>>>+       return false;
> >>>>+}
> >>>This seems a little bit too much for just one firmware ID.
> >>>Plus the name safe_fw_list gives hope that this list can be used for
> >>>something else later, but then it may conflict with it current
> >>>purpose.
> >>>
> >>>How about we just rely on the current list of PNPIDs we already have
> >>>for this generation?
> >>>This might not be a good idea either, so an other solution would be to
> >>>directly check for firmware 8.1 in the test below.
> >>>
> >>>I'd like to hear other opinions on this however before we commit to a decision.
> >>I think that checking the firmware version, rather then relying on pnp-ids, is
> >>the right thing to do, this e.g. also gives us more accurate min/max values
> >>on the x230 / t430 series.
> >>
> >>As for using the list, rather then just the one id, I'm fine either way, the list
> >>is more future proof, which is why I acked this patch as is. But we could go
> >>with just a check for the single version now and extend this later if needed.
> >>
> >If you are fine either way, I would lean to have only one check. I am
> >not confident in the "future proof" way of having a list, because the
> >list is too tight to the current bug. But I think I already made my
> >point clear enough.
> >Also, we already reported this to Synaptics, and I think (hope) they
> >will fix this in their future FW.
> 
> What about just checking it the Reports Min bit is set and if it is assuming
> that the minimum coordinates query exists? The Reports Min bit should be
> reliable even if the number of extended queries above 5 is not. Or if that
> is too broad I would suggest checking if the firmware revision major is >=
> 8. I don't think a list is necessary.

I had this idea too. Then Hans pointed out that there are (older)
buggy firmwares having the min bit set, but not supporting the query and
sending an unsupported query might crash the firmware.

> Since it looks like this is still an issue on the 2014 systems I will file a
> firmware bug.
> 
> Andrew
> 
> >
> >Cheers,
> >Benjamin
> 
