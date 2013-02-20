From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 4/7] hid: use hid_hw_request() instead of direct call to
 usbhid
Date: Wed, 20 Feb 2013 21:16:56 +0100
Message-ID: <20130220201656.GA1346@polaris.bitmath.org>
References: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
 <1360334256-22127-5-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1360334256-22127-5-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

> This allows the hid drivers to be independent from the transport layer.

Since the patch is pretty large, a few lines on how it was constructed
might be in order. Something like "by replacing all occurences of
usbhid_submit_report() by its hid_hw_request() counterpart".

Also, the list of dependency changes only contains the drivers that
actually become completely decoupled with this patch. The drivers that
also depend on the io wait are found in the next patch.

> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---

Thanks,
Henrik
