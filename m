From: Gregor Riepl <onitake@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Wed, 4 May 2016 01:35:48 +0200
Message-ID: <572935D4.6050303@gmail.com>
References: <CA+V1LzoXvWO1FROO2z7tFc-0zoM_Ur+B1iiar+EJ4uvn+DWGdQ@mail.gmail.com>
 <CA+V1LzpHBvYQ78Ky1XALvYZDy25NSP58upvue6GJCGQk+iE0fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36578 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756833AbcECXfv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2016 19:35:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so6801521wmw.3
        for <linux-input@vger.kernel.org>; Tue, 03 May 2016 16:35:50 -0700 (PDT)
In-Reply-To: <CA+V1LzpHBvYQ78Ky1XALvYZDy25NSP58upvue6GJCGQk+iE0fQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>, linux-input@vger.kernel.org

> At last I am releasing my icn85xx (tested on icn8528 on Chuwi Vi10,
> Baytrail) kernel space driver.
> It is unfortunately polling mode, but at the moment, I am happy with
> it and have no enough time to dig in with irq mode.
> 
> https://gitlab.com/SergK/icn85xx/tree/master

Good work!

A few comments - but bear in mind that I'm not an experienced kernel
developer. Someone else may be able to give better advice.

First: Patches to the kernel should be submitted according to these guidelines
at https://www.kernel.org/doc/Documentation/SubmittingPatches
In particular, a new driver should be a patch against the respective kernel
branch, which means it should live in the appropriate directory in the kernel
tree and include an addendum to the Kconfig/Makefile there. Standalone
Makefiles are nice when building drivers out-of-tree, but they are not
suitable for kernel code. This doesn't apply to your development repo, of
course. Testing may be easier when a driver can be built standalone.

Second: The patch should be formatted according to the Linux kernel coding
style at https://www.kernel.org/doc/Documentation/CodingStyle
There's also the checkpatch.pl utility in the kernel tree that can help you
find and fix mistakes.

But don't be discouraged by the lenghty guides - it's not that hard and
checkpatch helps a lot.

One thing I noticed on a quick glance is that line 833 in your code is
redundant. kzalloc aready clears the memory (hence, k_z_alloc).

Also: I highly recommend using devm_ variants of constructors, where
available. If you use those, you can reduce the footprint of your _remove()
function or even remove it completely. devm_input_allocate_device() is a good
example. You should use it instead of input_allocate_device(), and it will
take care of unregistering and deallocation automatically.
