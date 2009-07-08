From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input:Add clk api support for w90p910 touchscreen
Date: Tue, 7 Jul 2009 23:51:30 -0700
Message-ID: <20090708065130.GD3309@dtor-d630.eng.vmware.com>
References: <4A535B97.4010700@gmail.com> <5d5443650907071019w45474b2dhd0a175a0ffac4f3a@mail.gmail.com> <4A542D30.2040003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:60878 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759106AbZGHGvf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2009 02:51:35 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1675108rvb.1
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2009 23:51:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A542D30.2040003@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>

On Wed, Jul 08, 2009 at 01:22:56PM +0800, Wan ZongShun wrote:
> Dear Trilok,
> 
> You are right, here should be put "NULL",thanks for your help.
> Now, I fixed up my patch.
> 

It looks like clocken can be removed as well?

-- 
Dmitry
