From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: usbkbd: return proper error code
Date: Thu, 1 Sep 2016 13:21:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1609011320050.22028@cbobk.fhfr.pm>
References: <1472660901-1912-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472660901-1912-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 31 Aug 2016, Sudip Mukherjee wrote:

> Use proper error code instead of using -1 on failure to allocate
> memory. We may use the error code later in the caller.

But we don't. usb_kbd_probe() returns -ENOMEM in case usb_kbd_alloc_mem() 
fails anyway, so I fail to see the point of the change really.

-- 
Jiri Kosina
SUSE Labs
