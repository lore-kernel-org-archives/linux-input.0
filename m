From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: uclogic: make input_mapping independent of usb
Date: Mon, 16 Mar 2015 15:48:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503161548090.25438@pobox.suse.cz>
References: <1426443987-4017-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426443987-4017-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, 15 Mar 2015, Benjamin Tissoires wrote:

> No need to retrieve the USB handle in input_mapping() when we already
> do that in probe. It also allows to use the quirk without having to
> add the product ID matching.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> changes in v2:
> - renamed ignore_pen_interface in ignore_pen_usage

Applied to for-4.1/huion-uclogic-merge.

-- 
Jiri Kosina
SUSE Labs
