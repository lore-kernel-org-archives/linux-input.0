From: "Stefan Schweizer" <genstef@gentoo.org>
Subject: Re: suspend
Date: Thu, 3 Apr 2008 16:14:29 +0200
Message-ID: <e79639220804030714p31cbf680y6e9cd10ed10b853d@mail.gmail.com>
References: <dd18b0c30804012331oc548416k113e492d7dc9c189@mail.gmail.com>
	 <200804031029.26635.oliver@neukum.org>
	 <e79639220804030153q46fa82c7jb79bedbe88b30df7@mail.gmail.com>
	 <200804031258.32582.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.187]:49952 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710AbYDCOOb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Apr 2008 10:14:31 -0400
Received: by rn-out-0910.google.com with SMTP id e24so2051100rng.1
        for <linux-input@vger.kernel.org>; Thu, 03 Apr 2008 07:14:30 -0700 (PDT)
In-Reply-To: <200804031258.32582.oliver@neukum.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Apr 3, 2008 at 12:58 PM, Oliver Neukum <oliver@neukum.org> wrote:
>  here I have another test request. This patch on top of the earlier patch
>  implements autosuspend for the appletouch driver. Can you try it? You
>  also need to activate it as described in Documentation/usb/power-management.txt

this one fails to build with  several
struct atp has no element intf
errors.

trying the other one only now

regards,
Stefan
