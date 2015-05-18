From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] HID: i2c-hid: fix harmless test_bit() issue
Date: Mon, 18 May 2015 11:24:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505181124110.8186@pobox.suse.cz>
References: <20150514083330.GB1665@mwanda>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20150514083330.GB1665@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Antonio Borneo <borneo.antonio@gmail.com>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>, Andrew Duggan <aduggan@synaptics.com>, Gwendal Grignou <gwendal@chromium.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>
List-Id: linux-input@vger.kernel.org

On Thu, 14 May 2015, Dan Carpenter wrote:

> These defines are used like this:
> 
> 	if (test_bit(I2C_HID_STARTED, &ihid->flags))
> 
> The intent was to use bits 0, 1, and 2 but because of the extra shifts
> we're using bits 1, 2, and 4.  It's harmless becuase it's done
> consistently but it's not the intent and static checkers will complain.
> 
> Fixes: 4a200c3b9a40 ('HID: i2c-hid: introduce HID over i2c specification implementation')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to for-4.2/upstream, thanks Dan.

-- 
Jiri Kosina
SUSE Labs
