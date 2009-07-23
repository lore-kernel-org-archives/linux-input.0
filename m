From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: drivers/usb/class/cdc-acm.c patch kernel 2.6.31.-rc1
Date: Wed, 22 Jul 2009 23:25:33 -0700
Message-ID: <20090723062533.GC2782@dtor-d630.eng.vmware.com>
References: <C01FCF206F5D8D4C89B210408D7DB39C12ED1F@mail2.oerlikon.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:44946 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbZGWGZh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2009 02:25:37 -0400
Received: by rv-out-0506.google.com with SMTP id f6so204212rvb.1
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2009 23:25:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <C01FCF206F5D8D4C89B210408D7DB39C12ED1F@mail2.oerlikon.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Weng, Wending" <WWeng@rheinmetall.ca>
Cc: linux-input@vger.kernel.org

On Wed, Jul 22, 2009 at 05:08:50PM -0400, Weng, Wending wrote:
> From 39e8558a114297ee9192f406d63f423aded05288 Mon Sep 17 00:00:00 2001
> From: root <root@SBC_PC_3.localdomain>
> Date: Tue, 21 Jul 2009 10:48:15 -0400
> vers/usb/class/cdc-acm.cSubject: [PATCH] When the usb-serial cable is unpluged, the usb host controller driver returns all scheduled URBs to usb-serial driver(cdc-acm.c), and the usb-serial driver(cdc-acm.c) doesn't detect this exception, continues to schedule the URBs, it causes a dead loop.
> This change fixes this problem.
> 
> Signed-off-by: Wending Weng <wweng@rheinmetall.ca>

This should really go to linux-usb, not linux-input.

-- 
Dmitry
