From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Input: Elan HID-I2C device driver
Date: Wed, 11 Apr 2012 00:12:12 -0700
Message-ID: <20120411071212.GB6894@core.coreip.homeip.net>
References: <1334061766-20577-1-git-send-email-tom_lin@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55356 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902Ab2DKHMS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Apr 2012 03:12:18 -0400
Content-Disposition: inline
In-Reply-To: <1334061766-20577-1-git-send-email-tom_lin@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tom Lin <tom_lin@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, djkurtz@chromium.org

Hi Tom,

On Tue, Apr 10, 2012 at 08:42:46PM +0800, Tom Lin wrote:
> This patch adds driver for Elan I2C touchpad. These protocol of HID-I2C was
> defined by Microsoft. The kernel driver would use the multi-touch protocol
> format B.
> 

If this device truly supports HID protocol shouldn't we define i2c-hid
transport, similar to usbhid?

Thanks.

-- 
Dmitry
