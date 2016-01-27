From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: rmi: Check that the device is a RMI device in
 suspend and resume callbacks
Date: Wed, 27 Jan 2016 22:41:48 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601272241250.21446@cbobk.fhfr.pm>
References: <1453851636-5490-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453851636-5490-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Rodrigo Gomes <rodrigo.toste.gomes@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tue, 26 Jan 2016, Andrew Duggan wrote:

> Commit 092563604217 ("HID: rmi: Disable scanning if the device is not a
> wake source") introduced a regression for devices which use hid-rmi to
> handle composite USB devices. The suspend or resume callbacks are not
> checking that the device is a RMI device before calling rmi_read or
> rmi_write. This results in dereferencing uninitialized variables on
> non RMI devices. This patch checks that the RMI_DEVICE flag is set before
> sending RMI commands to the device.
> 
> Reported-by: Rodrigo Gomes <rodrigo.toste.gomes@gmail.com>
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Applied to for-4.5/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
