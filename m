From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: rmi: Check that a device is a RMI device before
 calling RMI functions
Date: Thu, 19 Oct 2017 10:04:31 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1710191004050.9294@jbgna.fhfr.qr>
References: <1508290656-18871-1-git-send-email-aduggan@synaptics.com> <20171018084803.GE24559@mail.corp.redhat.com> <nycvar.YFH.7.76.1710181612470.9294@jbgna.fhfr.qr> <53863464-d70b-5970-2408-4cf7c1d3a94b@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53863464-d70b-5970-2408-4cf7c1d3a94b@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Hendrik Langer <hendrik.langer@gmx.de>
Cc: Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 18 Oct 2017, Hendrik Langer wrote:

> Tested-by: Hendrik Langer <hendrik.langer@gmx.de>
> 
> Confirmed, the patch fixes the probem for me.
> All freezes/Oops and rmi or input related error messages are gone. Even
> keyboard and touchpad are working now!

Thanks a lot for confirmation.

Now queued in for-4.14/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
