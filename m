From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: wacom - add support for three new Intuos devices
Date: Thu, 03 Oct 2013 14:54:33 -0700
Message-ID: <2980943.RVh73cvMGD@dtor-d630.eng.vmware.com>
References: <1380833590-25267-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:61920 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414Ab3JCVyi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Oct 2013 17:54:38 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so3091178pdj.34
        for <linux-input@vger.kernel.org>; Thu, 03 Oct 2013 14:54:38 -0700 (PDT)
In-Reply-To: <1380833590-25267-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, chris@cnpbagwell.com, Ping Cheng <pingc@wacom.com>

On Thursday, October 03, 2013 01:53:10 PM Ping Cheng wrote:
> This series of models added a hardware switch to turn touch
> data on/off. To report the state of the switch, SW_TOUCH_ENABLED
> is added in include/uapi/linux/input.h.


Hmm, should we just postpone creating of input device until touch is enabled 
instead?

-- 
Dmitry
