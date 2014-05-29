From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: joydev devices are world readable
Date: Thu, 29 May 2014 11:46:56 +0200
Message-ID: <CANq1E4R+-o972FyFLQ3RVyma9ratqQmoNMr-J3vv+Y2ckuL6yg@mail.gmail.com>
References: <op.xgl3pdtz5k9y7g@alice.jkfloris.demon.nl>
	<CANq1E4QOOimhZ9pDLkRMvPYZBko8sWZiugHKgYwBR1gb7CKW5w@mail.gmail.com>
	<op.xgl708il5k9y7g@alice.jkfloris.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:64665 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932795AbaE2Jq5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 05:46:57 -0400
Received: by mail-yk0-f182.google.com with SMTP id 9so51882ykp.27
        for <linux-input@vger.kernel.org>; Thu, 29 May 2014 02:46:56 -0700 (PDT)
In-Reply-To: <op.xgl708il5k9y7g@alice.jkfloris.demon.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Floris <jkfloris@dds.nl>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Thu, May 29, 2014 at 11:44 AM, Floris <jkfloris@dds.nl> wrote:
>> I posted an explanation on systemd-devel [1] this morning. Please note
>> that this is a policy-issue created in user-space. The kernel-side
>> cannot help you there. Furthermore, the kernel recommends using evdev
>> instead of joydev and friends. Therefore, I cannot see what you expect
>> from us.
>
>
> just curious. If the joydev module is not recommended, why is it still
> available and used?

Linux has strict backwards-compatibility rules. Therefore, we cannot
remove joydev. However, we can decide to mark it obsolete, which means
we will not extend it anymore. Furthermore, we cannot force anyone to
stop using joydev, so we have to continue supporting it.

Thanks
David
