From: Petr Cvek <petr.cvek@tul.cz>
Subject: Re: [PATCH v2] ARM: pxa: magician: Add support for ADS7846
 touchscreen
Date: Mon, 13 Mar 2017 08:51:52 +0100
Message-ID: <f309f049-a0df-fcd5-efca-b7c4125cc6cc@tul.cz>
References: <65621425-91ac-1726-88ba-4626c85e7981@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:42746 "EHLO bubo.tul.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbdCMHuG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 03:50:06 -0400
In-Reply-To: <65621425-91ac-1726-88ba-4626c85e7981@tul.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

Dne 13.3.2017 v 01:25 Petr Cvek napsal(a):
> This patch adds a support for ADS7846 touchscreen driver.
> 
> The basic functionality was tested, x_plate_ohms and y_plate_ohms were
> physically measured. The value pressure_max was empirically set to match
> the measured range, which is affected by x_plate_ohms and ADS samples.
> 
> The value of keep_vref_on doesn't seem to have any effect on measurements
> (at least on T-Mobile MDA Compact PM10A device). Leave it to zero so
> the internal and external Vref sources will not collide.

Actually not, without vref on the touchscreen seems to be highly jittery.

Sending version 3 (fixed patch and a new commit message).

Petr

