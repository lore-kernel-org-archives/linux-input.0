From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: mms114 - add support for mms152
Date: Wed, 20 Dec 2017 10:34:01 -0800
Message-ID: <20171220183401.65ykqabkrjx66ch3@dtor-ws>
References: <20171218124933.1803-1-simon@lineageos.org>
 <20171220153810.1961-1-simon@lineageos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34231 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755979AbdLTSeE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Dec 2017 13:34:04 -0500
Content-Disposition: inline
In-Reply-To: <20171220153810.1961-1-simon@lineageos.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Shields <simon@lineageos.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, devicetree@vger.kernel.org, Andi Shyti <andi.shyti@samsung.com>

[resending as plain text]

Hi Simon,

On Wed, Dec 20, 2017 at 9:38 AM, Simon Shields <simon@lineageos.org> wrote:
> MMS152 has no configuration registers, but the packet format used in
> interrupts is identical to mms114.

Since there seems to be renewed interest in mms114 driver, I would like for
it to get a facelift and switch to using the standard touchscreen
properties rather than the custom ones (we still need to keep compatibility
though). Also, we do not seem to have any in-tree users of the
mms114_platform_data structure. Can you please see if you  can:

- switch the driver to use the generic device properties
(device_property_*() API)
- use touchscreen_parse_properties() to parse the standard touchscreen
properties
- use touchscreen_report_pos() to report coordinates
- drop mms114_platform_data

Thanks!

-- 
Dmitry
