From: Pavel Machek <pavel@ucw.cz>
Subject: v4.1 to v4.7: regression in tsc2005 driver
Date: Sun, 17 Jul 2016 19:52:57 +0200
Message-ID: <20160717175257.GA26719@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, mwelling@ieee.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: pali.rohar@gmail.com, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-input@vger.kernel.org

Hi!

tsc2005 driver changed input device name, from

drivers/input/touchscreen/tsc2005.c:	  input_dev->name = "TSC2005
touchscreen";

to "TSC200X touchscreen". Unfortunately, X seems to propagate that
name to userspace, where it is needed to be able to do

xinput --set-prop --type=int ...

with the right arguments to calibrate touchscreen. (Touchscreen is
unusable without calibration).

What to do with that?

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
