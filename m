From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 4/4] input: touchpad not detected on Asus G1S
Date: Fri, 7 Aug 2009 09:57:12 -0700
Message-ID: <20090807172720.3A043526EA5@mailhub.coreip.homeip.net>
References: <200908062304.n76N4ETi002625@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:8003 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbZHGQ5P (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2009 12:57:15 -0400
Received: by rv-out-0506.google.com with SMTP id f6so481256rvb.1
        for <linux-input@vger.kernel.org>; Fri, 07 Aug 2009 09:57:16 -0700 (PDT)
In-Reply-To: <200908062304.n76N4ETi002625@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, geekypenguin@gmail.com

On Thursday 06 August 2009 16:04:14 akpm@linux-foundation.org wrote:
> From: "Jory A. Pratt" <geekypenguin@gmail.com>
>
> The synaptic touchpad on the Asus G1S is not properly detected when
> rebooting machine or on cold boot from time to time.  Adding the Asus G1S
> to the noloop exception table resolves the issue, as it allows the AUX IRQ
> to be rasied.
>
> # dmidecode 2.10

Queued for mainline, please drop.

-- 
Dmitry
