From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Atmel updates to atmel_mxt_ts touch controller driver - v5 Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan.Bowens@atmel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, bleung@chromium.org, olofj@chromium.org
Date: Wed,  5 Jun 2013 18:36:53 +0100
Message-ID: <1370453866-16534-1-git-send-email-nick.dyer@itdev.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan.Bowens@atmel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, bleung@chromium.org, olofj@chromium.org
List-Id: linux-input@vger.kernel.org

The following patches are an updated series of patches to the atmel_mxt_ts
touch driver. They should apply cleanly to input/next.

This is a combined patchset, I've been working to merge my changes with the
changes from the Chromium team. It's undergone a lot of testing and review
over the last few months and I believe it is now ready to go upstream.

Most of these changes have been maintained and tested out-of-tree in some form
for a long time. I apologise for the backlog.

We also provide a set of user-space utilities as open source which are
available from github and work well with this driver:
  https://github.com/atmel-maxtouch/obp-utils

You can see the in-between versions at
  https://github.com/ndyer/linux/

regards
--
Nick Dyer Senior Software Engineer
ITDev Hardware and Software Development Consultancy http://www.itdev.co.uk
