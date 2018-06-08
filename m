From: Marek Wyborski <marek.wyborski@emwesoft.com>
Subject: Re: [PATCH v3] input: bcm5974 - Add driver for Apple Magic Trackpad 2
Date: Fri, 8 Jun 2018 19:28:49 +0200
Message-ID: <CAMBc8znYhLsQ3EXa_H7L-+ypVzOSHiKUQqnR6gSCfjOLkdCp8g@mail.gmail.com>
References: <40764439.8xGR6LbaWR@positron.chronox.de> <2305311.UGlXl2onVb@positron.chronox.de>
 <1566223.3I8hjEaRec@tauon.chronox.de> <2373130.0OS7LSYeBT@tauon.chronox.de> <73c3d354-8aa8-e0c2-c4c4-658a65154394@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <73c3d354-8aa8-e0c2-c4c4-658a65154394@bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Stephan Mueller <smueller@chronox.de>, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Henrik!

I think you have been absolutely right about the MT2 support and that
it should be in hid-magicmouse and not in bcm5974. The more i am
working on the driver, the more i see your awesome work for multitouch
in the kernel and in xf86-mtrack as well. So i try to keep close to
the event reporting in bcm5974 and added the MT2 support to the
hid-magicmouse with USB and bluetooth support through the HID layer.
It already seems to do the trick, but some people are testing and i
will have to clean up the code. Then i will send in a new patch until
end of this month. It would be great if you could have a look at the
new patch, when i send it in.

Marek
