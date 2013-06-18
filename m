From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: i2c-hid: support sending HID output reports
 using the output register
Date: Tue, 18 Jun 2013 10:58:13 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1306181057580.6750@pobox.suse.cz>
References: <1371510906-16859-1-git-send-email-aduggan@synaptics.com> <51C019DB.5070106@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51C019DB.5070106@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 18 Jun 2013, Benjamin Tissoires wrote:

> On 06/18/2013 01:15 AM, Andrew Duggan wrote:
> > The current i2c hid driver does not support sending HID output reports using
> > the output register for devices which support receiving reports through this
> > method. This patch determines which method to use to send output reports based
> >  on the value of wMaxOutputLength in the device's HID descriptor.
> > 
> > Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> 
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied, thanks guys.

-- 
Jiri Kosina
SUSE Labs
