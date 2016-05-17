From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to
 report multitouch data
Date: Tue, 17 May 2016 19:47:07 +0200
Message-ID: <1463507227.3440.9.camel@hadess.net>
References: <1463062363-12405-1-git-send-email-benjamin.tissoires@redhat.com>
	 <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2016-05-12 at 16:12 +0200, Benjamin Tissoires wrote:
> There is no reasons to filter out keyboard and consumer control
> collections
> in hid-multitouch.
> With the previous hid-input fix, there is now a full support of the
> Type
> Cover and we can remove all specific bits from hid-core and hid-
> microsoft.
> 
> hid-multitouch will automatically set HID_QUIRK_NO_INIT_REPORTS so we
> can
> also remove it from the list of ushbid quirks.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Works on my machine with up to 3 simultaneous touchpoints. A 4th one
releases all fingers (is that expected?).

Tested-by: Bastien Nocera <hadess@hadess.net>
