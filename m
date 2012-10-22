From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [BUG] capslock works across all keyboards but LED does not
Date: Mon, 22 Oct 2012 09:42:17 +0800
Message-ID: <CACVXFVN8s52UiSF0Q98sXNZzR9srnZ9aUjNYcZU6hDPfNzRGgA@mail.gmail.com>
References: <CACVXFVM8soazSixttzDBq-zLAxCpVNBDsDoz4Hc9gdsU8WQniA@mail.gmail.com>
	<21783709.sVZtM4k8zF@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:39489 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab2JVBmT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Oct 2012 21:42:19 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1TQ722-00044h-2e
	for linux-input@vger.kernel.org; Mon, 22 Oct 2012 01:42:18 +0000
Received: by mail-ee0-f46.google.com with SMTP id b15so775005eek.19
        for <linux-input@vger.kernel.org>; Sun, 21 Oct 2012 18:42:17 -0700 (PDT)
In-Reply-To: <21783709.sVZtM4k8zF@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Thu, Oct 18, 2012 at 1:30 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> I see it is broken in X, but it works for me if I am using the console.
> Does it work for you as well if you switch into the console? If so then
> you need to file a bug against X.

Thanks for your reply.

Unluckily, it becomes worse if I switch to console and capslock leds
in both keyborads are not changed but the function is OK.

So you mean the led is controlled by user-space totally? and Kernel
doesn't handle the case?

Thanks,
--
Ming Lei
