From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: rmi: Make hid-rmi a transport driver for
 synaptics-rmi4
Date: Wed, 15 Jun 2016 09:23:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606150923310.6874@cbobk.fhfr.pm>
References: <1464979306-2771-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464979306-2771-1-git-send-email-aduggan@synaptics.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Nick Dyer <nick.dyer@itdev.co.uk>
List-Id: linux-input@vger.kernel.org

On Fri, 3 Jun 2016, Andrew Duggan wrote:

> The Synaptics RMI4 driver provides support for RMI4 devices. Instead of
> duplicating the RMI4 processing code, make hid-rmi a transport driver
> and register it with the Synaptics RMI4 core.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Is there any update on the Input series please?

Thanks,

-- 
Jiri Kosina
SUSE Labs
