From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] alps: Fix finger jumps on lifting 2 fingers on v7
 touchpad
Date: Wed, 20 May 2015 11:00:06 -0700
Message-ID: <20150520180006.GE23809@dtor-ws>
References: <1432113413-7007-1-git-send-email-hdegoede@redhat.com>
 <20150520164016.GB23809@dtor-ws>
 <555CC6E4.8020806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34651 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbbETSAL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 May 2015 14:00:11 -0400
Received: by ieczm2 with SMTP id zm2so45388338iec.1
        for <linux-input@vger.kernel.org>; Wed, 20 May 2015 11:00:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <555CC6E4.8020806@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org

On Wed, May 20, 2015 at 07:39:48PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 20-05-15 18:40, Dmitry Torokhov wrote:
> >On Wed, May 20, 2015 at 11:16:53AM +0200, Hans de Goede wrote:
> >>On v7 touchpads sometimes when 2 fingers are moved down on the touchpad
> >>until they "fall of" the touchpad, the second touch will report 0 for y
> >>(max y really since the y axis is inverted) and max x as coordinates,
> >>rather then reporting 0, 0 as is expected for a non touching finger.
> >>
> >>This commit detects this and treats these touches as non touching.
> >>
> >>See the evemu-recording here:
> >>https://bugzilla.redhat.com/attachment.cgi?id=1025058
> >>
> >>BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1221200
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>  drivers/input/mouse/alps.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >>diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> >>index 745921f..9bc4343 100644
> >>--- a/drivers/input/mouse/alps.c
> >>+++ b/drivers/input/mouse/alps.c
> >>@@ -949,6 +949,11 @@ static void alps_get_finger_coordinate_v7(struct input_mt_pos *mt,
> >>  	case V7_PACKET_ID_TWO:
> >>  		mt[1].x &= ~0x000F;
> >>  		mt[1].y |= 0x000F;
> >>+		/* Detect false-postive touches where x & y report max value */
> >>+		if (mt[1].y == 0x7ff && mt[1].x == 0xff0) {
> >>+			mt[1].x = 0;
> >>+			/* y gets set to 0 at the end of this function */
> >
> >I think this is too fragile; I believe we can spare an assignment and
> >maybe compiler will optimize it out.
> >
> >I can fix it up locally unless there are objections to having this extra
> >assignment.
> 
> I object to having the extra assignment, the comment is there, because the setting
> to 0 at the end of the function is done in the form of:
> 
>         mt[0].y = 0x7FF - mt[0].y;
>         mt[1].y = 0x7FF - mt[1].y;
> 
> So if you add a "mt[1].y = 0" assignment in stead of the comment then you're
> actually making mt[1].y = 0x7ff instead of 0, that is why there is a comment
> there instead of an assignment. Feel free to modify the comment to make this
> more clear ...
> 
> And yes normally the firmware sends 0x7ff for y and 0 for x when there is no touch,
> except sometimes it glitches and it sends 0x7ff for y and 0xff0 for x when there is
> no touch, which is what this commit catches (this has been tested by the reporter).

Ah, I see.

Thanks.

-- 
Dmitry
