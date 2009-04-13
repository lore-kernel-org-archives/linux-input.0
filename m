From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: add ABS_PRESSURE to da9034 touchscreen
Date: Sun, 12 Apr 2009 22:13:45 -0700
Message-ID: <20090413051345.GA15752@dtor-d630.eng.vmware.com>
References: <f17812d70904122108r7b951b95o45ad9735722d8e7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:27557 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbZDMFNw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2009 01:13:52 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1891603rvb.1
        for <linux-input@vger.kernel.org>; Sun, 12 Apr 2009 22:13:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f17812d70904122108r7b951b95o45ad9735722d8e7b@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Bin Yang <bin.yang@marvell.com>

Hi Eric,

On Mon, Apr 13, 2009 at 12:08:33PM +0800, Eric Miao wrote:
> From 509bb071200cfe582199ba3ce2533e81949f42f0 Mon Sep 17 00:00:00 2001
> From: Eric Miao <eric.miao@marvell.com>
> Date: Mon, 13 Apr 2009 10:52:59 +0800
> Subject: [PATCH 1/3] input: add ABS_PRESSURE to da9034 touchscreen
> 

The driver does not seem to be reporting true pressure readings but
surrogate events. Tslib has been updated to not require ABS_PRESSURE to
recognize devices as touchscreens so this patch is not needed.

-- 
Dmitry
