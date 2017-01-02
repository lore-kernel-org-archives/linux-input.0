From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 0/2] Add support for the RainShadow Tech HDMI CEC adapter
Date: Mon, 2 Jan 2017 13:19:21 +0100
Message-ID: <9a66b5fe-c436-04ef-094e-77362a743f85@xs4all.nl>
References: <20161215130207.12913-1-hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lb3-smtp-cloud3.xs4all.net ([194.109.24.30]:40315 "EHLO
        lb3-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755294AbdABMT1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Jan 2017 07:19:27 -0500
In-Reply-To: <20161215130207.12913-1-hverkuil@xs4all.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-media@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>

Dmitry: ping!

And of course a happy New Year to you as well!

Regards,

	Hans

On 12/15/16 14:02, Hans Verkuil wrote:
> From: Hans Verkuil <hans.verkuil@cisco.com>
>
> This patch series adds support to the RainShadow Tech HDMI CEC adapter
> (http://rainshadowtech.com/HdmiCecUsb.html).
>
> The first patch adds the needed serio ID, the second adds the driver itself.
>
> Dmitry, will you take the first patch, or can we take it together with the
> second patch?
>
> This is of course for 4.11.
>
> Regards,
>
> 	Hans
>
> Hans Verkuil (2):
>   serio.h: add SERIO_RAINSHADOW_CEC ID
>   rainshadow-cec: new RainShadow Tech HDMI CEC driver
>
>  MAINTAINERS                                       |   7 +
>  drivers/media/usb/Kconfig                         |   1 +
>  drivers/media/usb/Makefile                        |   1 +
>  drivers/media/usb/rainshadow-cec/Kconfig          |  10 +
>  drivers/media/usb/rainshadow-cec/Makefile         |   1 +
>  drivers/media/usb/rainshadow-cec/rainshadow-cec.c | 344 ++++++++++++++++++++++
>  include/uapi/linux/serio.h                        |   1 +
>  7 files changed, 365 insertions(+)
>  create mode 100644 drivers/media/usb/rainshadow-cec/Kconfig
>  create mode 100644 drivers/media/usb/rainshadow-cec/Makefile
>  create mode 100644 drivers/media/usb/rainshadow-cec/rainshadow-cec.c
>

