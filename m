From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: i2c-hid: set power sleep before shutdown
Date: Tue, 21 Jun 2016 13:09:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606211308590.6874@cbobk.fhfr.pm>
References: <1466504865-19907-1-git-send-email-ghzhong@yifangdigital.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466504865-19907-1-git-send-email-ghzhong@yifangdigital.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guohua Zhong <ghzhong@yifangdigital.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Benson Leung <bleung@chromium.org>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 21 Jun 2016, Guohua Zhong wrote:

> Add i2c_hid_shutdown for i2c-hid driver to send suspend cmd & free
> irq before device shutdown.
> 
> Some HW design (i.e. Umaro, a chromebook model) is that the power to
> i2c hid device won't down after device shutdown. Also the i2c-hid driver
> do not send suspend cmd to the hid i2c device and free its irq before
> shutdown.So if We touch the touchscreen or some other i2c hid device,
> the power consumtion will be go up even when the device is in shutdown
> state.
> 
> Though the root cause maybe a HW issue. But it seems that it is a
> good pratice to set power sleep for i2c-hid device before shutdown.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
