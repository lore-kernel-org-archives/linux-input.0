From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/26] Input: synaptics-rmi4 - embed the function modules
 in rmi_core
Date: Mon, 9 Nov 2015 15:06:35 -0800
Message-ID: <20151109230635.GC9155@dtor-ws>
References: <1446766578-30160-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34933 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbbKIXGi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Nov 2015 18:06:38 -0500
Content-Disposition: inline
In-Reply-To: <1446766578-30160-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On Thu, Nov 05, 2015 at 03:36:18PM -0800, Andrew Duggan wrote:
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> the function modules can not be auto-loaded by udev. So at boot, the
> functions are not there and the device is not properly populated.
> Force the functions to be embedded in rmi_core so that when the touchpad
> is there, the functions are there too.

There is nothing inherently different in RMI compared to other buses.
kmod package simply needs to be aware of it.

Thanks.

-- 
Dmitry
