From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH, HP SDC] add option to disable HP SDC driver
Date: Mon, 14 Jul 2008 10:30:04 -0400
Message-ID: <20080714143003.GA13938@anvil.corenet.prv>
References: <200807131812.56801.deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:39792 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601AbYGNOaL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jul 2008 10:30:11 -0400
Received: by an-out-0708.google.com with SMTP id d40so945366and.103
        for <linux-input@vger.kernel.org>; Mon, 14 Jul 2008 07:30:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200807131812.56801.deller@gmx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-input@vger.kernel.org

On Sun, Jul 13, 2008 at 06:12:56PM +0200, Helge Deller wrote:
> Add "no_hpsdc" kernel module option to the hp_sdc driver, so that
> the driver can be instructed to not enable the HP SDC port.
> 
> This is useful on some older HPPA boxes with HIL keyboard 
> and HIL mouse where the new HP SDC HIL drivers don't work 
> yet. By disabling the new hp_sdc driver users are able to use
> the older hilkbd driver instead.
> 

Will apply, thank you Helge.

-- 
Dmitry
