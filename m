From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH V2 4/4] Input: pxa27x_keypad add choice to set direct_key_mask
Date: Sun, 01 Apr 2012 01:44:32 +0400
Message-ID: <4F777AC0.8040304@mvista.com>
References: <1333072698-15344-1-git-send-email-chao.xie@marvell.com> <1333072698-15344-4-git-send-email-chao.xie@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:50722 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab2CaVqD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 17:46:03 -0400
Received: by bkcik5 with SMTP id ik5so1502102bkc.19
        for <linux-input@vger.kernel.org>; Sat, 31 Mar 2012 14:46:01 -0700 (PDT)
In-Reply-To: <1333072698-15344-4-git-send-email-chao.xie@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chao Xie <chao.xie@marvell.com>
Cc: linux-input@vger.kernel.org, eric.y.miao@gmail.com, haojian.zhuang@marvell.com, linux-arm-kernel@lists.infradead.org

Hello.

On 30-03-2012 5:58, Chao Xie wrote:

> Direct keys usage may not start from KP_DKIN0, add a msk option
> to configure the specifics for platforms that can skip some keys.

> Change-Id: Ia8fd28254fec9595dcf39f12a78392c1e8b675eb

    Remove this line please -- it has no place in upstream patch.

> Signed-off-by: Chao Xie <chao.xie@marvell.com>

WBR, Sergei
