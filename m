From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] HID: wiimote: Parse calibration data of balance
 boards
Date: Mon, 17 Sep 2012 17:26:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209171725540.31149@pobox.suse.cz>
References: <1347877896-23939-1-git-send-email-dh.herrmann@googlemail.com> <1347877896-23939-2-git-send-email-dh.herrmann@googlemail.com> <50573FE0.6000003@butterbrot.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37027 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932086Ab2IQP0V (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 11:26:21 -0400
In-Reply-To: <50573FE0.6000003@butterbrot.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>, linux-input@vger.kernel.org

On Mon, 17 Sep 2012, Florian Echtler wrote:

> Darn, I just realized there may be an error here:
> 
> On 17.09.2012 12:31, David Herrmann wrote:
> >   drivers/hid/hid-wiimote-ext.c | 39 ++++++++++++++++++++++++++++++++++++++-
> >   1 file changed, 38 insertions(+), 1 deletion(-)
> > 
> > +	/* apply calibration data */
> > +	for (i = 0; i < 4; i++) {
> > +		if (val[i] < ext->calib[i][1]) {
> > +			tmp = val[i] - ext->calib[i][0];
> > +			tmp *= 1700;
> > +			tmp /= ext->calib[i][1] - ext->calib[i][0];
> > +		} else {
> > +			tmp = val[i] - ext->calib[i][1];
> > +			tmp *= 1700;
> > +			tmp /= ext->calib[i][2] - ext->calib[i][1] + 1700;
> I think this is not exactly the same formula as in my original patch; I'm
> quite sure this should read:
> 
> 	tmp /= ext->calib[i][2] - ext->calib[i][1];
> 	tmp += 1700;
> 
> instead.

Please send a followup patch if that's the case, as I have already pushed 
out the wiimote branch.

Thanks,

-- 
Jiri Kosina
SUSE Labs
