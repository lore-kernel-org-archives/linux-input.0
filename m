From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ABS_MT_TOUCH_MAJOR metric
Date: Thu, 22 May 2014 10:23:53 -0700
Message-ID: <20140522172353.GA1984@core.coreip.homeip.net>
References: <537DD98C.5090800@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:58535 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbaEVRX5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 May 2014 13:23:57 -0400
Received: by mail-pb0-f47.google.com with SMTP id rp16so2797585pbb.34
        for <linux-input@vger.kernel.org>; Thu, 22 May 2014 10:23:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <537DD98C.5090800@cypress.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferruh Yigit <fery@cypress.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

Hi Ferruh,

On Thu, May 22, 2014 at 02:03:40PM +0300, Ferruh Yigit wrote:
> Hi,
> 
> What is the metric of ABS_MT_TOUCH_MAJOR / ABS_MT_WIDTH_MAJOR events?
> 
> The Linux documentation
> <https://www.kernel.org/doc/Documentation/input/multi-touch-protocol.txt> says:
> "The length of the major axis of the contact. The length should be given
> in surface units. ..."
> 
> What does "surface units" means, is it millimeter or pixels?

It is whatever unit the device reports, similarly to ABS_MT_POSITION_X
and ABS_MT_POSITION_Y. Userspace can use EVIOCGABS to map device units
onto common units.

>From include/uapi/linux/input.h (struct input_absinfo):

 * Resolution for main axes (ABS_X, ABS_Y, ABS_Z) is reported in
 * units per millimeter (units/mm), resolution for rotational axes
 * (ABS_RX, ABS_RY, ABS_RZ) is reported in units per radian.

Hope this helps.

-- 
Dmitry
