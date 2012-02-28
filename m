From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Tue, 28 Feb 2012 17:12:36 +0200
Message-ID: <4F4CEEE4.7020204@gmail.com>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <CALu8Fe_h2=LCD+wmQbYBpF9m+yx+gYmkKf_nX3k69DOHktg_eA@mail.gmail.com> <alpine.LNX.2.00.1202281527250.31150@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54119 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855Ab2B1PMl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Feb 2012 10:12:41 -0500
Received: by eaah12 with SMTP id h12so2619623eaa.19
        for <linux-input@vger.kernel.org>; Tue, 28 Feb 2012 07:12:39 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1202281527250.31150@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Jiri,

On 02/28/2012 04:30 PM, Jiri Kosina wrote:
> well, I am not really sure what value does it provide to have such
> functionality in the kernel.
>
> I can understand that it helps you when developing out-of-tree (yet)
> drivers ...

It doesn't just help, it makes them possible. Without this parameter it is
not possible to have out-of-tree HID drivers. Currently, a driver won't be
used if it isn't in the hid_have_special_driver array, as you probably know.

> but as you are patching the kernel anyway with those drivers,
> you can easily run a kernel that has hid_have_special_driver[] array
> adjusted accordingly.

Me yes, but I can't expect tablet users to patch and build their kernels
every time their distributions update them.

> And once you are submitting the driver for inclusion, you are of course
> submitting it together with hid_have_special_driver[] addition.

Sure.

> So it doesn't seem to be a debugging facility to me, and neither does it
> provide any added value for users of vanilla kernel.

The current workflow is this:

1. The user buys a new tablet, which is not yet supported by the kernel.
2. I add and submit kernel support for it.

Now, until my patch gets into the user's distribution kernel (which takes
3 months minimum, but usually about 5), he/she should build a kernel with my
patch *every* time the distribution updates it, if the user whishes to keep
up with the security updates and have a working tablet.

This is a bit too much to expect from the regular graphics tablet users.

Ubuntu, for example, does lots of kernel releases even for LTS
distributions. Then, there are users who want to stay on an older kernel for
some reasons.

My plan is to have regular releases of a DKMS-enabled driver package, which
once installed is rebuilt and installed automatically with each kernel
update. The only additional required action would be putting "options hid
have_special_driver=usb:VID:PID" into modprobe.conf.

So, the full planned workflow is this:

1. The user buys a new tablet, which is not yet supported by the kernel.
2. I add and submit kernel support for it.
3. I release a new version of the DKMS-enabled driver package including
    support for the user's tablet.
4. The user downloads and installs the package variant for his distribution,
    say, a .deb.
5. The user adds the "options hid have_special_driver=usb:VID:PID" line into
    his modprobe.conf.
6. The tablet driver is automatically re-built and re-installed with each
    kernel update.
7. Once the distribution pushes a kernel release with his tablet driver, the
    user is free to remove the DKMS package.

It would also be useful to be able to send the user a DKMS package with an
experimental driver to have him easily install and test it. Currently I'm
forced to build whole kernel packages in these cases.

Another point in support of this change is that the usbhid module already
has "quirks" parameter, which is somewhat similar in purpose.

Thanks :)!

Sincerely,
Nick
