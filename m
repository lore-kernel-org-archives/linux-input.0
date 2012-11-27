From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 04/11] HID: hid-multitouch: creates and handle stylus
 report with dual-sensors
Date: Tue, 27 Nov 2012 21:25:54 +0100
Message-ID: <20121127202554.GA901@polaris.bitmath.org>
References: <1353684694-5723-1-git-send-email-benjamin.tissoires@gmail.com>
 <1353684694-5723-5-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353684694-5723-5-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Nov 23, 2012 at 04:31:27PM +0100, Benjamin Tissoires wrote:
> Now that drivers can create new inputs, let's use this to split
> the reports coming from the pen and from the touch.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---
>  drivers/hid/hid-multitouch.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)

NAK on this one in its present form. I appreciate the idea, just not
the implementation, sorry.

Thanks,
Henrik
