From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] usb: hid: Add new PID for Microchip Pick16F1454
Date: Fri, 8 Jan 2016 10:50:14 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601081050030.3402@cbobk.fhfr.pm>
References: <1452089333-32671-1-git-send-email-kristian.evensen@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452089333-32671-1-git-send-email-kristian.evensen@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristian Evensen <kristian.evensen@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 6 Jan 2016, Kristian Evensen wrote:

> From: Kristian Evensen <kristian.evensen@gmail.com>
> 
> There seems to be a new version of the Microchip Pick16F1454 with a
> different PID (0xf2f7). This device should also be ignored by the HID
> driver. The PID was observed with the second version of the Yepkit Ykush
> USB hub.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
