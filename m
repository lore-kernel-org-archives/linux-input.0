From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: trackpoint: add new trackpoint firmware ID
Date: Mon, 13 Feb 2017 20:24:35 -0800
Message-ID: <20170214042435.GB19688@dtor-ws>
References: <1486695741-8969-1-git-send-email-aaron.ma@canonical.com>
 <20170212223859.GA15928@dtor-ws>
 <ade83a37-f7d2-eaf0-d40b-c49511049dd1@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33693 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbdBNEYj (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Feb 2017 23:24:39 -0500
Content-Disposition: inline
In-Reply-To: <ade83a37-f7d2-eaf0-d40b-c49511049dd1@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Aaron Ma <aaron.ma@canonical.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Mon, Feb 13, 2017 at 04:30:02PM -0800, Andrew Duggan wrote:
> On 02/12/2017 02:38 PM, Dmitry Torokhov wrote:
> >On Fri, Feb 10, 2017 at 11:02:21AM +0800, Aaron Ma wrote:
> >>Synaptics add new TP firmware ID: 0x2 and 0x3, for now both lower 2 bits
> >>are indicated as TP. Change the constant to bitwise values.
> >Hmm, I thought IBM/Lenovo owned trackpoint support... Andrew, is it
> >yours now?
> 
> No, it should still be Lenovo's trackpoint.

OK, I see, but are you aware of new firmware with new IDs? I am hesitant
to extend the list for something that hasn't changed for many years.

> 
> Andrew
> 
> >Aaron, what devices have these new trackpoints>?
> >
> >Thanks.
> >
> >>Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> >>Cc: stable@vger.kernel.org
> >>---
> >>  drivers/input/mouse/trackpoint.c | 3 ++-
> >>  drivers/input/mouse/trackpoint.h | 3 ++-
> >>  2 files changed, 4 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> >>index 7331084..9ff0f38 100644
> >>--- a/drivers/input/mouse/trackpoint.c
> >>+++ b/drivers/input/mouse/trackpoint.c
> >>@@ -265,7 +265,8 @@ static int trackpoint_start_protocol(struct psmouse *psmouse, unsigned char *fir
> >>  	if (ps2_command(&psmouse->ps2dev, param, MAKE_PS2_CMD(0, 2, TP_READ_ID)))
> >>  		return -1;
> >>-	if (param[0] != TP_MAGIC_IDENT)
> >>+	/* add new TP ID. */
> >>+	if (!(param[0] & TP_MAGIC_IDENT))
> >>  		return -1;
> >>  	if (firmware_id)
> >>diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
> >>index 5617ed3..8805575 100644
> >>--- a/drivers/input/mouse/trackpoint.h
> >>+++ b/drivers/input/mouse/trackpoint.h
> >>@@ -21,8 +21,9 @@
> >>  #define TP_COMMAND		0xE2	/* Commands start with this */
> >>  #define TP_READ_ID		0xE1	/* Sent for device identification */
> >>-#define TP_MAGIC_IDENT		0x01	/* Sent after a TP_READ_ID followed */
> >>+#define TP_MAGIC_IDENT		0x03	/* Sent after a TP_READ_ID followed */
> >>  					/* by the firmware ID */
> >>+					/* Firmware ID includes 0x1, 0x2, 0x3 */
> >>  /*
> >>-- 
> >>2.9.3
> >>
> 

-- 
Dmitry
