From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Tue, 28 Feb 2012 15:30:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202281527250.31150@pobox.suse.cz>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <CALu8Fe_h2=LCD+wmQbYBpF9m+yx+gYmkKf_nX3k69DOHktg_eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37223 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085Ab2B1OaO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Feb 2012 09:30:14 -0500
In-Reply-To: <CALu8Fe_h2=LCD+wmQbYBpF9m+yx+gYmkKf_nX3k69DOHktg_eA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, 27 Feb 2012, Nikolai Kondrashov wrote:

> > Add "have_special_driver" hid module parameter - a list of additional 
> > HID devices which have specialized driver on HID bus. Needed to 
> > support out-of-tree HID drivers.
> 
> Did you have time to take a look at the patch?
> If there's anything wrong with it, please tell me and I'll fix it.

Hi Nikolai,

well, I am not really sure what value does it provide to have such 
functionality in the kernel.

I can understand that it helps you when developing out-of-tree (yet) 
drivers ... but as you are patching the kernel anyway with those drivers, 
you can easily run a kernel that has hid_have_special_driver[] array 
adjusted accordingly. And once you are submitting the driver for 
inclusion, you are of course submitting it together with 
hid_have_special_driver[] addition.

So it doesn't seem to be a debugging facility to me, and neither does it 
provide any added value for users of vanilla kernel.

Hmm?

Thanks,

-- 
Jiri Kosina
SUSE Labs
