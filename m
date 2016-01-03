From: =?UTF-8?Q?Cl=c3=a9ment_Vuchener?= <clement.vuchener@gmail.com>
Subject: Re: [PATCH 1/1] R.A.T.5 also works with hid-saitek
Date: Sun, 3 Jan 2016 11:45:29 +0100
Message-ID: <5688FBC9.1070403@gmail.com>
References: <56841599.5050800@users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35514 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbcACKpc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jan 2016 05:45:32 -0500
Received: by mail-wm0-f43.google.com with SMTP id f206so112772882wmf.0
        for <linux-input@vger.kernel.org>; Sun, 03 Jan 2016 02:45:31 -0800 (PST)
In-Reply-To: <56841599.5050800@users.sf.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Piotr Sawuk <piotr5@users.sf.net>, linux-input@vger.kernel.org

On 12/30/2015 06:34 PM, Piotr Sawuk wrote:
> sorry for the old kernel. tell me if it failed to apply.
You should send your patch to the appropriate maintainers (use the get_maintainer.pl script) and your patch should be inline (not an attachment). See documentation/SubmittingPatches for more information.
>
> and I have a question, since I know nothing of linux-programming:
> in include/linux/hidraw.h there is a struct hidraw defined.
> obviously one of these is assigned to each device.
> also hid-saitek.c uses that and stores its data inside.
> more exactly in ->hid->dev->mode is a value I'd like to read.
>From what I read, it uses the driver data pointer from the hid_device structure. As its name imply, it is a way for a driver to attach some data to a device for internal use (only the driver knows its meaning).
> what is the proper way to do that? is it possible from userspace?
> hid-saitek module removes information on what colour the mode-LED has.
> that information is stored in the mode variable of struct saitec_sc.
> since that struct is only defined in the c-sources, I have a problem?
> would it be sufficient to move that definition into include/?
> any suggestions on where to?
You can add a sysfs attribute to expose the value to userspace, you should find plenty of example code around.

If you have more questions, I suggest you send them to the kernelnewbies mailing list, you may get more help there.
>
> P

