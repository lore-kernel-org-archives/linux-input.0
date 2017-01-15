From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/5] nput: mpr121 - switch to use device tree probe
Date: Sun, 15 Jan 2017 15:07:01 -0800
Message-ID: <20170115230701.GC23285@dtor-ws>
References: <1484486144-27947-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33724 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdAOXHE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 15 Jan 2017 18:07:04 -0500
Content-Disposition: inline
In-Reply-To: <1484486144-27947-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>

On Sun, Jan 15, 2017 at 10:15:39PM +0900, Akinobu Mita wrote:
> This driver currently only supports legacy platform data probe.  This
> change adds device tree support and gets rid of platform data probe code
> since no one is actually using mpr121 platform data in the mainline.
> 
> This series also contains miscellaneous cleanup and bug fixes that
> mostly I found while playing with this driver.
> 
> * Changes since v1 (All changes are suggested by Dmitry Torokhov)
> - Add patch 'annotate PM methods as __maybe_unused'
> - Use for_each_set_bit() to search changed bit
> - Use linux,keycodes property instead of using matrix keymap API
> - Get rid of platform data
> 
> Akinobu Mita (5):
>   Input: mpr121 - annotate PM methods as __maybe_unused
>   Input: mpr121 - remove unused field in struct mpr121_touchkey
>   Input: mpr121 - set missing event capability
>   Input: mpr121 - handle multiple bits change of status register
>   Input: mpr121 - switch to device tree probe

Applied the lot (the last 2 with minor edits), thank you.

-- 
Dmitry
