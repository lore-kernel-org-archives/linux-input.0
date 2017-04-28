From: ulrik.debie-os@e2big.org
Subject: Re: Input: mouse: Trackpoint middle button not recognized on
 Thinkpad E470
Date: Fri, 28 Apr 2017 23:05:32 +0200
Message-ID: <20170428210531.3mfkua2lxj36yx2p@beacon.debie>
References: <13710506-2225-9f81-40e3-7463ac829860@techfak.uni-bielefeld.de>
 <f516c725-48d8-6f82-5ac7-c6afee303e59@techfak.uni-bielefeld.de>
 <20170425211633.bl72ajw5duwdpq4j@beacon.debie>
 <20170425221014.GD30843@dtor-ws>
 <a1682c1c-3894-0439-f224-b6c6fc73eba6@techfak.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:48593 "EHLO e2big.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938643AbdD1VFl (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 17:05:41 -0400
Content-Disposition: inline
In-Reply-To: <a1682c1c-3894-0439-f224-b6c6fc73eba6@techfak.uni-bielefeld.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julian Exner <jexner@techfak.uni-bielefeld.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, aduggan@synaptics.com

Hi Julian,

See below ..

On Wed, Apr 26, 2017 at 11:18:44PM +0200, Julian Exner wrote:
> On 26/04/17 00:10, Dmitry Torokhov wrote:
> > Hmm.. I do not recall seeing real trackpoints with only 2 buttons. Let's
> > try defaulting to 3 and see what happens.
> 
> This patch assumes three buttons when the trackpoint_read command failed.
> This is just a quick fix. trackpoint_read may fail for other reasons than
> the extended-button-data command not being available, e.g. errors in the ps2
> communication. A more narrow solution should check if a resend request was
> received, resend, and if the resend failed assume three buttons.

> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> index 354d47e..70c3a48 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -380,8 +380,8 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
>  		return 0;
>  
>  	if (trackpoint_read(&psmouse->ps2dev, TP_EXT_BTN, &button_info)) {
> -		psmouse_warn(psmouse, "failed to get extended button data\n");
> -		button_info = 0;
> +		psmouse_warn(psmouse, "failed to get extended button data, assuming 3 buttons are present\n");
> +		button_info = 0x33;
>  	}
>  
>  	psmouse->private = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);

Good, this patch is confirmed to make the trackpoint middle button work on
Thinkpad e570 when applied to vanilla 4.10 kernel.

Now in order to submit the patch for inclusion to the linux kernel,
and before I'll grant a Reviewed-by: tag, it would be best when you
follow the guidelines in Documentation/SubmittingPatches  
(recently moved to : Documentation/process/submitting-patches.rst )

Attention points there are: 
2) Describe your changes 
6) No MIME 
11) Sign your work (Signed-off: line) 
14) The canonical patch format

Thanks,
Kind regards,
Ulrik
