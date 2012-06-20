From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH Stable 3.4.x] HID: hid-multitouch: fix wrong protocol
 detection
Date: Wed, 20 Jun 2012 18:28:12 +0200
Message-ID: <20120620162812.GA433@polaris.bitmath.org>
References: <1340111206-11659-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1340111206-11659-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jun 19, 2012 at 03:06:46PM +0200, benjamin.tissoires wrote:
> From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> 
> The previous implementation introduced a randomness in the splitting
> of the different touches reported by the device. This version is more
> robust as we don't rely on hi->input->absbit, but on our own structure.
> 
> This also prepares hid-multitouch to better support Win8 devices.
> 
> [commit 3ac36d15557d1bedfb1151d9911b9587b2d40759 in Linus' tree]
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
> ---
> 
> Hi Jiri,
> 
> This patch is a port of the one included in the future 3.5.
> I already had users complaining about the broken behavior in 3.4, then this
> respin for 3.4. Kernels 3.3 and below are not impacted by the bug.

    Acked-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
