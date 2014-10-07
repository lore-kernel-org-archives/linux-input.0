From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/6] mfd: viperboard: fix platform-device id collision
Date: Tue, 7 Oct 2014 10:21:26 +0100
Message-ID: <20141007092126.GQ25331@lee--X1>
References: <1411728933-13351-1-git-send-email-johan@kernel.org>
 <1411728933-13351-2-git-send-email-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:39276 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbaJGJVc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Oct 2014 05:21:32 -0400
Received: by mail-ig0-f181.google.com with SMTP id r10so4343571igi.8
        for <linux-input@vger.kernel.org>; Tue, 07 Oct 2014 02:21:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1411728933-13351-2-git-send-email-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 26 Sep 2014, Johan Hovold wrote:

> Allow more than one viperboard to be connected by registering with
> PLATFORM_DEVID_AUTO instead of PLATFORM_DEVID_NONE.
>=20
> The subdevices are currently registered with PLATFORM_DEVID_NONE, whi=
ch
> will cause a name collision on the platform bus when a second viperbo=
ard
> is plugged in:

Applied to fixes.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
