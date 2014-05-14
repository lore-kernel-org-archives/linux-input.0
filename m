From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: pxa27x-keypad: bug fix of getting scan code
Date: Tue, 13 May 2014 23:12:05 -0700
Message-ID: <20140514061205.GA13621@core.coreip.homeip.net>
References: <1390797697-29217-1-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:54133 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbaENGMJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 May 2014 02:12:09 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so891279pbc.15
        for <linux-input@vger.kernel.org>; Tue, 13 May 2014 23:12:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1390797697-29217-1-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chao Xie <chao.xie@marvell.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, xiechao.mail@gmail.com

On Mon, Jan 27, 2014 at 12:41:37PM +0800, Chao Xie wrote:
> From: Chao Xie <chao.xie@marvell.com>
> 
> The rows of pxa27x-keypad used by each boards are not fixed.
> So in the driver, it will get the rows from DT and register
> the keymap as:
> matrix_keypad_build_keymap(keymap_data, NULL,
>                            pdata->matrix_key_rows,
>                            pdata->matrix_key_cols,
>                            keypad->keycodes, input_dev);
> 
> But the scan code is gotten as
> MATRIX_SCAN_CODE(row, col, MATRIX_ROW_SHIFT);
> It is not correct. Fix it as
> MATRIX_SCAN_CODE(row, col, keypad->row_shift);
> 
> row_shift is calculated from pdata->matrix_key_rows.
> 
> Signed-off-by: Chao Xie <chao.xie@marvell.com>

Applied with minor edits, thank you.

-- 
Dmitry
