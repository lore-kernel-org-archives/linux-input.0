From: Yann Cantin <yann.cantin@laposte.net>
Subject: ebeam PATCH (new eBeam input driver)
Date: Thu, 13 Dec 2012 08:07:42 +0100
Message-ID: <50C97EBE.20402@laposte.net>
References: <1349529287-23193-1-git-send-email-yann.cantin@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349529287-23193-1-git-send-email-yann.cantin@laposte.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-input@vger.kernel.org, gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

Do i need to resubmit the patchset for the next merge window ?

If so, do you guys prefer it against linus or next branch ?

For the record :

> New USB input driver for eBeam devices.
> 
> Currently supported (tested) :
> - Luidia eBeam classic projection and edge projection models
> - Nec "interactive solution" NP01Wi1 & NP01Wi2 accessories.
> 
> Patch 1 to blacklist the devices for hid generic-usb.
> 
> Patch 2 is the actual driver.

-- 
Yann Cantin
A4FEB47F
--
