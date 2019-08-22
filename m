From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH] HID: quirks: Disable runtime suspend on Microsoft Corp.
 Basic Optical Mouse v2.0
Date: Thu, 22 Aug 2019 11:45:51 +0200
Message-ID: <1566467151.8347.23.camel@suse.com>
References: <20190822091744.3451-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822091744.3451-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Donnerstag, den 22.08.2019, 17:17 +0800 schrieb Kai-Heng Feng:
> The optical sensor of the mouse gets turned off when it's runtime
> suspended, so moving the mouse can't wake the mouse up, despite that
> USB remote wakeup is successfully set.
> 
> Introduce a new quirk to prevent the mouse from getting runtime
> suspended.

Hi,

I am afraid this is a bad approach in principle. The device
behaves according to spec. And it behaves like most hardware.
If you do not want runtime PM for such devices, do not switch
it on. The refcounting needs to be done correctly.

This patch does something that udev should do and in a
questionable manner.

	Regards
		Oliver
