From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: about mouse lost synchronization
Date: Wed, 13 May 2009 19:56:09 -0700
Message-ID: <20090514025609.GC9461@dtor-d630.eng.vmware.com>
References: <000001c9d39c$4baeb6f0$e30c24d0$@org.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:64373 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761825AbZENC4Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2009 22:56:16 -0400
Received: by rv-out-0506.google.com with SMTP id f9so607963rvb.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2009 19:56:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <000001c9d39c$4baeb6f0$e30c24d0$@org.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yao-Chung Chang <yaochung@cic.org.tw>
Cc: linux-input@vger.kernel.org

Hi,

On Wed, May 13, 2009 at 03:27:33PM +0800, Yao-Chung Chang wrote:
> Dear all
> 
> I've implemented a ps/2 serio driver that uses GPIO (two GPIO pins). Each 
> 
> bit is triggered by GPIO interrupt. When in console mode, GPM works
> 
> fine, and I can see the mouse cursor moves correctly. But When entering 
> 
> GUI, say QT or microwindows, the following messages occurred:
> 
> Mouse at xxxxx/serio0/input0 lost synchronization, throwing 1 bytes away.
> ..
> Mouse at xxxxx/serio0/input0 lost synchronization, throwing 1 bytes away.
> 
> Mouse at xxxxx/serio0/input0 lost synchronization, throwing 2 bytes away.
> 
> And the mouse cursor is floating and moves incorrectly. 
> 
> What is the criteria that kernel think the mouse packet is lost of sync.?
> 

When interrupts are delayed for too long the krenel thinks that it
missed a few bytes and complains.

-- 
Dmitry
