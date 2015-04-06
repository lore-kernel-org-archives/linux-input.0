From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: cros_ec_keyb - Clear keyboard state only when
 it hasn't been a wake source
Date: Mon, 6 Apr 2015 09:47:40 -0700
Message-ID: <20150406164740.GE36770@dtor-ws>
References: <1427299718-22820-1-git-send-email-tomeu.vizoso@collabora.com>
 <55130243.4000209@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36217 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbbDFQrp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Apr 2015 12:47:45 -0400
Content-Disposition: inline
In-Reply-To: <55130243.4000209@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Doug Anderson <dianders@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Bill Richardson <wfrichar@chromium.org>, Todd Broch <tbroch@chromium.org>, linux-input@vger.kernel.org

On Wed, Mar 25, 2015 at 07:45:23PM +0100, Javier Martinez Canillas wrote:
> Hello Tomeu,
> 
> On 03/25/2015 05:08 PM, Tomeu Vizoso wrote:
> > As the comment right before explains, the keyboard state is to be
> > cleared only if the EC wasn't a wakeup source in the last suspend.
> > 
> > Without this commit, there's an unneeded delay when resuming from
> > suspend and we also lose the key that was pressed while suspended.
> > 
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > ---
> > 
> > Sorry, v1 included an unintended change.
> > 
> > Thanks,
> > 
> > Tomeu
> > 
> > ---
> >  drivers/input/keyboard/cros_ec_keyb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> > index 769f8f7..b50c5b8 100644
> > --- a/drivers/input/keyboard/cros_ec_keyb.c
> > +++ b/drivers/input/keyboard/cros_ec_keyb.c
> > @@ -341,7 +341,7 @@ static int cros_ec_keyb_resume(struct device *dev)
> >  	 * wake source (e.g. the lid is open and the user might press a key to
> >  	 * wake) then the key scan buffer should be preserved.
> >  	 */
> > -	if (ckdev->ec->was_wake_device)
> > +	if (!ckdev->ec->was_wake_device)
> >  		cros_ec_keyb_clear_keyboard(ckdev);
> >  
> 
> Your change matches the comment indeed and makes more sense.
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Applied, thank you.

-- 
Dmitry
