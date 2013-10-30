From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wiimote: add pro-controller analog stick
 calibration
Date: Wed, 30 Oct 2013 14:15:58 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1310301415460.21144@pobox.suse.cz>
References: <1382978960-849-1-git-send-email-dh.herrmann@gmail.com> <7969D126-74F7-4B91-9B5C-213AC76B3A66@rbrune.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49412 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333Ab3J3NQC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Oct 2013 09:16:02 -0400
In-Reply-To: <7969D126-74F7-4B91-9B5C-213AC76B3A66@rbrune.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafael Brune <mail@rbrune.de>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Wed, 30 Oct 2013, Rafael Brune wrote:

> > The analog sticks of the pro-controller might report slightly off values.
> > To guarantee a uniform setup, we now calibrate analog-stick values during
> > pro-controller setup.
> > 
> > Unfortunately, the pro-controller fails during normal EEPROM reads and I
> > couldn't figure out whether there are any calibration values stored on the
> > device. Therefore, we now use the first values reported by the device (iff
> > they are not _way_ off, which would indicate movement) to initialize the
> > calibration values. To allow users to change this calibration data, we
> > provide a pro_calib sysfs attribute.
> > 
> > We also change the "flat" values so user-space correctly smoothes our
> > data. It makes slightly off zero-positions less visible while still
> > guaranteeing highly precise movement reports. Note that the pro controller
> > reports zero-positions in a quite huge range (at least: -100 to +100).
> > 
> > Reported-by: Rafael Brune <mail@rbrune.de>
> > Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> 
> Tested-by: Rafael Brune <mail@rbrune.de>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
