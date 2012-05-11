From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] TWL6040: fix build error
Date: Fri, 11 May 2012 09:58:28 +0300
Message-ID: <4FACB894.7000304@ti.com>
References: <1336675473-24774-1-git-send-email-levinsasha928@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39187 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751548Ab2EKG6c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 May 2012 02:58:32 -0400
Received: by lahi5 with SMTP id i5so2506257lah.14
        for <linux-input@vger.kernel.org>; Thu, 10 May 2012 23:58:30 -0700 (PDT)
In-Reply-To: <1336675473-24774-1-git-send-email-levinsasha928@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: dmitry.torokhov@gmail.com, broonie@opensource.wolfsonicro.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On 05/10/2012 09:44 PM, Sasha Levin wrote:
> Fixes build error due to missing of_property_read_u32.

The reason I have not seen this is that I have CONFIG_OF_DEVICE selected
which will make the linux/of.h to be included in the linux/of_device.h

When I did sanity build check on x86 (64bit) I have not noticed any
breakage since the allmodconfig on 64bit does not build the
twl6040-vibra driver.

It is obvious that I need to improve my sanity kernel build testing.

> Signed-off-by: Sasha Levin <levinsasha928@gmail.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
