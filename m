From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC] Add support for the matrix keyboard used in
 Bachmann's OT200
Date: Wed, 12 Dec 2012 11:02:55 -0800
Message-ID: <20121212190255.GB10583@core.coreip.homeip.net>
References: <1355319341-26597-1-git-send-email-christian.gmeiner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:56466 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214Ab2LLTDJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Dec 2012 14:03:09 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so363475dak.19
        for <linux-input@vger.kernel.org>; Wed, 12 Dec 2012 11:03:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1355319341-26597-1-git-send-email-christian.gmeiner@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Christian,

On Wed, Dec 12, 2012 at 02:35:41PM +0100, Christian Gmeiner wrote:
> The used matrix keyboard controler (implemented via FPGA) supports
> two simultaneous key presses. The driver sends the raw register
> values for each key (row & column) to userspace.
> 
> In userspace a small tool is running, which reads a 'mapping'
> file, processes the key events and send the configured keycodes
> back to the kernel via uinput.

This is a bit roundabout way of doing it. Why can't the kernel driver
perform lookup in it's internal table and emit proper keycodes itself?
We have wealth of options for supplying keymaps to the kernel drivers,
including:

- platform data
- device tree data
- loading from userspace via EVIOCSKEYCODE ioctl.

Thanks.

-- 
Dmitry
