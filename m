From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Thu, 29 Mar 2012 11:00:42 +0300
Message-ID: <4F7416AA.1070704@gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <CALu8Fe_h2=LCD+wmQbYBpF9m+yx+gYmkKf_nX3k69DOHktg_eA@mail.gmail.com> <alpine.LNX.2.00.1202281527250.31150@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54427 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796Ab2C2IAx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 04:00:53 -0400
Received: by bkcik5 with SMTP id ik5so1669463bkc.19
        for <linux-input@vger.kernel.org>; Thu, 29 Mar 2012 01:00:51 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1202281527250.31150@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Jiri,

On 02/28/2012 04:30 PM, Jiri Kosina wrote:
> On Mon, 27 Feb 2012, Nikolai Kondrashov wrote:
>
>>> Add "have_special_driver" hid module parameter - a list of additional
>>> HID devices which have specialized driver on HID bus. Needed to
>>> support out-of-tree HID drivers.
>>
>> Did you have time to take a look at the patch?
>> If there's anything wrong with it, please tell me and I'll fix it.
>
> Hi Nikolai,
>
> well, I am not really sure what value does it provide to have such
> functionality in the kernel.

In addition to my other explanations, I know about 10 people who are using
my tablet drivers which are to be included into the 3.4 release. And these
are only those who contacted me. Now, they can't be helped, they will have
to build their own kernels until they can install an official one with the
drivers.

However, there are still many unsupported tablets and other devices which
could be made to work with a simple HID driver. If this or a similar
functionality is there, they will need to only build and install a few
modules, or just install a DKMS-enabled package for their distribution.
And the sooner that happens, the better.

I understand that this solution is somewhat hackish, but it matches the
generic HID driver's ignoring of devices. The only proper solution,
considering asynchronous module loading, would be to bind the generic HID
driver to all HID devices unconditionally and then rebind a specific driver
once it's loaded. Yet, I'm not sure how this would fit the device driver
model.

Thank you for your attention and sorry if I bother you unnecessarily :)

Sincerely,
Nick
