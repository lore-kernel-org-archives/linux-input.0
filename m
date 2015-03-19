From: Ramiro Morales <cramm0@gmail.com>
Subject: Re: [PATCH] Input: synaptics - quirk for Thinkpad E440
Date: Thu, 19 Mar 2015 12:17:13 -0300
Message-ID: <CAO7PdF-NNkxo5Ym2+Wf9Bd+d7pU7U3X0puN8QNj_cXpQfbf9qA@mail.gmail.com>
References: <1426761442-4823-1-git-send-email-cramm0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33750 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbbCSPRe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 11:17:34 -0400
Received: by qgfa8 with SMTP id a8so67843878qgf.0
        for <linux-input@vger.kernel.org>; Thu, 19 Mar 2015 08:17:34 -0700 (PDT)
In-Reply-To: <1426761442-4823-1-git-send-email-cramm0@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On Thu, Mar 19, 2015 at 7:37 AM, Ramiro Morales <cramm0@gmail.com> wrote:

> Subject: [PATCH] Input: synaptics - quirk for Thinkpad E440
>
> Its ClickPad shares PNP ID "LEN2006" with the one in model E540 which is
> already handled by the driver (both are Haswell iterations of the Edge
> line, launched in 2014) but the dimensions it reports are different:

Clarification: This patch is against the synaptics branch.

Regards,

-- 
Ramiro Morales
