From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 2/2] HID: usbhid: add quirk for innomedia INNEX
 GENESIS/ATARI adapter
Date: Mon, 6 Mar 2017 14:04:53 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061404380.31814@cbobk.fhfr.pm>
References: <20170214231433.27060-1-tk@the-tk.com> <20170214231433.27060-3-tk@the-tk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170214231433.27060-3-tk@the-tk.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Kramkowski <tk@the-tk.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 14 Feb 2017, Tomasz Kramkowski wrote:

> The (1292:4745) Innomedia INNEX GENESIS/ATARI adapter needs
> HID_QUIRK_MULTI_INPUT to split the device up into two controllers
> instead of inputs from both being merged into one.
> 
> Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>

Applied to for-4.12/innomedia. Thanks Tomasz,

-- 
Jiri Kosina
SUSE Labs
