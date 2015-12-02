From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: [PATCH RFC 0/8] Input: atmel_mxt_ts - raw data via debugfs
Date: Wed,  2 Dec 2015 20:42:23 +0000
Message-ID: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yufeng Shen <miletus@google.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>
List-Id: linux-input@vger.kernel.org

Hello-

This is a series of patches to add diagnostic data support to the Atmel
maXTouch driver. There's an existing implementation in the open-source mxt-app
tool, however there are performance advantages to moving this code into the driver.
The algorithm for retrieving the data has been fairly consistent across a range of
chips, with the exception of the mXT1386 series (see patch).

The intention is to open-source a utility which can read/display this data, this
should be available very shortly.

It would be good if we could agree a single debugfs interface which could be
supported by all touchscreen chips that have this kind of feature, so I've attempted
to keep that part of this vendor neutral.

This patch sequence is also available from
    https://github.com/ndyer/linux/commits/diagnostic-debug

Any feedback appreciated.

Best regards

Nick Dyer
