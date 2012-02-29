From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Wed, 29 Feb 2012 23:23:36 +0200
Message-ID: <4F4E9758.9020908@gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <CALu8Fe_h2=LCD+wmQbYBpF9m+yx+gYmkKf_nX3k69DOHktg_eA@mail.gmail.com> <alpine.LNX.2.00.1202281527250.31150@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63176 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756341Ab2B2VXn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Feb 2012 16:23:43 -0500
Received: by eekc41 with SMTP id c41so1774940eek.19
        for <linux-input@vger.kernel.org>; Wed, 29 Feb 2012 13:23:42 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1202281527250.31150@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

On 02/28/2012 04:30 PM, Jiri Kosina wrote:
> well, I am not really sure what value does it provide to have such
> functionality in the kernel.
>
> I can understand that it helps you when developing out-of-tree (yet)
> drivers ... but as you are patching the kernel anyway with those drivers,
> you can easily run a kernel that has hid_have_special_driver[] array
> adjusted accordingly. And once you are submitting the driver for
> inclusion, you are of course submitting it together with
> hid_have_special_driver[] addition.
>
> So it doesn't seem to be a debugging facility to me, and neither does it
> provide any added value for users of vanilla kernel.

Maybe I did too extensive an explanation. Here is a shorter one.

This is not needed for development, but only for end users to be able to
load an out-of-tree driver before it becomes available in their
distribution.

Without this, they will need to build their own kernel with my patches every
time it is updated.

With this, they will even be able to use DKMS to have drivers built and
installed automatically with each kernel update.

My rationalization for this specific solution:
http://thread.gmane.org/gmane.linux.usb.general/58661/focus=58869

Sincerely,
Nick
