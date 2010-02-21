From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: add driver for Roccat Kone gaming mouse
Date: Sun, 21 Feb 2010 00:13:27 -0800
Message-ID: <20100221081327.GB18298@core.coreip.homeip.net>
References: <201002200911.53900.stefan_achatz@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201002200911.53900.stefan_achatz@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Achatz <stefan_achatz@web.de>
Cc: Jiri Kosina <jkosina@suse.cz>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, wylda@volny.cz, Pavel Machek <pavel@suse.cz>, Alessandro Guido <ag@alessandroguido.name>, Tomas Hanak <tomas.hanak@gmail.com>, Jason Noble <nobleja@polezero.com>, simon.windows@gmail.com, Sean Hildebrand <silverwraithii@gmail.com>, Sid Boyce <sboyce@blueyonder.co.uk>, Henning Glawe <glaweh@debian.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Stefan,

On Sat, Feb 20, 2010 at 09:11:53AM +0100, Stefan Achatz wrote:
> This Patch adds support for Kone gaming mouse from Roccat.
> It provides access to profiles, settings, firmware, weight,
> actual settings etc. through sysfs files.

There is no documentation provided for all these new sysfs attributes
so it is really hard to judge their usefullness. For example why would
one care about weight?

Thanks.

-- 
Dmitry
