From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input:Add keypad header file for w90p910
Date: Mon, 13 Jul 2009 21:29:15 -0700
Message-ID: <20090714042914.GB2822@dtor-d630.eng.vmware.com>
References: <4A55B406.90203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:20633 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbZGNE3T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 00:29:19 -0400
Received: by rv-out-0506.google.com with SMTP id f6so763368rvb.1
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2009 21:29:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A55B406.90203@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Trilok Soni <soni.trilok@gmail.com>, linux-input@vger.kernel.org, Russell King <linux@arm.linux.org.uk>

Hi Wan,

On Thu, Jul 09, 2009 at 05:10:30PM +0800, Wan ZongShun wrote:
> Dear sirs,
> 
> This is a header file for supporting my keypad driver,
> a few days ago,I have submitted it, Now, for updating
> keypad driver, I submit new patch updated again!
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> 

Please submit this header file together with the keypad driver,
I believe there is an updated version coming, right?

> +
> +#define KEY(row, col, val)	(((row) << 28) | ((col) << 24) | (val))
> +

Please use definitions from include/linux/input/matrix_keypad.h found in
my tree.

-- 
Dmitry
