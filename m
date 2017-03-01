From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH v14 5/5] mfd: Move binding document
Date: Wed,  1 Mar 2017 19:02:13 +0100
Message-ID: <caea9955cdabe87265c9e10695c2a464a2aa3a2d.1488380468.git.ksenija.stanojevic@gmail.com>
References: <cover.1488380468.git.ksenija.stanojevic@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36349 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdCASfN (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Mar 2017 13:35:13 -0500
In-Reply-To: <cover.1488380468.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1488380468.git.ksenija.stanojevic@gmail.com>
References: <cover.1488380468.git.ksenija.stanojevic@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: lee.jones@linaro.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de, linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com, fabio.estevam@freescale.com, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>

The bindings, which are now used in MFD, need also to be
documented in the MFD binding document.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
Changes in v14:
 - none

Changes in v13:
 - none

Changes in v12:
 - none

Changes in v11:
 - none

Changes in v10:
 - none

Changes in v9:
 - format patch using -M option

Changes in v8:
 - rebase onto 4.9-rc1

Changes in v7:
 - add to the patchset

 Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)

diff --git a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/mfd/mxs-lradc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
rename to Documentation/devicetree/bindings/mfd/mxs-lradc.txt
-- 
1.9.1

