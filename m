From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: workaround pen {down,up} events not
	reliable after stopping TSI
Date: Sun, 12 Apr 2009 22:26:29 -0700
Message-ID: <20090413052627.GA17034@dtor-d630.eng.vmware.com>
References: <f17812d70904122109w4d14ab4frc66d95aad123d7a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:27178 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbZDMF0f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2009 01:26:35 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1895739rvb.1
        for <linux-input@vger.kernel.org>; Sun, 12 Apr 2009 22:26:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <f17812d70904122109w4d14ab4frc66d95aad123d7a7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Bin Yang <bin.yang@marvell.com>

On Mon, Apr 13, 2009 at 12:09:10PM +0800, Eric Miao wrote:
> From 424ea166ef37e3f69883ef5aeaf14f1489e9f085 Mon Sep 17 00:00:00 2001
> From: Eric Miao <eric.miao@marvell.com>
> Date: Mon, 13 Apr 2009 11:04:51 +0800
> Subject: [PATCH 2/3] input: workaround pen {down,up} events not
> reliable after stopping TSI
> 
> PEN_{UP/DOWN} events are expected to be available soon after stopping TSI
> auto measurement, but this is found not always true. Workaround this by
> delay and simulate such an event (according to pen down status bit).
> 

Applied (but please find a mailer that does not wrap around long
lines).

-- 
Dmitry
