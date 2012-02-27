From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Mon, 27 Feb 2012 16:15:43 +0200
Message-ID: <CALu8Fe_h2=LCD+wmQbYBpF9m+yx+gYmkKf_nX3k69DOHktg_eA@mail.gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43476 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab2B0OPo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Feb 2012 09:15:44 -0500
Received: by vcqp1 with SMTP id p1so1502398vcq.19
        for <linux-input@vger.kernel.org>; Mon, 27 Feb 2012 06:15:44 -0800 (PST)
In-Reply-To: <1329773340-14066-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>, Nikolai Kondrashov <spbnick@gmail.com>

Hi Jiri,

On Mon, Feb 20, 2012 at 11:29 PM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> Add "have_special_driver" hid module parameter - a list of additional HID
> devices which have specialized driver on HID bus. Needed to support out-of-tree
> HID drivers.

Did you have time to take a look at the patch?
If there's anything wrong with it, please tell me and I'll fix it.

Thanks :)

Sincerely,
Nick
