From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 3/7] HID: Kconfig: Remove explicit transport layer
 dependencies
Date: Wed, 20 Feb 2013 21:06:25 +0100
Message-ID: <20130220200625.GA1321@polaris.bitmath.org>
References: <1360334256-22127-1-git-send-email-benjamin.tissoires@gmail.com>
 <1360334256-22127-4-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1360334256-22127-4-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

> Most HID drivers (rightfully) only depend on the HID bus, not the
> specific transport layer. Remove such dependencies where applicable.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
> ---

I suppose you checked this list against newcomers as well, so:

    Acked-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
