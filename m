From: Ming Lei <ming.lei@canonical.com>
Subject: Re: [BUG] capslock works across all keyboards but LED does not
Date: Fri, 26 Oct 2012 08:56:13 +0800
Message-ID: <CACVXFVNCyQHExJ9f8=NpdjUJt=zKhCjahQgKajkCgUNh+ifL8Q@mail.gmail.com>
References: <CACVXFVM8soazSixttzDBq-zLAxCpVNBDsDoz4Hc9gdsU8WQniA@mail.gmail.com>
	<21783709.sVZtM4k8zF@dtor-d630.eng.vmware.com>
	<CACVXFVN8s52UiSF0Q98sXNZzR9srnZ9aUjNYcZU6hDPfNzRGgA@mail.gmail.com>
	<20121022155446.GB13791@core.coreip.homeip.net>
	<CACVXFVMbc3eBMj4gcAVDZjB4SJYwbLeVzUi13C62FMVYymgFug@mail.gmail.com>
	<20121023174834.GB649@core.coreip.homeip.net>
	<CACVXFVNpYrET-2GoLsKEmds2Ua0QnCNwN-q+31hewNDnmdpN9w@mail.gmail.com>
	<20121024052420.GB13826@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59924 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab2JZA4P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 20:56:15 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174])
	by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.71)
	(envelope-from <ming.lei@canonical.com>)
	id 1TRYDe-0008UN-7i
	for linux-input@vger.kernel.org; Fri, 26 Oct 2012 00:56:14 +0000
Received: by mail-ea0-f174.google.com with SMTP id c13so683086eaa.19
        for <linux-input@vger.kernel.org>; Thu, 25 Oct 2012 17:56:14 -0700 (PDT)
In-Reply-To: <20121024052420.GB13826@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, Oct 24, 2012 at 1:24 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> Do you have thinkpads platform driver loaded? What happens if you boot
> with it blacklisted?

Looks no change after blacklisting 'thinkpad_acpi' module.


Thanks,
--
Ming Lei
