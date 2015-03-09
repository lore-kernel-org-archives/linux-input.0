From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/6] Input: synaptics - Query min dimensions for fw
 v8.1
Date: Sun, 8 Mar 2015 23:43:53 -0700
Message-ID: <20150309064353.GC17331@dtor-ws>
References: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com>
 <1423237499-2930-4-git-send-email-benjamin.tissoires@redhat.com>
 <54D50490.7090303@gmail.com>
 <54D5D1F1.2050300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:33979 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408AbbCIGn6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 02:43:58 -0400
Content-Disposition: inline
In-Reply-To: <54D5D1F1.2050300@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Daniel Martin <consume.noise@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Feb 07, 2015 at 09:50:57AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 02/06/2015 07:14 PM, Benjamin Tissoires wrote:
> > 
> > 
> > On 02/06/2015 10:44 AM, Benjamin Tissoires wrote:
> >> From: Daniel Martin <consume.noise@gmail.com>
> >>
> >> Query the min dimensions even if the check
> >>      SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7
> >> fails, but we know that the firmware version 8.1 is safe.
> >>
> >> With that we don't need quirks for post-2013 models anymore as they
> >> expose correct min and max dimensions.
> >>
> >> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=91541
> >>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Daniel Martin <consume.noise@gmail.com>
> >>    re-order the tests to check SYN_CAP_MIN_DIMENSIONS even on FW 8.1
> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >> ---
> >> v2: Don't use a list for safe firmwares.
> >>
> >>   drivers/input/mouse/synaptics.c | 9 +++++++--
> >>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> >> index 0485e6b..19dc87f 100644
> >> --- a/drivers/input/mouse/synaptics.c
> >> +++ b/drivers/input/mouse/synaptics.c
> >> @@ -372,8 +372,13 @@ static int synaptics_resolution(struct psmouse *psmouse)
> >>           }
> >>       }
> >>
> >> -    if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 &&
> >> -        SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c)) {
> >> +    if (SYN_CAP_MIN_DIMENSIONS(priv->ext_cap_0c) &&
> >> +        (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 7 ||
> >> +         /* Firmware v8.1 doesn't stand the previous checks, though has
> >> +          * been proven to report correct min coordinates.
> >> +          *     https://bugzilla.kernel.org/show_bug.cgi?id=91541 */
> >> +         (SYN_ID_MAJOR(priv->identity) == 8 &&
> >> +          SYN_ID_MINOR(priv->identity) == 1))) {
> > 
> > Hmm... this can be actually read as:
> > +         SYN_ID_FULL(priv->identity) == 0x801)) {
> 
> And "checks" should be just "check" as the firmware check only is or-ed
> together with the >= 7 check (which is intentional but the comment suggests
> wrongly that it overrides both check_s_ .
> 
> Other then that the entire series looks good and is:
> 
> Acked-by: Hans de Goede <hdegoede@redhat.com>

Adjusted to use SYN_ID_FULL and adjusted the comment as well.

> 
> Regards,
> 
> Hans
> 
> 
> > 
> > Cheers,
> > Benjamin
> > 
> >>           if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MIN_COORDS, resp)) {
> >>               psmouse_warn(psmouse,
> >>                        "device claims to have min coordinates query, but I'm not able to read it.\n");
> >>

-- 
Dmitry
