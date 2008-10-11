From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Thinkpad R31 i8042 nomux quirk
Date: Sat, 11 Oct 2008 18:18:09 -0400
Message-ID: <200810111818.09349.dmitry.torokhov@gmail.com>
References: <48F0EDF0.3020702@math.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:30743 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbYJKWSO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Oct 2008 18:18:14 -0400
Received: by yw-out-2324.google.com with SMTP id 9so309135ywe.1
        for <linux-input@vger.kernel.org>; Sat, 11 Oct 2008 15:18:13 -0700 (PDT)
In-Reply-To: <48F0EDF0.3020702@math.ucla.edu>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Colin Macdonald <cbm@math.ucla.edu>
Cc: linux-input@vger.kernel.org, dtor@mail.ru

On Saturday 11 October 2008, Colin Macdonald wrote:
> Subject: [PATCH] input: Thinkpad R31 i8042 nomux quirk
> from: Colin B Macdonald <cbm@m.fsf.org>
> 
> Thinkpad R31 needs i8042 nomux quirk.  Stops jittery jumping mouse
> and random keyboard input.  Fixes kernel bug #11723.  Cherry picked
> from Ubuntu who have sometimes (on-again-off-again) had a fix in
> their patched kernels.
> 

Applied, thank you Colin.
 
-- 
Dmitry
