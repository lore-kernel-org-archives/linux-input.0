From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: pxa27x_keypad - Use resource_size
Date: Fri, 18 Sep 2009 00:58:04 -0700
Message-ID: <20090918075803.GI18668@core.coreip.homeip.net>
References: <1253258021-7817-1-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.211.175]:65460 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbZIRH6F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Sep 2009 03:58:05 -0400
Received: by ywh5 with SMTP id 5so991976ywh.4
        for <linux-input@vger.kernel.org>; Fri, 18 Sep 2009 00:58:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1253258021-7817-1-git-send-email-tklauser@distanz.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-input@vger.kernel.org

Hi Tobias,

On Fri, Sep 18, 2009 at 09:13:41AM +0200, Tobias Klauser wrote:
> Use resource size from linux/ioport.h instead of the private macro
> res_size.
> 
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Thank you for the patch but a similar change has already been committed.

-- 
Dmitry
