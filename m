From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: rmi: introduce RMI driver for Synaptics touchpads
Date: Wed, 9 Apr 2014 16:03:22 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1404091603110.14588@pobox.suse.cz>
References: <1396892373-3330-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1396892373-3330-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 7 Apr 2014, Benjamin Tissoires wrote:

> This driver add support for RMI4 over USB or I2C.
> The current state is that it uses its own RMI4 implementation, but once
> RMI4 is merged upstream, the driver will be a transport driver for the
> RMI4 library.

Queuing for 3.16, thanks.

-- 
Jiri Kosina
SUSE Labs
