From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Revert "HID: add NOGET quirk for Eaton Ellipse MAX
 UPS"
Date: Fri, 26 Oct 2018 17:11:05 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1810261710570.23511@cbobk.fhfr.pm>
References: <20181017070153.465-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181017070153.465-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Laurent Bigonville <bigon@bigon.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 17 Oct 2018, Benjamin Tissoires wrote:

> This reverts commit 67ddbb3e6568fb1820b2cc45b00c50702b114801.
> 
> 67ddbb3e656 ("HID: add NOGET quirk for Eaton Ellipse MAX UPS") was reported
> by Laurent Bigonville. It turns out that a later model Laurent got
> doesn't need the quirk after all.
> 
> My take is that Eaton upgraded their firmwares, so we don't need it
> anymore.
> 
> The old model was from 2012, so better make sure the new line works
> properly by removing the quirk. This allows upower to actually fetch
> the current data.
> 
> Reported-by: Laurent Bigonville <bigon@bigon.be>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Ok, fingers crossed. Applied,

-- 
Jiri Kosina
SUSE Labs
