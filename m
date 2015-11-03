From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/11] Input: synaptics-rmi4: various fixes for the
 existing rmi4 branch
Date: Tue, 3 Nov 2015 11:29:28 +0100
Message-ID: <CACRpkdZe+jVqq1T7OXb6SXGAPf+UWMBCok8OQo_WCzEdigEwuA@mail.gmail.com>
References: <1435087050-11444-1-git-send-email-benjamin.tissoires@redhat.com>
	<20150723171041.GA14941@mail.corp.redhat.com>
	<CACRpkdamzJbxaBjJGGC7gq7Vqadtn30creAk-S1vtg02OoA9RQ@mail.gmail.com>
	<5637E03B.5010804@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35781 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbbKCK33 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Nov 2015 05:29:29 -0500
Received: by oifu63 with SMTP id u63so6241292oif.2
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2015 02:29:29 -0800 (PST)
In-Reply-To: <5637E03B.5010804@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Nov 2, 2015 at 11:14 PM, Andrew Duggan <aduggan@synaptics.com> wrote:

> I think the biggest blocker right now is just the fact that it is a large
> body of code and there hasn't been enough continuous activity to on it. So
> whenever a new patch is posted, reviewers have to go through the time
> consuming process of relearning the code. But, there are a lot of RMI4
> devices out there without an upstreamed driver so I think it is worth doing.

OK I've offloaded Dmitry with reviews of this code in the past and I
can do it again.

I'd like to know what to review though and it needs to be posted to
the mailing list with a cover letter.

In the meantime I can clone your git and see if I can get it working
on my Ux500 TVK with the RMI4 Synaptics touchscreen.

Yours,
Linus Walleij
