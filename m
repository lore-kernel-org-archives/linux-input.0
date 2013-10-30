From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wiimote: fix inverted pro-controller axes
Date: Wed, 30 Oct 2013 14:15:42 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1310301415330.21144@pobox.suse.cz>
References: <1382978873-802-1-git-send-email-dh.herrmann@gmail.com> <1530A042-4C08-422E-A162-2057D250D325@rbrune.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1530A042-4C08-422E-A162-2057D250D325@rbrune.de>
Sender: stable-owner@vger.kernel.org
To: Rafael Brune <mail@rbrune.de>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 30 Oct 2013, Rafael Brune wrote:

> > The analog-stick vertical axes are inverted. Fix that! Otherwise, games
> > and other gamepad applications need to carry their own fixups (which they
> > thankfully haven't done, yet).
> > 
> > Cc: <stable@vger.kernel.org> # 3.11+
> > Reported-by: Rafael Brune <mail@rbrune.de>
> > Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> Tested-by: Rafael Brune <mail@rbrune.de>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
