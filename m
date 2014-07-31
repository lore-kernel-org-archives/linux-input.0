From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 05/06] input synaptics-rmi4: Add firmware update
 support
Date: Thu, 31 Jul 2014 10:53:23 -0700
Message-ID: <20140731175323.GB5631@core.coreip.homeip.net>
References: <1394675637-23853-1-git-send-email-cheiny@synaptics.com>
 <1394675637-23853-5-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:60591 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaGaRx1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2014 13:53:27 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so4038104pab.15
        for <linux-input@vger.kernel.org>; Thu, 31 Jul 2014 10:53:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1394675637-23853-5-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Hi Christopher,

On Wed, Mar 12, 2014 at 06:53:56PM -0700, Christopher Heiny wrote:
> Add support for updating firmware on RMI4 devices with V5 bootloader.

I am wondering why F34 is not following the staindard RMI function
implementation. By that I mean that it does not declare itself as struct
rmi_function_handler and does not rely on RMI core to bind itself to the device
if device supports it.

By the way, isn't rmi_extract_u32() is the same as le32_to_cpup()?

Thanks.

-- 
Dmitry
